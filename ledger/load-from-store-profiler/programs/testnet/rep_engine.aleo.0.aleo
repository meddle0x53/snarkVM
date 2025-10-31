program rep_engine.aleo;

record Points:
    owner as address.private;
    amount as u64.private;

mapping balances:
    key as field.public;
    value as u64.public;

function new:
    input r0 as address.private;
    cast r0 0u64 into r1 as Points.record;
    output r1 as Points.record;

function update:
    input r0 as Points.record;
    input r1 as address.private;
    hash.bhp256 r1 into r2 as field;
    add r0.amount 1u64 into r3;
    cast r0.owner r3 into r4 as Points.record;
    async update r2 1u64 into r5;
    output r4 as Points.record;
    output r5 as rep_engine.aleo/update.future;

finalize update:
    input r0 as field.public;
    input r1 as u64.public;
    get.or_use balances[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balances[r0];
