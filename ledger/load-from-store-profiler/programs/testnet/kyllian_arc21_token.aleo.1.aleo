import credits.aleo;
import token_registry.aleo;

program kyllian_arc21_token.aleo;

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
    call token_registry.aleo/register_token 147258369147258369147258369field 841093770778651985129313818u128 540116687u128 6u8 100000000000000u128 false self.caller into r0;
    async initialize r0 into r1;
    output r1 as kyllian_arc21_token.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.private;
    lte r0 18446744073709551615u128 into r1;
    assert.eq r1 true;
    cast r0 into r2 as u64;
    lte r2 18446744073709551615u64 into r3;
    assert.eq r3 true;
    mul r2 1u64 into r4;
    call credits.aleo/transfer_public aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh r4 into r5;
    call token_registry.aleo/mint_public 147258369147258369147258369field self.caller r0 4294967295u32 into r6;
    async mint r5 r6 into r7;
    output r7 as kyllian_arc21_token.aleo/mint.future;

finalize mint:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    gte block.height 5000000u32 into r2;
    assert.eq r2 true;
    await r0;
    await r1;

function update_admin:
    input r0 as address.private;
    call token_registry.aleo/update_token_management 147258369147258369147258369field r0 self.caller into r1;
    async update_admin r1 into r2;
    output r2 as kyllian_arc21_token.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
