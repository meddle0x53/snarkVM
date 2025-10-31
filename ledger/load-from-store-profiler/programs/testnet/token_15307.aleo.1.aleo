program token_15307.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

function mint:
    input r0 as u64.private;
    cast self.caller r0 into r1 as Token.record;
    output r1 as Token.record;

function transfer:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    cast r1 r2 into r4 as Token.record;
    sub r0.amount r2 into r5;
    cast self.caller r5 into r6 as Token.record;
    output r6 as Token.record;
    output r4 as Token.record;

function balance_of:
    input r0 as Token.record;
    output r0.amount as u64.private;
