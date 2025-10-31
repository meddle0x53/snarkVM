program dynamic_compliance.aleo;

record KYCStatus:
    owner as address.private;
    verifier as address.private;
    client_id as u64.private;
    status as boolean.private;

function record_kyc:
    input r0 as u64.private;
    input r1 as boolean.private;
    cast self.caller aleo1ah07nrxxzat95yzjekx7wzfr4ju0k7vwljlwstc47nuwg9r5zs8q7ntsry r0 r1 into r2 as KYCStatus.record;
    output r2 as KYCStatus.record;

function check_kyc:
    input r0 as KYCStatus.record;
    assert.eq self.caller aleo1ah07nrxxzat95yzjekx7wzfr4ju0k7vwljlwstc47nuwg9r5zs8q7ntsry;
    output r0.status as boolean.private;
