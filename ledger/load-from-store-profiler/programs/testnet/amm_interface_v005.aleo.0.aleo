import credits.aleo;
import token_registry.aleo;
import amm_admin_v004.aleo;
import amm_reserve_state_v002.aleo;
import amm_instant_cbr_v002.aleo;
import amm_user_state_v002.aleo;

program amm_interface_v005.aleo;

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

struct ReserveConfig:
    token_id as field;
    decimals as u8;
    base_LTV_as_collateral as u128;
    liquidation_threshold as u128;
    liquidation_bonus as u128;
    optimal_utilization_rate as u128;
    base_borrow_rate as u128;
    borrow_threshold as u128;
    is_freezed as boolean;
    is_active as boolean;

struct UserKey:
    holder as address;
    salt as field;

struct TokenHash:
    user_key as field;
    token_id as field;

function withdraw_token:
    input r0 as field.private;
    input r1 as [field; 10u32].private;
    input r2 as u128.private;
    input r3 as amm_user_state_v002.aleo/UserSalt.record;
    input r4 as u128.private;
    gt r2 0u128 into r5;
    assert.eq r5 true;
    cast self.caller r3.salt into r6 as UserKey;
    hash.bhp256 r6 into r7 as field;
    cast r7 r0 into r8 as TokenHash;
    hash.bhp256 r8 into r9 as field;
    cast r7 r1[0u32] into r10 as TokenHash;
    hash.bhp256 r10 into r11 as field;
    cast r7 r1[1u32] into r12 as TokenHash;
    hash.bhp256 r12 into r13 as field;
    cast r7 r1[2u32] into r14 as TokenHash;
    hash.bhp256 r14 into r15 as field;
    cast r7 r1[3u32] into r16 as TokenHash;
    hash.bhp256 r16 into r17 as field;
    cast r7 r1[4u32] into r18 as TokenHash;
    hash.bhp256 r18 into r19 as field;
    cast r7 r1[5u32] into r20 as TokenHash;
    hash.bhp256 r20 into r21 as field;
    cast r7 r1[6u32] into r22 as TokenHash;
    hash.bhp256 r22 into r23 as field;
    cast r7 r1[7u32] into r24 as TokenHash;
    hash.bhp256 r24 into r25 as field;
    cast r7 r1[8u32] into r26 as TokenHash;
    hash.bhp256 r26 into r27 as field;
    cast r7 r1[9u32] into r28 as TokenHash;
    hash.bhp256 r28 into r29 as field;
    call amm_instant_cbr_v002.aleo/instant_CBR r1 into r30;
    call amm_reserve_state_v002.aleo/update_CI r0 into r31;
    cast r11 r13 r15 r17 r19 r21 r23 r25 r27 r29 into r32 as [field; 10u32];
    call amm_user_state_v002.aleo/update_user_data r0 r1 0u128 r9 r4 r32 r2 into r33;
    call amm_reserve_state_v002.aleo/update_RR_timestamp r0 0u128 r2 into r34;
    call amm_reserve_state_v002.aleo/update_data_redeem r0 r9 r2 into r35;
    call amm_admin_v004.aleo/give_token_private self.caller r2 r0 into r36 r37;
    async withdraw_token r30 r31 r33 r34 r35 r37 into r38;
    output r36 as token_registry.aleo/Token.record;
    output r38 as amm_interface_v005.aleo/withdraw_token.future;

finalize withdraw_token:
    input r0 as amm_instant_cbr_v002.aleo/instant_CBR.future;
    input r1 as amm_reserve_state_v002.aleo/update_CI.future;
    input r2 as amm_user_state_v002.aleo/update_user_data.future;
    input r3 as amm_reserve_state_v002.aleo/update_RR_timestamp.future;
    input r4 as amm_reserve_state_v002.aleo/update_data_redeem.future;
    input r5 as amm_admin_v004.aleo/give_token_private.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;

function deposit_token:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.private;
    input r2 as amm_user_state_v002.aleo/UserSalt.record;
    cast self.caller r2.salt into r3 as UserKey;
    hash.bhp256 r3 into r4 as field;
    cast r4 r0.token_id into r5 as TokenHash;
    hash.bhp256 r5 into r6 as field;
    call token_registry.aleo/transfer_private_to_public amm_admin_v004.aleo r1 r0 into r7 r8;
    call amm_reserve_state_v002.aleo/instant_CBR r0.token_id into r9;
    call amm_reserve_state_v002.aleo/update_CI r0.token_id into r10;
    call amm_reserve_state_v002.aleo/update_user_amt_LD r0.token_id r1 r6 into r11;
    call amm_reserve_state_v002.aleo/update_RR_timestamp r0.token_id r1 0u128 into r12;
    async deposit_token r9 r10 r11 r12 r8 into r13;
    output r7 as token_registry.aleo/Token.record;
    output r13 as amm_interface_v005.aleo/deposit_token.future;

