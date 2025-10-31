program rln_boardv02.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

struct Group:
    id as field;
    root as field;
    size as u32;

struct GroupMember:
    group_id as field;
    identity_commitment as field;
    index as u32;
    message_counter as u32;

struct RLNOutput:
    y as field;
    nullifier as field;
    root as field;

record UserMessageCounter:
    owner as address.private;
    group_id as field.private;
    counter as u32.private;

struct Message:
    message as field;
    timestamp as u32;

mapping rln_group:
    key as field.public;
    value as Group.public;

mapping rln_group_member:
    key as field.public;
    value as GroupMember.public;

mapping group_member_index:
    key as field.public;
    value as u32.public;

mapping group_member_exit_flag:
    key as field.public;
    value as boolean.public;

mapping group_nullifier:
    key as field.public;
    value as field.public;

mapping group_message:
    key as field.public;
    value as Message.public;

mapping rln_outputs:
    key as field.public;
    value as RLNOutput.public;

mapping messages:
    key as field.public;
    value as Message.public;

mapping deposits:
    key as field.public;
    value as u64.public;

function create_group:
    input r0 as field.private;
    async create_group r0 into r1;
    output r1 as rln_boardv02.aleo/create_group.future;

finalize create_group:
    input r0 as field.public;
    contains rln_group[r0] into r1;
    not r1 into r2;
    assert.eq r2 true;
    cast r0 0field 1u32 into r3 as Group;
    hash.psd2 r0 into r4 as field;
    set r4 into group_nullifier[r0];
    set r3 into rln_group[r0];

function mint_token:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller r0;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function register:
    input r0 as field.public;
    input r1 as field.private;
    input r2 as Token.record;
    input r3 as field.private;
    hash.psd2 r1 into r4 as field;
    is.eq r2.owner self.caller into r5;
    assert.eq r5 true;
    cast 2u32 into r6 as u64;
    gte r2.amount r6 into r7;
    assert.eq r7 true;
    cast 2u32 into r8 as u64;
    sub r2.amount r8 into r9;
    cast r2.owner r9 into r10 as Token.record;
    cast r0 r1 into r11 as [field; 2u32];
    hash.bhp256 r11 into r12 as field;
    cast 2u32 into r13 as u64;
    async register r0 r2.owner r12 r4 r13 r3 into r14;
    output r10 as Token.record;
    output r14 as rln_boardv02.aleo/register.future;

finalize register:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u64.public;
    input r5 as field.public;
    get rln_group[r0] into r6;
    cast r0 r3 r6.size 0u32 into r7 as GroupMember;
    cast r0 r3 into r8 as [field; 2u32];
    hash.psd2 r8 into r9 as field;
    contains rln_group_member[r9] into r10;
    not r10 into r11;
    assert.eq r11 true;
    contains group_member_exit_flag[r9] into r12;
    branch.eq r12 false to end_then_0_0;
    get group_member_exit_flag[r9] into r13;
    is.eq r13 false into r14;
    assert.eq r14 true;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    set r7 into rln_group_member[r9];
    set false into group_member_exit_flag[r9];
    set r6.size into group_member_index[r9];
    set r4 into deposits[r2];
    add r6.size 1u32 into r15;
    cast r0 r5 r15 into r16 as Group;
    set r16 into rln_group[r0];

