import credits.aleo;
import token_registry.aleo;

program real_token_flo.aleo;

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
    call token_registry.aleo/register_token 123456789field 38274928u128 123u128 16u8 10000u128 false aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r0;
    async initialize r0 into r1;
    output r1 as real_token_flo.aleo/initialize.future;

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
    call credits.aleo/transfer_public aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv r6 into r7;
    call token_registry.aleo/mint_public 123456789field r0 r1 r2 into r8;
    async mint r7 r8 into r9;
    output r9 as real_token_flo.aleo/mint.future;

finalize mint:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;

function update_admin:
    input r0 as address.public;
    call token_registry.aleo/update_token_management 123456789field r0 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r1;
    async update_admin r1 into r2;
    output r2 as real_token_flo.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
