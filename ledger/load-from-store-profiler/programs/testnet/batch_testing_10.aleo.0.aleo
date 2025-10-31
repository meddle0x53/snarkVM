import credits.aleo;

program batch_testing_10.aleo;

function payroll_private:
    input r0 as [u64; 10u32].private;
    input r1 as [address; 10u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_to_private self.signer r2 into r3 r4;
    call credits.aleo/transfer_public_as_signer batch_testing_10.aleo r2 into r5;
    call credits.aleo/split r3 r0[0u32] into r6 r7;
    call credits.aleo/transfer_private r6 r1[0u32] r0[0u32] into r8 r9;
    call credits.aleo/split r7 r0[1u32] into r10 r11;
    call credits.aleo/transfer_private r10 r1[1u32] r0[1u32] into r12 r13;
    call credits.aleo/split r11 r0[2u32] into r14 r15;
    call credits.aleo/transfer_private r14 r1[2u32] r0[2u32] into r16 r17;
    call credits.aleo/split r15 r0[3u32] into r18 r19;
    call credits.aleo/transfer_private r18 r1[3u32] r0[3u32] into r20 r21;
    call credits.aleo/split r19 r0[4u32] into r22 r23;
    call credits.aleo/transfer_private r22 r1[4u32] r0[4u32] into r24 r25;
    call credits.aleo/split r23 r0[5u32] into r26 r27;
    call credits.aleo/transfer_private r26 r1[5u32] r0[5u32] into r28 r29;
    call credits.aleo/split r27 r0[6u32] into r30 r31;
    call credits.aleo/transfer_private r30 r1[6u32] r0[6u32] into r32 r33;
    call credits.aleo/split r31 r0[7u32] into r34 r35;
    call credits.aleo/transfer_private r34 r1[7u32] r0[7u32] into r36 r37;
    call credits.aleo/split r35 r0[8u32] into r38 r39;
    call credits.aleo/transfer_private r38 r1[8u32] r0[8u32] into r40 r41;
    call credits.aleo/split r39 r0[9u32] into r42 r43;
    call credits.aleo/transfer_private r42 r1[9u32] r0[9u32] into r44 r45;
    async payroll_private r4 r5 into r46;
    output r46 as batch_testing_10.aleo/payroll_private.future;

finalize payroll_private:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    await r1;
    await r0;