finalize deposit_token:
    input r0 as amm_reserve_state_v002.aleo/instant_CBR.future;
    input r1 as amm_reserve_state_v002.aleo/update_CI.future;
    input r2 as amm_reserve_state_v002.aleo/update_user_amt_LD.future;
    input r3 as amm_reserve_state_v002.aleo/update_RR_timestamp.future;
    input r4 as token_registry.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;

function borrow_token:
    input r0 as field.private;
    input r1 as u128.private;
    input r2 as amm_user_state_v002.aleo/UserSalt.record;
    input r3 as u128.private;
    input r4 as [field; 10u32].private;
    gt r1 0u128 into r5;
    assert.eq r5 true;
    gt r3 0u128 into r6;
    assert.eq r6 true;
    cast self.caller r2.salt into r7 as UserKey;
    hash.bhp256 r7 into r8 as field;
    cast r8 r0 into r9 as TokenHash;
    hash.bhp256 r9 into r10 as field;
    cast r8 r4[0u32] into r11 as TokenHash;
    hash.bhp256 r11 into r12 as field;
    cast r8 r4[1u32] into r13 as TokenHash;
    hash.bhp256 r13 into r14 as field;
    cast r8 r4[2u32] into r15 as TokenHash;
    hash.bhp256 r15 into r16 as field;
    cast r8 r4[3u32] into r17 as TokenHash;
    hash.bhp256 r17 into r18 as field;
    cast r8 r4[4u32] into r19 as TokenHash;
    hash.bhp256 r19 into r20 as field;
    cast r8 r4[5u32] into r21 as TokenHash;
    hash.bhp256 r21 into r22 as field;
    cast r8 r4[6u32] into r23 as TokenHash;
    hash.bhp256 r23 into r24 as field;
    cast r8 r4[7u32] into r25 as TokenHash;
    hash.bhp256 r25 into r26 as field;
    cast r8 r4[8u32] into r27 as TokenHash;
    hash.bhp256 r27 into r28 as field;
    cast r8 r4[9u32] into r29 as TokenHash;
    hash.bhp256 r29 into r30 as field;
    call amm_reserve_state_v002.aleo/checks_on_borrow r0 r1 into r31;
    call amm_instant_cbr_v002.aleo/instant_CBR r4 into r32;
    call amm_reserve_state_v002.aleo/update_CI r0 into r33;
    cast r12 r14 r16 r18 r20 r22 r24 r26 r28 r30 into r34 as [field; 10u32];
    call amm_user_state_v002.aleo/update_user_data r0 r4 r1 r10 r3 r34 0u128 into r35;
    call amm_reserve_state_v002.aleo/update_user_amt_borrow r0 r10 r1 0u128 into r36;
    call amm_reserve_state_v002.aleo/update_RR_timestamp r0 0u128 r1 into r37;
    sub r1 r3 into r38;
    call amm_admin_v004.aleo/give_token_private self.caller r38 r0 into r39 r40;
    async borrow_token r31 r32 r33 r35 r36 r37 r40 into r41;
    output r39 as token_registry.aleo/Token.record;
    output r41 as amm_interface_v005.aleo/borrow_token.future;

finalize borrow_token:
    input r0 as amm_reserve_state_v002.aleo/checks_on_borrow.future;
    input r1 as amm_instant_cbr_v002.aleo/instant_CBR.future;
    input r2 as amm_reserve_state_v002.aleo/update_CI.future;
    input r3 as amm_user_state_v002.aleo/update_user_data.future;
    input r4 as amm_reserve_state_v002.aleo/update_user_amt_borrow.future;
    input r5 as amm_reserve_state_v002.aleo/update_RR_timestamp.future;
    input r6 as amm_admin_v004.aleo/give_token_private.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;

