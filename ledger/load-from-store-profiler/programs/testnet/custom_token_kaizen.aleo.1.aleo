import credits.aleo;
import token_registry.aleo;

program custom_token_kaizen.aleo;

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
    call token_registry.aleo/register_token 125field 1768847739u128 4482878u128 6u8 1000000000000u128 false aleo16u8md23gtv4zvpmdpszrwfjm68vv2xlzy6mqjzcva2n34a722sxs5q7g3a into r0;
    async initialize r0 into r1;
    output r1 as custom_token_kaizen.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.public;
    cast r0 into r1 as u64;
    mul 1000000u64 r1 into r2;
    call credits.aleo/transfer_public aleo1rdkvexuy0hefu4nxp6l9ek6t0f2mlxkm7x09mtvgcdtucx690s9s7gc3h9 r2 into r3;
    call token_registry.aleo/mint_public 125field self.caller r0 999999999u32 into r4;
    async mint r3 r4 into r5;
    output r5 as custom_token_kaizen.aleo/mint.future;

finalize mint:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;

function update_admin:
    input r0 as address.public;
    assert.eq self.caller aleo16u8md23gtv4zvpmdpszrwfjm68vv2xlzy6mqjzcva2n34a722sxs5q7g3a;
    call token_registry.aleo/update_token_management 125field r0 aleo16u8md23gtv4zvpmdpszrwfjm68vv2xlzy6mqjzcva2n34a722sxs5q7g3a into r1;
    async update_admin r1 into r2;
    output r2 as custom_token_kaizen.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
