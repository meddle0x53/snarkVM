program gmplaygame.aleo;

struct GuessGame:
    secret_number as u8;
    attempts as u8;
    max_attempts as u8;

function new:
    input r0 as u8.private;
    input r1 as u8.private;
    cast r0 0u8 r1 into r2 as GuessGame;
    output r2 as GuessGame.private;

function guess:
    input r0 as GuessGame.private;
    input r1 as u8.private;
    add r0.attempts 1u8 into r2;
    is.eq r1 r0.secret_number into r3;
    gte r2 r0.max_attempts into r4;
    cast r0.secret_number r2 r0.max_attempts into r5 as GuessGame;
    ternary r4 r0.secret_number r5.secret_number into r6;
    ternary r4 r0.attempts r5.attempts into r7;
    ternary r4 r0.max_attempts r5.max_attempts into r8;
    cast r6 r7 r8 into r9 as GuessGame;
    ternary r4 2u8 0u8 into r10;
    ternary r3 r0.secret_number r9.secret_number into r11;
    ternary r3 r0.attempts r9.attempts into r12;
    ternary r3 r0.max_attempts r9.max_attempts into r13;
    cast r11 r12 r13 into r14 as GuessGame;
    ternary r3 1u8 r10 into r15;
    output r14 as GuessGame.private;
    output r15 as u8.private;
