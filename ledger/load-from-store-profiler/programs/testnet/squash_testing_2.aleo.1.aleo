import timestamp_testing.aleo;

program squash_testing_2.aleo;

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
    sub r0.kg r8 into r9;
    cast r0.owner r9 r2 into r10 as Squash.record;
    lt r0.last_water r1.time into r11;
    add r0.kg 1u64 into r12;
    cast r0.owner r12 r2 into r13 as Squash.record;
    not r5 into r14;
    and r14 r11 into r15;
    ternary r15 r13.owner r0.owner into r16;
    not r5 into r17;
    and r17 r11 into r18;
    ternary r18 r13.kg r0.kg into r19;
    not r5 into r20;
    and r20 r11 into r21;
    ternary r21 r13.last_water r0.last_water into r22;
    cast r16 r19 r22 into r23 as Squash.record;
    ternary r5 r10.owner r23.owner into r24;
    ternary r5 r10.kg r23.kg into r25;
    ternary r5 r10.last_water r23.last_water into r26;
    cast r24 r25 r26 into r27 as Squash.record;
    output r27 as Squash.record;
