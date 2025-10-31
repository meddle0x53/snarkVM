import credits.aleo;

program batch_public_private_15.aleo;

function payroll_public_private:
    input r0 as [u64; 15u32].private;
    input r1 as [address; 15u32].private;
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
    call credits.aleo/transfer_public_as_signer batch_public_private_15.aleo r16 into r17;
    call credits.aleo/transfer_public_to_private self.signer r16 into r18 r19;
    call credits.aleo/transfer_private r18 r1[0u32] r0[0u32] into r20 r21;
    call credits.aleo/transfer_private r21 r1[1u32] r0[1u32] into r22 r23;
    call credits.aleo/transfer_private r23 r1[2u32] r0[2u32] into r24 r25;
    call credits.aleo/transfer_private r25 r1[3u32] r0[3u32] into r26 r27;
    call credits.aleo/transfer_private r27 r1[4u32] r0[4u32] into r28 r29;
    call credits.aleo/transfer_private r29 r1[5u32] r0[5u32] into r30 r31;
    call credits.aleo/transfer_private r31 r1[6u32] r0[6u32] into r32 r33;
    call credits.aleo/transfer_private r33 r1[7u32] r0[7u32] into r34 r35;
    call credits.aleo/transfer_private r35 r1[8u32] r0[8u32] into r36 r37;
    call credits.aleo/transfer_private r37 r1[9u32] r0[9u32] into r38 r39;
    call credits.aleo/transfer_private r39 r1[10u32] r0[10u32] into r40 r41;
    call credits.aleo/transfer_private r41 r1[11u32] r0[11u32] into r42 r43;
    call credits.aleo/transfer_private r43 r1[12u32] r0[12u32] into r44 r45;
    call credits.aleo/transfer_private r45 r1[13u32] r0[13u32] into r46 r47;
    call credits.aleo/transfer_private r47 r1[14u32] r0[14u32] into r48 r49;
    async payroll_public_private r17 r19 into r50;
    output r50 as batch_public_private_15.aleo/payroll_public_private.future;

finalize payroll_public_private:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/transfer_public_to_private.future;
    await r0;
    await r1;
