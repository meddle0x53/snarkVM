program verify_poseidon2.aleo;

struct Credentials:
    issuer as address;
    subject as address;
    robloxId as u64;
    accountCreatedAt as u64;
    isBanned as boolean;
    verifiedBadge as boolean;
    overAge13 as boolean;

function verify:
    input r0 as signature.private;
    input r1 as Credentials.private;
    hash.psd2 r1 into r2 as field;
    sign.verify r0 r1.issuer r2 into r3;
    output r3 as boolean.private;
