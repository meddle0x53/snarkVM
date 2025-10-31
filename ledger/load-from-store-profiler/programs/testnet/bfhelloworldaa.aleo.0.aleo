import credits.aleo;

program bfhelloworldaa.aleo;

function transfer_pub:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public r0 r1 into r2;
    async transfer_pub r2 into r3;
    output r3 as bfhelloworldaa.aleo/transfer_pub.future;

finalize transfer_pub:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
