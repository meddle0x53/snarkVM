import timestamp_testing.aleo;

program squash_testing_3.aleo;

record Squash:
    owner as address.private;
    kg as u64.private;
    last_water as u64.private;

function mint:
    input r0 as address.private;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    cast r0 0u64 r1.time into r2 as Squash.record;
    output r2 as Squash.record;

function water:
    input r0 as Squash.record;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    sub r1.time r3 into r4;
    lt r0.last_water r4 into r5;
    sub r1.time r0.last_water into r6;
    rem r6 r3 into r7;
    div r7 2000000u64 into r8;
    lt r0.kg r8 into r9;
    sub r0.kg r8 into r10;
    ternary r9 0u64 r10 into r11;
    cast r0.owner r11 r2 into r12 as Squash.record;
    lt r0.last_water r1.time into r13;
    add r0.kg 1u64 into r14;
    cast r0.owner r14 r2 into r15 as Squash.record;
    not r5 into r16;
    and r16 r13 into r17;
    ternary r17 r15.owner r0.owner into r18;
    not r5 into r19;
    and r19 r13 into r20;
    ternary r20 r15.kg r0.kg into r21;
    not r5 into r22;
    and r22 r13 into r23;
    ternary r23 r15.last_water r0.last_water into r24;
    cast r18 r21 r24 into r25 as Squash.record;
    ternary r5 r12.owner r25.owner into r26;
    ternary r5 r12.kg r25.kg into r27;
    ternary r5 r12.last_water r25.last_water into r28;
    cast r26 r27 r28 into r29 as Squash.record;
    output r29 as Squash.record;
