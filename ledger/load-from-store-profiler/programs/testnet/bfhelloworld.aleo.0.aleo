import credits.aleo;

program bfhelloworld.aleo;

function transfer_pub:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as [u8; 32u32].public;
    call credits.aleo/transfer_public r0 r1 into r3;
    async transfer_pub r3 into r4;
    output r4 as bfhelloworld.aleo/transfer_pub.future;

finalize transfer_pub:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
