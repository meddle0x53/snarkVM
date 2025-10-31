program weekly_payroll_pool.aleo;

mapping weekly_balance:
    key as address.public;
    value as u64.public;

function fund_weekly_pool:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    async fund_weekly_pool r0 r1 into r3;
    output r3 as weekly_payroll_pool.aleo/fund_weekly_pool.future;

finalize fund_weekly_pool:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use weekly_balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into weekly_balance[r0];

function execute_weekly_payroll:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    async execute_weekly_payroll r0 r1 into r3;
    output r3 as weekly_payroll_pool.aleo/execute_weekly_payroll.future;

finalize execute_weekly_payroll:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use weekly_balance[r0] 0u64 into r2;
    gte r2 r1 into r3;
    assert.eq r3 true;
    sub r2 r1 into r4;
    set r4 into weekly_balance[r0];

function verify_pool_exists:
    input r0 as address.private;
    async verify_pool_exists r0 into r1;
    output r1 as weekly_payroll_pool.aleo/verify_pool_exists.future;

finalize verify_pool_exists:
    input r0 as address.public;
    contains weekly_balance[r0] into r1;
    assert.eq r1 true;
