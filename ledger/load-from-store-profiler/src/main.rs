// Copyright (c) 2019-2025 Provable Inc.
// This file is part of the snarkVM library.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at:

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

use snarkvm_console::{
    account::PrivateKey,
    network::prelude::*,
    prelude::{CanaryV0, ConsensusVersion, CryptoRng, MainnetV0, Network, Rng, TestRng, TestnetV0},
    program::ProgramOwner,
    types::Field,
};
use snarkvm_ledger::{
    Block,
    ConfirmedTransaction,
    Header,
    Metadata,
    Transaction,
    store::{ConsensusStore, helpers::rocksdb::ConsensusDB},
};
use snarkvm_synthesizer::{Program, VM, process::deployment_cost, program::FinalizeGlobalState};

use anyhow::{Context, Result, bail};
use clap::{Arg, ArgAction};
use reqwest::Client;
use serde_json::Value;
use std::{
    collections::HashMap,
    fs,
    path::{Path, PathBuf},
    str::FromStr,
};
use tokio::time::{Duration, sleep};
use tracing::{info, warn};

const PRIVATE_KEY: &str = "APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH";

#[tokio::main(flavor = "multi_thread")]
async fn main() -> Result<()> {
    tracing_subscriber::fmt::init();

    // === CLI ===
    let matches = clap::Command::new("Aleo Program Runner")
        .version("0.1.0")
        .about("Walks blocks to scrape all programs, builds manifest, then runs them")
        .arg(Arg::new("network").long("network").short('n').default_value("mainnet"))
        .arg(
            Arg::new("scrape")
                .long("scrape")
                .action(ArgAction::SetTrue)
                .help("Read manifest and download listed programs into ./programs/<network>"),
        )
        .arg(
            Arg::new("manifest")
                .long("manifest")
                .value_name("PATH")
                .help("Path to manifest JSON (default: ./programs/manifests/<network>.json)"),
        )
        .arg(
            Arg::new("endpoint")
                .long("endpoint")
                .default_value("https://api.explorer.provable.com/v1/")
                .help("Explorer API endpoint used for scraping"),
        )
        .arg(Arg::new("retries").long("retries").default_value("3"))
        .arg(Arg::new("wait").long("wait").default_value("5"))
        .arg(
            Arg::new("refresh")
                .long("refresh")
                .action(ArgAction::SetTrue)
                .help("Re-download programs even if files exist"),
        )
        .get_matches();

    // === Resolve paths ===
    let network_str = matches.get_one::<String>("network").unwrap().to_lowercase();

    let programs_dir = format!("./programs/{network_str}");
    let manifest_default = format!("./programs/manifests/{network_str}.json");
    let manifest_path =
        matches.get_one::<String>("manifest").map(|s| s.as_str()).unwrap_or(&manifest_default).to_string();
    let deployment_path = format!("./deployments/{network_str}");
    let storage_path = format!("./storage/{network_str}");

    // === Optional scrape ===
    if matches.get_flag("scrape") {
        let opts = ScrapeOpts {
            endpoint: matches.get_one::<String>("endpoint").unwrap().to_string(),
            network: network_str.clone(),
            retries: matches.get_one::<String>("retries").unwrap().parse().unwrap_or(3),
            wait_secs: matches.get_one::<String>("wait").unwrap().parse().unwrap_or(5),
            refresh: matches.get_flag("refresh"),
        };
        scrape_from_manifest(&manifest_path, &programs_dir, opts).await?;
    }

    // === Run the test ===
    match network_str.as_str() {
        "mainnet" => run_test::<MainnetV0>(&programs_dir, &manifest_path, &deployment_path, &storage_path)?,
        "testnet" => run_test::<TestnetV0>(&programs_dir, &manifest_path, &deployment_path, &storage_path)?,
        "canary" => run_test::<CanaryV0>(&programs_dir, &manifest_path, &deployment_path, &storage_path)?,
        _ => bail!("Invalid network: {network_str}"),
    }

    Ok(())
}

#[derive(Clone)]
struct ScrapeOpts {
    endpoint: String,
    network: String,
    retries: u32,
    wait_secs: u64,
    refresh: bool,
}

