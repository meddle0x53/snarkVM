program sanctions_guard.aleo;

record ComplianceCheck:
    owner as address.private;
    officer as address.private;
    entity as address.private;
    flagged as boolean.private;
    expiry_block as u32.private;

function enforce_compliance:
    input r0 as address.private;
    input r1 as boolean.private;
    input r2 as u32.private;
    assert.eq self.caller aleo1q89nk75qgvm322y6z7k2g2k4n85x7g9quctxtfv27vxt7r87augsyk9kkw;
    cast self.caller self.caller r0 r1 r2 into r3 as ComplianceCheck.record;
    output r3 as ComplianceCheck.record;

function validate_transaction:
    input r0 as ComplianceCheck.record;
    input r1 as u32.private;
    assert.eq self.caller r0.entity;
    lte r1 r0.expiry_block into r2;
    assert.eq r2 true;
    not r0.flagged into r3;
    output r3 as boolean.private;
