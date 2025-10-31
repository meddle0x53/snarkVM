program compliant_jurisdiction_transfer.aleo;

record Account:
    owner as address.private;
    amount as u64.private;
    jurisdiction as u8.private;

function register_user:
    input r0 as u8.private;
    input r1 as u64.private;
    cast self.caller r1 r0 into r2 as Account.record;
    output r2 as Account.record;

function compliant_transfer:
    input r0 as Account.record;
    input r1 as address.private;
    input r2 as u8.private;
    input r3 as u64.private;
    input r4 as u8.private;
    gte r0.amount r3 into r5;
    assert.eq r5 true;
    is.neq r2 r4 into r6;
    assert.eq r6 true;
    sub r0.amount r3 into r7;
    cast r0.owner r7 r0.jurisdiction into r8 as Account.record;
    cast r1 r3 r2 into r9 as Account.record;
    output r8 as Account.record;
    output r9 as Account.record;
