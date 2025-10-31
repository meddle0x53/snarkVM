program verify_onchain_zpass_rnm.aleo;

struct Credentials:
    issuer as address;
    subject as address;
    playside_userId as u32;
    presentAtRnm as boolean;

mapping is_issuer:
    key as address.public;
    value as boolean.public;

function add_issuer:
    input r0 as address.public;
    assert.eq self.caller aleo1qjwngxfvhansjjprun4nx905hp5jjycw3yn49ykefuxrzv0p6szqnfjt5z;
    async add_issuer r0 into r1;
    output r1 as verify_onchain_zpass_rnm.aleo/add_issuer.future;

finalize add_issuer:
    input r0 as address.public;
    set true into is_issuer[r0];

function remove_issuer:
    input r0 as address.public;
    assert.eq self.caller aleo1qjwngxfvhansjjprun4nx905hp5jjycw3yn49ykefuxrzv0p6szqnfjt5z;
    async remove_issuer r0 into r1;
    output r1 as verify_onchain_zpass_rnm.aleo/remove_issuer.future;

finalize remove_issuer:
    input r0 as address.public;
    set false into is_issuer[r0];

function verify:
    input r0 as signature.private;
    input r1 as address.public;
    input r2 as address.private;
    input r3 as u32.private;
    input r4 as boolean.private;
    cast r1 r2 r3 r4 into r5 as Credentials;
    hash.psd2 r5 into r6 as field;
    sign.verify r0 r5.issuer r6 into r7;
    assert.eq r7 true;
    async verify r1 into r8;
    output r8 as verify_onchain_zpass_rnm.aleo/verify.future;

finalize verify:
    input r0 as address.public;
    get is_issuer[r0] into r1;
    assert.eq r1 true;