/// Download all programs listed in the manifest into `out_dir`
async fn scrape_from_manifest(manifest_path: &str, out_dir: &str, opts: ScrapeOpts) -> Result<()> {
    fs::create_dir_all(out_dir)?;
    let body = fs::read_to_string(manifest_path).with_context(|| format!("reading manifest {manifest_path}"))?;
    let arr: Vec<Value> = serde_json::from_str(&body).with_context(|| "parsing manifest JSON as array")?;

    let client = Client::new();
    let base = opts.endpoint.trim_end_matches('/').to_string();
    let net = opts.network;

    info!("Scraping programs from manifest: {manifest_path}");
    for obj in arr {
        let id =
            obj.get("id").and_then(|v| v.as_str()).ok_or_else(|| anyhow::anyhow!("manifest entry missing 'id'"))?;
        let edition = obj.get("edition").and_then(|v| v.as_u64());
        let stem = if let Some(ed) = edition { format!("{id}.{ed}") } else { id.to_string() };
        let aleo_path = PathBuf::from(out_dir).join(format!("{stem}.aleo"));

        if aleo_path.exists() && !opts.refresh {
            continue;
        }

        let url = match edition {
            Some(ed) => format!("{base}/{net}/program/{id}/{ed}"),
            None => format!("{base}/{net}/program/{id}"),
        };

        let src = fetch_with_retry(&client, &url, opts.retries, opts.wait_secs).await?;
        let content: String = serde_json::from_str::<String>(&src).unwrap_or(src);
        fs::write(&aleo_path, content)?;
        info!("Downloaded {}", aleo_path.display());
    }

    Ok(())
}

async fn fetch_with_retry(client: &Client, url: &str, retries: u32, wait: u64) -> Result<String> {
    for attempt in 1..=retries {
        match client.get(url).send().await {
            Ok(res) if res.status().is_success() => return Ok(res.text().await?),
            Ok(res) => warn!("Attempt {}/{}: HTTP {} {}", attempt, retries, res.status(), url),
            Err(e) => warn!("Attempt {}/{}: {} {}", attempt, retries, e, url),
        }
        if attempt < retries {
            sleep(Duration::from_secs(wait)).await;
        }
    }
    Err(anyhow::anyhow!("Failed GET {url} after {retries} attempts"))
}

fn run_test<N: Network>(
    program_path: &str,
    manifest_path: &str,
    deployment_path: &str,
    storage_path: &str,
) -> Result<()> {
    std::fs::create_dir_all(program_path)?;
    std::fs::create_dir_all(deployment_path)?;
    std::fs::create_dir_all(storage_path)?;

    // Retrieve the programs
    let programs = parse_aleo_programs_in_directory::<N, _>(program_path)?
        .into_iter()
        .map(|program| (program.id().to_string(), program))
        .collect::<HashMap<String, Program<_>>>();

    // Retrieve the sorted manifest
    let manifest = read_manifest(manifest_path)?;
    println!("Loading {} programs from: {program_path}", manifest.len());

    let private_key = PrivateKey::<N>::from_str(PRIVATE_KEY)?;
    let rng = &mut TestRng::from_seed(123456789);

    let store = ConsensusStore::<N, ConsensusDB<N>>::open(PathBuf::from(storage_path))?;
    let vm = VM::<N, _>::from(store)?;
    if vm.block_store().max_height().is_none() {
        let genesis_block = vm.genesis_beacon(&private_key, rng)?;
        vm.add_next_block(&genesis_block)?;
    }

    for (i, (program_id, _)) in manifest.iter().enumerate() {
        if i % (manifest.len() / 10).max(1) == 0 {
            println!("{}% complete.", i * 100 / manifest.len());
        }
        let program = programs.get(program_id).unwrap_or_else(|| panic!("Program {program_id} not found"));
        if vm.process().read().contains_program(program.id()) {
            continue;
        }
        println!("Adding program: {program_id}");

        let deployment = match fs::read_to_string(format!("{deployment_path}/{program_id}.json")) {
            Ok(deployment) => serde_json::from_str(&deployment)?,
            Err(_) => {
                let deployment = if let Ok(deployment) =
                    fs::read_to_string(format!("{program_path}/{program_id}.deployment.json"))
                {
                    let confirmed = serde_json::from_str::<ConfirmedTransaction<N>>(&deployment)?;
                    let deployment = confirmed.transaction();
                    reskin_deployment(&vm, &private_key, deployment, rng)?
                } else {
                    vm.deploy(&private_key, program, None, 0, None, rng)?
                };
                let deployment_str = serde_json::to_string(&deployment)?;
                fs::write(format!("{deployment_path}/{program_id}.json"), deployment_str)?;
                deployment
            }
        };
        let block = sample_next_block(&vm, &private_key, &[deployment], rng)?;
        vm.add_next_block(&block)?;
    }

    println!("All programs added successfully.\n");

    drop(vm);
    for _ in 0..5 {
        std::thread::sleep(std::time::Duration::from_secs(5));
        let timer = std::time::Instant::now();
        let _ = VM::<N, _>::from(ConsensusStore::<N, ConsensusDB<N>>::open(PathBuf::from(storage_path))?)?;
        println!("Loaded the VM from storage in: {:?}", timer.elapsed());
    }

    Ok(())
}

