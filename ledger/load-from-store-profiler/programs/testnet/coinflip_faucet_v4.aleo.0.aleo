import credits.aleo;
import token_registry.aleo;

program coinflip_faucet_v4.aleo;

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

mapping admin:
    key as boolean.public;
    value as address.public;

mapping status:
    key as boolean.public;
    value as u8.public;

mapping user:
    key as address.public;
    value as u32.public;

mapping timestamp_threshold:
    key as boolean.public;
    value as u32.public;

function initialize:
    input r0 as address.private;
    input r1 as u32.private;
    async initialize r0 r1 into r2;
    output r2 as coinflip_faucet_v4.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    input r1 as u32.public;
    contains admin[true] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r0 into admin[true];
    set 0u8 into status[true];
    set r1 into timestamp_threshold[true];

function free_mint:
    input r0 as field.private;
    input r1 as address.private;
    call token_registry.aleo/mint_public r0 r1 50000000u128 4294967295u32 into r2;
    async free_mint r2 self.caller into r3;
    output r3 as coinflip_faucet_v4.aleo/free_mint.future;

finalize free_mint:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as address.public;
    await r0;
    get status[true] into r2;
    assert.eq r2 1u8;
    get.or_use user[r1] 0u32 into r3;
    get timestamp_threshold[true] into r4;
    add r3 r4 into r5;
    gte block.height r5 into r6;
    assert.eq r6 true;
    set block.height into user[r1];

function unpause:
    async unpause self.caller into r0;
    output r0 as coinflip_faucet_v4.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 1u8 into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as coinflip_faucet_v4.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 0u8 into status[true];

function change_time_limit:
    input r0 as u32.private;
    async change_time_limit self.caller r0 into r1;
    output r1 as coinflip_faucet_v4.aleo/change_time_limit.future;

finalize change_time_limit:
    input r0 as address.public;
    input r1 as u32.public;
    get admin[true] into r2;
    assert.eq r0 r2;
    set r1 into timestamp_threshold[true];
