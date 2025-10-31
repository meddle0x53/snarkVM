import credits.aleo;
import token_example.aleo;

program example_program7.aleo;

function transfer_credit:
    call token_example.aleo/transfer_credit into r0;
    call credits.aleo/transfer_public example_program7.aleo 0u64 into r1;
    async transfer_credit r0 r1 into r2;
    output r2 as example_program7.aleo/transfer_credit.future;

finalize transfer_credit:
    input r0 as token_example.aleo/transfer_credit.future;
    input r1 as credits.aleo/transfer_public.future;
    await r1;
    await r0;
    assert.eq true true;
