import credits.aleo;
import token_registry.aleo;

program my_token_assignement2_2025.aleo;

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
    call token_registry.aleo/register_token 1234567890field 1111111111u128 2222222222u128 6u8 10000u128 false aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw into r0;
    async initialize r0 into r1;
    output r1 as my_token_assignement2_2025.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    gte block.height 1u32 into r1;
    assert.eq r1 true;
    await r0;

function mint:
    input r0 as u64.private;
    mul r0 1u64 into r1;
    call credits.aleo/transfer_public aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw r1 into r2;
    cast r0 into r3 as u128;
    call token_registry.aleo/mint_public 1234567890field self.caller r3 1000000u32 into r4;
    async mint r2 r4 into r5;
    output r5 as my_token_assignement2_2025.aleo/mint.future;

finalize mint:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;

function update_admin:
    input r0 as address.private;
    call token_registry.aleo/update_token_management 1234567890field r0 self.caller into r1;
    async update_admin r1 into r2;
    output r2 as my_token_assignement2_2025.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
