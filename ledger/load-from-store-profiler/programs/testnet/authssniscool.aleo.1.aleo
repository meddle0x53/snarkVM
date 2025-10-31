program authssniscool.aleo;

struct data:
    ssn as scalar;

record ID:
    owner as address.private;
    metadata as data.private;

function mint_id:
    input r0 as address.private;
    input r1 as data.private;
    assert.eq self.caller aleo15xd9tee983ts3urff8j22q64wvcyc8geakghyc3ew5u0v8jfuqgs958t6d;
    cast r0 r1 into r2 as ID.record;
