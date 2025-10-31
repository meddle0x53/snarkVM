program beginner_v0001.aleo;

record Hello:
    owner as address.private;
    count as u64.private;

mapping global_count:
    key as boolean.public;
    value as u64.public;

mapping personal_count:
    key as address.public;
    value as u64.public;

function main:
    input r0 as u32.public;
    input r1 as u32.private;
    add r0 r1 into r2;
    output r2 as u32.private;

function say_hello:
    async say_hello self.caller into r0;
    output r0 as beginner_v0001.aleo/say_hello.future;

finalize say_hello:
    input r0 as address.public;
    get.or_use global_count[true] 0u64 into r1;
    add r1 1u64 into r2;
    set r2 into global_count[true];
    get.or_use personal_count[r0] 0u64 into r3;
    add r3 1u64 into r4;
    set r4 into personal_count[r0];

function generate_record:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as Hello.record;
    async generate_record self.caller r1 into r3;
    output r2 as Hello.record;
    output r3 as beginner_v0001.aleo/generate_record.future;

finalize generate_record:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use personal_count[r0] 0u64 into r2;
    gte r2 r1 into r3;
    assert.eq r3 true;
    sub r2 r1 into r4;
    set r4 into personal_count[r0];
