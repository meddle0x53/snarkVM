import credits.aleo;

program batch_p2p_20_records_3.aleo;

function join_send:
    input r0 as credits.aleo/credits.record;
    input r1 as credits.aleo/credits.record;
    input r2 as credits.aleo/credits.record;
    input r3 as [u64; 20u32].private;
    input r4 as [address; 20u32].private;
    call credits.aleo/join r0 r1 into r5;
    call credits.aleo/join r5 r2 into r6;
    call credits.aleo/transfer_private r6 r4[0u32] r3[0u32] into r7 r8;
    call credits.aleo/transfer_private r8 r4[1u32] r3[1u32] into r9 r10;
    call credits.aleo/transfer_private r10 r4[2u32] r3[2u32] into r11 r12;
    call credits.aleo/transfer_private r12 r4[3u32] r3[3u32] into r13 r14;
    call credits.aleo/transfer_private r14 r4[4u32] r3[4u32] into r15 r16;
    call credits.aleo/transfer_private r16 r4[5u32] r3[5u32] into r17 r18;
    call credits.aleo/transfer_private r18 r4[6u32] r3[6u32] into r19 r20;
    call credits.aleo/transfer_private r20 r4[7u32] r3[7u32] into r21 r22;
    call credits.aleo/transfer_private r22 r4[8u32] r3[8u32] into r23 r24;
    call credits.aleo/transfer_private r24 r4[9u32] r3[9u32] into r25 r26;
    call credits.aleo/transfer_private r26 r4[10u32] r3[10u32] into r27 r28;
    call credits.aleo/transfer_private r28 r4[11u32] r3[11u32] into r29 r30;
    call credits.aleo/transfer_private r30 r4[12u32] r3[12u32] into r31 r32;
    call credits.aleo/transfer_private r32 r4[13u32] r3[13u32] into r33 r34;
    call credits.aleo/transfer_private r34 r4[14u32] r3[14u32] into r35 r36;
    call credits.aleo/transfer_private r36 r4[15u32] r3[15u32] into r37 r38;
    call credits.aleo/transfer_private r38 r4[16u32] r3[16u32] into r39 r40;
    call credits.aleo/transfer_private r40 r4[17u32] r3[17u32] into r41 r42;
    call credits.aleo/transfer_private r42 r4[18u32] r3[18u32] into r43 r44;
    call credits.aleo/transfer_private r44 r4[19u32] r3[19u32] into r45 r46;
    output r46 as credits.aleo/credits.record;
