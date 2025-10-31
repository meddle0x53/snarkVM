import credits.aleo;
import token_registry.aleo;

program amm_admin_v003.aleo;

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

mapping pool_threshold:
    key as field.public;
    value as u128.public;

function initialize:
    async initialize self.caller into r0;
    output r0 as amm_admin_v003.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    contains admin[true] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into admin[true];
    set 0u8 into status[true];

function unpause:
    async unpause self.caller into r0;
    output r0 as amm_admin_v003.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 1u8 into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as amm_admin_v003.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 0u8 into status[true];

function give_token:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as field.private;
    gt r1 0u128 into r3;
    assert.eq r3 true;
    call token_registry.aleo/transfer_public r2 r0 r1 into r4;
    async give_token self.caller r2 r4 into r5;
    output r5 as amm_admin_v003.aleo/give_token.future;

finalize give_token:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as token_registry.aleo/transfer_public.future;
    await r2;
    get allowed_programs[r0] into r3;
    assert.eq r3 true;
    get status[true] into r4;
    assert.eq r4 1u8;
    get pool_threshold[r1] into r5;
    cast amm_admin_v003.aleo r1 into r6 as TokenOwner;
    hash.bhp256 r6 into r7 as field;
    get token_registry.aleo/authorized_balances[r7] into r8;
    gte r5 r8.balance into r9;
    branch.eq r9 false to end_then_0_0;
    set 0u8 into status[true];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function give_token_private:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as field.private;
    gt r1 0u128 into r3;
    assert.eq r3 true;
    call token_registry.aleo/transfer_public_to_private r2 r0 r1 false into r4 r5;
    async give_token_private self.caller r2 r5 into r6;
    output r4 as token_registry.aleo/Token.record;
    output r6 as amm_admin_v003.aleo/give_token_private.future;

finalize give_token_private:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as token_registry.aleo/transfer_public_to_private.future;
    await r2;
    get allowed_programs[r0] into r3;
    assert.eq r3 true;
    get status[true] into r4;
    assert.eq r4 1u8;
    get.or_use pool_threshold[r1] 0u128 into r5;
    cast amm_admin_v003.aleo r1 into r6 as TokenOwner;
    hash.bhp256 r6 into r7 as field;
    get token_registry.aleo/authorized_balances[r7] into r8;
    gte r5 r8.balance into r9;
    branch.eq r9 false to end_then_0_2;
    set 0u8 into status[true];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;

function update_program_status:
    input r0 as address.private;
    input r1 as boolean.private;
    async update_program_status self.caller r0 r1 into r2;
    output r2 as amm_admin_v003.aleo/update_program_status.future;

finalize update_program_status:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get admin[true] into r3;
    assert.eq r0 r3;
    is.eq r2 true into r4;
    branch.eq r4 false to end_then_0_4;
    set true into allowed_programs[r1];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    remove allowed_programs[r1];
    position end_otherwise_0_5;

function withdraw_token:
    input r0 as u128.private;
    input r1 as field.private;
    call token_registry.aleo/transfer_public r1 self.caller r0 into r2;
    async withdraw_token self.caller r2 into r3;
    output r3 as amm_admin_v003.aleo/withdraw_token.future;

finalize withdraw_token:
    input r0 as address.public;
    input r1 as token_registry.aleo/transfer_public.future;
    await r1;
    get admin[true] into r2;
    assert.eq r0 r2;

function update_pool_threshold:
    input r0 as field.private;
    input r1 as u128.private;
    async update_pool_threshold self.caller r0 r1 into r2;
    output r2 as amm_admin_v003.aleo/update_pool_threshold.future;

finalize update_pool_threshold:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get admin[true] into r3;
    assert.eq r0 r3;
    set r2 into pool_threshold[r1];