closure verify_merkle_proof:
    input r0 as field;
    input r1 as field;
    input r2 as [field; 15u32];
    input r3 as [field; 15u32];
    sub r3[0u32] 1field into r4;
    mul r3[0u32] r4 into r5;
    assert.eq r5 0field;
    is.eq r3[0u32] 0field into r6;
    cast r1 r2[0u32] into r7 as [field; 2u32];
    hash.psd2 r7 into r8 as field;
    not r6 into r9;
    cast r2[0u32] r1 into r10 as [field; 2u32];
    hash.psd2 r10 into r11 as field;
    ternary r6 r8 r11 into r12;
    sub r3[1u32] 1field into r13;
    mul r3[1u32] r13 into r14;
    assert.eq r14 0field;
    is.eq r3[1u32] 0field into r15;
    cast r12 r2[1u32] into r16 as [field; 2u32];
    hash.psd2 r16 into r17 as field;
    not r15 into r18;
    cast r2[1u32] r12 into r19 as [field; 2u32];
    hash.psd2 r19 into r20 as field;
    ternary r15 r17 r20 into r21;
    sub r3[2u32] 1field into r22;
    mul r3[2u32] r22 into r23;
    assert.eq r23 0field;
    is.eq r3[2u32] 0field into r24;
    cast r21 r2[2u32] into r25 as [field; 2u32];
    hash.psd2 r25 into r26 as field;
    not r24 into r27;
    cast r2[2u32] r21 into r28 as [field; 2u32];
    hash.psd2 r28 into r29 as field;
    ternary r24 r26 r29 into r30;
    sub r3[3u32] 1field into r31;
    mul r3[3u32] r31 into r32;
    assert.eq r32 0field;
    is.eq r3[3u32] 0field into r33;
    cast r30 r2[3u32] into r34 as [field; 2u32];
    hash.psd2 r34 into r35 as field;
    not r33 into r36;
    cast r2[3u32] r30 into r37 as [field; 2u32];
    hash.psd2 r37 into r38 as field;
    ternary r33 r35 r38 into r39;
    sub r3[4u32] 1field into r40;
    mul r3[4u32] r40 into r41;
    assert.eq r41 0field;
    is.eq r3[4u32] 0field into r42;
    cast r39 r2[4u32] into r43 as [field; 2u32];
    hash.psd2 r43 into r44 as field;
    not r42 into r45;
    cast r2[4u32] r39 into r46 as [field; 2u32];
    hash.psd2 r46 into r47 as field;
    ternary r42 r44 r47 into r48;
    sub r3[5u32] 1field into r49;
    mul r3[5u32] r49 into r50;
    assert.eq r50 0field;
    is.eq r3[5u32] 0field into r51;
    cast r48 r2[5u32] into r52 as [field; 2u32];
    hash.psd2 r52 into r53 as field;
    not r51 into r54;
    cast r2[5u32] r48 into r55 as [field; 2u32];
    hash.psd2 r55 into r56 as field;
    ternary r51 r53 r56 into r57;
    sub r3[6u32] 1field into r58;
    mul r3[6u32] r58 into r59;
    assert.eq r59 0field;
    is.eq r3[6u32] 0field into r60;
    cast r57 r2[6u32] into r61 as [field; 2u32];
    hash.psd2 r61 into r62 as field;
    not r60 into r63;
    cast r2[6u32] r57 into r64 as [field; 2u32];
    hash.psd2 r64 into r65 as field;
    ternary r60 r62 r65 into r66;
    sub r3[7u32] 1field into r67;
    mul r3[7u32] r67 into r68;
    assert.eq r68 0field;
    is.eq r3[7u32] 0field into r69;
    cast r66 r2[7u32] into r70 as [field; 2u32];
    hash.psd2 r70 into r71 as field;
    not r69 into r72;
    cast r2[7u32] r66 into r73 as [field; 2u32];
    hash.psd2 r73 into r74 as field;
    ternary r69 r71 r74 into r75;
    sub r3[8u32] 1field into r76;
    mul r3[8u32] r76 into r77;
    assert.eq r77 0field;
    is.eq r3[8u32] 0field into r78;
    cast r75 r2[8u32] into r79 as [field; 2u32];
    hash.psd2 r79 into r80 as field;
    not r78 into r81;
    cast r2[8u32] r75 into r82 as [field; 2u32];
    hash.psd2 r82 into r83 as field;
    ternary r78 r80 r83 into r84;
    sub r3[9u32] 1field into r85;
    mul r3[9u32] r85 into r86;
    assert.eq r86 0field;
    is.eq r3[9u32] 0field into r87;
    cast r84 r2[9u32] into r88 as [field; 2u32];
    hash.psd2 r88 into r89 as field;
    not r87 into r90;
    cast r2[9u32] r84 into r91 as [field; 2u32];
    hash.psd2 r91 into r92 as field;
    ternary r87 r89 r92 into r93;
    sub r3[10u32] 1field into r94;
    mul r3[10u32] r94 into r95;
    assert.eq r95 0field;
    is.eq r3[10u32] 0field into r96;
    cast r93 r2[10u32] into r97 as [field; 2u32];
    hash.psd2 r97 into r98 as field;
    not r96 into r99;
    cast r2[10u32] r93 into r100 as [field; 2u32];
    hash.psd2 r100 into r101 as field;
    ternary r96 r98 r101 into r102;
    sub r3[11u32] 1field into r103;
    mul r3[11u32] r103 into r104;
    assert.eq r104 0field;
    is.eq r3[11u32] 0field into r105;
    cast r102 r2[11u32] into r106 as [field; 2u32];
    hash.psd2 r106 into r107 as field;
    not r105 into r108;
    cast r2[11u32] r102 into r109 as [field; 2u32];
    hash.psd2 r109 into r110 as field;
    ternary r105 r107 r110 into r111;
    sub r3[12u32] 1field into r112;
    mul r3[12u32] r112 into r113;
    assert.eq r113 0field;
    is.eq r3[12u32] 0field into r114;
    cast r111 r2[12u32] into r115 as [field; 2u32];
    hash.psd2 r115 into r116 as field;
    not r114 into r117;
    cast r2[12u32] r111 into r118 as [field; 2u32];
    hash.psd2 r118 into r119 as field;
    ternary r114 r116 r119 into r120;
    sub r3[13u32] 1field into r121;
    mul r3[13u32] r121 into r122;
    assert.eq r122 0field;
    is.eq r3[13u32] 0field into r123;
    cast r120 r2[13u32] into r124 as [field; 2u32];
    hash.psd2 r124 into r125 as field;
    not r123 into r126;
    cast r2[13u32] r120 into r127 as [field; 2u32];
    hash.psd2 r127 into r128 as field;
    ternary r123 r125 r128 into r129;
    sub r3[14u32] 1field into r130;
    mul r3[14u32] r130 into r131;
    assert.eq r131 0field;
    is.eq r3[14u32] 0field into r132;
    cast r129 r2[14u32] into r133 as [field; 2u32];
    hash.psd2 r133 into r134 as field;
    not r132 into r135;
    cast r2[14u32] r129 into r136 as [field; 2u32];
    hash.psd2 r136 into r137 as field;
    ternary r132 r134 r137 into r138;
    is.eq r138 r0 into r139;
    output r139 as boolean;

