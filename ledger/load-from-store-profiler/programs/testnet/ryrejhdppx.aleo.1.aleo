program ryrejhdppx.aleo;

struct Node:
    left as field;
    right as field;

mapping maps:
    key as u128.public;
    value as field.public;

function set_map:
    input r0 as u128.private;
    input r1 as address.private;
    async set_map self.caller r0 r1 into r2;
    output r2 as ryrejhdppx.aleo/set_map.future;

finalize set_map:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as address.public;
    assert.eq r0 aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn;
    cast r2 into r3 as field;
    set r3 into maps[r1];

function hashcalc:
    input r0 as [[field; 2u32]; 2u32].private;
    cast r0[0u32][0u32] r0[1u32][0u32] into r1 as Node;
    hash.psd4 r1 into r2 as field;
    cast r2 r0[0u32][0u32] into r3 as Node;
    hash.psd4 r1 into r4 as field;
    cast r4 r0[0u32][1u32] into r5 as Node;
    hash.psd4 r1 into r6 as field;
    cast r6 r0[1u32][0u32] into r7 as Node;
    hash.psd4 r1 into r8 as field;
    cast r8 r0[1u32][1u32] into r9 as Node;
    hash.psd4 r1 into r10 as field;
    output r10 as field.private;
