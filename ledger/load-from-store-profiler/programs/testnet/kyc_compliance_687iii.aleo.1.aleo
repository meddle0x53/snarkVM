program kyc_compliance_687iii.aleo;

record KYC:
    owner as address.private;
    is_verified as boolean.private;
    jurisdiction as u32.private;

record Transaction:
    owner as address.private;
    sender as address.private;
    recipient as address.private;
    amount as u64.private;
    jurisdiction as u32.private;

function register_user:
    input r0 as u32.private;
    assert.eq self.caller self.caller;
    cast self.caller true r0 into r1 as KYC.record;
    output r1 as KYC.record;

function compliant_transfer:
    input r0 as KYC.record;
    input r1 as KYC.record;
    input r2 as u64.private;
    assert.eq r0.is_verified true;
    assert.eq r1.is_verified true;
    assert.eq r0.jurisdiction r1.jurisdiction;
    cast r0.owner r0.owner r1.owner r2 r0.jurisdiction into r3 as Transaction.record;
    output r3 as Transaction.record;
