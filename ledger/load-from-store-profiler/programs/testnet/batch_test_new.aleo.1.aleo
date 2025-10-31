import credits.aleo;

program batch_test_new.aleo;

function payroll_private:
    input r0 as [u64; 29u32].private;
    input r1 as [address; 29u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_to_private self.signer r2 into r3 r4;
    call credits.aleo/transfer_private r3 r1[0u32] r0[0u32] into r5 r6;
    call credits.aleo/transfer_private r6 r1[1u32] r0[1u32] into r7 r8;
    call credits.aleo/transfer_private r8 r1[2u32] r0[2u32] into r9 r10;
    call credits.aleo/transfer_private r10 r1[3u32] r0[3u32] into r11 r12;
    call credits.aleo/transfer_private r12 r1[4u32] r0[4u32] into r13 r14;
    call credits.aleo/transfer_private r14 r1[5u32] r0[5u32] into r15 r16;
    call credits.aleo/transfer_private r16 r1[6u32] r0[6u32] into r17 r18;
    call credits.aleo/transfer_private r18 r1[7u32] r0[7u32] into r19 r20;
    call credits.aleo/transfer_private r20 r1[8u32] r0[8u32] into r21 r22;
    call credits.aleo/transfer_private r22 r1[9u32] r0[9u32] into r23 r24;
    call credits.aleo/transfer_private r24 r1[10u32] r0[10u32] into r25 r26;
    call credits.aleo/transfer_private r26 r1[11u32] r0[11u32] into r27 r28;
    call credits.aleo/transfer_private r28 r1[12u32] r0[12u32] into r29 r30;
    call credits.aleo/transfer_private r30 r1[13u32] r0[13u32] into r31 r32;
    call credits.aleo/transfer_private r32 r1[14u32] r0[14u32] into r33 r34;
    call credits.aleo/transfer_private r34 r1[15u32] r0[15u32] into r35 r36;
    call credits.aleo/transfer_private r36 r1[16u32] r0[16u32] into r37 r38;
    call credits.aleo/transfer_private r38 r1[17u32] r0[17u32] into r39 r40;
    call credits.aleo/transfer_private r40 r1[18u32] r0[18u32] into r41 r42;
    call credits.aleo/transfer_private r42 r1[19u32] r0[19u32] into r43 r44;
    call credits.aleo/transfer_private r44 r1[20u32] r0[20u32] into r45 r46;
    call credits.aleo/transfer_private r46 r1[21u32] r0[21u32] into r47 r48;
    call credits.aleo/transfer_private r48 r1[22u32] r0[22u32] into r49 r50;
    call credits.aleo/transfer_private r50 r1[23u32] r0[23u32] into r51 r52;
    call credits.aleo/transfer_private r52 r1[24u32] r0[24u32] into r53 r54;
    call credits.aleo/transfer_private r54 r1[25u32] r0[25u32] into r55 r56;
    call credits.aleo/transfer_private r56 r1[26u32] r0[26u32] into r57 r58;
    call credits.aleo/transfer_private r58 r1[27u32] r0[27u32] into r59 r60;
    call credits.aleo/transfer_private r60 r1[28u32] r0[28u32] into r61 r62;
    async payroll_private r4 into r63;
    output r63 as batch_test_new.aleo/payroll_private.future;

finalize payroll_private:
    input r0 as credits.aleo/transfer_public_to_private.future;
    await r0;
