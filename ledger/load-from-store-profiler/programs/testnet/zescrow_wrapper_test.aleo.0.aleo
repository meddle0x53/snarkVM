import credits.aleo;

program zescrow_wrapper_test.aleo;

record WALEO:
    owner as address.private;
    amount as u128.private;

function wrap_public_credits:
    input r0 as address.public;
    input r1 as u64.public;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    cast r1 into r3 as u128;
    cast r0 r3 into r4 as WALEO.record;
    call credits.aleo/transfer_public aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec r1 into r5;
    async wrap_public_credits r5 into r6;
    output r4 as WALEO.record;
    output r6 as zescrow_wrapper_test.aleo/wrap_public_credits.future;

finalize wrap_public_credits:
    input r0 as credits.aleo/transfer_public.future;
    await r0;

function unwrap_public_credits:
    input r0 as WALEO.record;
    input r1 as address.public;
    assert.eq r0.owner self.caller;
    cast r0.amount into r2 as u64;
    call credits.aleo/transfer_public r1 r2 into r3;
    async unwrap_public_credits r3 into r4;
    output r2 as u64.private;
    output r4 as zescrow_wrapper_test.aleo/unwrap_public_credits.future;

finalize unwrap_public_credits:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
