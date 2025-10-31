program d6u8w3s0a2q9.aleo;

record USDG:
    owner as address.private;
    token_id as field.private;
    amount as u64.private;

record aUSDG:
    owner as address.private;
    token_id as field.private;
    timestamp as u32.private;
    amount as u64.private;
    admin as address.private;

function mint:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u64.private;
    assert.eq self.caller aleo1pvvpm6jynyupjdsmeqqp03xeydter9yvrvu4qej9j6ax3hlgrgzqtauzm9;
    cast r0 r1 r2 into r3 as USDG.record;
    output r3 as USDG.record;

function lend:
    input r0 as USDG.record;
    input r1 as u64.private;
    input r2 as u32.private;
    assert.eq r0.token_id 5983142094692128773510225623816045070304444621008302359049788306211838130558field;
    gte r0.amount r1 into r3;
    assert.eq r3 true;
    gt r1 0u64 into r4;
    assert.eq r4 true;
    cast r0.owner 184467440737095516171234567890123456789012345678901234567890123456789field r2 r1 self.caller into r5 as aUSDG.record;
    sub r0.amount r1 into r6;
    cast r0.owner 5983142094692128773510225623816045070304444621008302359049788306211838130558field r6 into r7 as USDG.record;
    output r5 as aUSDG.record;
    output r7 as USDG.record;

function redeem_lend:
    input r0 as aUSDG.record;
    input r1 as u32.private;
    assert.eq r0.token_id 184467440737095516171234567890123456789012345678901234567890123456789field;
    gt r0.amount 0u64 into r2;
    assert.eq r2 true;
    cast r0.owner 5983142094692128773510225623816045070304444621008302359049788306211838130558field r0.amount into r3 as USDG.record;
    output r3 as USDG.record;
