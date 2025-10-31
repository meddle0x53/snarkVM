import credits.aleo;

program batch_public_private_20.aleo;

function payroll_public_private:
    input r0 as [u64; 20u32].private;
    input r1 as [address; 20u32].private;
    add 0u64 r0[0u32] into r2;
    add r2 r0[1u32] into r3;
    add r3 r0[2u32] into r4;
    add r4 r0[3u32] into r5;
    add r5 r0[4u32] into r6;
    add r6 r0[5u32] into r7;
    add r7 r0[6u32] into r8;
    add r8 r0[7u32] into r9;
    add r9 r0[8u32] into r10;
    add r10 r0[9u32] into r11;
    add r11 r0[10u32] into r12;
    add r12 r0[11u32] into r13;
    add r13 r0[12u32] into r14;
    add r14 r0[13u32] into r15;
    add r15 r0[14u32] into r16;
    add r16 r0[15u32] into r17;
    add r17 r0[16u32] into r18;
    add r18 r0[17u32] into r19;
    add r19 r0[18u32] into r20;
    add r20 r0[19u32] into r21;
    call credits.aleo/transfer_public_as_signer batch_public_private_20.aleo r21 into r22;
    call credits.aleo/transfer_public_to_private self.signer r21 into r23 r24;
    call credits.aleo/transfer_private r23 r1[0u32] r0[0u32] into r25 r26;
    call credits.aleo/transfer_private r26 r1[1u32] r0[1u32] into r27 r28;
    call credits.aleo/transfer_private r28 r1[2u32] r0[2u32] into r29 r30;
    call credits.aleo/transfer_private r30 r1[3u32] r0[3u32] into r31 r32;
    call credits.aleo/transfer_private r32 r1[4u32] r0[4u32] into r33 r34;
    call credits.aleo/transfer_private r34 r1[5u32] r0[5u32] into r35 r36;
    call credits.aleo/transfer_private r36 r1[6u32] r0[6u32] into r37 r38;
    call credits.aleo/transfer_private r38 r1[7u32] r0[7u32] into r39 r40;
    call credits.aleo/transfer_private r40 r1[8u32] r0[8u32] into r41 r42;
    call credits.aleo/transfer_private r42 r1[9u32] r0[9u32] into r43 r44;
    call credits.aleo/transfer_private r44 r1[10u32] r0[10u32] into r45 r46;
    call credits.aleo/transfer_private r46 r1[11u32] r0[11u32] into r47 r48;
    call credits.aleo/transfer_private r48 r1[12u32] r0[12u32] into r49 r50;
    call credits.aleo/transfer_private r50 r1[13u32] r0[13u32] into r51 r52;
    call credits.aleo/transfer_private r52 r1[14u32] r0[14u32] into r53 r54;
    call credits.aleo/transfer_private r54 r1[15u32] r0[15u32] into r55 r56;
    call credits.aleo/transfer_private r56 r1[16u32] r0[16u32] into r57 r58;
    call credits.aleo/transfer_private r58 r1[17u32] r0[17u32] into r59 r60;
    call credits.aleo/transfer_private r60 r1[18u32] r0[18u32] into r61 r62;
    call credits.aleo/transfer_private r62 r1[19u32] r0[19u32] into r63 r64;
    async payroll_public_private r22 r24 into r65;
    output r65 as batch_public_private_20.aleo/payroll_public_private.future;

finalize payroll_public_private:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/transfer_public_to_private.future;
    await r0;
    await r1;
