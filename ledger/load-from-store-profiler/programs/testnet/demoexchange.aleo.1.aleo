program demoexchange.aleo;

record Cubias:
    owner as address.private;
    amount as u64.private;
    cubias as u64.private;

struct CubiaInfo:
    cubia_id as field;
    max_cubia as u64;
    receiver as address;
    cubia_price as u64;
    total_cubia as u64;

mapping unique_cubia:
    key as field.public;
    value as CubiaInfo.public;

mapping account:
    key as address.public;
    value as u64.public;

function buy_cubia:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    sub r1 1000u64 into r3;
    cast r0 r3 r2 into r4 as Cubias.record;
    async buy_cubia r0 1000u64 1u64 into r5;
    output r4 as Cubias.record;
    output 1000u64 as u64.private;
    output r5 as demoexchange.aleo/buy_cubia.future;

finalize buy_cubia:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    hash.keccak512 r0 into r3 as field;
    rand.chacha into r4 as field;
    cast r4 0u64 r0 r1 0u64 into r5 as CubiaInfo;
    get.or_use unique_cubia[r3] r5 into r6;
    get.or_use account[r0] 1000u64 into r7;
    sub r7 r6.cubia_price into r8;
    set r8 into account[r0];
    gt r7 r6.cubia_price into r9;
    assert.eq r9 true;
    is.eq r6.receiver r0 into r10;
    assert.eq r10 true;
    gte r6.max_cubia 0u64 into r11;
    assert.eq r11 true;
    lte r6.total_cubia 10000u64 into r12;
    assert.eq r12 true;
    add r6.max_cubia r2 into r13;
    add r6.cubia_price 100u64 into r14;
    add r6.total_cubia r2 into r15;
    cast r6.cubia_id r13 r6.receiver r14 r15 into r16 as CubiaInfo;
    set r16 into unique_cubia[r3];

function sale_cubia:
    input r0 as address.private;
    input r1 as address.private;
    async sale_cubia r0 r1 into r2;
    output r0 as address.private;
    output r1 as address.private;
    output r2 as demoexchange.aleo/sale_cubia.future;

finalize sale_cubia:
    input r0 as address.public;
    input r1 as address.public;
    hash.keccak512 r0 into r2 as field;
    hash.keccak512 r1 into r3 as field;
    cast 111field 10u64 r0 600u64 10u64 into r4 as CubiaInfo;
    get.or_use unique_cubia[r2] r4 into r5;
    get.or_use account[r1] 1000u64 into r6;
    mul r5.max_cubia r5.cubia_price into r7;
    sub r6 r7 into r8;
    set r8 into account[r1];
    get.or_use account[r0] 1000u64 into r9;
    mul r5.max_cubia r5.cubia_price into r10;
    add r9 r10 into r11;
    set r11 into account[r0];
    sub r5.cubia_price 100u64 into r12;
    sub r5.total_cubia r5.max_cubia into r13;
    cast r5.cubia_id r5.max_cubia r0 r12 r13 into r14 as CubiaInfo;
    set r14 into unique_cubia[r2];
    add r5.max_cubia r5.max_cubia into r15;
    cast r5.cubia_id r15 r1 r5.cubia_price r5.total_cubia into r16 as CubiaInfo;
    set r16 into unique_cubia[r3];
    remove unique_cubia[r2];
