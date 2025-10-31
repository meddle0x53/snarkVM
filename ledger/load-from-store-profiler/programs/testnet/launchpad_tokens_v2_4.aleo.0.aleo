import credits.aleo;
import token_registry.aleo;

program launchpad_tokens_v2_4.aleo;

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

mapping managed_tokens:
    key as field.public;
    value as boolean.public;

function is_token_manageable:
    input r0 as field.private;
    async is_token_manageable r0 into r1;
    output r1 as launchpad_tokens_v2_4.aleo/is_token_manageable.future;

finalize is_token_manageable:
    input r0 as field.public;
    contains managed_tokens[r0] into r1;
    assert.eq r1 true;

function create_token:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u8.public;
    pow 10u128 r3 into r4;
    mul 1000000000u128 r4 into r5;
    call token_registry.aleo/register_token r0 r1 r2 r3 r5 false launchpad_tokens_v2_4.aleo into r6;
    call token_registry.aleo/mint_public r0 self.caller r5 0u32 into r7;
    async create_token r6 r7 r0 into r8;
    output r8 as launchpad_tokens_v2_4.aleo/create_token.future;

finalize create_token:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as token_registry.aleo/mint_public.future;
    input r2 as field.public;
    await r0;
    await r1;
    set true into managed_tokens[r2];
