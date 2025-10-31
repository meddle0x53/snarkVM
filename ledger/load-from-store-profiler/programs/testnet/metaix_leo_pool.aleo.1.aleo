import credits.aleo;

program metaix_leo_pool.aleo;

mapping u128_settings:
    key as u8.public;
    value as u128.public;

mapping u32_settings:
    key as u8.public;
    value as u32.public;

mapping user_stakes:
    key as address.public;
    value as u128.public;

mapping user_last_acc_token_per_stake:
    key as address.public;
    value as u128.public;

mapping user_stored_token:
    key as address.public;
    value as u128.public;

mapping user_harvested_token:
    key as address.public;
    value as u128.public;

function set_token_info:
    input r0 as u128.public;
    assert.eq self.caller aleo154g0gsqg9n3z2rlmtcuj8h8fyk9kah6wyuyawe979qngzzs9fqpsdf64f2;
    async set_token_info 1u8 r0 into r1;
    output r1 as metaix_leo_pool.aleo/set_token_info.future;

finalize set_token_info:
    input r0 as u8.public;
    input r1 as u128.public;
    set r1 into u128_settings[r0];

function set_open_status:
    input r0 as u128.public;
    assert.eq self.caller aleo154g0gsqg9n3z2rlmtcuj8h8fyk9kah6wyuyawe979qngzzs9fqpsdf64f2;
    async set_open_status 0u8 r0 into r1;
    output r1 as metaix_leo_pool.aleo/set_open_status.future;

finalize set_open_status:
    input r0 as u8.public;
    input r1 as u128.public;
    set r1 into u128_settings[r0];

function deposit:
    input r0 as u128.public;
    async deposit r0 self.caller into r1;
    output r1 as metaix_leo_pool.aleo/deposit.future;

finalize deposit:
    input r0 as u128.public;
    input r1 as address.public;
    get u128_settings[0u8] into r2;
    assert.eq r2 1u128;
    get.or_use u32_settings[0u8] 0u32 into r3;
    lte block.height r3 into r4;
    branch.eq r4 false to end_then_0_0;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    get.or_use u32_settings[0u8] 0u32 into r5;
    gt block.height r5 into r6;
    get.or_use u128_settings[2u8] 0u128 into r7;
    gt r7 0u128 into r8;
    and r6 r8 into r9;
    branch.eq r9 false to end_then_0_2;
    get.or_use u128_settings[1u8] 0u128 into r10;
    get.or_use u32_settings[0u8] 0u32 into r11;
    sub block.height r11 into r12;
    cast r12 into r13 as u128;
    mul r10 r13 into r14;
    get.or_use u128_settings[3u8] 0u128 into r15;
    get.or_use u128_settings[2u8] 0u128 into r16;
    get.or_use u128_settings[4u8] 0u128 into r17;
    mul r14 1000000000000000000u128 into r18;
    div r18 r16 into r19;
    add r15 r19 into r20;
    set r20 into u128_settings[3u8];
    add r17 r14 into r21;
    set r21 into u128_settings[4u8];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
    set block.height into u32_settings[0u8];
    get.or_use user_stakes[r1] 0u128 into r22;
    gt r22 0u128 into r23;
    branch.eq r23 false to end_then_0_4;
    get.or_use u128_settings[3u8] 0u128 into r24;
    get.or_use user_last_acc_token_per_stake[r1] 0u128 into r25;
    sub r24 r25 into r26;
    mul r22 r26 into r27;
    div r27 1000000000000000000u128 into r28;
    gt r28 0u128 into r29;
    branch.eq r29 false to end_then_1_6;
    get user_stored_token[r1] into r30;
    add r30 r28 into r31;
    set r31 into user_stored_token[r1];
    branch.eq true true to end_otherwise_1_7;
    position end_then_1_6;
    position end_otherwise_1_7;
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    position end_otherwise_0_5;
    gt r0 0u128 into r32;
    branch.eq r32 false to end_then_0_8;
    add r22 r0 into r33;
    set r33 into user_stakes[r1];
    get.or_use u128_settings[2u8] 0u128 into r34;
    add r34 r0 into r35;
    set r35 into u128_settings[2u8];
    branch.eq true true to end_otherwise_0_9;
    position end_then_0_8;
    position end_otherwise_0_9;
    get.or_use u128_settings[3u8] 0u128 into r36;
    set r36 into user_last_acc_token_per_stake[r1];

function withdraw:
    input r0 as u128.public;
    cast r0 into r1 as u64;
    call credits.aleo/transfer_public self.caller r1 into r2;
    async withdraw r2 into r3;
    output r3 as metaix_leo_pool.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public.future;
    await r0;

function harvest:
    async harvest self.caller into r0;
    output r0 as metaix_leo_pool.aleo/harvest.future;

finalize harvest:
    input r0 as address.public;
    get.or_use u32_settings[0u8] 0u32 into r1;
    lte block.height r1 into r2;
    branch.eq r2 false to end_then_0_10;
    branch.eq true true to end_otherwise_0_11;
    position end_then_0_10;
    position end_otherwise_0_11;
    get.or_use u32_settings[0u8] 0u32 into r3;
    gt block.height r3 into r4;
    get.or_use u128_settings[2u8] 0u128 into r5;
    gt r5 0u128 into r6;
    and r4 r6 into r7;
    branch.eq r7 false to end_then_0_12;
    get.or_use u128_settings[1u8] 0u128 into r8;
    get.or_use u32_settings[0u8] 0u32 into r9;
    sub block.height r9 into r10;
    cast r10 into r11 as u128;
    mul r8 r11 into r12;
    get.or_use u128_settings[3u8] 0u128 into r13;
    get.or_use u128_settings[2u8] 0u128 into r14;
    get.or_use u128_settings[4u8] 0u128 into r15;
    mul r12 1000000000000000000u128 into r16;
    div r16 r14 into r17;
    add r13 r17 into r18;
    set r18 into u128_settings[3u8];
    add r15 r12 into r19;
    set r19 into u128_settings[4u8];
    branch.eq true true to end_otherwise_0_13;
    position end_then_0_12;
    position end_otherwise_0_13;
    set block.height into u32_settings[0u8];
    get.or_use user_stakes[r0] 0u128 into r20;
    get.or_use u128_settings[3u8] 0u128 into r21;
    get.or_use user_last_acc_token_per_stake[r0] 0u128 into r22;
    sub r21 r22 into r23;
    mul r20 r23 into r24;
    div r24 1000000000000000000u128 into r25;
    get.or_use user_stored_token[r0] 0u128 into r26;
    add r26 r25 into r27;
    gt r27 0u128 into r28;
    assert.eq r28 true;
    set 0u128 into user_stored_token[r0];
    set r21 into user_last_acc_token_per_stake[r0];
    get user_harvested_token[r0] into r29;
    add r29 r27 into r30;
    set r30 into user_harvested_token[r0];
    get.or_use u128_settings[5u8] 0u128 into r31;
    add r31 r27 into r32;
    set r32 into u128_settings[5u8];
