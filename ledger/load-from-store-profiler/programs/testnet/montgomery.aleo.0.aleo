program montgomery.aleo;

function dummy:

closure main:
    input r0 as [field; 2u32];
    add 1field r0[1u32] into r1;
    sub 1field r0[1u32] into r2;
    div r1 r2 into r3;
    div r3 r0[0u32] into r4;
    sub 1field r0[1u32] into r5;
    mul r3 r5 into r6;
    add 1field r0[1u32] into r7;
    assert.eq r6 r7;
    mul r4 r0[0u32] into r8;
    assert.eq r8 r3;
    cast r3 r4 into r9 as [field; 2u32];
    output r9 as [field; 2u32];
