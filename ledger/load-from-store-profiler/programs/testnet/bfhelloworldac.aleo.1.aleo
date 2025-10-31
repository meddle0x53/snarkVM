import credits.aleo;

program bfhelloworldac.aleo;

function transfer_pub:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    sub r1 r2 into r3;
    call credits.aleo/transfer_public r0 r3 into r4;
    async transfer_pub r4 into r5;
    output r5 as bfhelloworldac.aleo/transfer_pub.future;

finalize transfer_pub:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
