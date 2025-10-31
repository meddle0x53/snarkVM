import credits.aleo;

program batch_p2p_20_records_1.aleo;

function join_send:
    input r0 as credits.aleo/credits.record;
    input r1 as [u64; 20u32].private;
    input r2 as [address; 20u32].private;
    call credits.aleo/transfer_private r0 r2[0u32] r1[0u32] into r3 r4;
    call credits.aleo/transfer_private r4 r2[1u32] r1[1u32] into r5 r6;
    call credits.aleo/transfer_private r6 r2[2u32] r1[2u32] into r7 r8;
    call credits.aleo/transfer_private r8 r2[3u32] r1[3u32] into r9 r10;
    call credits.aleo/transfer_private r10 r2[4u32] r1[4u32] into r11 r12;
    call credits.aleo/transfer_private r12 r2[5u32] r1[5u32] into r13 r14;
    call credits.aleo/transfer_private r14 r2[6u32] r1[6u32] into r15 r16;
    call credits.aleo/transfer_private r16 r2[7u32] r1[7u32] into r17 r18;
    call credits.aleo/transfer_private r18 r2[8u32] r1[8u32] into r19 r20;
    call credits.aleo/transfer_private r20 r2[9u32] r1[9u32] into r21 r22;
    call credits.aleo/transfer_private r22 r2[10u32] r1[10u32] into r23 r24;
    call credits.aleo/transfer_private r24 r2[11u32] r1[11u32] into r25 r26;
    call credits.aleo/transfer_private r26 r2[12u32] r1[12u32] into r27 r28;
    call credits.aleo/transfer_private r28 r2[13u32] r1[13u32] into r29 r30;
    call credits.aleo/transfer_private r30 r2[14u32] r1[14u32] into r31 r32;
    call credits.aleo/transfer_private r32 r2[15u32] r1[15u32] into r33 r34;
    call credits.aleo/transfer_private r34 r2[16u32] r1[16u32] into r35 r36;
    call credits.aleo/transfer_private r36 r2[17u32] r1[17u32] into r37 r38;
    call credits.aleo/transfer_private r38 r2[18u32] r1[18u32] into r39 r40;
    call credits.aleo/transfer_private r40 r2[19u32] r1[19u32] into r41 r42;
    output r42 as credits.aleo/credits.record;
