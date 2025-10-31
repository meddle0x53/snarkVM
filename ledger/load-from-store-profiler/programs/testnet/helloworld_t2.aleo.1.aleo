program helloworld_t2.aleo;

function main:
    input r0 as u32.public;
    input r1 as u32.private;
    add r0 2u32 into r2;
    output r2 as u32.private;
