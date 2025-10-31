import credits.aleo;

program batch_p2p_20_records_2.aleo;

function join_send:
    input r0 as credits.aleo/credits.record;
    input r1 as credits.aleo/credits.record;
    input r2 as [u64; 20u32].private;
    input r3 as [address; 20u32].private;
    call credits.aleo/join r0 r1 into r4;
    call credits.aleo/transfer_private r4 r3[0u32] r2[0u32] into r5 r6;
    call credits.aleo/transfer_private r6 r3[1u32] r2[1u32] into r7 r8;
    call credits.aleo/transfer_private r8 r3[2u32] r2[2u32] into r9 r10;
    call credits.aleo/transfer_private r10 r3[3u32] r2[3u32] into r11 r12;
    call credits.aleo/transfer_private r12 r3[4u32] r2[4u32] into r13 r14;
    call credits.aleo/transfer_private r14 r3[5u32] r2[5u32] into r15 r16;
    call credits.aleo/transfer_private r16 r3[6u32] r2[6u32] into r17 r18;
    call credits.aleo/transfer_private r18 r3[7u32] r2[7u32] into r19 r20;
    call credits.aleo/transfer_private r20 r3[8u32] r2[8u32] into r21 r22;
    call credits.aleo/transfer_private r22 r3[9u32] r2[9u32] into r23 r24;
    call credits.aleo/transfer_private r24 r3[10u32] r2[10u32] into r25 r26;
    call credits.aleo/transfer_private r26 r3[11u32] r2[11u32] into r27 r28;
    call credits.aleo/transfer_private r28 r3[12u32] r2[12u32] into r29 r30;
    call credits.aleo/transfer_private r30 r3[13u32] r2[13u32] into r31 r32;
    call credits.aleo/transfer_private r32 r3[14u32] r2[14u32] into r33 r34;
    call credits.aleo/transfer_private r34 r3[15u32] r2[15u32] into r35 r36;
    call credits.aleo/transfer_private r36 r3[16u32] r2[16u32] into r37 r38;
    call credits.aleo/transfer_private r38 r3[17u32] r2[17u32] into r39 r40;
    call credits.aleo/transfer_private r40 r3[18u32] r2[18u32] into r41 r42;
    call credits.aleo/transfer_private r42 r3[19u32] r2[19u32] into r43 r44;
    output r44 as credits.aleo/credits.record;
