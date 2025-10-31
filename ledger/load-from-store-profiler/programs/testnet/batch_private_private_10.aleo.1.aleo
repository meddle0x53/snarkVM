import credits.aleo;

program batch_private_private_10.aleo;

function payroll_private_private:
    input r0 as [u64; 10u32].private;
    input r1 as [address; 10u32].private;
    input r2 as credits.aleo/credits.record;
    add 0u64 r0[0u32] into r3;
    add r3 r0[1u32] into r4;
    add r4 r0[2u32] into r5;
    add r5 r0[3u32] into r6;
    add r6 r0[4u32] into r7;
    add r7 r0[5u32] into r8;
    add r8 r0[6u32] into r9;
    add r9 r0[7u32] into r10;
    add r10 r0[8u32] into r11;
    add r11 r0[9u32] into r12;
    call credits.aleo/transfer_private r2 r1[0u32] r0[0u32] into r13 r14;
    call credits.aleo/transfer_private r14 r1[1u32] r0[1u32] into r15 r16;
    call credits.aleo/transfer_private r16 r1[2u32] r0[2u32] into r17 r18;
    call credits.aleo/transfer_private r18 r1[3u32] r0[3u32] into r19 r20;
    call credits.aleo/transfer_private r20 r1[4u32] r0[4u32] into r21 r22;
    call credits.aleo/transfer_private r22 r1[5u32] r0[5u32] into r23 r24;
    call credits.aleo/transfer_private r24 r1[6u32] r0[6u32] into r25 r26;
    call credits.aleo/transfer_private r26 r1[7u32] r0[7u32] into r27 r28;
    call credits.aleo/transfer_private r28 r1[8u32] r0[8u32] into r29 r30;
    call credits.aleo/transfer_private r30 r1[9u32] r0[9u32] into r31 r32;
    output r32 as credits.aleo/credits.record;
