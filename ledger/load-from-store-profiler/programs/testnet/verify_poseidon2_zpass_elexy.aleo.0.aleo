program verify_poseidon2_zpass_elexy.aleo;

record ZPass:
    owner as address.private;
    issuer as address.private;
    dob as u32.private;
    nationality as field.private;
    expiry as u32.private;
    salt as scalar.private;

struct PrivateCredentials:
    issuer as address;
    subject as address;
    dob as u32;
    nationality as field;
    expiry as u32;

struct PublicCredentials:
    salt as scalar;

struct FullCredentials:
    issuer as address;
    subject as address;
    dob as u32;
    nationality as field;
    expiry as u32;
    salt as scalar;

mapping issued:
    key as group.public;
    value as boolean.public;

mapping issuance_count:
    key as field.public;
    value as u128.public;

function issue:
    input r0 as signature.private;
    input r1 as PrivateCredentials.private;
    input r2 as PublicCredentials.public;
    cast r1.issuer self.caller r1.dob r1.nationality r1.expiry r2.salt into r3 as FullCredentials;
    hash.psd2 r3 into r4 as field;
    sign.verify r0 r1.issuer r4 into r5;
    assert.eq r5 true;
    commit.bhp256 self.caller r2.salt into r6 as group;
    cast self.caller r1.issuer r1.dob r1.nationality r1.expiry r2.salt into r7 as ZPass.record;
    async issue r6 into r8;
    output r7 as ZPass.record;
    output r8 as verify_poseidon2_zpass_elexy.aleo/issue.future;

finalize issue:
    input r0 as group.public;
    get.or_use issued[r0] false into r1;
    assert.eq r1 false;
    set true into issued[r0];
    get.or_use issuance_count[0field] 0u128 into r2;
    add r2 1u128 into r3;
    set r3 into issuance_count[0field];
