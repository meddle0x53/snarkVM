import credits.aleo;
import token_registry.aleo;
import amm_admin_v005.aleo;
import amm_reserve_state_v003.aleo;
import amm_instant_cbr_v003.aleo;
import amm_oracle_v003.aleo;
import amm_user_state_v003.aleo;

program amm_interface_v006.aleo;

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
    last_update_block_height as u32;
    liquidity_rate as u128;
    borrow_rate as u128;
    liquidity_cumulative_index as u128;
    borrow_cumulative_index as u128;

struct UserTokenKey:
    user_key as field;
    token_id as field;

struct ReserveConfig:
    token_id as field;
    decimals as u8;
    borrow_fee_percentage as u128;
    base_LTV_as_collateral as u128;
    liquidation_threshold as u128;
    liquidation_bonus as u128;
    optimal_utilization_rate as u128;
    base_borrow_rate as u128;
    borrow_threshold as u128;
    is_freezed as boolean;
    is_active as boolean;

struct UserData:
    last_updated_block_height as u32;
    total_liquidity_balance_USD as u128;
    total_collateral_balance_USD as u128;
    total_borrow_balance_USD as u128;
    avaialble_borrow_USD as u128;
    current_LTV as u128;
    current_liquidation_threshold as u128;
    borrowing_power as u128;
    health_factor_below_threshold as boolean;
    collateral_needed_in_USD as u128;
    hf_withdraw_below_threshold as boolean;

struct UserKey:
    holder as address;
    salt as field;

function withdraw_token:
    input r0 as field.private;
    input r1 as [field; 10u32].private;
    input r2 as u128.private;
    input r3 as boolean.private;
    input r4 as amm_user_state_v003.aleo/UserSalt.record;
    cast self.caller r4.salt into r5 as UserKey;
    hash.bhp256 r5 into r6 as field;
    cast r6 r0 into r7 as UserTokenKey;
    hash.bhp256 r7 into r8 as field;
    cast r6 r1[0u32] into r9 as UserTokenKey;
    hash.bhp256 r9 into r10 as field;
    cast r6 r1[1u32] into r11 as UserTokenKey;
    hash.bhp256 r11 into r12 as field;
    cast r6 r1[2u32] into r13 as UserTokenKey;
    hash.bhp256 r13 into r14 as field;
    cast r6 r1[3u32] into r15 as UserTokenKey;
    hash.bhp256 r15 into r16 as field;
    cast r6 r1[4u32] into r17 as UserTokenKey;
    hash.bhp256 r17 into r18 as field;
    cast r6 r1[5u32] into r19 as UserTokenKey;
    hash.bhp256 r19 into r20 as field;
    cast r6 r1[6u32] into r21 as UserTokenKey;
    hash.bhp256 r21 into r22 as field;
    cast r6 r1[7u32] into r23 as UserTokenKey;
    hash.bhp256 r23 into r24 as field;
    cast r6 r1[8u32] into r25 as UserTokenKey;
    hash.bhp256 r25 into r26 as field;
    cast r6 r1[9u32] into r27 as UserTokenKey;
    hash.bhp256 r27 into r28 as field;
    call amm_instant_cbr_v003.aleo/instant_CBR r1 into r29;
    call amm_reserve_state_v003.aleo/update_CI r0 into r30;
    cast r10 r12 r14 r16 r18 r20 r22 r24 r26 r28 into r31 as [field; 10u32];
    call amm_user_state_v003.aleo/update_user_data r0 r1 0u128 r6 r3 r31 r2 into r32;
    call amm_reserve_state_v003.aleo/update_data_redeem r0 r8 r2 r3 into r33;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r0 0u128 r2 into r34;
    call amm_admin_v005.aleo/give_token_private self.caller r2 r0 into r35 r36;
    async withdraw_token r6 r29 r30 r32 r33 r34 r36 into r37;
    output r35 as token_registry.aleo/Token.record;
    output r37 as amm_interface_v006.aleo/withdraw_token.future;

finalize withdraw_token:
    input r0 as field.public;
    input r1 as amm_instant_cbr_v003.aleo/instant_CBR.future;
    input r2 as amm_reserve_state_v003.aleo/update_CI.future;
    input r3 as amm_user_state_v003.aleo/update_user_data.future;
    input r4 as amm_reserve_state_v003.aleo/update_data_redeem.future;
    input r5 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    input r6 as amm_admin_v005.aleo/give_token_private.future;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    get amm_user_state_v003.aleo/usersdata[r0] into r7;
    assert.eq r7.hf_withdraw_below_threshold false;

function claim_treasury:
    input r0 as field.private;
    input r1 as u128.private;
    gt r1 0u128 into r2;
    assert.eq r2 true;
    call amm_admin_v005.aleo/give_token amm_treasury_v001.aleo r1 r0 into r3;
    call amm_reserve_state_v003.aleo/claim_treasury r0 r1 into r4;
    async claim_treasury r3 r4 into r5;
    output r5 as amm_interface_v006.aleo/claim_treasury.future;

