import credits.aleo;
import multi_token_support_program.aleo;

program coinflip_admin_v1.aleo;

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

mapping allowed_programs:
    key as address.public;
    value as boolean.public;

function initialize:
    input r0 as address.private;
    async initialize r0 into r1;
    output r1 as coinflip_admin_v1.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    contains admin[true] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into admin[true];
    set 0u8 into status[true];

function unpause:
    async unpause self.caller into r0;
    output r0 as coinflip_admin_v1.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 1u8 into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as coinflip_admin_v1.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 0u8 into status[true];

function withdraw_native:
    input r0 as u64.private;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async withdraw_native self.caller r1 into r2;
    output r2 as coinflip_admin_v1.aleo/withdraw_native.future;

finalize withdraw_native:
    input r0 as address.public;
    input r1 as credits.aleo/transfer_public.future;
    await r1;
    get admin[true] into r2;
    assert.eq r0 r2;

function withdraw_token:
    input r0 as u128.private;
    input r1 as field.private;
    call multi_token_support_program.aleo/transfer_public r1 self.caller r0 into r2;
    async withdraw_token self.caller r2 into r3;
    output r3 as coinflip_admin_v1.aleo/withdraw_token.future;

finalize withdraw_token:
    input r0 as address.public;
    input r1 as multi_token_support_program.aleo/transfer_public.future;
    await r1;
    get admin[true] into r2;
    assert.eq r0 r2;

function receive_native:
    input r0 as address.private;
    input r1 as u64.private;
    call credits.aleo/transfer_public r0 r1 into r2;
    async receive_native self.caller r2 into r3;
    output r3 as coinflip_admin_v1.aleo/receive_native.future;

finalize receive_native:
    input r0 as address.public;
    input r1 as credits.aleo/transfer_public.future;
    await r1;
    get allowed_programs[r0] into r2;
    assert.eq r2 true;
    get status[true] into r3;
    assert.eq r3 1u8;

function receive_native_private:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    call credits.aleo/transfer_public_to_private r0 r1 into r3 r4;
    async receive_native_private self.caller r4 into r5;
    output r3 as credits.aleo/credits.record;
    output r5 as coinflip_admin_v1.aleo/receive_native_private.future;

finalize receive_native_private:
    input r0 as address.public;
    input r1 as credits.aleo/transfer_public_to_private.future;
    await r1;
    get allowed_programs[r0] into r2;
    assert.eq r2 true;
    get status[true] into r3;
    assert.eq r3 1u8;

function receive_token:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as field.private;
    call multi_token_support_program.aleo/transfer_public r2 r0 r1 into r3;
    async receive_token self.caller r3 into r4;
    output r4 as coinflip_admin_v1.aleo/receive_token.future;

finalize receive_token:
    input r0 as address.public;
    input r1 as multi_token_support_program.aleo/transfer_public.future;
    await r1;
    get allowed_programs[r0] into r2;
    assert.eq r2 true;
    get status[true] into r3;
    assert.eq r3 1u8;

function receive_token_private:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as field.private;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    cast r1 into r4 as u128;
    call multi_token_support_program.aleo/transfer_public_to_private r2 r0 r4 false into r5 r6;
    async receive_token_private self.caller r6 into r7;
    output r5 as multi_token_support_program.aleo/Token.record;
    output r7 as coinflip_admin_v1.aleo/receive_token_private.future;

finalize receive_token_private:
    input r0 as address.public;
    input r1 as multi_token_support_program.aleo/transfer_public_to_private.future;
    await r1;
    get allowed_programs[r0] into r2;
    assert.eq r2 true;
    get status[true] into r3;
    assert.eq r3 1u8;

function add_program:
    input r0 as address.private;
    async add_program self.caller r0 into r1;
    output r1 as coinflip_admin_v1.aleo/add_program.future;

finalize add_program:
    input r0 as address.public;
    input r1 as address.public;
    get admin[true] into r2;
    assert.eq r0 r2;
    set true into allowed_programs[r1];
