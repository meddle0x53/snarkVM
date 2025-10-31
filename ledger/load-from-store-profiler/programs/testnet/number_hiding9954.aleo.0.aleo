program number_hiding9954.aleo;

record Token:
    owner as address.private;
    amount as u32.private;

function mint:
    input r0 as address.private;
    input r1 as u32.private;
    assert.eq self.caller aleo138rcw3e29rs44xgfxu6mm3yav7vxvp0wat9h45fz93v8hwkqkcqsv5ruvg;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer:
    input r0 as address.private;
    input r1 as u32.private;
    input r2 as Token.record;
    gte r2.amount r1 into r3;
    assert.eq r3 true;
    sub r2.amount r1 into r4;
    cast r2.owner r4 into r5 as Token.record;
    cast r0 r1 into r6 as Token.record;
    output r5 as Token.record;
    output r6 as Token.record;
