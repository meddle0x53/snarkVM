import arcn_access_manager_v1.aleo;
import arcn_whitelist.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_2.aleo;
import tokenlocker_v2.aleo;
import lock_distributor_v2.aleo;
import lp_locker_v2.aleo;
import wrapped_credits.aleo;

program launchpad_v2.aleo;

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

struct ProtocolFeeConfig:
    rate as u16;
    foundation as address;

struct LockedTokens:
    lock_owner as address;
    lock_id as field;
    token_id as field;
    locked_amount as u128;
    claimed_amount as u128;
    cancellable as boolean;
    start_block as u32;
    blocks_count_per_tick as u32;
    parts_unlock_per_tick as u128;

struct LockedTokensRef:
    lock_owner as address;
    lock_id as field;
    token_id as field;

struct ShareOwner:
    share_owner as address;
    lock_id as field;

struct ShareValue:
    share_size as u128;
    extracted_tokens as u128;

struct Ratio:
    numerator as u32;
    denominator as u32;

struct AllocationRules:
    min_allocation_enabled as boolean;
    max_allocation_enabled as boolean;
    is_oversubscription_enabled as boolean;
    min_allocation as u128;
    max_allocation as u128;

struct Schedule:
    sale_start as u32;
    sale_finish as u32;

struct LockInfo:
    lock_id as field;
    amount as u128;

struct ResultingLockInfo:
    start_block as u32;
    block_length as u32;
    part as Ratio;

struct SaleMetadata:
    sale_id as field;
    price_ratio as Ratio;
    token_id as field;
    sale_max_amount as u128;
    pool_max_amount as u128;
    min_goal as u128;
    allocation_rules as AllocationRules;
    team_lock as LockInfo;
    sale_lock as LockInfo;
    schedule as Schedule;
    receiver as address;
    completion_status as u8;
    resulting_lock_params as ResultingLockInfo;

struct RefundKey:
    sale_id as field;
    refund_owner as address;

struct UnclaimedTokenOwner:
    account as address;
    token_id as field;

struct LaunchpadFeeConfig:
    rate as u16;

struct finalize_schedule_sale_props:
    sale_id as field;
    token_id as field;
    sale_max_amount as u128;
    pool_max_amount as u128;
    min_goal as u128;
    price_ratio_numerator as u32;
    price_ratio_denominator as u32;
    min_allocation_enabled as boolean;
    max_allocation_enabled as boolean;
    is_oversubscription_enabled as boolean;
    min_allocation as u128;
    max_allocation as u128;
    sale_start as u32;
    sale_finish as u32;
    receiver as address;
    team_lock as LockInfo;
    sale_lock as LockInfo;
    resulting_lock_params as ResultingLockInfo;

struct schedule_sale_props:
    sale_id as field;
    token_id as field;
    sale_amount as u128;
    min_goal as u128;
    price_ratio_numerator as u32;
    price_ratio_denominator as u32;
    min_allocation_enabled as boolean;
    max_allocation_enabled as boolean;
    is_oversubscription_enabled as boolean;
    min_allocation as u128;
    max_allocation as u128;
    sale_start as u32;
    sale_finish as u32;
    team_lock_receiver as address;
    team_lock_id as field;
    team_lock_amount as u128;
    team_lock_block_length as u32;
    sale_lock_id as field;
    sale_lock_block_length as u32;
    resulting_lock_params as ResultingLockInfo;

mapping sales:
    key as field.public;
    value as SaleMetadata.public;

mapping sale_collected_amounts:
    key as field.public;
    value as u128.public;

mapping refunded:
    key as field.public;
    value as boolean.public;

mapping sale_unclaimed_token_amount:
    key as field.public;
    value as u128.public;

mapping fee_config:
    key as field.public;
    value as LaunchpadFeeConfig.public;

mapping accrued_fees:
    key as field.public;
    value as u128.public;

function set_protocol_fee_public:
    input r0 as field.public;
    input r1 as LaunchpadFeeConfig.public;
    lte r1.rate 10000u16 into r2;
    assert.eq r2 true;
    call arcn_access_manager_v1.aleo/check_access_public self.caller into r3;
    async set_protocol_fee_public r3 r0 r1 into r4;
    output r4 as launchpad_v2.aleo/set_protocol_fee_public.future;