finalize claim_treasury:
    input r0 as amm_admin_v005.aleo/give_token.future;
    input r1 as amm_reserve_state_v003.aleo/claim_treasury.future;
    await r0;
    await r1;

function claim_pending_withdraw:
    input r0 as amm_user_state_v003.aleo/UserSalt.record;
    input r1 as field.private;
    input r2 as u128.private;
    cast self.caller r0.salt into r3 as UserKey;
    hash.bhp256 r3 into r4 as field;
    cast r4 r1 into r5 as UserTokenKey;
    hash.bhp256 r5 into r6 as field;
    call amm_admin_v005.aleo/give_token_private self.caller r2 r1 into r7 r8;
    call amm_reserve_state_v003.aleo/claim_pending_withdraw r6 r1 r2 into r9;
    async claim_pending_withdraw r8 r9 into r10;
    output r7 as token_registry.aleo/Token.record;
    output r10 as amm_interface_v006.aleo/claim_pending_withdraw.future;

finalize claim_pending_withdraw:
    input r0 as amm_admin_v005.aleo/give_token_private.future;
    input r1 as amm_reserve_state_v003.aleo/claim_pending_withdraw.future;
    await r0;
    await r1;

function claim_pending_repay:
    input r0 as amm_user_state_v003.aleo/UserSalt.record;
    input r1 as field.private;
    input r2 as u128.private;
    cast self.caller r0.salt into r3 as UserKey;
    hash.bhp256 r3 into r4 as field;
    cast r4 r1 into r5 as UserTokenKey;
    hash.bhp256 r5 into r6 as field;
    call amm_admin_v005.aleo/give_token_private self.caller r2 r1 into r7 r8;
    call amm_reserve_state_v003.aleo/claim_pending_repay r6 r1 r2 into r9;
    async claim_pending_repay r8 r9 into r10;
    output r7 as token_registry.aleo/Token.record;
    output r10 as amm_interface_v006.aleo/claim_pending_repay.future;

finalize claim_pending_repay:
    input r0 as amm_admin_v005.aleo/give_token_private.future;
    input r1 as amm_reserve_state_v003.aleo/claim_pending_repay.future;
    await r0;
    await r1;

function deposit_token:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.private;
    input r2 as amm_user_state_v003.aleo/UserSalt.record;
    gte r0.amount r1 into r3;
    assert.eq r3 true;
    gt r1 0u128 into r4;
    assert.eq r4 true;
    cast self.caller r2.salt into r5 as UserKey;
    hash.bhp256 r5 into r6 as field;
    cast r6 r0.token_id into r7 as UserTokenKey;
    hash.bhp256 r7 into r8 as field;
    call token_registry.aleo/transfer_private_to_public amm_admin_v005.aleo r1 r0 into r9 r10;
    call amm_reserve_state_v003.aleo/instant_CBR r0.token_id into r11;
    call amm_reserve_state_v003.aleo/update_CI r0.token_id into r12;
    call amm_reserve_state_v003.aleo/update_user_amt_LD r0.token_id r1 r8 into r13;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r0.token_id r1 0u128 into r14;
    async deposit_token r11 r12 r13 r14 r10 into r15;
    output r9 as token_registry.aleo/Token.record;
    output r15 as amm_interface_v006.aleo/deposit_token.future;

finalize deposit_token:
    input r0 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r1 as amm_reserve_state_v003.aleo/update_CI.future;
    input r2 as amm_reserve_state_v003.aleo/update_user_amt_LD.future;
    input r3 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    input r4 as token_registry.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;

