import credits.aleo;

program bfhelloworldab.aleo;

function transfer_pub:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as address.public;
    input r3 as u64.public;
    call credits.aleo/transfer_public r0 r1 into r4;
    call credits.aleo/transfer_public r2 r3 into r5;
    async transfer_pub r4 r5 into r6;
    output r6 as bfhelloworldab.aleo/transfer_pub.future;

finalize transfer_pub:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as credits.aleo/transfer_public.future;
    await r0;
    await r1;