finalize set_protocol_fee_public:
    input r0 as arcn_access_manager_v1.aleo/check_access_public.future;
    input r1 as field.public;
    input r2 as LaunchpadFeeConfig.public;
    await r0;
    is.eq r1 1field into r3;
    contains sales[r1] into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    set r2 into fee_config[r1];

function withdraw_protocol_fee:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    call arcn_access_manager_v1.aleo/check_access_public self.caller into r3;
    call token_registry.aleo/transfer_public r1 r0 r2 into r4;
    async withdraw_protocol_fee r3 r4 r1 r2 into r5;
    output r5 as launchpad_v2.aleo/withdraw_protocol_fee.future;

finalize withdraw_protocol_fee:
    input r0 as arcn_access_manager_v1.aleo/check_access_public.future;
    input r1 as token_registry.aleo/transfer_public.future;
    input r2 as field.public;
    input r3 as u128.public;
    get accrued_fees[r2] into r4;
    gte r4 r3 into r5;
    assert.eq r5 true;
    await r0;
    await r1;
    sub r4 r3 into r6;
    set r6 into accrued_fees[r2];

function schedule_sale:
    input r0 as schedule_sale_props.public;
    gt r0.sale_amount 0u128 into r1;
    assert.eq r1 true;
    gt r0.resulting_lock_params.part.numerator 0u32 into r2;
    assert.eq r2 true;
    gt r0.resulting_lock_params.part.denominator 0u32 into r3;
    assert.eq r3 true;
    div r0.resulting_lock_params.part.denominator r0.resulting_lock_params.part.numerator into r4;
    lte r4 2u32 into r5;
    assert.eq r5 true;
    mul 2u32 r0.resulting_lock_params.part.denominator into r6;
    sub r6 r0.resulting_lock_params.part.numerator into r7;
    cast r0.resulting_lock_params.part.denominator r7 into r8 as Ratio;
    cast r8.numerator into r9 as u128;
    mul r0.sale_amount r9 into r10;
    cast r8.denominator into r11 as u128;
    div r10 r11 into r12;
    sub r0.sale_amount r12 into r13;
    lte r0.min_goal r12 into r14;
    assert.eq r14 true;
    gt r0.price_ratio_numerator 0u32 into r15;
    assert.eq r15 true;
    gt r0.price_ratio_denominator 0u32 into r16;
    assert.eq r16 true;
    gt r0.sale_start 0u32 into r17;
    assert.eq r17 true;
    gt r0.sale_finish r0.sale_start into r18;
    assert.eq r18 true;
    not r0.max_allocation_enabled into r19;
    gt r0.max_allocation r0.min_allocation into r20;
    or r19 r20 into r21;
    assert.eq r21 true;
    not r0.min_allocation_enabled into r22;
    gt r0.min_allocation 0u128 into r23;
    or r22 r23 into r24;
    assert.eq r24 true;
    call token_registry.aleo/transfer_public_as_signer r0.token_id launchpad_v2.aleo r0.sale_amount into r25;
    call tokenlocker_v2.aleo/linear_public r0.team_lock_id r0.token_id r0.team_lock_amount launchpad_v2.aleo r0.team_lock_block_length r0.sale_finish true into r26 r27;
    call lock_distributor_v2.aleo/create_lock r0.team_lock_id r0.team_lock_id r0.team_lock_receiver into r28;
    call tokenlocker_v2.aleo/linear_public_empty r0.sale_lock_id r0.token_id launchpad_v2.aleo r0.sale_lock_block_length r0.sale_finish true into r29 r30;
    call lock_distributor_v2.aleo/create_lock r0.sale_lock_id r0.sale_lock_id launchpad_v2.aleo into r31;
    call credits.aleo/transfer_public_as_signer aleo16e5ckxpxh0pshx03shk43mc5l8m7lgrrrk2vjefw3muypc4xuc9sea9wmc 10000000u64 into r32;
    ternary r0.min_allocation_enabled r0.min_allocation 0u128 into r33;
    ternary r0.max_allocation_enabled r0.max_allocation 0u128 into r34;
    cast r0.team_lock_id r0.team_lock_amount into r35 as LockInfo;
    cast r0.sale_lock_id 0u128 into r36 as LockInfo;
    cast r0.sale_id r0.token_id r12 r13 r0.min_goal r0.price_ratio_numerator r0.price_ratio_denominator r0.min_allocation_enabled r0.max_allocation_enabled r0.is_oversubscription_enabled r33 r34 r0.sale_start r0.sale_finish self.caller r35 r36 r0.resulting_lock_params into r37 as finalize_schedule_sale_props;
    async schedule_sale r25 r27 r28 r30 r31 r32 r37 into r38;
    output r38 as launchpad_v2.aleo/schedule_sale.future;

