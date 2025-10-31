program token_biest.aleo;

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
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as Token.record;
    cast r1 r2 into r5 as Token.record;
    output r4 as Token.record;
    output r5 as Token.record;

function balance_of:
    input r0 as Token.record;
    gte r0.amount 0u64 into r1;
    ternary r1 r0.amount 0u64 into r2;
    output r2 as u64.private;
