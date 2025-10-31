program daddys_orders.aleo;

function get_order:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 into r2 as field;
    cast r1 into r3 as field;
    add r2 r3 into r4;
    hash.bhp256 r4 into r5 as u128;
    rem r5 3u128 into r6;
    cast r6 into r7 as u8;
    div r5 3u128 into r8;
    rem r8 3u128 into r9;
    cast r9 into r10 as u8;
    div r5 9u128 into r11;
    rem r11 3u128 into r12;
    cast r12 into r13 as u8;
    output r7 as u8.private;
    output r10 as u8.private;
    output r13 as u8.private;

function obey_order:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u8.public;
    input r3 as u8.public;
    input r4 as u8.public;
    cast r0 into r5 as field;
    cast r1 into r6 as field;
    add r5 r6 into r7;
    hash.bhp256 r7 into r8 as u128;
    rem r8 3u128 into r9;
    cast r9 into r10 as u8;
    div r8 3u128 into r11;
    rem r11 3u128 into r12;
    cast r12 into r13 as u8;
    div r8 9u128 into r14;
    rem r14 3u128 into r15;
    cast r15 into r16 as u8;
    is.eq r2 r10 into r17;
    assert.eq r17 true;
    is.eq r3 r13 into r18;
    assert.eq r18 true;
    is.eq r4 r16 into r19;
    assert.eq r19 true;
    output 1u8 as u8.private;
