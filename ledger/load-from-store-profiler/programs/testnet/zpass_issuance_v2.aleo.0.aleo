program zpass_issuance_v2.aleo;

record ZPass:
    owner as address.private;
    issuer as address.private;
    isBanned as boolean.private;
    verifiedBadge as boolean.private;
    salt as scalar.private;

struct PrivateCredentials:
    issuer as address;
    subject as address;
    isBanned as boolean;
    verifiedBadge as boolean;

struct PublicCredentials:
    salt as scalar;

struct FullCredentials:
    issuer as address;
    subject as address;
    isBanned as boolean;
    verifiedBadge as boolean;
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
    cast r1.issuer r1.subject r1.isBanned r1.verifiedBadge r2.salt into r3 as FullCredentials;
    hash.psd2 r3 into r4 as field;
    sign.verify r0 r1.issuer r4 into r5;
    assert.eq r5 true;
    commit.bhp256 r1.subject r2.salt into r6 as group;
    cast r1.issuer r1.issuer r1.isBanned r1.verifiedBadge r2.salt into r7 as ZPass.record;
    async issue r6 into r8;
    output r7 as ZPass.record;
    output r8 as zpass_issuance_v2.aleo/issue.future;

finalize issue:
    input r0 as group.public;
    get.or_use issued[r0] false into r1;
    assert.eq r1 false;
    set true into issued[r0];
    get.or_use issuance_count[0field] 0u128 into r2;
    add r2 1u128 into r3;
    set r3 into issuance_count[0field];
