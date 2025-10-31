program zk_date_testnet_program.aleo;

mapping account:
    key as address.public;
    value as [u8; 10u32].public;

function create_user:
    input r0 as address.public;
    input r1 as [u8; 10u32].public;
    async create_user r0 r1 into r2;
    output r2 as zk_date_testnet_program.aleo/create_user.future;

finalize create_user:
    input r0 as address.public;
    input r1 as [u8; 10u32].public;
    set r1 into account[r0];

function get_user:
    input r0 as address.public;
    async get_user r0 into r1;
    output r1 as zk_date_testnet_program.aleo/get_user.future;

finalize get_user:
    input r0 as address.public;
    get account[r0] into r1;

function compare_users:
    input r0 as [u8; 10u32].private;
    input r1 as [u8; 10u32].private;
    is.neq r0[0u32] r1[0u32] into r2;
    add 0u8 1u8 into r3;
    ternary r2 r3 0u8 into r4;
    is.neq r0[1u32] r1[1u32] into r5;
    add r4 1u8 into r6;
    ternary r5 r6 r4 into r7;
    is.neq r0[2u32] r1[2u32] into r8;
    add r7 1u8 into r9;
    ternary r8 r9 r7 into r10;
    is.neq r0[3u32] r1[3u32] into r11;
    add r10 1u8 into r12;
    ternary r11 r12 r10 into r13;
    is.neq r0[4u32] r1[4u32] into r14;
    add r13 1u8 into r15;
    ternary r14 r15 r13 into r16;
    is.neq r0[5u32] r1[5u32] into r17;
    add r16 1u8 into r18;
    ternary r17 r18 r16 into r19;
    is.neq r0[6u32] r1[6u32] into r20;
    add r19 1u8 into r21;
    ternary r20 r21 r19 into r22;
    is.neq r0[7u32] r1[7u32] into r23;
    add r22 1u8 into r24;
    ternary r23 r24 r22 into r25;
    is.neq r0[8u32] r1[8u32] into r26;
    add r25 1u8 into r27;
    ternary r26 r27 r25 into r28;
    is.neq r0[9u32] r1[9u32] into r29;
    add r28 1u8 into r30;
    ternary r29 r30 r28 into r31;
    output r31 as u8.private;
