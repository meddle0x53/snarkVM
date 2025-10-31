import official_oracle_v2.aleo;
import perp_oracle_v0_3.aleo;
import config_perps_v0_4.aleo;
import pool_perps_v0_4.aleo;

program faucet_perps.aleo;

struct UniqueID:
    chunk_1 as u128;
    chunk_2 as u128;

struct PcrValues:
    pcr_0_chunk_1 as u128;
    pcr_0_chunk_2 as u128;
    pcr_0_chunk_3 as u128;
    pcr_1_chunk_1 as u128;
    pcr_1_chunk_2 as u128;
    pcr_1_chunk_3 as u128;
    pcr_2_chunk_1 as u128;
    pcr_2_chunk_2 as u128;
    pcr_2_chunk_3 as u128;

struct AttestedData:
    data as u128;
    attestation_timestamp as u128;

struct PositionData:
    block_index as u8;
    shift_a as u8;
    shift_b as u8;
    mask_a as u128;
    mask_b as u128;

struct DataChunk:
    f0 as u128;
    f1 as u128;
    f2 as u128;
    f3 as u128;
    f4 as u128;
    f5 as u128;
    f6 as u128;
    f7 as u128;
    f8 as u128;
    f9 as u128;
    f10 as u128;
    f11 as u128;
    f12 as u128;
    f13 as u128;
    f14 as u128;
    f15 as u128;
    f16 as u128;
    f17 as u128;
    f18 as u128;
    f19 as u128;
    f20 as u128;
    f21 as u128;
    f22 as u128;
    f23 as u128;
    f24 as u128;
    f25 as u128;
    f26 as u128;
    f27 as u128;
    f28 as u128;
    f29 as u128;
    f30 as u128;
    f31 as u128;

struct Report:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;
    c8 as DataChunk;
    c9 as DataChunk;

struct ReportData:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;

struct TokenConfig:
    is_whitelist as boolean;
    is_stable as boolean;
    weight as u128;

struct AumConfig:
    addition as u128;
    deduction as u128;
    cooldown_duration as u32;

struct FundingRateConfig:
    stable_funding_rate_factor as u128;
    funding_rate_factor as u128;
    funding_interval_block as u32;

struct LiquidityFeeBpsConfig:
    tax_basis_points as u128;
    stable_tax_basis_points as u128;
    mint_burn_fee_basis_points as u128;
    has_dynamic_fees as boolean;
    swap_fee_basis_points as u128;
    stable_swap_fee_basis_points as u128;

struct PositionFeeBpsConfig:
    margin_fee_basis_points as u128;
    liquidation_fee_usd as u128;
    min_profit_block as u32;

struct LeverageSwapLiqModeConfig:
    leverage_enabled as boolean;
    max_leverage as u128;
    swap_enabled as boolean;
    in_private_liquidation_mode as boolean;

struct BlockDelayConfig:
    min_block_delay_keeper as u32;
    min_block_delay_user as u32;
    max_block_delay_user as u32;

struct ShortsTrackerConfig:
    is_global_short_data_ready as boolean;
    average_price_weight as u128;

mapping admins:
    key as address.public;
    value as boolean.public;

mapping faucets:
    key as field.public;
    value as u128.public;

function init:
    input r0 as [field; 5u32].public;
    input r1 as [u128; 5u32].public;
    assert.eq self.caller aleo1cnm2w8qlrhahlsmalph7t0jh3adny5pj4m38jgpcdzt2reqthurqaen3dp;
    async init self.caller r0 r1 into r2;
    output r2 as faucet_perps.aleo/init.future;

finalize init:
    input r0 as address.public;
    input r1 as [field; 5u32].public;
    input r2 as [u128; 5u32].public;
    contains admins[r0] into r3;
    assert.eq r3 false;
    set true into admins[r0];
    set r2[0u32] into faucets[r1[0u32]];
    set r2[1u32] into faucets[r1[1u32]];
    set r2[2u32] into faucets[r1[2u32]];
    set r2[3u32] into faucets[r1[3u32]];
    set r2[4u32] into faucets[r1[4u32]];

function claim:
    input r0 as field.public;
    input r1 as u128.public;
    assert.eq self.caller self.signer;
    call pool_perps_v0_4.aleo/transfer_public r0 self.caller r1 into r2;
    async claim r0 r1 r2 into r3;
    output r3 as faucet_perps.aleo/claim.future;

finalize claim:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as pool_perps_v0_4.aleo/transfer_public.future;
    await r2;
    get faucets[r0] into r3;
    lte r1 r3 into r4;
    assert.eq r4 true;

function set_faucet:
    input r0 as field.public;
    input r1 as u128.public;
    async set_faucet self.caller r0 r1 into r2;
    output r2 as faucet_perps.aleo/set_faucet.future;

finalize set_faucet:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get admins[r0] into r3;
    assert.eq r3 true;
    set r2 into faucets[r1];

function set_admin:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_admin self.caller r0 r1 into r2;
    output r2 as faucet_perps.aleo/set_admin.future;

finalize set_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get admins[r0] into r3;
    assert.eq r3 true;
    set r2 into admins[r1];

function withdraw:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    call pool_perps_v0_4.aleo/transfer_public r0 r1 r2 into r3;
    async withdraw self.caller r0 r2 r3 into r4;
    output r4 as faucet_perps.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as pool_perps_v0_4.aleo/transfer_public.future;
    await r3;
    get admins[r0] into r4;
    assert.eq r4 true;
