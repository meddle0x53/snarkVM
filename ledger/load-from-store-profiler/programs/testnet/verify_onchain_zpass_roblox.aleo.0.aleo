program verify_onchain_zpass_roblox.aleo;

struct Credentials:
    issuer as address;
    subject as address;
    robloxId as u64;
    accountCreatedAt as u64;
    isBanned as boolean;
    verifiedBadge as boolean;
    overAge13 as boolean;

mapping is_issuer:
    key as address.public;
    value as boolean.public;

function add_issuer:
    input r0 as address.public;
    assert.eq self.caller aleo1qjwngxfvhansjjprun4nx905hp5jjycw3yn49ykefuxrzv0p6szqnfjt5z;
    async add_issuer r0 into r1;
    output r1 as verify_onchain_zpass_roblox.aleo/add_issuer.future;

finalize add_issuer:
    input r0 as address.public;
    set true into is_issuer[r0];

function remove_issuer:
    input r0 as address.public;
    assert.eq self.caller aleo1qjwngxfvhansjjprun4nx905hp5jjycw3yn49ykefuxrzv0p6szqnfjt5z;
    async remove_issuer r0 into r1;
    output r1 as verify_onchain_zpass_roblox.aleo/remove_issuer.future;

finalize remove_issuer:
    input r0 as address.public;
    set false into is_issuer[r0];

function verify:
    input r0 as signature.private;
    input r1 as address.public;
    input r2 as address.private;
    input r3 as u64.private;
    input r4 as u64.private;
    input r5 as boolean.private;
    input r6 as boolean.private;
    input r7 as boolean.private;
    cast r1 r2 r3 r4 r5 r6 r7 into r8 as Credentials;
    hash.psd2 r8 into r9 as field;
    sign.verify r0 r8.issuer r9 into r10;
    assert.eq r10 true;
    async verify r1 into r11;
    output r11 as verify_onchain_zpass_roblox.aleo/verify.future;

finalize verify:
    input r0 as address.public;
    get is_issuer[r0] into r1;
    assert.eq r1 true;