function post_message:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as field.private;
    input r4 as u32.private;
    input r5 as field.private;
    input r6 as UserMessageCounter.record;
    input r7 as [field; 15u32].private;
    input r8 as [field; 15u32].private;
    input r9 as field.private;
    hash.psd2 r3 into r10 as field;
    hash.psd2 r5 into r11 as field;
    cast 1u32 into r12 as field;
    cast r3 r1 r12 into r13 as [field; 3u32];
    hash.psd4 r13 into r14 as field;
    mul r14 r11 into r15;
    add r15 r3 into r16;
    hash.psd2 r14 into r17 as field;
    assert.eq r0 r6.group_id;
    call verify_merkle_proof r9 r10 r7 r8 into r18;
    assert.eq r18 true;
    gt r6.counter 1u32 into r19;
    ternary r19 true false into r20;
    add r6.counter 1u32 into r21;
    cast r6.owner r0 r21 into r22 as UserMessageCounter.record;
    cast r16 r17 r9 into r23 as RLNOutput;
    async post_message r0 r10 r4 r22.owner r11 r6.counter r23 r20 into r24;
    output r22 as UserMessageCounter.record;
    output r20 as boolean.private;
    output r24 as rln_boardv02.aleo/post_message.future;

finalize post_message:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u32.public;
    input r3 as address.public;
    input r4 as field.public;
    input r5 as u32.public;
    input r6 as RLNOutput.public;
    input r7 as boolean.public;
    get rln_group[r0] into r8;
    cast r0 r1 into r9 as [field; 2u32];
    hash.psd2 r9 into r10 as field;
    contains rln_group_member[r10] into r11;
    assert.eq r11 true;
    get group_member_exit_flag[r10] into r12;
    not r12 into r13;
    assert.eq r13 true;
    get rln_group_member[r10] into r14;
    get group_member_index[r10] into r15;
    is.eq r2 r15 into r16;
    assert.eq r16 true;
    is.eq r14.identity_commitment r1 into r17;
    assert.eq r17 true;
    cast r4 block.height into r18 as Message;
    cast r0 r1 into r19 as [field; 2u32];
    hash.psd2 r19 into r20 as field;
    not r7 into r21;
    branch.eq r21 false to end_then_0_2;
    set r18 into group_message[r20];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
    cast r2 into r22 as field;
    cast r5 into r23 as field;
    cast r0 r22 r23 into r24 as [field; 3u32];
    hash.psd4 r24 into r25 as field;
    set r18 into messages[r25];
    set r6 into rln_outputs[r25];
    add r14.message_counter 1u32 into r26;
    is.eq r26 r5 into r27;
    assert.eq r27 true;
    cast r0 r1 r2 r5 into r28 as GroupMember;
    set r28 into rln_group_member[r10];
    cast r0 r6.root r8.size into r29 as Group;
    set r29 into rln_group[r0];

