import credits.aleo;
import token_registry.aleo;

program real_token_skrt2.aleo;

record Counter:
    owner as address.private;
    amount as u64.private;

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
    call token_registry.aleo/register_token 13321321131131352351656532213132354845field 29u128 29u128 18u8 1000000000u128 false aleo1zt7gv58x2ny7vw7anugllr6p6jev7ayw8hlcj08rpcg0hcypxqqsdxwth5 into r0;
    async initialize r0 into r1;
    output r1 as real_token_skrt2.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as address.public;
    input r1 as u128.public;
    call token_registry.aleo/mint_public 13321321131131352351656532213132354845field r0 r1 10u32 into r2;
    call token_registry.aleo/transfer_public 13321321131131352351656532213132354845field aleo1zt7gv58x2ny7vw7anugllr6p6jev7ayw8hlcj08rpcg0hcypxqqsdxwth5 3u128 into r3;
    async mint r3 r2 into r4;
    output r4 as real_token_skrt2.aleo/mint.future;

finalize mint:
    input r0 as token_registry.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;

function update_admin:
    input r0 as address.private;
    call token_registry.aleo/update_token_management 13321321131131352351656532213132354845field r0 aleo1zt7gv58x2ny7vw7anugllr6p6jev7ayw8hlcj08rpcg0hcypxqqsdxwth5 into r1;
    async update_admin r1 into r2;
    output r2 as real_token_skrt2.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;

function init_token:
    input r0 as address.private;
    cast r0 10u64 into r1 as Counter.record;
    output r1 as Counter.record;
