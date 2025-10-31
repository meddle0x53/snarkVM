program kyc_compliance.aleo;

record ComplianceRecord:
    owner as address.private;
    user_id as u64.private;
    is_compliant as boolean.private;

function submit_compliance:
    input r0 as u64.private;
    input r1 as boolean.private;
    cast aleo1qwfefjx65qenhsemuhpp9vz9cmdhqvdlwr7fzpt069psu9hggggqvn2shl r0 r1 into r2 as ComplianceRecord.record;
    output r2 as ComplianceRecord.record;

function verify_compliance:
    input r0 as ComplianceRecord.record;
    assert.eq self.caller aleo1qwfefjx65qenhsemuhpp9vz9cmdhqvdlwr7fzpt069psu9hggggqvn2shl;
    output r0.is_compliant as boolean.private;