function withdraw_stake:
    input r0 as field.public;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u32.private;
    input r4 as Token.record;
    input r5 as UserMessageCounter.record;
    input r6 as [field; 15u32].private;
    input r7 as [field; 15u32].private;
    input r8 as field.private;
    is.eq r4.owner r1 into r9;
    assert.eq r9 true;
    hash.psd2 r2 into r10 as field;
    call verify_merkle_proof r8 r10 r6 r7 into r11;
    assert.eq r11 true;
    cast 2u32 into r12 as u64;
    add r4.amount r12 into r13;
    cast r4.owner r13 into r14 as Token.record;
    cast r0 r2 into r15 as [field; 2u32];
    hash.bhp256 r15 into r16 as field;
    async withdraw_stake r0 r3 r5.counter r8 r16 r10 into r17;
    output r14 as Token.record;
    output r17 as rln_boardv02.aleo/withdraw_stake.future;

finalize withdraw_stake:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as u32.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    get rln_group[r0] into r6;
    cast r0 r5 into r7 as [field; 2u32];
    hash.psd2 r7 into r8 as field;
    get group_member_exit_flag[r8] into r9;
    not r9 into r10;
    assert.eq r10 true;
    get rln_group_member[r8] into r11;
    is.eq r11.identity_commitment r5 into r12;
    assert.eq r12 true;
    get group_member_index[r8] into r13;
    is.eq r1 r13 into r14;
    assert.eq r14 true;
    cast r1 into r15 as field;
    cast r2 into r16 as field;
    cast r0 r15 r16 into r17 as [field; 3u32];
    hash.psd4 r17 into r18 as field;
    get messages[r18] into r19;
    sub r6.size 1u32 into r20;
    cast r0 r3 r20 into r21 as Group;
    remove group_message[r8];
    remove group_member_index[r8];
    remove rln_group_member[r8];
    remove deposits[r4];
    set true into group_member_exit_flag[r8];
    set r21 into rln_group[r0];

function slash:
    input r0 as field.public;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as field.private;
    input r5 as field.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as Token.record;
    input r9 as [field; 15u32].private;
    input r10 as [field; 15u32].private;
    input r11 as field.private;
    sub r7 r6 into r12;
    sub r5 r4 into r13;
    div r12 r13 into r14;
    mul r14 r4 into r15;
    sub r6 r15 into r16;
    hash.psd2 r16 into r17 as field;
    is.eq r17 r3 into r18;
    assert.eq r18 true;
    call verify_merkle_proof r11 r17 r9 r10 into r19;
    assert.eq r19 true;
    add r8.amount 2u64 into r20;
    cast r8.owner r20 into r21 as Token.record;
    hash.psd2 r2 into r22 as field;
    cast r0 r2 into r23 as [field; 2u32];
    hash.psd2 r23 into r24 as field;
    cast r0 r16 into r25 as [field; 2u32];
    hash.psd2 r25 into r26 as field;
    async slash r0 r1 r22 r24 r26 r17 r11 into r27;
    output r21 as Token.record;
    output r27 as rln_boardv02.aleo/slash.future;

finalize slash:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    input r6 as field.public;
    get rln_group[r0] into r7;
    cast r0 r2 into r8 as [field; 2u32];
    hash.psd2 r8 into r9 as field;
    contains rln_group_member[r9] into r10;
    assert.eq r10 true;
    cast r0 r5 into r11 as [field; 2u32];
    hash.psd2 r11 into r12 as field;
    get group_member_exit_flag[r12] into r13;
    not r13 into r14;
    assert.eq r14 true;
    get deposits[r4] into r15;
    get deposits[r3] into r16;
    get rln_group_member[r12] into r17;
    sub r7.size 1u32 into r18;
    cast r0 r6 r18 into r19 as Group;
    remove group_message[r12];
    remove rln_group_member[r12];
    remove group_member_index[r12];
    remove deposits[r4];
    set true into group_member_exit_flag[r12];
    add r16 r15 into r20;
    set r20 into deposits[r3];
    set r19 into rln_group[r0];
