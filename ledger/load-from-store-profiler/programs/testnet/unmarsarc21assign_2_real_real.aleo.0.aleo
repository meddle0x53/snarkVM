import credits.aleo;
import token_registry.aleo;

program unmarsarc21assign_2_real_real.aleo;

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
    call token_registry.aleo/register_token 132435465786977465field 442933381709110046233946628591345458u128 5592148u128 18u8 1000000000u128 false aleo1y6zdsh9ca7npkpu820n76kef6k0hg5a6ytrle8egrmfduc34aqrq9mfw43 into r0;
    async initialize r0 into r1;
    output r1 as unmarsarc21assign_2_real_real.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.private;
    input r1 as address.private;
    lte r0 18446744073709551615u128 into r2;
    assert.eq r2 true;
    cast r0 into r3 as u64;
    call credits.aleo/transfer_public aleo1y6zdsh9ca7npkpu820n76kef6k0hg5a6ytrle8egrmfduc34aqrq9mfw43 r3 into r4;
    call token_registry.aleo/mint_public 132435465786977465field r1 r0 4294967295u32 into r5;
    async mint r4 r5 into r6;
    output r6 as unmarsarc21assign_2_real_real.aleo/mint.future;

finalize mint:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    gte block.height 100u32 into r2;
    assert.eq r2 true;
    await r0;
    await r1;

function update_admin:
    input r0 as address.private;
    call token_registry.aleo/update_token_management 132435465786977465field r0 aleo1y6zdsh9ca7npkpu820n76kef6k0hg5a6ytrle8egrmfduc34aqrq9mfw43 into r1;
    async update_admin r1 into r2;
    output r2 as unmarsarc21assign_2_real_real.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
