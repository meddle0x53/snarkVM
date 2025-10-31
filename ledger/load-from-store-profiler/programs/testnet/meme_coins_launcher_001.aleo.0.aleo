import credits.aleo;
import multi_token_support_program.aleo;

program meme_coins_launcher_001.aleo;

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

struct TokenData:
    token_id as field;
    virtualTokenReserve as u128;
    virtualAleoReserve as u128;
    actualAleoReserve as u128;

mapping account:
    key as address.public;
    value as u64.public;

mapping tokens:
    key as field.public;
    value as TokenData.public;

function create_token:
    input r0 as u128.private;
    input r1 as u128.private;
    cast r0 into r2 as field;
    cast r1 into r3 as field;
    add r2 276042930540560field into r4;
    add r4 r3 into r5;
    call multi_token_support_program.aleo/register_token r5 r0 r1 6u8 1000000000000000u128 true meme_coins_launcher_001.aleo into r6;
    call multi_token_support_program.aleo/mint_public r5 aleo1jcndksk7tlm4s8kzdpal09jkllc3rgzd2yz2g6rrzyhyfl5khuxsluqwry 1000000000000000u128 4294967295u32 into r7;
    async create_token r6 r7 r5 into r8;
    output r8 as meme_coins_launcher_001.aleo/create_token.future;

finalize create_token:
    input r0 as multi_token_support_program.aleo/register_token.future;
    input r1 as multi_token_support_program.aleo/mint_public.future;
    input r2 as field.public;
    contains tokens[r2] into r3;
    assert.eq r3 false;
    cast r2 1050000000000000u128 450000000u128 0u128 into r4 as TokenData;
    set r4 into tokens[r2];
    await r0;
    await r1;

function main:
    input r0 as u32.public;
    input r1 as u32.private;
    add r0 r1 into r2;
    output r2 as u32.private;
