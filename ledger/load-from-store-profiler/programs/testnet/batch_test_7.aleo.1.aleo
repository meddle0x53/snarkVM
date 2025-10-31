import credits.aleo;

program batch_test_7.aleo;

function payroll_private:
    input r0 as [u64; 7u32].private;
    input r1 as [address; 7u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_to_private self.signer r2 into r3 r4;
    call credits.aleo/transfer_public_as_signer batch_test_7.aleo r2 into r5;
    call credits.aleo/transfer_private r3 r1[0u32] r0[0u32] into r6 r7;
    call credits.aleo/transfer_private r7 r1[1u32] r0[1u32] into r8 r9;
    call credits.aleo/transfer_private r9 r1[2u32] r0[2u32] into r10 r11;
    call credits.aleo/transfer_private r11 r1[3u32] r0[3u32] into r12 r13;
    call credits.aleo/transfer_private r13 r1[4u32] r0[4u32] into r14 r15;
    call credits.aleo/transfer_private r15 r1[5u32] r0[5u32] into r16 r17;
    call credits.aleo/transfer_private r17 r1[6u32] r0[6u32] into r18 r19;
    async payroll_private r4 r5 into r20;
    output r20 as batch_test_7.aleo/payroll_private.future;

finalize payroll_private:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    await r1;
    await r0;
