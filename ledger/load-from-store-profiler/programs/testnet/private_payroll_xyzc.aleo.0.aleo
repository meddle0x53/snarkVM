import credits.aleo;

program private_payroll_xyzc.aleo;

function payroll_private:
    input r0 as [u64; 3u32].private;
    input r1 as [address; 3u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_as_signer private_payroll_xyzc.aleo r2 into r3;
    call credits.aleo/transfer_public_to_private self.signer r2 into r4 r5;
    call credits.aleo/split r4 r0[0u32] into r6 r7;
    call credits.aleo/transfer_private r6 r1[0u32] r0[0u32] into r8 r9;
    call credits.aleo/split r7 r0[1u32] into r10 r11;
    call credits.aleo/transfer_private r10 r1[1u32] r0[1u32] into r12 r13;
    call credits.aleo/split r11 r0[2u32] into r14 r15;
    call credits.aleo/transfer_private r14 r1[2u32] r0[2u32] into r16 r17;
    async payroll_private r5 r3 into r18;
    output r18 as private_payroll_xyzc.aleo/payroll_private.future;

finalize payroll_private:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    await r1;
    await r0;
