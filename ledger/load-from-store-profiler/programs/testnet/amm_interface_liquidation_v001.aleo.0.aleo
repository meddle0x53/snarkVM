import credits.aleo;
import token_registry.aleo;
import amm_admin_v005.aleo;
import amm_reserve_state_v003.aleo;
import amm_instant_cbr_v003.aleo;
import amm_oracle_v003.aleo;
import amm_user_state_v003.aleo;

program amm_interface_liquidation_v001.aleo;

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

struct UserKey:
    holder as address;
    salt as field;

function claim_liquidation:
    input r0 as amm_user_state_v003.aleo/UserSalt.record;
    input r1 as u128.private;
    input r2 as u128.private;
    input r3 as u128.private;
    input r4 as u128.private;
    input r5 as boolean.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    call amm_reserve_state_v003.aleo/instant_CBR r6 into r10;
    call amm_reserve_state_v003.aleo/update_CI r6 into r11;
    call amm_reserve_state_v003.aleo/update_CI r7 into r12;
    call amm_user_state_v003.aleo/claim_liquidation r1 r2 r3 r4 r5 r6 r7 r8 r9 into r13;
    ternary r5 r1 0u128 into r14;
    ternary r5 r2 0u128 into r15;
    ternary r5 r3 0u128 into r16;
    ternary r5 r4 0u128 into r17;
    call amm_reserve_state_v003.aleo/claim_liquidation r14 r15 r16 r17 r6 r7 r8 r9 into r18;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r7 0u128 r3 into r19;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r6 r1 0u128 into r20;
    call amm_admin_v005.aleo/give_token_private self.caller r4 r7 into r21 r22;
    sub r1 r2 into r23;
    call amm_admin_v005.aleo/give_token_private self.caller r23 r7 into r24 r25;
    async claim_liquidation r10 r11 r12 r13 r18 r19 r20 r22 r25 into r26;
    output r21 as token_registry.aleo/Token.record;
    output r24 as token_registry.aleo/Token.record;
    output r26 as amm_interface_liquidation_v001.aleo/claim_liquidation.future;

finalize claim_liquidation:
    input r0 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r1 as amm_reserve_state_v003.aleo/update_CI.future;
    input r2 as amm_reserve_state_v003.aleo/update_CI.future;
    input r3 as amm_user_state_v003.aleo/claim_liquidation.future;
    input r4 as amm_reserve_state_v003.aleo/claim_liquidation.future;
    input r5 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    input r6 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    input r7 as amm_admin_v005.aleo/give_token_private.future;
    input r8 as amm_admin_v005.aleo/give_token_private.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;

function claim_liq_3rd_party:
    input r0 as u128.private;
    input r1 as u128.private;
    input r2 as u128.private;
    input r3 as u128.private;
    input r4 as field.private;
    input r5 as field.private;
    input r6 as field.private;
    input r7 as field.private;
    call amm_reserve_state_v003.aleo/instant_CBR r4 into r8;
    call amm_reserve_state_v003.aleo/update_CI r4 into r9;
    call amm_reserve_state_v003.aleo/update_CI r5 into r10;
    call amm_user_state_v003.aleo/claim_liq_3rd_party r0 r1 r2 r3 false r6 r7 into r11;
    call amm_reserve_state_v003.aleo/claim_liquidation r0 r1 r2 r3 r4 r5 r6 r7 into r12;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r5 0u128 r2 into r13;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r4 r0 0u128 into r14;
    async claim_liq_3rd_party r8 r9 r10 r11 r12 r13 r14 into r15;
    output r15 as amm_interface_liquidation_v001.aleo/claim_liq_3rd_party.future;

finalize claim_liq_3rd_party:
    input r0 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r1 as amm_reserve_state_v003.aleo/update_CI.future;
    input r2 as amm_reserve_state_v003.aleo/update_CI.future;
    input r3 as amm_user_state_v003.aleo/claim_liq_3rd_party.future;
    input r4 as amm_reserve_state_v003.aleo/claim_liquidation.future;
    input r5 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    input r6 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;

function liquidation:
    input r0 as token_registry.aleo/Token.record;
    input r1 as amm_user_state_v003.aleo/UserSalt.record;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as [field; 10u32].private;
    input r5 as field.private;
    input r6 as u128.private;
    input r7 as u128.private;
    cast self.caller r1.salt into r8 as UserKey;
    hash.bhp256 r8 into r9 as field;
    cast r9 r2 into r10 as UserTokenKey;
    hash.bhp256 r10 into r11 as field;
    cast r5 r4[0u32] into r12 as UserTokenKey;
    hash.bhp256 r12 into r13 as field;
    cast r5 r4[1u32] into r14 as UserTokenKey;
    hash.bhp256 r14 into r15 as field;
    cast r5 r4[2u32] into r16 as UserTokenKey;
    hash.bhp256 r16 into r17 as field;
    cast r5 r4[3u32] into r18 as UserTokenKey;
    hash.bhp256 r18 into r19 as field;
    cast r5 r4[4u32] into r20 as UserTokenKey;
    hash.bhp256 r20 into r21 as field;
    cast r5 r4[5u32] into r22 as UserTokenKey;
    hash.bhp256 r22 into r23 as field;
    cast r5 r4[6u32] into r24 as UserTokenKey;
    hash.bhp256 r24 into r25 as field;
    cast r5 r4[7u32] into r26 as UserTokenKey;
    hash.bhp256 r26 into r27 as field;
    cast r5 r4[8u32] into r28 as UserTokenKey;
    hash.bhp256 r28 into r29 as field;
    cast r5 r4[9u32] into r30 as UserTokenKey;
    hash.bhp256 r30 into r31 as field;
    call amm_instant_cbr_v003.aleo/instant_CBR r4 into r32;
    call amm_reserve_state_v003.aleo/update_CI r0.token_id into r33;
    call amm_reserve_state_v003.aleo/update_CI r2 into r34;
    cast r13 r15 r17 r19 r21 r23 r25 r27 r29 r31 into r35 as [field; 10u32];
    call amm_user_state_v003.aleo/update_user_data r3 r4 0u128 r5 false r35 0u128 into r36;
    call amm_user_state_v003.aleo/check_on_liquidation r2 r3 r11 r5 r6 r7 into r37;
    call amm_reserve_state_v003.aleo/update_user_liquidation r3 r2 r5 r9 r6 r7 into r38;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r2 0u128 r7 into r39;
    call amm_reserve_state_v003.aleo/update_RR_timestamp r3 r6 0u128 into r40;
    call token_registry.aleo/transfer_private_to_public amm_admin_v005.aleo r6 r0 into r41 r42;
    async liquidation r32 r33 r34 r36 r37 r38 r39 r40 r42 into r43;
    output r41 as token_registry.aleo/Token.record;
    output r43 as amm_interface_liquidation_v001.aleo/liquidation.future;

finalize liquidation:
    input r0 as amm_instant_cbr_v003.aleo/instant_CBR.future;
    input r1 as amm_reserve_state_v003.aleo/update_CI.future;
    input r2 as amm_reserve_state_v003.aleo/update_CI.future;
    input r3 as amm_user_state_v003.aleo/update_user_data.future;
    input r4 as amm_user_state_v003.aleo/check_on_liquidation.future;
    input r5 as amm_reserve_state_v003.aleo/update_user_liquidation.future;
    input r6 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    input r7 as amm_reserve_state_v003.aleo/update_RR_timestamp.future;
    input r8 as token_registry.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
