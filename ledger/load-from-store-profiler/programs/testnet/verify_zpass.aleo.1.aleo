program verify_zpass.aleo;

struct Credentials:
    issuer as address;
    subject as address;
    playside_userId as u64;
    presentAtRnm as u64;

function verify:
    input r0 as signature.private;
    input r1 as Credentials.private;
    hash.psd2 r1 into r2 as field;
    sign.verify r0 r1.issuer r2 into r3;
    output r3 as boolean.private;