finalize schedule_sale:
    input r0 as token_registry.aleo/transfer_public_as_signer.future;
    input r1 as tokenlocker_v2.aleo/linear_public.future;
    input r2 as lock_distributor_v2.aleo/create_lock.future;
    input r3 as tokenlocker_v2.aleo/linear_public_empty.future;
    input r4 as lock_distributor_v2.aleo/create_lock.future;
    input r5 as credits.aleo/transfer_public_as_signer.future;
    input r6 as finalize_schedule_sale_props.public;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    contains sales[r6.sale_id] into r7;
    not r7 into r8;
    assert.eq r8 true;
    lte r6.resulting_lock_params.part.numerator r6.resulting_lock_params.part.denominator into r9;
    assert.eq r9 true;
    gte r6.sale_start block.height into r10;
    assert.eq r10 true;
    cast r6.price_ratio_numerator r6.price_ratio_denominator into r11 as Ratio;
    cast r6.min_allocation_enabled r6.max_allocation_enabled r6.is_oversubscription_enabled r6.min_allocation r6.max_allocation into r12 as AllocationRules;
    cast r6.sale_start r6.sale_finish into r13 as Schedule;
    cast r6.sale_id r11 r6.token_id r6.sale_max_amount r6.pool_max_amount r6.min_goal r12 r6.team_lock r6.sale_lock r13 r6.receiver 0u8 r6.resulting_lock_params into r14 as SaleMetadata;
    set r14 into sales[r6.sale_id];

function complete_sale_success:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    input r5 as field.public;
    input r6 as u128.public;
    input r7 as address.public;
    input r8 as u32.public;
    input r9 as u32.public;
    call tokenlocker_v2.aleo/deposit_public r3 r1 r4 into r10;
    call tokenlocker_v2.aleo/transfer_lock r2 lock_distributor_v2.aleo into r11;
    call tokenlocker_v2.aleo/transfer_lock r3 lock_distributor_v2.aleo into r12;
    cast r6 into r13 as u64;
    call credits.aleo/transfer_public_to_private self.signer r13 into r14 r15;
    cast r6 into r16 as u64;
    call wrapped_credits.aleo/deposit_credits_private r14 r16 into r17 r18 r19;
    call tokenlocker_v2.aleo/linear r5 r18 r6 r7 r8 r9 false into r20 r21 r22;
    async complete_sale_success r10 r11 r12 r15 r19 r22 r0 r2 r3 r4 r6 r7 r8 r9 into r23;
    output r23 as launchpad_v2.aleo/complete_sale_success.future;