function borrow_token:
    input r0 as field.private;
    input r1 as u128.private;
    input r2 as amm_user_state_v003.aleo/UserSalt.record;
    input r3 as u128.private;
    input r4 as [field; 10u32].private;
    gt r1 0u128 into r5;
    assert.eq r5 true;
    gt r3 0u128 into r6;
    assert.eq r6 true;
    cast self.caller r2.salt into r7 as UserKey;
    hash.bhp256 r7 into r8 as field;
    cast r8 r0 into r9 as UserTokenKey;
    hash.bhp256 r9 into r10 as field;
    cast r8 r4[0u32] into r11 as UserTokenKey;
    hash.bhp256 r11 into r12 as field;
    cast r8 r4[1u32] into r13 as UserTokenKey;
    hash.bhp256 r13 into r14 as field;
    cast r8 r4[2u32] into r15 as UserTokenKey;
    hash.bhp256 r15 into r16 as field;
    cast r8 r4[3u32] into r17 as UserTokenKey;
    hash.bhp256 r17 into r18 as field;
    cast r8 r4[4u32] into r19 as UserTokenKey;
    hash.bhp256 r19 into r20 as field;
    cast r8 r4[5u32] into r21 as UserTokenKey;
    hash.bhp256 r21 into r22 as field;
    cast r8 r4[6u32] into r23 as UserTokenKey;
    hash.bhp256 r23 into r24 as field;
    cast r8 r4[7u32] into r25 as UserTokenKey;
    hash.bhp256 r25 into r26 as field;
    cast r8 r4[8u32] into r27 as UserTokenKey;
    hash.bhp256 r27 into r28 as field;
    cast r8 r4[9u32] into r29 as UserTokenKey;
    hash.bhp256 r29 into r30 as field;
    call amm_reserve_state_v003.aleo/checks_on_borrow r0 r1 into r31;
    call amm_instant_cbr_v003.aleo/instant_CBR r4 into r32;
    call amm_reserve_state_v003.aleo/update_CI r0 into r33;
    cast r12 r14 r16 r18 r20 r22 r24 r26 r28 r30 into r34 as [field; 10u32];
    call amm_user_state_v003.aleo/update_user_data r0 r4 r1 r8 false r34 0u128 into r35;
    call amm_reserve_state_v003.aleo/update_user_amt_borrow r0 r10 r1 0u128 false into r36;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r0 0u128 r1 into r37;
    sub r1 r3 into r38;
    call amm_admin_v005.aleo/give_token_private self.caller r38 r0 into r39 r40;
    call amm_admin_v005.aleo/give_token amm_treasury_v001.aleo r3 r0 into r41;
    async borrow_token r8 r0 r1 r3 r31 r32 r33 r35 r36 r37 r40 r41 into r42;
    output r39 as token_registry.aleo/Token.record;
    output r42 as amm_interface_v006.aleo/borrow_token.future;

finalize borrow_token:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as amm_reserve_state_v003.aleo/checks_on_borrow.future;
    input r5 as amm_instant_cbr_v003.aleo/instant_CBR.future;
    input r6 as amm_reserve_state_v003.aleo/update_CI.future;
    input r7 as amm_user_state_v003.aleo/update_user_data.future;
    input r8 as amm_reserve_state_v003.aleo/update_user_amt_borrow.future;
    input r9 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    input r10 as amm_admin_v005.aleo/give_token_private.future;
    input r11 as amm_admin_v005.aleo/give_token.future;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
    await r9;
    await r10;
    await r11;
    get amm_user_state_v003.aleo/usersdata[r0] into r12;
    get amm_reserve_state_v003.aleo/reserve_config[r1] into r13;
    pow 10u128 r13.decimals into r14;
    div 1000000000000000000u128 r14 into r15;
    mul r2 r15 into r16;
    div r16 1000000000000000000u128 into r17;
    div r13.borrow_fee_percentage 1000000000000000000u128 into r18;
    rem r16 1000000000000000000u128 into r19;
    rem r13.borrow_fee_percentage 1000000000000000000u128 into r20;
    mul r16 r18 into r21;
    mul r17 r20 into r22;
    add r21 r22 into r23;
    mul r19 r20 into r24;
    div r24 1000000000000000000u128 into r25;
    add r23 r25 into r26;
    pow 10u128 r13.decimals into r27;
    div 1000000000000000000u128 r27 into r28;
    div r26 r28 into r29;
    assert.eq r29 r3;
    gt r12.total_collateral_balance_USD 0u128 into r30;
    assert.eq r30 true;
    assert.eq r12.health_factor_below_threshold false;
    lte r12.collateral_needed_in_USD r12.total_collateral_balance_USD into r31;
    assert.eq r31 true;

function repay_token:
    input r0 as amm_user_state_v003.aleo/UserSalt.record;
    input r1 as token_registry.aleo/Token.record;
    input r2 as u128.private;
    input r3 as boolean.private;
    cast self.caller r0.salt into r4 as UserKey;
    hash.bhp256 r4 into r5 as field;
    cast r5 r1.token_id into r6 as UserTokenKey;
    hash.bhp256 r6 into r7 as field;
    ternary r3 r1.amount r2 into r8;
    call token_registry.aleo/transfer_private_to_public amm_admin_v005.aleo r8 r1 into r9 r10;
    call amm_reserve_state_v003.aleo/instant_CBR r1.token_id into r11;
    call amm_reserve_state_v003.aleo/update_CI r1.token_id into r12;
    call amm_reserve_state_v003.aleo/update_user_amt_borrow r1.token_id r7 0u128 r8 r3 into r13;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r1.token_id 0u128 r8 into r14;
    async repay_token r10 r11 r12 r13 r14 into r15;
    output r9 as token_registry.aleo/Token.record;
    output r15 as amm_interface_v006.aleo/repay_token.future;

finalize repay_token:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r2 as amm_reserve_state_v003.aleo/update_CI.future;
    input r3 as amm_reserve_state_v003.aleo/update_user_amt_borrow.future;
    input r4 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
