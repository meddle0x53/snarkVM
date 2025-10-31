import token_registry.aleo;
import amm_admin_v001.aleo;
import amm_state_v001.aleo;
import amm_token_borrow_v001.aleo;
import amm_token_deposit_v001.aleo;

program amm_interface_v001.aleo;

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

struct UserData:
    last_updated_block_height as u32;
    origination_fee as u128;
    total_liquidity_balance_USD as u128;
    total_collateral_balance_USD as u128;
    total_borrow_balance_USD as u128;
    total_fees_USD as u128;
    avaialble_borrow_USD as u128;
    current_LTV as u128;
    current_liquidation_threshold as u128;
    borrowing_power as u128;
    health_factor_below_threshold as boolean;
    collateral_needed_in_USD as u128;

struct TokenData:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;

record TokenSalt:
    owner as address.private;
    salt as field.private;

struct UserKey:
    holder as address;
    salt as field;

struct TokenHash:
    user_key as field;
    token_id as field;

mapping admin:
    key as boolean.public;
    value as address.public;

mapping user_balance:
    key as field.public;
    value as u64.public;

mapping allowed_tokens:
    key as field.public;
    value as boolean.public;

mapping allowed_borrowing:
    key as field.public;
    value as boolean.public;

mapping status:
    key as boolean.public;
    value as u8.public;

mapping user_list:
    key as u128.public;
    value as field.public;

mapping user_index:
    key as field.public;
    value as u128.public;

function initialize:
    async initialize self.caller into r0;
    output r0 as amm_interface_v001.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    contains admin[true] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into admin[true];
    set 0u8 into status[true];

function unpause:
    async unpause self.caller into r0;
    output r0 as amm_interface_v001.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 1u8 into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as amm_interface_v001.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 0u8 into status[true];

function create_salt_record:
    input r0 as field.private;
    cast self.caller r0 into r1 as TokenSalt.record;
    output r1 as TokenSalt.record;

function deposit_token:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.private;
    input r2 as TokenSalt.record;
    cast self.caller r2.salt into r3 as UserKey;
    hash.bhp256 r3 into r4 as field;
    cast r4 r0.token_id into r5 as TokenHash;
    hash.bhp256 r5 into r6 as field;
    call token_registry.aleo/transfer_private_to_public amm_admin_v001.aleo r1 r0 into r7 r8;
    call amm_state_v001.aleo/instant_cumulated_borrow_rate r0.token_id into r9;
    call amm_state_v001.aleo/update_cumulative_indexes r0.token_id into r10;
    call amm_state_v001.aleo/update_user_amt_liquidity r0.token_id r1 r6 into r11;
    call amm_state_v001.aleo/update_reserve_rates_timestamp r0.token_id r1 0u128 into r12;
    call amm_token_deposit_v001.aleo/mint r0.token_id r6 r1 into r13;
    async deposit_token r9 r10 r11 r12 r8 r13 r0.token_id r4 into r14;
    output r7 as token_registry.aleo/Token.record;
    output r2 as TokenSalt.record;
    output r14 as amm_interface_v001.aleo/deposit_token.future;

