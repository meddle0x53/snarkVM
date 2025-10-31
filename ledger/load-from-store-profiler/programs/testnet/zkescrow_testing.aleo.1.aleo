import credits.aleo;

program zkescrow_testing.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

struct Escrow:
    sender as address;
    recipient as address;
    amount as u64;

mapping escrows:
    key as u64.public;
    value as Escrow.public;

function mint_token:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function wrap:
    input r0 as u64.public;
    input r1 as credits.aleo/credits.record;
    assert.eq r1.owner self.caller;
    assert.eq r1.microcredits r0;
    cast self.caller r0 into r2 as Token.record;
    output r2 as Token.record;

function fund:
    input r0 as u64.public;
    input r1 as address.private;
    input r2 as Token.record;
    input r3 as field.public;
    assert.eq r2.owner self.caller;
    async fund r0 r1 r2.amount self.caller into r4;
    output 0u8 as u8.private;
    output r4 as zkescrow_testing.aleo/fund.future;

finalize fund:
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
    cast self.caller 0u64 into r1 as Token.record;
    async release r0 self.caller into r2;
    output r1 as Token.record;
    output r2 as zkescrow_testing.aleo/release.future;

finalize release:
    input r0 as u64.public;
    input r1 as address.public;
    get escrows[r0] into r2;
    assert.eq r1 r2.sender;
    remove escrows[r0];

function claim:
    input r0 as u64.public;
    cast self.caller 0u64 into r1 as Token.record;
    async claim r0 self.caller into r2;
    output r1 as Token.record;
    output r2 as zkescrow_testing.aleo/claim.future;

finalize claim:
    input r0 as u64.public;
    input r1 as address.public;
    get escrows[r0] into r2;
    assert.eq r1 r2.recipient;
    remove escrows[r0];

function unwrap:
    input r0 as Token.record;
    input r1 as field.public;
    assert.eq r0.owner self.caller;
    gt r0.amount 0u64 into r2;
    assert.eq r2 true;
    output r0.amount as u64.private;
