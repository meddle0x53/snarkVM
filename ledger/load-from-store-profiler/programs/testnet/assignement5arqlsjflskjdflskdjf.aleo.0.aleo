import credits.aleo;
import token_registry.aleo;

program assignement5arqlsjflskjdflskdjf.aleo;

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
    assert.eq self.caller aleo1rx2w9vw6hly6pfg4aj4m85pwc9x05arzhtw8ryjk50my7cr7kvps8w38zf;
    call token_registry.aleo/register_token 765432345678987532222330096969669field 77797884797569786585807985766984u128 778480u128 6u8 1000000000000u128 false aleo1rx2w9vw6hly6pfg4aj4m85pwc9x05arzhtw8ryjk50my7cr7kvps8w38zf into r0;
    async initialize r0 into r1;
    output r1 as assignement5arqlsjflskjdflskdjf.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u32.public;
    gte r2 500000u32 into r3;
    assert.eq r3 true;
    cast r1 into r4 as u128;
    mul r4 1u128 into r5;
    div r5 1000000u128 into r6;
    gt r6 0u128 into r7;
    assert.eq r7 true;
    call credits.aleo/transfer_public aleo1rx2w9vw6hly6pfg4aj4m85pwc9x05arzhtw8ryjk50my7cr7kvps8w38zf r1 into r8;
    call token_registry.aleo/mint_public 765432345678987532222330096969669field r0 r6 0u32 into r9;
    async mint r8 r9 into r10;
    output r10 as assignement5arqlsjflskjdflskdjf.aleo/mint.future;

finalize mint:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;

function update_admin:
    input r0 as address.public;
    assert.eq self.caller aleo1rx2w9vw6hly6pfg4aj4m85pwc9x05arzhtw8ryjk50my7cr7kvps8w38zf;
    call token_registry.aleo/update_token_management 765432345678987532222330096969669field r0 r0 into r1;
    async update_admin r1 into r2;
    output r2 as assignement5arqlsjflskjdflskdjf.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
