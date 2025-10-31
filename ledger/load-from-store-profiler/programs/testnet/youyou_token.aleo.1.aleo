import credits.aleo;
import token_registry.aleo;

program youyou_token.aleo;

record Token:
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

mapping balance:
    key as address.public;
    value as u64.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as youyou_token.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use balance[r1] 0u64 into r3;
    add r3 r2 into r4;
    set r4 into balance[r1];
    get.or_use balance[r0] 0u64 into r5;
    sub r5 r2 into r6;
    set r6 into balance[r0];

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as Token.record;
    cast r1 r2 into r5 as Token.record;
    output r4 as Token.record;
    output r5 as Token.record;

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as Token.record;
    async transfer_private_to_public r1 r2 into r5;
    output r4 as Token.record;
    output r5 as youyou_token.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as Token.record;
    async transfer_public_to_private self.caller r1 into r3;
    output r2 as Token.record;
    output r3 as youyou_token.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into balance[r0];

function initialize:
    call token_registry.aleo/register_token 123456789field 82462020551622442035522468669263693962u128 506097522914230528u128 6u8 1000000u128 false self.signer into r0;
    async initialize r0 into r1;
    output r1 as youyou_token.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1udqhkkr39eprzfg9dgkkv3mwve27590qtss9rfafcpuse9tsxqgslxjqmv;
    async mint_public r0 r1 into r2;
    output r2 as youyou_token.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1udqhkkr39eprzfg9dgkkv3mwve27590qtss9rfafcpuse9tsxqgslxjqmv;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function mint:
    input r0 as u128.public;
    input r1 as u32.public;
    gte r1 50000u32 into r2;
    assert.eq r2 true;
    call token_registry.aleo/mint_public 123456789field self.signer r0 0u32 into r3;
    async mint r3 into r4;
    output r4 as youyou_token.aleo/mint.future;

finalize mint:
    input r0 as token_registry.aleo/mint_public.future;
    await r0;

function update_admin:
    input r0 as address.public;
    call token_registry.aleo/update_token_management 123456789field r0 self.signer into r1;
    async update_admin r1 into r2;
    output r2 as youyou_token.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
