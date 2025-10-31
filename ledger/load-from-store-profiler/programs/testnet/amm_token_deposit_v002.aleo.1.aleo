import amm_state_v002.aleo;

program amm_token_deposit_v002.aleo;

struct ReserveData:
    token_id as field;
    last_update_block_height as u32;
    liquidity_rate as u128;
    borrow_rate as u128;
    liquidity_cumulative_index as u128;
    borrow_cumulative_index as u128;
    base_LTV_as_collateral as u128;
    liquidation_threshold as u128;
    liquidation_bonus as u128;
    decimals as u8;
    optimal_utilization_rate as u128;
    base_borrow_rate as u128;
    borrowing_enabled as boolean;
    usage_as_collateral_enabled as boolean;
    is_freezed as boolean;
    is_active as boolean;

struct TokenData:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;

struct TokenOwner:
    account as address;
    token_id as field;

mapping registered_tokens:
    key as field.public;
    value as TokenData.public;

mapping dToken_balance:
    key as field.public;
    value as u128.public;

mapping admin:
    key as boolean.public;
    value as address.public;

mapping roles:
    key as field.public;
    value as u8.public;

function initialize:
    async initialize self.caller into r0;
    output r0 as amm_token_deposit_v002.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    contains admin[true] into r1;
    not r1 into r2;
    assert.eq r2 true;
    contains admin[false] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r0 into admin[true];

function register_token:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u8.public;
    input r4 as u128.public;
    cast r0 r1 r2 r3 0u128 r4 self.caller into r5 as TokenData;
    async register_token r5 into r6;
    output r6 as amm_token_deposit_v002.aleo/register_token.future;

finalize register_token:
    input r0 as TokenData.public;
    contains registered_tokens[r0.token_id] into r1;
    assert.eq r1 false;
    set r0 into registered_tokens[r0.token_id];

function set_role:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u8.public;
    is.eq r2 1u8 into r3;
    is.eq r2 2u8 into r4;
    or r3 r4 into r5;
    is.eq r2 3u8 into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    cast r1 r0 into r8 as TokenOwner;
    hash.bhp256 r8 into r9 as field;
    async set_role r0 r2 self.caller r9 into r10;
    output r10 as amm_token_deposit_v002.aleo/set_role.future;

finalize set_role:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as address.public;
    input r3 as field.public;
    get registered_tokens[r0] into r4;
    assert.eq r2 r4.admin;
    set r1 into roles[r3];

function remove_role:
    input r0 as field.public;
    input r1 as address.public;
    cast r1 r0 into r2 as TokenOwner;
    hash.bhp256 r2 into r3 as field;
    async remove_role r0 self.caller r3 into r4;
    output r4 as amm_token_deposit_v002.aleo/remove_role.future;

finalize remove_role:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    get registered_tokens[r0] into r3;
    assert.eq r1 r3.admin;
    remove roles[r2];

function mint:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u128.private;
    cast self.caller r0 into r3 as TokenOwner;
    hash.bhp256 r3 into r4 as field;
    async mint r1 r0 r2 self.caller r4 into r5;
    output r5 as amm_token_deposit_v002.aleo/mint.future;

finalize mint:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as address.public;
    input r4 as field.public;
    get registered_tokens[r1] into r5;
    is.eq r3 r5.admin into r6;
    not r6 into r7;
    branch.eq r7 false to end_then_0_0;
    get roles[r4] into r8;
    is.eq r8 1u8 into r9;
    is.eq r8 3u8 into r10;
    or r9 r10 into r11;
    assert.eq r11 true;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    get.or_use amm_state_v002.aleo/deposited_amount[r0] 0u128 into r12;
    get.or_use dToken_balance[r0] 0u128 into r13;
    sub r12 r13 into r14;
    sub r14 r2 into r15;
    add r5.supply r2 into r16;
    add r16 r15 into r17;
    lte r17 r5.max_supply into r18;
    assert.eq r18 true;
    cast r1 r5.name r5.symbol r5.decimals r17 r5.max_supply r5.admin into r19 as TokenData;
    set r19 into registered_tokens[r1];
    add r13 r2 into r20;
    add r20 r15 into r21;
    set r21 into dToken_balance[r0];