finalize complete_sale_success:
    input r0 as tokenlocker_v2.aleo/deposit_public.future;
    input r1 as tokenlocker_v2.aleo/transfer_lock.future;
    input r2 as tokenlocker_v2.aleo/transfer_lock.future;
    input r3 as credits.aleo/transfer_public_to_private.future;
    input r4 as wrapped_credits.aleo/deposit_credits_private.future;
    input r5 as tokenlocker_v2.aleo/linear.future;
    input r6 as field.public;
    input r7 as field.public;
    input r8 as field.public;
    input r9 as u128.public;
    input r10 as u128.public;
    input r11 as address.public;
    input r12 as u32.public;
    input r13 as u32.public;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    get sales[r6] into r14;
    assert.eq r14.completion_status 0u8;
    lte r14.schedule.sale_finish block.height into r15;
    assert.eq r15 true;
    assert.eq r14.team_lock.lock_id r7;
    assert.eq r14.sale_lock.lock_id r8;
    assert.eq r14.resulting_lock_params.start_block r13;
    assert.eq r14.resulting_lock_params.block_length r12;
    assert.eq r14.receiver r11;
    cast r14.price_ratio.numerator into r16 as u128;
    mul r14.min_goal r16 into r17;
    cast r14.price_ratio.denominator into r18 as u128;
    div r17 r18 into r19;
    cast r14.price_ratio.numerator into r20 as u128;
    mul r14.sale_max_amount r20 into r21;
    cast r14.price_ratio.denominator into r22 as u128;
    div r21 r22 into r23;
    get sale_collected_amounts[r6] into r24;
    gt r24 r23 into r25;
    ternary r25 r23 r24 into r26;
    gte r26 r19 into r27;
    assert.eq r27 true;
    cast 0u16 into r28 as LaunchpadFeeConfig;
    get.or_use fee_config[1field] r28 into r29;
    get.or_use fee_config[r6] r29 into r30;
    cast r30.rate into r31 as u128;
    mul r26 r31 into r32;
    cast 10000u16 into r33 as u128;
    div r32 r33 into r34;
    sub r26 r34 into r35;
    cast r14.resulting_lock_params.part.numerator into r36 as u128;
    mul r35 r36 into r37;
    cast r14.resulting_lock_params.part.denominator into r38 as u128;
    div r37 r38 into r39;
    assert.eq r39 r10;
    cast r14.resulting_lock_params.part.numerator into r40 as u128;
    mul r26 r40 into r41;
    cast r14.resulting_lock_params.part.denominator into r42 as u128;
    div r41 r42 into r43;
    cast r14.price_ratio.denominator r14.price_ratio.numerator into r44 as Ratio;
    cast r44.numerator into r45 as u128;
    mul r43 r45 into r46;
    cast r44.denominator into r47 as u128;
    div r46 r47 into r48;
    assert.eq r48 r9;
    sub r14.sale_max_amount r9 into r49;
    cast r14.receiver r14.token_id into r50 as UnclaimedTokenOwner;
    hash.bhp256 r50 into r51 as field;
    set r49 into sale_unclaimed_token_amount[r51];
    get.or_use accrued_fees[3443843282313283355522573239085696902919850365217539366784739393210722344986field] 0u128 into r52;
    add r52 r34 into r53;
    set r53 into accrued_fees[3443843282313283355522573239085696902919850365217539366784739393210722344986field];
    cast r14.sale_lock.lock_id r9 into r54 as LockInfo;
    cast r6 r14.price_ratio r14.token_id r14.sale_max_amount r14.pool_max_amount r14.min_goal r14.allocation_rules r14.team_lock r54 r14.schedule r14.receiver 2u8 r14.resulting_lock_params into r55 as SaleMetadata;
    set r55 into sales[r6];

function create_pool_credits_is_token1:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u128.private;
    input r3 as u128.private;
    input r4 as boolean.private;
    input r5 as address.private;
    input r6 as field.private;
    cast r2 into r7 as u64;
    call credits.aleo/transfer_public_to_private self.signer r7 into r8 r9;
    cast r2 into r10 as u64;
    call wrapped_credits.aleo/deposit_credits_private r8 r10 into r11 r12 r13;
    call token_registry.aleo/transfer_public_to_private r1 self.signer r3 r4 into r14 r15;
    call arcn_pool_v2_2_2.aleo/create_pool self.signer r12 r12.amount r14 r14.amount 55u16 r6 0u8 0u16 into r16 r17 r18 r19 r20;
    call arcn_pool_v2_2_2.aleo/transfer_lp_receipt_by_salt r6 r16.pool_key r12.token_id r14.token_id lp_locker_v2.aleo r6 true into r21 r22;
    call lp_locker_v2.aleo/lock_lp r6 r5 into r23;
    async create_pool_credits_is_token1 r9 r13 r15 r20 r22 r23 r0 r1 r2 r3 r5 into r24;
    output r24 as launchpad_v2.aleo/create_pool_credits_is_token1.future;

