import credits.aleo;

program batch_test_28.aleo;

function payroll_private:
    input r0 as [u64; 28u32].private;
    input r1 as [address; 28u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_to_private self.signer r2 into r3 r4;
    call credits.aleo/transfer_public_as_signer batch_test_28.aleo r2 into r5;
    call credits.aleo/transfer_private r3 r1[0u32] r0[0u32] into r6 r7;
    call credits.aleo/transfer_private r7 r1[1u32] r0[1u32] into r8 r9;
    call credits.aleo/transfer_private r9 r1[2u32] r0[2u32] into r10 r11;
    call credits.aleo/transfer_private r11 r1[3u32] r0[3u32] into r12 r13;
    call credits.aleo/transfer_private r13 r1[4u32] r0[4u32] into r14 r15;
    call credits.aleo/transfer_private r15 r1[5u32] r0[5u32] into r16 r17;
    call credits.aleo/transfer_private r17 r1[6u32] r0[6u32] into r18 r19;
    call credits.aleo/transfer_private r19 r1[7u32] r0[7u32] into r20 r21;
    call credits.aleo/transfer_private r21 r1[8u32] r0[8u32] into r22 r23;
    call credits.aleo/transfer_private r23 r1[9u32] r0[9u32] into r24 r25;
    call credits.aleo/transfer_private r25 r1[10u32] r0[10u32] into r26 r27;
    call credits.aleo/transfer_private r27 r1[11u32] r0[11u32] into r28 r29;
    call credits.aleo/transfer_private r29 r1[12u32] r0[12u32] into r30 r31;
    call credits.aleo/transfer_private r31 r1[13u32] r0[13u32] into r32 r33;
    call credits.aleo/transfer_private r33 r1[14u32] r0[14u32] into r34 r35;
    call credits.aleo/transfer_private r35 r1[15u32] r0[15u32] into r36 r37;
    call credits.aleo/transfer_private r37 r1[16u32] r0[16u32] into r38 r39;
    call credits.aleo/transfer_private r39 r1[17u32] r0[17u32] into r40 r41;
    call credits.aleo/transfer_private r41 r1[18u32] r0[18u32] into r42 r43;
    call credits.aleo/transfer_private r43 r1[19u32] r0[19u32] into r44 r45;
    call credits.aleo/transfer_private r45 r1[20u32] r0[20u32] into r46 r47;
    call credits.aleo/transfer_private r47 r1[21u32] r0[21u32] into r48 r49;
    call credits.aleo/transfer_private r49 r1[22u32] r0[22u32] into r50 r51;
    call credits.aleo/transfer_private r51 r1[23u32] r0[23u32] into r52 r53;
    call credits.aleo/transfer_private r53 r1[24u32] r0[24u32] into r54 r55;
    call credits.aleo/transfer_private r55 r1[25u32] r0[25u32] into r56 r57;
    call credits.aleo/transfer_private r57 r1[26u32] r0[26u32] into r58 r59;
    call credits.aleo/transfer_private r59 r1[27u32] r0[27u32] into r60 r61;
    async payroll_private r4 r5 into r62;
    output r62 as batch_test_28.aleo/payroll_private.future;

finalize payroll_private:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    await r1;
    await r0;
