import credits.aleo;
import token_registry.aleo;

program assignement3_token.aleo;

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
    call token_registry.aleo/register_token 2993923020308239098023970392889012921field 77797884797569786585807985766984u128 778480u128 6u8 1000000000000000u128 false assignement3_token.aleo into r0;
    async initialize r0 into r1;
    output r1 as assignement3_token.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.private;
    mul r0 100000u128 into r1;
    div r1 1000000u128 into r2;
    cast r2 into r3 as u64;
    call credits.aleo/transfer_public_as_signer aleo1wamjqlka7d0gazlxdys6n8e8zeee3ymedwvw8elvh7529kwd45rq0plgax r3 into r4;
    call token_registry.aleo/mint_public 2993923020308239098023970392889012921field self.caller r0 4294967295u32 into r5;
    async mint r0 r4 r5 into r6;
    output r6 as assignement3_token.aleo/mint.future;

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
    assert.eq self.caller aleo1wamjqlka7d0gazlxdys6n8e8zeee3ymedwvw8elvh7529kwd45rq0plgax;
    call token_registry.aleo/update_token_management 2993923020308239098023970392889012921field r0 r0 into r1;
    async update_admin r1 into r2;
    output r2 as assignement3_token.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
