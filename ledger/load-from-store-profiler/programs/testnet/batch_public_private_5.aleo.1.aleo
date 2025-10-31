import credits.aleo;

program batch_public_private_5.aleo;

function payroll_public_private:
    input r0 as [u64; 5u32].private;
    input r1 as [address; 5u32].private;
    add 0u64 r0[0u32] into r2;
    add r2 r0[1u32] into r3;
    add r3 r0[2u32] into r4;
    add r4 r0[3u32] into r5;
    add r5 r0[4u32] into r6;
    call credits.aleo/transfer_public_as_signer batch_public_private_5.aleo r6 into r7;
    call credits.aleo/transfer_public_to_private self.signer r6 into r8 r9;
    call credits.aleo/transfer_private r8 r1[0u32] r0[0u32] into r10 r11;
    call credits.aleo/transfer_private r11 r1[1u32] r0[1u32] into r12 r13;
    call credits.aleo/transfer_private r13 r1[2u32] r0[2u32] into r14 r15;
    call credits.aleo/transfer_private r15 r1[3u32] r0[3u32] into r16 r17;
    call credits.aleo/transfer_private r17 r1[4u32] r0[4u32] into r18 r19;
    async payroll_public_private r7 r9 into r20;
    output r20 as batch_public_private_5.aleo/payroll_public_private.future;

finalize payroll_public_private:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/transfer_public_to_private.future;
    await r0;
    await r1;
