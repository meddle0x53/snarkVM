import authssniscool.aleo;

program authssnverify.aleo;

struct data:
    ssn as scalar;

function verify_id:
    input r0 as address.public;
    input r1 as scalar.private;
    input r2 as authssniscool.aleo/ID.record;
    assert.eq r2.metadata.ssn r1;
    output true as boolean.private;
