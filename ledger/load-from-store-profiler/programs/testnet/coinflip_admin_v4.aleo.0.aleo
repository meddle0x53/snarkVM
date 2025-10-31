import credits.aleo;
import token_registry.aleo;

program coinflip_admin_v4.aleo;

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

mapping admin:
    key as boolean.public;
    value as address.public;

mapping status:
    key as boolean.public;
    value as u8.public;

mapping allowed_programs:
    key as address.public;
    value as boolean.public;

mapping threshold_amount:
    key as boolean.public;
    value as u128.public;

function initialize:
    input r0 as address.private;
    input r1 as u128.private;
    async initialize r0 r1 into r2;
    output r2 as coinflip_admin_v4.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    input r1 as u128.public;
    contains admin[true] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r0 into admin[true];
    set 0u8 into status[true];
    set r1 into threshold_amount[true];

function unpause:
    async unpause self.caller into r0;
    output r0 as coinflip_admin_v4.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 1u8 into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as coinflip_admin_v4.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 0u8 into status[true];

function withdraw_native:
    input r0 as u64.private;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async withdraw_native self.caller r1 into r2;
    output r2 as coinflip_admin_v4.aleo/withdraw_native.future;

finalize withdraw_native:
    input r0 as address.public;
    input r1 as credits.aleo/transfer_public.future;
    await r1;
    get admin[true] into r2;
    assert.eq r0 r2;

function withdraw_token:
    input r0 as u128.private;
    input r1 as field.private;
    call token_registry.aleo/transfer_public r1 self.caller r0 into r2;
    async withdraw_token self.caller r2 into r3;
    output r3 as coinflip_admin_v4.aleo/withdraw_token.future;

finalize withdraw_token:
    input r0 as address.public;
    input r1 as token_registry.aleo/transfer_public.future;
    await r1;
    get admin[true] into r2;
    assert.eq r0 r2;

function give_native:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    call credits.aleo/transfer_public r0 r1 into r3;
    async give_native self.caller r1 r3 into r4;
    output r4 as coinflip_admin_v4.aleo/give_native.future;

finalize give_native:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public.future;
    await r2;
    get allowed_programs[r0] into r3;
    assert.eq r3 true;
    get status[true] into r4;
    assert.eq r4 1u8;
    get threshold_amount[true] into r5;
    get credits.aleo/account[coinflip_admin_v4.aleo] into r6;
    cast r6 into r7 as u128;
    gte r5 r7 into r8;
    branch.eq r8 false to end_then_0_0;
    set 0u8 into status[true];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function give_native_private:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    call credits.aleo/transfer_public_to_private r0 r1 into r3 r4;
    async give_native_private self.caller r1 r4 into r5;
    output r3 as credits.aleo/credits.record;
    output r5 as coinflip_admin_v4.aleo/give_native_private.future;

finalize give_native_private:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_to_private.future;
    await r2;
    get allowed_programs[r0] into r3;
    assert.eq r3 true;
    get status[true] into r4;
    assert.eq r4 1u8;
    get threshold_amount[true] into r5;
    get credits.aleo/account[coinflip_admin_v4.aleo] into r6;
    cast r6 into r7 as u128;
    gte r5 r7 into r8;
    branch.eq r8 false to end_then_0_2;
    set 0u8 into status[true];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;

function give_token:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as field.private;
    gt r1 0u128 into r3;
    assert.eq r3 true;
    call token_registry.aleo/transfer_public r2 r0 r1 into r4;
    async give_token self.caller r2 r4 into r5;
    output r5 as coinflip_admin_v4.aleo/give_token.future;

finalize give_token:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as token_registry.aleo/transfer_public.future;
    await r2;
    get allowed_programs[r0] into r3;
    assert.eq r3 true;
    get status[true] into r4;
    assert.eq r4 1u8;
    get threshold_amount[true] into r5;
    cast coinflip_admin_v4.aleo r1 into r6 as TokenOwner;
    hash.bhp256 r6 into r7 as field;
    get token_registry.aleo/authorized_balances[r7] into r8;
    gte r5 r8.balance into r9;
    branch.eq r9 false to end_then_0_4;
    set 0u8 into status[true];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    position end_otherwise_0_5;

function give_token_private:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as field.private;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    cast r1 into r4 as u128;
    call token_registry.aleo/transfer_public_to_private r2 r0 r4 false into r5 r6;
    async give_token_private self.caller r2 r6 into r7;
    output r5 as token_registry.aleo/Token.record;
    output r7 as coinflip_admin_v4.aleo/give_token_private.future;

finalize give_token_private:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as token_registry.aleo/transfer_public_to_private.future;
    await r2;
    get allowed_programs[r0] into r3;
    assert.eq r3 true;
    get status[true] into r4;
    assert.eq r4 1u8;
    get threshold_amount[true] into r5;
    cast coinflip_admin_v4.aleo r1 into r6 as TokenOwner;
    hash.bhp256 r6 into r7 as field;
    get token_registry.aleo/authorized_balances[r7] into r8;
    gte r5 r8.balance into r9;
    branch.eq r9 false to end_then_0_6;
    set 0u8 into status[true];
    branch.eq true true to end_otherwise_0_7;
    position end_then_0_6;
    position end_otherwise_0_7;

function add_program:
    input r0 as address.private;
    async add_program self.caller r0 into r1;
    output r1 as coinflip_admin_v4.aleo/add_program.future;

finalize add_program:
    input r0 as address.public;
    input r1 as address.public;
    get admin[true] into r2;
    assert.eq r0 r2;
    set true into allowed_programs[r1];
