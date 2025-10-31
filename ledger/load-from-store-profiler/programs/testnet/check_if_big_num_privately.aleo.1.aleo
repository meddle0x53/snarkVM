program check_if_big_num_privately.aleo;

struct Store:
    id as field;
    user as address;
    number as u32;

mapping stores:
    key as field.public;
    value as Store.public;

function store_number:
    input r0 as Store.private;
    input r1 as field.private;
    gte r0.number 0u32 into r2;
    assert.eq r2 true;
    async store_number r1 r0.number self.caller into r3;
    output r0 as Store.private;
    output r3 as check_if_big_num_privately.aleo/store_number.future;

finalize store_number:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as address.public;
    cast r0 r2 r1 into r3 as Store;
    set r3 into stores[r0];

function is_bigger:
    input r0 as field.private;
    input r1 as u32.private;
    gte r1 0u32 into r2;
    assert.eq r2 true;
    async is_bigger r0 r1 into r3;
    output r3 as check_if_big_num_privately.aleo/is_bigger.future;

finalize is_bigger:
    input r0 as field.public;
    input r1 as u32.public;
    get stores[r0] into r2;
    gt r2.number r1 into r3;
    assert.eq r3 true;
