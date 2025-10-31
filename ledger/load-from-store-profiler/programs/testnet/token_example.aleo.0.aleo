import credits.aleo;

program token_example.aleo;

function main:
    input r0 as u32.public;
    input r1 as u32.private;
    add r0 r1 into r2;
    output r2 as u32.private;

function transfer_credit:
    call credits.aleo/transfer_public token_example.aleo 0u64 into r0;
    async transfer_credit r0 into r1;
    output r1 as token_example.aleo/transfer_credit.future;

finalize transfer_credit:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
    assert.eq true true;
