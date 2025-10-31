import credits.aleo;

program private_payroll_xyz.aleo;

function payroll_private:
    input r0 as [u64; 3u32].private;
    input r1 as [address; 3u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_to_private self.signer r2 into r3 r4;
    call credits.aleo/split r3 r0[0u32] into r5 r6;
    call credits.aleo/transfer_private r5 r1[0u32] r0[0u32] into r7 r8;
    call credits.aleo/split r6 r0[1u32] into r9 r10;
    call credits.aleo/transfer_private r9 r1[1u32] r0[1u32] into r11 r12;
    call credits.aleo/split r10 r0[2u32] into r13 r14;
    call credits.aleo/transfer_private r13 r1[2u32] r0[2u32] into r15 r16;
    async payroll_private r4 into r17;
    output r17 as private_payroll_xyz.aleo/payroll_private.future;

finalize payroll_private:
    input r0 as credits.aleo/transfer_public_to_private.future;
    await r0;
