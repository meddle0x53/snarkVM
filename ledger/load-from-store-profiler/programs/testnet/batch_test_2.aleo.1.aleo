import credits.aleo;

program batch_test_2.aleo;

function payroll_private:
    input r0 as [u64; 2u32].private;
    input r1 as [address; 2u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_to_private self.signer r2 into r3 r4;
    call credits.aleo/transfer_public_as_signer batch_test_2.aleo r2 into r5;
    call credits.aleo/transfer_private r3 r1[0u32] r0[0u32] into r6 r7;
    call credits.aleo/transfer_private r7 r1[1u32] r0[1u32] into r8 r9;
    async payroll_private r4 r5 into r10;
    output r10 as batch_test_2.aleo/payroll_private.future;

finalize payroll_private:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    await r1;
    await r0;
