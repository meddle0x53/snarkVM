import credits.aleo;
import multi_token_support_program.aleo;

program arcn_faucet_fei.aleo;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

function main:
    input r0 as address.public;
    call credits.aleo/transfer_public r0 1u64 into r1;
    async main r1 into r2;
    output r2 as arcn_faucet_fei.aleo/main.future;

finalize main:
    input r0 as credits.aleo/transfer_public.future;
    await r0;

function create_faucetable_token:
    input r0 as field.private;
    input r1 as u128.private;
    input r2 as u128.private;
    input r3 as u8.private;
    input r4 as u128.private;
    cast 0field into r5 as address;
    call multi_token_support_program.aleo/register_token r0 r1 r2 r3 r4 false r5 into r6;
    async create_faucetable_token r6 into r7;
    output r7 as arcn_faucet_fei.aleo/create_faucetable_token.future;

finalize create_faucetable_token:
    input r0 as multi_token_support_program.aleo/register_token.future;
    await r0;

function faucet_private:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as u128.private;
    call multi_token_support_program.aleo/mint_private r0 r1 r2 false 0u32 into r3 r4;
    async faucet_private r4 into r5;
    output r3 as multi_token_support_program.aleo/Token.record;
    output r5 as arcn_faucet_fei.aleo/faucet_private.future;

finalize faucet_private:
    input r0 as multi_token_support_program.aleo/mint_private.future;
    await r0;

function faucet_public:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as u128.private;
    call multi_token_support_program.aleo/mint_public r0 r1 r2 0u32 into r3;
    async faucet_public r3 into r4;
    output r4 as arcn_faucet_fei.aleo/faucet_public.future;

finalize faucet_public:
    input r0 as multi_token_support_program.aleo/mint_public.future;
    await r0;
