import credits.aleo;

program dispersecredits.aleo;

function compile:

function multi_send:
    input r0 as [address; 3u32].private;
    input r1 as [u64; 3u32].private;
    call credits.aleo/transfer_public r0[0u32] r1[0u32] into r2;
    call credits.aleo/transfer_public r0[1u32] r1[1u32] into r3;
    call credits.aleo/transfer_public r0[2u32] r1[2u32] into r4;
    async multi_send r2 r3 r4 into r5;
    output r5 as dispersecredits.aleo/multi_send.future;

finalize multi_send:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as credits.aleo/transfer_public.future;
    input r2 as credits.aleo/transfer_public.future;
    await r0;
    await r1;
    await r2;
