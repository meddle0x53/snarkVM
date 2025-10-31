program zkescrow_testing2.aleo;

record WALEO:
    owner as address.private;
    amount as u128.private;

struct Escrow:
    sender as address;
    recipient as address;
    amount as u128;

mapping escrows:
    key as u64.public;
    value as Escrow.public;

function deposit:
    input r0 as u64.public;
    input r1 as address.private;
    input r2 as WALEO.record;
    assert.eq r2.owner self.caller;
    gt r2.amount 0u128 into r3;
    assert.eq r3 true;
    async deposit r0 r1 r2.amount self.caller into r4;
    output 0u8 as u8.private;
    output r4 as zkescrow_testing2.aleo/deposit.future;

finalize deposit:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as address.public;
    contains escrows[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    cast r3 r1 r2 into r6 as Escrow;
    set r6 into escrows[r0];

function release:
    input r0 as u64.public;
    input r1 as u128.public;
    input r2 as address.public;
    cast r2 r1 into r3 as WALEO.record;
    async release r0 r1 r2 self.caller into r4;
    output r3 as WALEO.record;
    output r4 as zkescrow_testing2.aleo/release.future;

finalize release:
    input r0 as u64.public;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as address.public;
    get escrows[r0] into r4;
    assert.eq r3 r4.sender;
    assert.eq r2 r4.recipient;
    assert.eq r1 r4.amount;
    remove escrows[r0];

function claim:
    input r0 as u64.public;
    input r1 as u128.public;
    cast self.caller r1 into r2 as WALEO.record;
    async claim r0 r1 self.caller into r3;
    output r2 as WALEO.record;
    output r3 as zkescrow_testing2.aleo/claim.future;

finalize claim:
    input r0 as u64.public;
    input r1 as u128.public;
    input r2 as address.public;
    get escrows[r0] into r3;
    assert.eq r2 r3.recipient;
    assert.eq r1 r3.amount;
    remove escrows[r0];
