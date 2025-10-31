import credits.aleo;
import token_registry.aleo;

program ass2token.aleo;

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

struct Balance:
    token_id as field;
    account as address;
    balance as u128;
    authorized_until as u32;

function registration:
    call token_registry.aleo/register_token 4422567719351659849379377242401533579293208542674360522242535381597636270394field 6689648321342499353264907444833u128 2368548u128 6u8 10000000000u128 false aleo1f33gkcn02v3df34vfs38x0p8sk3xnzfcyxqkamu0twl26w4qxqgs7xhv8r into r0;
    async registration r0 into r1;
    output r1 as ass2token.aleo/registration.future;

finalize registration:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.private;
    input r1 as Balance.private;
    input r2 as u32.private;
    gte r2 500000u32 into r3;
    assert.eq r3 true;
    mul r0 1000000u128 into r4;
    call token_registry.aleo/mint_public 4422567719351659849379377242401533579293208542674360522242535381597636270394field r1.account r0 r1.authorized_until into r5;
    call token_registry.aleo/transfer_public 4422567719351659849379377242401533579293208542674360522242535381597636270394field aleo1f33gkcn02v3df34vfs38x0p8sk3xnzfcyxqkamu0twl26w4qxqgs7xhv8r r4 into r6;
    async mint r5 r6 into r7;
    output r7 as ass2token.aleo/mint.future;

finalize mint:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as token_registry.aleo/transfer_public.future;
    await r0;
    await r1;

function admin_change:
    input r0 as address.private;
    call token_registry.aleo/update_token_management 4422567719351659849379377242401533579293208542674360522242535381597636270394field r0 aleo1f33gkcn02v3df34vfs38x0p8sk3xnzfcyxqkamu0twl26w4qxqgs7xhv8r into r1;
    async admin_change r1 into r2;
    output r2 as ass2token.aleo/admin_change.future;

finalize admin_change:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;

function start:
    call token_registry.aleo/initialize into r0;
    async start r0 into r1;
    output r1 as ass2token.aleo/start.future;

finalize start:
    input r0 as token_registry.aleo/initialize.future;
    await r0;
