import credits.aleo;
import token_registry.aleo;

program zksp500test3.aleo;

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
    call token_registry.aleo/register_token 2993923020308239098003928892921field 34457952730820656u128 357827948592u128 6u8 1000000000000000u128 false zksp500test3.aleo into r0;
    async initialize r0 into r1;
    output r1 as zksp500test3.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.private;
    mul r0 100000u128 into r1;
    cast r1 into r2 as u64;
    call credits.aleo/transfer_public_as_signer aleo1xfvzdlxj7r38adsxprkkasxwpm9a9u6dmfznrmzvdueapmwfmqzsprsxgh r2 into r3;
    call token_registry.aleo/mint_public 2993923020308239098003928892921field self.caller r0 4294967295u32 into r4;
    async mint r0 r3 r4 into r5;
    output r5 as zksp500test3.aleo/mint.future;

finalize mint:
    input r0 as u128.public;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    input r2 as token_registry.aleo/mint_public.future;
    gte block.height 7200000u32 into r3;
    assert.eq r3 true;
    await r1;
    await r2;

function update_admin:
    input r0 as address.private;
    assert.eq self.caller aleo1xfvzdlxj7r38adsxprkkasxwpm9a9u6dmfznrmzvdueapmwfmqzsprsxgh;
    call token_registry.aleo/update_token_management 2993923020308239098003928892921field r0 r0 into r1;
    async update_admin r1 into r2;
    output r2 as zksp500test3.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
