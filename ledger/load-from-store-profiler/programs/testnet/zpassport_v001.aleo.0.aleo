program zpassport_v001.aleo;

struct PrivateCredentials:
    issuer as address;
    name as field;
    passport_number as u32;
    nationality as u8;
    dob as u32;
    expiry as u32;

struct PublicCredentials:
    salt as scalar;

record ZPassport:
    owner as address.private;
    private_credentials as PrivateCredentials.private;
    public_credentials as PublicCredentials.public;

struct FullCredentials:
    private_credentials as PrivateCredentials;
    public_credentials as PublicCredentials;

mapping issued:
    key as group.public;
    value as boolean.public;

mapping invalidated:
    key as group.public;
    value as boolean.public;

mapping issuance_count:
    key as field.public;
    value as u128.public;

function issue:
    input r0 as PrivateCredentials.private;
    input r1 as PublicCredentials.public;
    commit.bhp256 r0 r1.salt into r2 as group;
    cast self.caller r0 r1 into r3 as ZPassport.record;
    async issue r2 into r4;
    output r3 as ZPassport.record;
    output r4 as zpassport_v001.aleo/issue.future;

finalize issue:
    input r0 as group.public;
    get.or_use issued[r0] false into r1;
    assert.eq r1 false;
    set true into issued[r0];
    get.or_use issuance_count[0field] 0u128 into r2;
    add r2 1u128 into r3;
    set r3 into issuance_count[0field];

function invalidate:
    input r0 as ZPassport.record;
    commit.bhp256 r0.private_credentials r0.public_credentials.salt into r1 as group;
    async invalidate r1 into r2;
    output r2 as zpassport_v001.aleo/invalidate.future;

finalize invalidate:
    input r0 as group.public;
    set true into invalidated[r0];

function is_invalid:
    input r0 as FullCredentials.private;
    commit.bhp256 r0.private_credentials r0.public_credentials.salt into r1 as group;
    async is_invalid r1 into r2;
    output r2 as zpassport_v001.aleo/is_invalid.future;

finalize is_invalid:
    input r0 as group.public;
    get.or_use invalidated[r0] false into r1;
    assert.eq r1 false;