finalize create_pool_credits_is_token1:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as wrapped_credits.aleo/deposit_credits_private.future;
    input r2 as token_registry.aleo/transfer_public_to_private.future;
    input r3 as arcn_pool_v2_2_2.aleo/create_pool.future;
    input r4 as arcn_pool_v2_2_2.aleo/transfer_lp_receipt_by_salt.future;
    input r5 as lp_locker_v2.aleo/lock_lp.future;
    input r6 as field.public;
    input r7 as field.public;
    input r8 as u128.public;
    input r9 as u128.public;
    input r10 as address.public;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    get sales[r6] into r11;
    assert.eq r11.completion_status 2u8;
    assert.eq r11.token_id r7;
    assert.eq r11.receiver r10;
    cast r11.price_ratio.numerator into r12 as u128;
    mul r11.sale_max_amount r12 into r13;
    cast r11.price_ratio.denominator into r14 as u128;
    div r13 r14 into r15;
    get sale_collected_amounts[r6] into r16;
    gt r16 r15 into r17;
    ternary r17 r15 r16 into r18;
    cast 0u16 into r19 as LaunchpadFeeConfig;
    get.or_use fee_config[1field] r19 into r20;
    get.or_use fee_config[r6] r20 into r21;
    cast r21.rate into r22 as u128;
    mul r18 r22 into r23;
    cast 10000u16 into r24 as u128;
    div r23 r24 into r25;
    sub r18 r25 into r26;
    cast r11.resulting_lock_params.part.numerator into r27 as u128;
    mul r26 r27 into r28;
    cast r11.resulting_lock_params.part.denominator into r29 as u128;
    div r28 r29 into r30;
    sub r18 r25 into r31;
    sub r31 r30 into r32;
    assert.eq r32 r8;
    cast r11.price_ratio.denominator r11.price_ratio.numerator into r33 as Ratio;
    cast r33.numerator into r34 as u128;
    mul r32 r34 into r35;
    cast r33.denominator into r36 as u128;
    div r35 r36 into r37;
    assert.eq r37 r9;
    sub r11.pool_max_amount r37 into r38;
    cast r11.receiver r11.token_id into r39 as UnclaimedTokenOwner;
    hash.bhp256 r39 into r40 as field;
    get.or_use sale_unclaimed_token_amount[r40] 0u128 into r41;
    add r38 r41 into r42;
    set r42 into sale_unclaimed_token_amount[r40];
    cast r6 r11.price_ratio r11.token_id r11.sale_max_amount r11.pool_max_amount r11.min_goal r11.allocation_rules r11.team_lock r11.sale_lock r11.schedule r11.receiver 3u8 r11.resulting_lock_params into r43 as SaleMetadata;
    set r43 into sales[r6];

function create_pool_credits_is_token2:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u128.private;
    input r3 as u128.private;
    input r4 as boolean.private;
    input r5 as address.private;
    input r6 as field.private;
    cast r2 into r7 as u64;
    call credits.aleo/transfer_public_to_private self.signer r7 into r8 r9;
    cast r2 into r10 as u64;
    call wrapped_credits.aleo/deposit_credits_private r8 r10 into r11 r12 r13;
    call token_registry.aleo/transfer_public_to_private r1 self.signer r3 r4 into r14 r15;
    call arcn_pool_v2_2_2.aleo/create_pool r5 r14 r14.amount r12 r12.amount 55u16 r6 0u8 0u16 into r16 r17 r18 r19 r20;
    call arcn_pool_v2_2_2.aleo/transfer_lp_receipt_by_salt r6 r16.pool_key r14.token_id r12.token_id lp_locker_v2.aleo r6 true into r21 r22;
    call lp_locker_v2.aleo/lock_lp r6 r5 into r23;
    async create_pool_credits_is_token2 r9 r13 r15 r20 r22 r23 r0 r1 r2 r3 r5 into r24;
    output r24 as launchpad_v2.aleo/create_pool_credits_is_token2.future;