function repay_token:
    input r0 as amm_user_state_v002.aleo/UserSalt.record;
    input r1 as token_registry.aleo/Token.record;
    input r2 as u128.private;
    cast self.caller r0.salt into r3 as UserKey;
    hash.bhp256 r3 into r4 as field;
    cast r4 r1.token_id into r5 as TokenHash;
    hash.bhp256 r5 into r6 as field;
    call token_registry.aleo/transfer_private_to_public amm_admin_v004.aleo r2 r1 into r7 r8;
    call amm_reserve_state_v002.aleo/instant_CBR r1.token_id into r9;
    call amm_reserve_state_v002.aleo/update_CI r1.token_id into r10;
    call amm_reserve_state_v002.aleo/update_user_amt_borrow r1.token_id r6 0u128 r2 into r11;
    call amm_reserve_state_v002.aleo/update_RR_timestamp r1.token_id 0u128 r2 into r12;
    async repay_token r8 r9 r10 r11 r12 into r13;
    output r7 as token_registry.aleo/Token.record;
    output r13 as amm_interface_v005.aleo/repay_token.future;

finalize repay_token:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as amm_reserve_state_v002.aleo/instant_CBR.future;
    input r2 as amm_reserve_state_v002.aleo/update_CI.future;
    input r3 as amm_reserve_state_v002.aleo/update_user_amt_borrow.future;
    input r4 as amm_reserve_state_v002.aleo/update_RR_timestamp.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;

function liquidation_call:
    input r0 as token_registry.aleo/Token.record;
    input r1 as amm_user_state_v002.aleo/UserSalt.record;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as [field; 10u32].private;
    input r5 as [field; 10u32].private;
    input r6 as u128.private;
    input r7 as u128.private;
    input r8 as u128.private;
    cast self.caller r1.salt into r9 as UserKey;
    hash.bhp256 r9 into r10 as field;
    cast r10 r2 into r11 as TokenHash;
    hash.bhp256 r11 into r12 as field;
    call amm_instant_cbr_v002.aleo/instant_CBR r5 into r13;
    call amm_reserve_state_v002.aleo/update_CI r0.token_id into r14;
    call amm_user_state_v002.aleo/update_user_data r0.token_id r5 0u128 r4[1u32] 0u128 r4 0u128 into r15;
    call amm_user_state_v002.aleo/check_on_liquidation r2 r3 r12 r4[1u32] r6 r7 r8 into r16;
    call amm_reserve_state_v002.aleo/update_user_amt_LD r0.token_id 0u128 r4[1u32] into r17;
    call amm_reserve_state_v002.aleo/burning_internal_token r0.token_id r4[1u32] r8 into r18;
    call amm_reserve_state_v002.aleo/instant_CBR r2 into r19;
    call amm_reserve_state_v002.aleo/update_CI r2 into r20;
    call amm_reserve_state_v002.aleo/update_RR_timestamp r2 r6 0u128 into r21;
    call amm_user_state_v002.aleo/update_user_timestamp r3 r4[1u32] into r22;
    call amm_reserve_state_v002.aleo/update_int_timestamp r0.token_id true r4[1u32] into r23;
    call amm_reserve_state_v002.aleo/update_int_timestamp r0.token_id false r4[1u32] into r24;
    call amm_admin_v004.aleo/give_token_private self.caller r7 r2 into r25 r26;
    call token_registry.aleo/transfer_private_to_public amm_admin_v004.aleo r8 r0 into r27 r28;
    async liquidation_call r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r26 r28 into r29;
    output r25 as token_registry.aleo/Token.record;
    output r27 as token_registry.aleo/Token.record;
    output r29 as amm_interface_v005.aleo/liquidation_call.future;

finalize liquidation_call:
    input r0 as amm_instant_cbr_v002.aleo/instant_CBR.future;
    input r1 as amm_reserve_state_v002.aleo/update_CI.future;
    input r2 as amm_user_state_v002.aleo/update_user_data.future;
    input r3 as amm_user_state_v002.aleo/check_on_liquidation.future;
    input r4 as amm_reserve_state_v002.aleo/update_user_amt_LD.future;
    input r5 as amm_reserve_state_v002.aleo/burning_internal_token.future;
    input r6 as amm_reserve_state_v002.aleo/instant_CBR.future;
    input r7 as amm_reserve_state_v002.aleo/update_CI.future;
    input r8 as amm_reserve_state_v002.aleo/update_RR_timestamp.future;
    input r9 as amm_user_state_v002.aleo/update_user_timestamp.future;
    input r10 as amm_reserve_state_v002.aleo/update_int_timestamp.future;
    input r11 as amm_reserve_state_v002.aleo/update_int_timestamp.future;
    input r12 as amm_admin_v004.aleo/give_token_private.future;
    input r13 as token_registry.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
    await r9;
    await r10;
    await r11;
    await r12;
    await r13;
