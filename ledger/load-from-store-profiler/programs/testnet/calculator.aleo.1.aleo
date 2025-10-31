program calculator.aleo;

closure calculate:
    input r0 as i32;
    input r1 as i32;
    add r0 r1 into r2;
    sub r0 r1 into r3;
    mul r0 r1 into r4;
    div r0 r1 into r5;
    output r2 as i32;
    output r3 as i32;
    output r4 as i32;
    output r5 as i32;

function main:
    input r0 as i32.public;
    input r1 as i32.private;
    call calculate r0 r1 into r2 r3 r4 r5;
    output r2 as i32.private;
    output r3 as i32.private;
    output r4 as i32.private;
    output r5 as i32.private;