finalize create_pool_credits_is_token2:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as wrapped_credits.aleo/deposit_credits_private.future;
    input r2 as token_registry.aleo/transfer_public_to_private.future;
    input r3 as arcn_pool_v2_2_2.aleo/create_pool.future;
    input r4 as arcn_pool_v2_2_2.aleo/transfer_lp_receipt_by_salt.future;
    input r5 as lp_locker_v2.aleo/lock_lp.future;
    input r6 as field.public;
    input r7 as field.public;
    input r8 as u128.public;
    input r9 as u128.public;
    input r10 as address.public;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    get sales[r6] into r11;
    assert.eq r11.completion_status 2u8;
    assert.eq r11.token_id r7;
    assert.eq r11.receiver r10;
    cast r11.price_ratio.numerator into r12 as u128;
    mul r11.sale_max_amount r12 into r13;
    cast r11.price_ratio.denominator into r14 as u128;
    div r13 r14 into r15;
    get sale_collected_amounts[r6] into r16;
    gt r16 r15 into r17;
    ternary r17 r15 r16 into r18;
    cast 0u16 into r19 as LaunchpadFeeConfig;
    get.or_use fee_config[1field] r19 into r20;
    get.or_use fee_config[r6] r20 into r21;
    cast r21.rate into r22 as u128;
    mul r18 r22 into r23;
    cast 10000u16 into r24 as u128;
    div r23 r24 into r25;
    sub r18 r25 into r26;
    cast r11.resulting_lock_params.part.numerator into r27 as u128;
    mul r26 r27 into r28;
    cast r11.resulting_lock_params.part.denominator into r29 as u128;
    div r28 r29 into r30;
    sub r18 r25 into r31;
    sub r31 r30 into r32;
    assert.eq r32 r8;
    cast r11.price_ratio.denominator r11.price_ratio.numerator into r33 as Ratio;
    cast r33.numerator into r34 as u128;
    mul r32 r34 into r35;
    cast r33.denominator into r36 as u128;
    div r35 r36 into r37;
    assert.eq r37 r9;
    sub r11.pool_max_amount r37 into r38;
    cast r11.receiver r11.token_id into r39 as UnclaimedTokenOwner;
    hash.bhp256 r39 into r40 as field;
    get.or_use sale_unclaimed_token_amount[r40] 0u128 into r41;
    add r38 r41 into r42;
    set r42 into sale_unclaimed_token_amount[r40];
    cast r6 r11.price_ratio r11.token_id r11.sale_max_amount r11.pool_max_amount r11.min_goal r11.allocation_rules r11.team_lock r11.sale_lock r11.schedule r11.receiver 3u8 r11.resulting_lock_params into r43 as SaleMetadata;
    set r43 into sales[r6];

function complete_sale_fail:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as address.private;
    input r5 as u128.private;
    input r6 as u128.private;
    call tokenlocker_v2.aleo/cancell_lock r1 r3 r4 r5 into r7;
    call tokenlocker_v2.aleo/cancell_lock r2 r3 r4 0u128 into r8;
    async complete_sale_fail r7 r8 r0 r1 r2 r3 r4 r5 r6 into r9;
    output r9 as launchpad_v2.aleo/complete_sale_fail.future;

finalize complete_sale_fail:
    input r0 as tokenlocker_v2.aleo/cancell_lock.future;
    input r1 as tokenlocker_v2.aleo/cancell_lock.future;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    input r6 as address.public;
    input r7 as u128.public;
    input r8 as u128.public;
    await r0;
    await r1;
    get sales[r2] into r9;
    assert.eq r9.completion_status 0u8;
    lte r9.schedule.sale_finish block.height into r10;
    assert.eq r10 true;
    assert.eq r9.team_lock.lock_id r3;
    assert.eq r9.sale_lock.lock_id r4;
    assert.eq r9.token_id r5;
    assert.eq r9.team_lock.amount r7;
    assert.eq r9.sale_lock.amount 0u128;
    add r9.sale_max_amount r9.pool_max_amount into r11;
    assert.eq r11 r8;
    assert.eq r9.receiver r6;
    cast r6 r5 into r12 as UnclaimedTokenOwner;
    hash.bhp256 r12 into r13 as field;
    set r8 into sale_unclaimed_token_amount[r13];
    cast r9.price_ratio.numerator into r14 as u128;
    mul r9.min_goal r14 into r15;
    cast r9.price_ratio.denominator into r16 as u128;
    div r15 r16 into r17;
    get.or_use sale_collected_amounts[r2] 0u128 into r18;
    lt r18 r17 into r19;
    is.eq r17 0u128 into r20;
    is.eq r18 r17 into r21;
    and r20 r21 into r22;
    or r19 r22 into r23;
    assert.eq r23 true;
    cast r2 r9.price_ratio r9.token_id r9.sale_max_amount r9.pool_max_amount r9.min_goal r9.allocation_rules r9.team_lock r9.sale_lock r9.schedule r9.receiver 1u8 r9.resulting_lock_params into r24 as SaleMetadata;
    set r24 into sales[r2];

