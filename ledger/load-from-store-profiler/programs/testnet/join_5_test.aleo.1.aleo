import credits.aleo;

program join_5_test.aleo;

function join_5:
    input r0 as credits.aleo/credits.record;
    input r1 as credits.aleo/credits.record;
    input r2 as credits.aleo/credits.record;
    input r3 as credits.aleo/credits.record;
    input r4 as credits.aleo/credits.record;
    call credits.aleo/join r0 r1 into r5;
    call credits.aleo/join r5 r2 into r6;
    call credits.aleo/join r6 r3 into r7;
    call credits.aleo/join r7 r4 into r8;
    output r8 as credits.aleo/credits.record;
