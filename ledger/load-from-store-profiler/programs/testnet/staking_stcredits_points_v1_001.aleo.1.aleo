import credits.aleo;
import multi_token_support_program.aleo;
import spectre_access_control_v1_001.aleo;
import spectre_acl_manager_v1_001.aleo;
import staking_stcredits_v1_001.aleo;

program staking_stcredits_points_v1_001.aleo;

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

struct metadata:
    name as u128;
    symbol as u64;
    decimals as u8;

struct UserState:
    stcredits as u64;
    points as u128;
    height as u32;
    inviter as address;
    inviter_of_inviter as address;
    invite_points as u128;
    invite_of_invite_points as u128;

struct Stats:
    stcredits as u64;
    points as u128;

mapping states:
    key as address.public;
    value as UserState.public;

mapping inviters:
    key as u32.public;
    value as address.public;

mapping invite_codes:
    key as address.public;
    value as u32.public;

mapping invite_code_counter:
    key as u8.public;
    value as u32.public;

mapping stats:
    key as u8.public;
    value as Stats.public;

mapping paused:
    key as u8.public;
    value as boolean.public;

function pause:
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r0;
    async pause r0 into r1;
    output r1 as staking_stcredits_points_v1_001.aleo/pause.future;

finalize pause:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    await r0;
    set true into paused[0u8];

function unpause:
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r0;
    async unpause r0 into r1;
    output r1 as staking_stcredits_points_v1_001.aleo/unpause.future;

finalize unpause:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    await r0;
    set false into paused[0u8];

function settle:
    async settle self.caller into r0;
    output r0 as staking_stcredits_points_v1_001.aleo/settle.future;