function purchase_private:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/credits.record;
    input r3 as field.public;
    input r4 as address.private;
    input r5 as Ratio.public;
    call credits.aleo/transfer_private_to_public r2 launchpad_v2.aleo r1 into r6 r7;
    cast r1 into r8 as u128;
    cast r5.denominator r5.numerator into r9 as Ratio;
    cast r9.numerator into r10 as u128;
    mul r8 r10 into r11;
    cast r9.denominator into r12 as u128;
    div r11 r12 into r13;
    call lock_distributor_v2.aleo/set_shares r3 r4 r13 true into r14;
    async purchase_private r7 r14 r0 r1 r3 r5 into r15;
    output r6 as credits.aleo/credits.record;
    output r15 as launchpad_v2.aleo/purchase_private.future;

finalize purchase_private:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as lock_distributor_v2.aleo/set_shares.future;
    input r2 as field.public;
    input r3 as u64.public;
    input r4 as field.public;
    input r5 as Ratio.public;
    await r0;
    await r1;
    get sales[r2] into r6;
    assert.eq r6.completion_status 0u8;
    assert.eq r6.price_ratio.numerator r5.numerator;
    assert.eq r6.price_ratio.denominator r5.denominator;
    assert.eq r6.sale_lock.lock_id r4;
    lte r6.schedule.sale_start block.height into r7;
    assert.eq r7 true;
    gte r6.schedule.sale_finish block.height into r8;
    assert.eq r8 true;
    cast r3 into r9 as u128;
    cast r5.denominator r5.numerator into r10 as Ratio;
    cast r10.numerator into r11 as u128;
    mul r9 r11 into r12;
    cast r10.denominator into r13 as u128;
    div r12 r13 into r14;
    not r6.allocation_rules.min_allocation_enabled into r15;
    gte r14 r6.allocation_rules.min_allocation into r16;
    or r15 r16 into r17;
    assert.eq r17 true;
    not r6.allocation_rules.max_allocation_enabled into r18;
    lte r14 r6.allocation_rules.max_allocation into r19;
    or r18 r19 into r20;
    assert.eq r20 true;
    cast r5.numerator into r21 as u128;
    mul r6.sale_max_amount r21 into r22;
    cast r5.denominator into r23 as u128;
    div r22 r23 into r24;
    get.or_use sale_collected_amounts[r2] 0u128 into r25;
    cast r3 into r26 as u128;
    add r25 r26 into r27;
    lte r27 r24 into r28;
    or r6.allocation_rules.is_oversubscription_enabled r28 into r29;
    assert.eq r29 true;
    cast r3 into r30 as u128;
    add r25 r30 into r31;
    set r31 into sale_collected_amounts[r2];

function purchase_public:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as field.public;
    input r3 as address.private;
    input r4 as Ratio.public;
    call credits.aleo/transfer_public_as_signer launchpad_v2.aleo r1 into r5;
    cast r1 into r6 as u128;
    cast r4.denominator r4.numerator into r7 as Ratio;
    cast r7.numerator into r8 as u128;
    mul r6 r8 into r9;
    cast r7.denominator into r10 as u128;
    div r9 r10 into r11;
    call lock_distributor_v2.aleo/set_shares r2 r3 r11 true into r12;
    async purchase_public r5 r12 r0 r1 r2 r4 into r13;
    output r13 as launchpad_v2.aleo/purchase_public.future;

