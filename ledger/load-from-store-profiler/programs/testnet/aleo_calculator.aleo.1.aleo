program aleo_calculator.aleo;

function calculate_sum:
    input r0 as u32.public;
    input r1 as u32.public;
    add r0 r1 into r2;
    output r2 as u32.private;

function calculate_difference:
    input r0 as u32.public;
    input r1 as u32.public;
    sub r0 r1 into r2;
    output r2 as u32.private;

function calculate_product:
    input r0 as u32.public;
    input r1 as u32.public;
    mul r0 r1 into r2;
    output r2 as u32.private;

function calculate_quotient:
    input r0 as u32.public;
    input r1 as u32.public;
    is.neq r1 0u32 into r2;
    assert.eq r2 true;
    div r0 r1 into r3;
    output r3 as u32.private;
