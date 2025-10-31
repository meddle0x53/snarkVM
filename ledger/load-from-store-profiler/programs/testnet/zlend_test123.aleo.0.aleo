program zlend_test123.aleo;

record USDG:
    owner as address.private;
    token_id as field.private;

record aUSDG:
    owner as address.private;
    token_id as field.private;
    timestamp as u32.private;
    admin as address.private;

function lend:
    input r0 as USDG.record;
    input r1 as u32.private;
    assert.eq r0.token_id 5983142094692128773510225623816045070304444621008302359049788306211838130558field;
    cast r0.owner 184467440737095516171234567890123456789012345678901234567890123456789field r1 self.caller into r2 as aUSDG.record;
    output r2 as aUSDG.record;

function redeem_lend:
    input r0 as aUSDG.record;
    input r1 as u32.private;
    assert.eq r0.token_id 184467440737095516171234567890123456789012345678901234567890123456789field;
    assert.eq r0.admin self.caller;
    gte r1 r0.timestamp into r2;
    assert.eq r2 true;
    cast r0.owner 5983142094692128773510225623816045070304444621008302359049788306211838130558field into r3 as USDG.record;
    output r3 as USDG.record;
