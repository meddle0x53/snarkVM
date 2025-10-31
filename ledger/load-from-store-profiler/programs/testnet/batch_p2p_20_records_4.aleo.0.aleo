import credits.aleo;

program batch_p2p_20_records_4.aleo;

function join_send:
    input r0 as credits.aleo/credits.record;
    input r1 as credits.aleo/credits.record;
    input r2 as credits.aleo/credits.record;
    input r3 as credits.aleo/credits.record;
    input r4 as [u64; 20u32].private;
    input r5 as [address; 20u32].private;
    call credits.aleo/join r0 r1 into r6;
    call credits.aleo/join r6 r2 into r7;
    call credits.aleo/join r7 r3 into r8;
    call credits.aleo/transfer_private r8 r5[0u32] r4[0u32] into r9 r10;
    call credits.aleo/transfer_private r10 r5[1u32] r4[1u32] into r11 r12;
    call credits.aleo/transfer_private r12 r5[2u32] r4[2u32] into r13 r14;
    call credits.aleo/transfer_private r14 r5[3u32] r4[3u32] into r15 r16;
    call credits.aleo/transfer_private r16 r5[4u32] r4[4u32] into r17 r18;
    call credits.aleo/transfer_private r18 r5[5u32] r4[5u32] into r19 r20;
    call credits.aleo/transfer_private r20 r5[6u32] r4[6u32] into r21 r22;
    call credits.aleo/transfer_private r22 r5[7u32] r4[7u32] into r23 r24;
    call credits.aleo/transfer_private r24 r5[8u32] r4[8u32] into r25 r26;
    call credits.aleo/transfer_private r26 r5[9u32] r4[9u32] into r27 r28;
    call credits.aleo/transfer_private r28 r5[10u32] r4[10u32] into r29 r30;
    call credits.aleo/transfer_private r30 r5[11u32] r4[11u32] into r31 r32;
    call credits.aleo/transfer_private r32 r5[12u32] r4[12u32] into r33 r34;
    call credits.aleo/transfer_private r34 r5[13u32] r4[13u32] into r35 r36;
    call credits.aleo/transfer_private r36 r5[14u32] r4[14u32] into r37 r38;
    call credits.aleo/transfer_private r38 r5[15u32] r4[15u32] into r39 r40;
    call credits.aleo/transfer_private r40 r5[16u32] r4[16u32] into r41 r42;
    call credits.aleo/transfer_private r42 r5[17u32] r4[17u32] into r43 r44;
    call credits.aleo/transfer_private r44 r5[18u32] r4[18u32] into r45 r46;
    call credits.aleo/transfer_private r46 r5[19u32] r4[19u32] into r47 r48;
    output r48 as credits.aleo/credits.record;
