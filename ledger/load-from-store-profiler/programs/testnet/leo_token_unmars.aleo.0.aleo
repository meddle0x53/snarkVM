import credits.aleo;
import token_registry.aleo;

program leo_token_unmars.aleo;

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

function initialize:
    call token_registry.aleo/register_token 12345651780field 3874947u128 1294u128 16u8 10000u128 false aleo1y6zdsh9ca7npkpu820n76kef6k0hg5a6ytrle8egrmfduc34aqrq9mfw43 into r0;
    async initialize r0 into r1;
    output r1 as leo_token_unmars.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u32.public;
    gte r2 1000u32 into r3;
    assert.eq r3 true;
    mul r1 1u128 into r4;
    lte r4 18446744073709551615u128 into r5;
    assert.eq r5 true;
    cast r4 into r6 as u64;
    call credits.aleo/transfer_public aleo1y6zdsh9ca7npkpu820n76kef6k0hg5a6ytrle8egrmfduc34aqrq9mfw43 r6 into r7;
    call token_registry.aleo/mint_public 12345651780field r0 r1 r2 into r8;
    async mint r7 r8 into r9;
    output r9 as leo_token_unmars.aleo/mint.future;

finalize mint:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;

function update_admin:
    input r0 as address.public;
    call token_registry.aleo/update_token_management 12345651780field r0 aleo1y6zdsh9ca7npkpu820n76kef6k0hg5a6ytrle8egrmfduc34aqrq9mfw43 into r1;
    async update_admin r1 into r2;
    output r2 as leo_token_unmars.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
