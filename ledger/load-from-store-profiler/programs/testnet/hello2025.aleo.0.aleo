program hello2025.aleo;

function main:
    input r0 as u32.public;
    input r1 as u32.private;
    add r0 r1 into r2;
    add r2 6u32 into r3;
    output r3 as u32.private;