fn parse_aleo_programs_in_directory<N: Network, P: AsRef<Path>>(path: P) -> Result<Vec<Program<N>>> {
    let path = path.as_ref();
    let mut programs = vec![];
    for entry in fs::read_dir(path)? {
        let entry = entry?;
        let path = entry.path();
        if path.is_file() && path.extension().and_then(|e| e.to_str()) == Some("aleo") {
            programs.push(Program::from_str(&fs::read_to_string(path)?)?);
        }
    }
    Ok(programs)
}

fn read_manifest(path: &str) -> Result<Vec<(String, u64)>> {
    let mut program_data = vec![];
    let json_str = fs::read_to_string(path)?;
    let programs = serde_json::from_str::<serde_json::Value>(&json_str)?;
    for program in programs.as_array().expect("JSON must be an array") {
        if let Some(id) = program.get("id").and_then(|i| i.as_str()) {
            let height = program.get("block_height").and_then(|h| h.as_u64()).unwrap_or(0);
            program_data.push((id.to_string(), height));
        }
    }
    program_data.sort_by(|a, b| a.1.cmp(&b.1));
    Ok(program_data)
}

fn sample_next_block<N: Network, R: Rng + CryptoRng>(
    vm: &VM<N, ConsensusDB<N>>,
    private_key: &PrivateKey<N>,
    transactions: &[Transaction<N>],
    rng: &mut R,
) -> Result<Block<N>> {
    let block_hash = vm.block_store().get_block_hash(vm.block_store().max_height().unwrap()).unwrap().unwrap();
    let previous_block = vm.block_store().get_block(&block_hash).unwrap().unwrap();
    let time_since_last_block = N::BLOCK_TIME as i64;
    let (ratifications, transactions, aborted_transaction_ids, ratified_finalize_operations) = vm.speculate(
        sample_finalize_state(1),
        time_since_last_block,
        None,
        vec![],
        &None.into(),
        transactions.iter(),
        rng,
    )?;
    let metadata = Metadata::new(
        N::ID,
        previous_block.round() + 1,
        previous_block.height() + 1,
        0,
        0,
        N::GENESIS_COINBASE_TARGET,
        N::GENESIS_PROOF_TARGET,
        previous_block.last_coinbase_target(),
        previous_block.last_coinbase_timestamp(),
        previous_block.timestamp().saturating_add(time_since_last_block),
    )?;
    let header = Header::from(
        vm.block_store().current_state_root(),
        transactions.to_transactions_root().unwrap(),
        transactions.to_finalize_root(ratified_finalize_operations).unwrap(),
        ratifications.to_ratifications_root().unwrap(),
        Field::zero(),
        Field::zero(),
        metadata,
    )?;
    Block::new_beacon(
        private_key,
        previous_block.hash(),
        header,
        ratifications,
        None.into(),
        vec![],
        transactions,
        aborted_transaction_ids,
        rng,
    )
}

fn sample_finalize_state(block_height: u32) -> FinalizeGlobalState {
    FinalizeGlobalState::from(block_height as u64, block_height, [0u8; 32])
}

fn reskin_deployment<N: Network, R: Rng + CryptoRng>(
    vm: &VM<N, ConsensusDB<N>>,
    private_key: &PrivateKey<N>,
    deployment: &Transaction<N>,
    rng: &mut R,
) -> Result<Transaction<N>> {
    let Some(deployment) = deployment.deployment() else {
        bail!("Invalid deployment");
    };
    let deployment_id = deployment.to_deployment_id()?;
    let owner = ProgramOwner::new(private_key, deployment_id, rng)?;
    let (minimum_deployment_cost, _) = deployment_cost(&vm.process().read(), deployment, ConsensusVersion::V10)?;
    let fee_authorization = vm.authorize_fee_public(private_key, minimum_deployment_cost, 0, deployment_id, rng)?;
    let fee = vm.execute_fee_authorization(fee_authorization, None, rng)?;
    Transaction::from_deployment(owner, deployment.clone(), fee)
}
