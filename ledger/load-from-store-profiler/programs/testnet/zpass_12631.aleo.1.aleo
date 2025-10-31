program zpass_12631.aleo;

record ZPass:
    owner as address.private;
    hash as field.private;
    issuer as address.private;

struct Credentials:
    issuer as address;
    holder as address;
    dob as u32;
    nationality as field;

mapping issued:
    key as field.public;
    value as boolean.public;

function get_hash:
    input r0 as Credentials.private;
    hash.psd2 r0 into r1 as field;
    output r1 as field.private;

function get_zpass:
    input r0 as Credentials.private;
    input r1 as signature.private;
    hash.psd2 r0 into r2 as field;
    sign.verify r1 r0.issuer r2 into r3;
    assert.eq r3 true;
    assert.eq r0.holder self.caller;
    cast r0.holder r2 r0.issuer into r4 as ZPass.record;
    async get_zpass r2 into r5;
    output r4 as ZPass.record;
    output r5 as zpass_12631.aleo/get_zpass.future;

finalize get_zpass:
    input r0 as field.public;
    get.or_use issued[r0] false into r1;
    assert.neq r1 true;
    set true into issued[r0];