finalize purchase_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as lock_distributor_v2.aleo/set_shares.future;
    input r2 as field.public;
    input r3 as u64.public;
    input r4 as field.public;
    input r5 as Ratio.public;
    await r0;
    await r1;
    get sales[r2] into r6;
    assert.eq r6.completion_status 0u8;
    assert.eq r6.price_ratio.numerator r5.numerator;
    assert.eq r6.price_ratio.denominator r5.denominator;
    assert.eq r6.sale_lock.lock_id r4;
    lte r6.schedule.sale_start block.height into r7;
    assert.eq r7 true;
    gte r6.schedule.sale_finish block.height into r8;
    assert.eq r8 true;
    cast r3 into r9 as u128;
    cast r5.denominator r5.numerator into r10 as Ratio;
    cast r10.numerator into r11 as u128;
    mul r9 r11 into r12;
    cast r10.denominator into r13 as u128;
    div r12 r13 into r14;
    not r6.allocation_rules.min_allocation_enabled into r15;
    gte r14 r6.allocation_rules.min_allocation into r16;
    or r15 r16 into r17;
    assert.eq r17 true;
    not r6.allocation_rules.max_allocation_enabled into r18;
    lte r14 r6.allocation_rules.max_allocation into r19;
    or r18 r19 into r20;
    assert.eq r20 true;
    cast r5.numerator into r21 as u128;
    mul r6.sale_max_amount r21 into r22;
    cast r5.denominator into r23 as u128;
    div r22 r23 into r24;
    get.or_use sale_collected_amounts[r2] 0u128 into r25;
    cast r3 into r26 as u128;
    add r25 r26 into r27;
    lte r27 r24 into r28;
    or r6.allocation_rules.is_oversubscription_enabled r28 into r29;
    assert.eq r29 true;
    cast r3 into r30 as u128;
    add r25 r30 into r31;
    set r31 into sale_collected_amounts[r2];

function refund_sale:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as u64.private;
    call credits.aleo/transfer_public r1 r2 into r3;
    cast r0 self.caller into r4 as RefundKey;
    hash.bhp256 r4 into r5 as field;
    async refund_sale r3 r0 r5 r2 self.caller into r6;
    output r6 as launchpad_v2.aleo/refund_sale.future;

finalize refund_sale:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u64.public;
    input r4 as address.public;
    await r0;
    get sales[r1] into r5;
    get sale_collected_amounts[r1] into r6;
    cast r5.price_ratio.denominator r5.price_ratio.numerator into r7 as Ratio;
    cast r7.numerator into r8 as u128;
    mul r6 r8 into r9;
    cast r7.denominator into r10 as u128;
    div r9 r10 into r11;
    gte r5.completion_status 2u8 into r12;
    and r12 r5.allocation_rules.is_oversubscription_enabled into r13;
    gt r11 r5.sale_max_amount into r14;
    and r13 r14 into r15;
    is.eq r5.completion_status 1u8 into r16;
    or r16 r15 into r17;
    assert.eq r17 true;
    cast r4 r5.sale_lock.lock_id into r18 as ShareOwner;
    hash.bhp256 r18 into r19 as field;
    get lock_distributor_v2.aleo/user_shares[r19] into r20;
    mul r20.share_size r5.sale_max_amount into r21;
    div r21 r11 into r22;
    sub r20.share_size r22 into r23;
    ternary r15 r23 r20.share_size into r24;
    cast r5.price_ratio.numerator into r25 as u128;
    mul r24 r25 into r26;
    cast r5.price_ratio.denominator into r27 as u128;
    div r26 r27 into r28;
    get.or_use refunded[r2] false into r29;
    not r29 into r30;
    assert.eq r30 true;
    cast r3 into r31 as u128;
    assert.eq r28 r31;
    set true into refunded[r2];

function withdraw_unclaimed_tokens:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u128.private;
    call token_registry.aleo/transfer_public r1 self.caller r2 into r3;
    async withdraw_unclaimed_tokens r3 r0 r1 r2 self.caller into r4;
    output r4 as launchpad_v2.aleo/withdraw_unclaimed_tokens.future;

finalize withdraw_unclaimed_tokens:
    input r0 as token_registry.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as address.public;
    await r0;
    get sales[r1] into r5;
    is.neq r5.completion_status 0u8 into r6;
    assert.eq r6 true;
    assert.eq r5.token_id r2;
    assert.eq r5.receiver r4;
    cast r4 r2 into r7 as UnclaimedTokenOwner;
    hash.bhp256 r7 into r8 as field;
    get sale_unclaimed_token_amount[r8] into r9;
    lte r3 r9 into r10;
    assert.eq r10 true;
    sub r9 r3 into r11;
    set r11 into sale_unclaimed_token_amount[r8];