finalize deposit_token:
    input r0 as amm_state_v001.aleo/instant_cumulated_borrow_rate.future;
    input r1 as amm_state_v001.aleo/update_cumulative_indexes.future;
    input r2 as amm_state_v001.aleo/update_user_amt_liquidity.future;
    input r3 as amm_state_v001.aleo/update_reserve_rates_timestamp.future;
    input r4 as token_registry.aleo/transfer_private_to_public.future;
    input r5 as amm_token_deposit_v001.aleo/mint.future;
    input r6 as field.public;
    input r7 as field.public;
    get status[true] into r8;
    assert.eq r8 1u8;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    get.or_use user_index[r7] 0u128 into r9;
    get.or_use user_index[0field] 0u128 into r10;
    is.eq r9 0u128 into r11;
    branch.eq r11 false to end_then_0_0;
    add r10 1u128 into r12;
    set r12 into user_index[r7];
    add r10 1u128 into r13;
    set r7 into user_list[r13];
    add r10 1u128 into r14;
    set r14 into user_index[0field];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function borrow_token:
    input r0 as field.private;
    input r1 as u128.private;
    input r2 as TokenSalt.record;
    input r3 as u128.private;
    input r4 as [field; 2u32].private;
    gt r1 0u128 into r5;
    assert.eq r5 true;
    cast self.caller r2.salt into r6 as UserKey;
    hash.bhp256 r6 into r7 as field;
    cast r7 r0 into r8 as TokenHash;
    hash.bhp256 r8 into r9 as field;
    cast r7 r4[0u32] into r10 as TokenHash;
    hash.bhp256 r10 into r11 as field;
    cast r7 r4[1u32] into r12 as TokenHash;
    hash.bhp256 r12 into r13 as field;
    sub r1 r3 into r14;
    call amm_admin_v001.aleo/give_token_private self.caller r14 r0 into r15 r16;
    call amm_state_v001.aleo/instant_cumulated_borrow_rate r4[0u32] into r17;
    call amm_state_v001.aleo/instant_cumulated_borrow_rate r4[1u32] into r18;
    call amm_state_v001.aleo/update_cumulative_indexes r0 into r19;
    cast r11 r13 into r20 as [field; 2u32];
    call amm_state_v001.aleo/update_user_data r0 r4 r1 r9 r3 r20 into r21;
    call amm_state_v001.aleo/update_user_amt_borrow r0 r9 r1 into r22;
    call amm_state_v001.aleo/update_reserve_rates_timestamp r0 0u128 r1 into r23;
    call amm_token_borrow_v001.aleo/mint r0 r9 r1 into r24;
    async borrow_token r17 r18 r19 r21 r22 r23 r24 r16 r0 r9 into r25;
    output r15 as token_registry.aleo/Token.record;
    output r2 as TokenSalt.record;
    output r25 as amm_interface_v001.aleo/borrow_token.future;

finalize borrow_token:
    input r0 as amm_state_v001.aleo/instant_cumulated_borrow_rate.future;
    input r1 as amm_state_v001.aleo/instant_cumulated_borrow_rate.future;
    input r2 as amm_state_v001.aleo/update_cumulative_indexes.future;
    input r3 as amm_state_v001.aleo/update_user_data.future;
    input r4 as amm_state_v001.aleo/update_user_amt_borrow.future;
    input r5 as amm_state_v001.aleo/update_reserve_rates_timestamp.future;
    input r6 as amm_token_borrow_v001.aleo/mint.future;
    input r7 as amm_admin_v001.aleo/give_token_private.future;
    input r8 as field.public;
    input r9 as field.public;
    get status[true] into r10;
    assert.eq r10 1u8;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    get amm_state_v001.aleo/usersdata[r9] into r11;
    gt r11.total_collateral_balance_USD 0u128 into r12;
    assert.eq r12 true;
    not r11.health_factor_below_threshold into r13;
    assert.eq r13 true;
    lte r11.collateral_needed_in_USD r11.total_collateral_balance_USD into r14;
    assert.eq r14 true;

function update_tokens:
    input r0 as field.private;
    input r1 as boolean.private;
    async update_tokens self.caller r0 r1 into r2;
    output r2 as amm_interface_v001.aleo/update_tokens.future;

finalize update_tokens:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as boolean.public;
    get admin[true] into r3;
    assert.eq r0 r3;
    is.eq r2 true into r4;
    branch.eq r4 false to end_then_0_2;
    set true into allowed_tokens[r1];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    remove allowed_tokens[r1];
    position end_otherwise_0_3;

function update_tokens_to_borrow:
    input r0 as field.private;
    input r1 as boolean.private;
    async update_tokens_to_borrow self.caller r0 r1 into r2;
    output r2 as amm_interface_v001.aleo/update_tokens_to_borrow.future;

finalize update_tokens_to_borrow:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as boolean.public;
    get admin[true] into r3;
    assert.eq r0 r3;
    is.eq r2 true into r4;
    branch.eq r4 false to end_then_0_4;
    set true into allowed_borrowing[r1];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    remove allowed_borrowing[r1];
    position end_otherwise_0_5;
