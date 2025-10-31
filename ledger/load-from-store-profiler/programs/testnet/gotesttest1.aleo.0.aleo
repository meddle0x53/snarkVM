import credits.aleo;

program gotesttest1.aleo;

function claim:
    input r0 as u64.public;
    input r1 as address.public;
    call credits.aleo/transfer_public r1 r0 into r2;
    async claim r2 into r3;
    output r3 as gotesttest1.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
