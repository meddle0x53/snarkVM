import credits.aleo;

program batch_private_private_5.aleo;

function payroll_private_private:
    input r0 as [u64; 5u32].private;
    input r1 as [address; 5u32].private;
    input r2 as credits.aleo/credits.record;
    add 0u64 r0[0u32] into r3;
    add r3 r0[1u32] into r4;
    add r4 r0[2u32] into r5;
    add r5 r0[3u32] into r6;
    add r6 r0[4u32] into r7;
    call credits.aleo/transfer_private r2 r1[0u32] r0[0u32] into r8 r9;
    call credits.aleo/transfer_private r9 r1[1u32] r0[1u32] into r10 r11;
    call credits.aleo/transfer_private r11 r1[2u32] r0[2u32] into r12 r13;
    call credits.aleo/transfer_private r13 r1[3u32] r0[3u32] into r14 r15;
    call credits.aleo/transfer_private r15 r1[4u32] r0[4u32] into r16 r17;
    output r17 as credits.aleo/credits.record;
