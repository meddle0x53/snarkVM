import credits.aleo;
import token_registry.aleo;

program actual_token_assignment_2.aleo;

record Token:
    owner as address.private;
    amount as u128.private;
    token_id as field.private;
    external_authorization_required as boolean.private;
    authorized_until as u32.private;

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
    input r0 as address.public;
    call token_registry.aleo/register_token 1654871field 125498563254u128 15487467983u128 6u8 1000000u128 false r0 into r1;
    async initialize r1 into r2;
    output r2 as actual_token_assignment_2.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u128.public;
    gte r3 100000u128 into r4;
    assert.eq r4 true;
    mul r1 100000u128 into r5;
    gte r2 r5 into r6;
    assert.eq r6 true;
    call token_registry.aleo/mint_public 1654871field r0 r1 4294967295u32 into r7;
    async mint r7 into r8;
    output r8 as actual_token_assignment_2.aleo/mint.future;

finalize mint:
    input r0 as token_registry.aleo/mint_public.future;
    await r0;

function update_admin:
    input r0 as address.public;
    call token_registry.aleo/update_token_management 1654871field r0 r0 into r1;
    async update_admin r1 into r2;
    output r2 as actual_token_assignment_2.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
