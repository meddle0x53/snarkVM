import credits.aleo;

program zkescrow_premaintest_v1.aleo;

record WALEO:
    owner as address.private;
    amount as u64.private;

struct Escrow:
    sender as address;
    recipient as address;
    amount as u64;

mapping escrows:
    key as u64.public;
    value as Escrow.public;

function wrap_public_credits:
    input r0 as address.public;
    input r1 as u64.public;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    cast r0 r1 into r3 as WALEO.record;
    call credits.aleo/transfer_public_as_signer aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec r1 into r4;
    async wrap_public_credits r4 into r5;
    output r3 as WALEO.record;
    output r5 as zkescrow_premaintest_v1.aleo/wrap_public_credits.future;

finalize wrap_public_credits:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    await r0;

function unwrap_public_credits:
    input r0 as WALEO.record;
    input r1 as address.public;
    assert.eq r0.owner self.caller;
    call credits.aleo/transfer_public r1 r0.amount into r2;
    async unwrap_public_credits r2 into r3;
    output r0.amount as u64.private;
    output r3 as zkescrow_premaintest_v1.aleo/unwrap_public_credits.future;

finalize unwrap_public_credits:
    input r0 as credits.aleo/transfer_public.future;
    await r0;

function deposit:
    input r0 as u64.public;
    input r1 as address.private;
    input r2 as WALEO.record;
    assert.eq r2.owner self.caller;
    gt r2.amount 0u64 into r3;
    assert.eq r3 true;
    async deposit r0 r1 r2.amount self.caller into r4;
    output 0u8 as u8.private;
    output r4 as zkescrow_premaintest_v1.aleo/deposit.future;

finalize deposit:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as address.public;
    contains escrows[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    cast r3 r1 r2 into r6 as Escrow;
    set r6 into escrows[r0];

function release:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as address.public;
    cast r2 r1 into r3 as WALEO.record;
    async release r0 r1 r2 self.caller into r4;
    output r3 as WALEO.record;
    output r4 as zkescrow_premaintest_v1.aleo/release.future;

finalize release:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as address.public;
    input r3 as address.public;
    get escrows[r0] into r4;
    assert.eq r3 r4.sender;
    assert.eq r2 r4.recipient;
    assert.eq r1 r4.amount;
    remove escrows[r0];

function claim:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as address.public;
    cast r2 r1 into r3 as WALEO.record;
    async claim r0 r1 r2 into r4;
    output r3 as WALEO.record;
    output r4 as zkescrow_premaintest_v1.aleo/claim.future;

finalize claim:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as address.public;
    get escrows[r0] into r3;
    assert.eq r2 r3.recipient;
    assert.eq r1 r3.amount;
    remove escrows[r0];

function cancel:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as address.public;
    cast r2 r1 into r3 as WALEO.record;
    async cancel r0 r1 r2 into r4;
    output r3 as WALEO.record;
    output r4 as zkescrow_premaintest_v1.aleo/cancel.future;

finalize cancel:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as address.public;
    get escrows[r0] into r3;
    assert.eq r2 r3.sender;
    assert.eq r1 r3.amount;
    remove escrows[r0];
