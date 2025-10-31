program subdao_reserve.aleo;

mapping reserve_balance:
    key as address.public;
    value as u64.public;

mapping tax_obligations:
    key as address.public;
    value as u64.public;

function deposit:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    async deposit r0 r1 into r3;
    output r3 as subdao_reserve.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use reserve_balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into reserve_balance[r0];

function process_taxes:
    input r0 as address.private;
    async process_taxes r0 into r1;
    output r1 as subdao_reserve.aleo/process_taxes.future;

finalize process_taxes:
    input r0 as address.public;
    get.or_use reserve_balance[r0] 0u64 into r1;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    mul r1 10u64 into r3;
    div r3 100u64 into r4;
    sub r1 r4 into r5;
    set r5 into reserve_balance[r0];
    get.or_use tax_obligations[r0] 0u64 into r6;
    add r6 r4 into r7;
    set r7 into tax_obligations[r0];

function withdraw:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    async withdraw r0 r1 into r3;
    output r3 as subdao_reserve.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use reserve_balance[r0] 0u64 into r2;
    gte r2 r1 into r3;
    assert.eq r3 true;
    sub r2 r1 into r4;
    set r4 into reserve_balance[r0];