finalize settle:
    input r0 as address.public;
    get paused[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    get states[r0] into r3;
    is.neq r3.inviter aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r4;
    is.neq r3.inviter_of_inviter aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r5;
    cast r3.stcredits into r6 as u128;
    sub block.height r3.height into r7;
    cast r7 into r8 as u128;
    mul r6 r8 into r9;
    mul r9 16u128 into r10;
    div r10 100u128 into r11;
    mul r9 8u128 into r12;
    div r12 100u128 into r13;
    add r3.points r9 into r14;
    cast r3.stcredits r14 block.height r3.inviter r3.inviter_of_inviter r3.invite_points r3.invite_of_invite_points into r15 as UserState;
    set r15 into states[r0];
    gt r11 0u128 into r16;
    and r4 r16 into r17;
    branch.eq r17 false to end_then_0_0;
    cast 0u64 0u128 0u32 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0u128 into r18 as UserState;
    get.or_use states[r3.inviter] r18 into r19;
    add r19.points r11 into r20;
    add r19.invite_points r11 into r21;
    cast r19.stcredits r20 r19.height r19.inviter r19.inviter_of_inviter r21 r19.invite_of_invite_points into r22 as UserState;
    set r22 into states[r3.inviter];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    gt r13 0u128 into r23;
    and r5 r23 into r24;
    branch.eq r24 false to end_then_0_2;
    cast 0u64 0u128 0u32 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0u128 into r25 as UserState;
    get.or_use states[r3.inviter_of_inviter] r25 into r26;
    add r26.points r13 into r27;
    add r26.invite_of_invite_points r13 into r28;
    cast r26.stcredits r27 r26.height r26.inviter r26.inviter_of_inviter r26.invite_points r28 into r29 as UserState;
    set r29 into states[r3.inviter_of_inviter];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
    cast 0u64 0u128 into r30 as Stats;
    get.or_use stats[0u8] r30 into r31;
    add r31.points r9 into r32;
    ternary r4 r11 0u128 into r33;
    add r32 r33 into r34;
    ternary r5 r13 0u128 into r35;
    add r34 r35 into r36;
    cast r31.stcredits r36 into r37 as Stats;
    set r37 into stats[0u8];

function lock:
    input r0 as u64.public;
    input r1 as u32.public;
    cast staking_stcredits_points_v1_001.aleo into r2 as address;
    call staking_stcredits_v1_001.aleo/transfer_from_public self.signer r2 r0 into r3;
    async lock r3 self.signer r0 r1 into r4;
    output r4 as staking_stcredits_points_v1_001.aleo/lock.future;

finalize lock:
    input r0 as staking_stcredits_v1_001.aleo/transfer_from_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u32.public;
    await r0;
    get paused[0u8] into r4;
    not r4 into r5;
    assert.eq r5 true;
    cast 0u64 0u128 0u32 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0u128 into r6 as UserState;
    get.or_use states[r1] r6 into r7;
    is.eq r7.height 0u32 into r8;
    is.eq r3 0u32 into r9;
    or r8 r9 into r10;
    assert.eq r10 true;
    get.or_use inviters[r3] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r11;
    is.neq r11 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r12;
    is.eq r3 0u32 into r13;
    or r12 r13 into r14;
    assert.eq r14 true;
    cast 0u64 0u128 0u32 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0u128 into r15 as UserState;
    get.or_use states[r11] r15 into r16;
    ternary r8 r11 r7.inviter into r17;
    ternary r8 r16.inviter r7.inviter_of_inviter into r18;
    is.neq r17 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r19;
    is.neq r18 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r20;
    cast r7.stcredits into r21 as u128;
    sub block.height r7.height into r22;
    cast r22 into r23 as u128;
    mul r21 r23 into r24;
    mul r24 16u128 into r25;
    div r25 100u128 into r26;
    mul r24 8u128 into r27;
    div r27 100u128 into r28;
    add r7.stcredits r2 into r29;
    add r7.points r24 into r30;
    cast r29 r30 block.height r17 r18 r7.invite_points r7.invite_of_invite_points into r31 as UserState;
    set r31 into states[r1];
    gt r26 0u128 into r32;
    and r19 r32 into r33;
    branch.eq r33 false to end_then_0_4;
    cast 0u64 0u128 0u32 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0u128 into r34 as UserState;
    get.or_use states[r17] r34 into r35;
    add r35.points r26 into r36;
    add r35.invite_points r26 into r37;
    cast r35.stcredits r36 r35.height r35.inviter r35.inviter_of_inviter r37 r35.invite_of_invite_points into r38 as UserState;
    set r38 into states[r17];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    position end_otherwise_0_5;
    gt r28 0u128 into r39;
    and r20 r39 into r40;
    branch.eq r40 false to end_then_0_6;
    cast 0u64 0u128 0u32 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0u128 into r41 as UserState;
    get.or_use states[r18] r41 into r42;
    add r42.points r28 into r43;
    add r42.invite_of_invite_points r28 into r44;
    cast r42.stcredits r43 r42.height r42.inviter r42.inviter_of_inviter r42.invite_points r44 into r45 as UserState;
    set r45 into states[r18];
    branch.eq true true to end_otherwise_0_7;
    position end_then_0_6;
    position end_otherwise_0_7;
    cast 0u64 0u128 into r46 as Stats;
    get.or_use stats[0u8] r46 into r47;
    add r47.stcredits r2 into r48;
    add r47.points r24 into r49;
    ternary r19 r26 0u128 into r50;
    add r49 r50 into r51;
    ternary r20 r28 0u128 into r52;
    add r51 r52 into r53;
    cast r48 r53 into r54 as Stats;
    set r54 into stats[0u8];
    contains invite_codes[r1] into r55;
    not r55 into r56;
    branch.eq r56 false to end_then_0_8;
    get.or_use invite_code_counter[0u8] 10000u32 into r57;
    add r57 1u32 into r58;
    set r58 into invite_code_counter[0u8];
    set r1 into inviters[r58];
    set r58 into invite_codes[r1];
    branch.eq true true to end_otherwise_0_9;
    position end_then_0_8;
    position end_otherwise_0_9;

function unlock:
    input r0 as u64.public;
    call staking_stcredits_v1_001.aleo/transfer_public self.signer r0 into r1;
    async unlock r1 self.signer r0 into r2;
    output r2 as staking_stcredits_points_v1_001.aleo/unlock.future;

finalize unlock:
    input r0 as staking_stcredits_v1_001.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get paused[0u8] into r3;
    not r3 into r4;
    assert.eq r4 true;
    get states[r1] into r5;
    is.neq r5.inviter aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r6;
    is.neq r5.inviter_of_inviter aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r7;
    cast r5.stcredits into r8 as u128;
    sub block.height r5.height into r9;
    cast r9 into r10 as u128;
    mul r8 r10 into r11;
    mul r11 16u128 into r12;
    div r12 100u128 into r13;
    mul r11 8u128 into r14;
    div r14 100u128 into r15;
    sub r5.stcredits r2 into r16;
    add r5.points r11 into r17;
    cast r16 r17 block.height r5.inviter r5.inviter_of_inviter r5.invite_points r5.invite_of_invite_points into r18 as UserState;
    set r18 into states[r1];
    gt r13 0u128 into r19;
    and r6 r19 into r20;
    branch.eq r20 false to end_then_0_10;
    cast 0u64 0u128 0u32 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0u128 into r21 as UserState;
    get.or_use states[r5.inviter] r21 into r22;
    add r22.points r13 into r23;
    add r22.invite_points r13 into r24;
    cast r22.stcredits r23 r22.height r22.inviter r22.inviter_of_inviter r24 r22.invite_of_invite_points into r25 as UserState;
    set r25 into states[r5.inviter];
    branch.eq true true to end_otherwise_0_11;
    position end_then_0_10;
    position end_otherwise_0_11;
    gt r15 0u128 into r26;
    and r7 r26 into r27;
    branch.eq r27 false to end_then_0_12;
    cast 0u64 0u128 0u32 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0u128 into r28 as UserState;
    get.or_use states[r5.inviter_of_inviter] r28 into r29;
    add r29.points r15 into r30;
    add r29.invite_of_invite_points r15 into r31;
    cast r29.stcredits r30 r29.height r29.inviter r29.inviter_of_inviter r29.invite_points r31 into r32 as UserState;
    set r32 into states[r5.inviter_of_inviter];
    branch.eq true true to end_otherwise_0_13;
    position end_then_0_12;
    position end_otherwise_0_13;
    cast 0u64 0u128 into r33 as Stats;
    get.or_use stats[0u8] r33 into r34;
    sub r34.stcredits r2 into r35;
    add r34.points r11 into r36;
    ternary r6 r13 0u128 into r37;
    add r36 r37 into r38;
    ternary r7 r15 0u128 into r39;
    add r38 r39 into r40;
    cast r35 r40 into r41 as Stats;
    set r41 into stats[0u8];

function invite_code:
    async invite_code self.caller into r0;
    output r0 as staking_stcredits_points_v1_001.aleo/invite_code.future;

finalize invite_code:
    input r0 as address.public;
    contains invite_codes[r0] into r1;
    not r1 into r2;
    assert.eq r2 true;
    get.or_use invite_code_counter[0u8] 10000u32 into r3;
    add r3 1u32 into r4;
    set r4 into invite_code_counter[0u8];
    set r0 into inviters[r4];
    set r4 into invite_codes[r0];
