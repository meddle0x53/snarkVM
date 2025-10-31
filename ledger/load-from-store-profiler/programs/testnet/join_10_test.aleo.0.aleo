import credits.aleo;

program join_10_test.aleo;

function join_10:
    input r0 as credits.aleo/credits.record;
    input r1 as credits.aleo/credits.record;
    input r2 as credits.aleo/credits.record;
    input r3 as credits.aleo/credits.record;
    input r4 as credits.aleo/credits.record;
    input r5 as credits.aleo/credits.record;
    input r6 as credits.aleo/credits.record;
    input r7 as credits.aleo/credits.record;
    input r8 as credits.aleo/credits.record;
    input r9 as credits.aleo/credits.record;
    call credits.aleo/join r0 r1 into r10;
    call credits.aleo/join r10 r2 into r11;
    call credits.aleo/join r11 r3 into r12;
    call credits.aleo/join r12 r4 into r13;
    call credits.aleo/join r13 r5 into r14;
    call credits.aleo/join r14 r6 into r15;
    call credits.aleo/join r15 r7 into r16;
    call credits.aleo/join r16 r8 into r17;
    call credits.aleo/join r17 r9 into r18;
    output r18 as credits.aleo/credits.record;
