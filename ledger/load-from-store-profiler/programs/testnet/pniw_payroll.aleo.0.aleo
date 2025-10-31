program pniw_payroll.aleo;

mapping employer_funding:
    key as address.public;
    value as u64.public;

mapping worker_balances:
    key as address.public;
    value as u64.public;

function fund_payroll:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    async fund_payroll r0 r1 into r3;
    output r3 as pniw_payroll.aleo/fund_payroll.future;

finalize fund_payroll:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use employer_funding[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into employer_funding[r0];

function execute_payroll:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as u64.private;
    gt r2 0u64 into r3;
    assert.eq r3 true;
    async execute_payroll r0 r1 r2 into r4;
    output r4 as pniw_payroll.aleo/execute_payroll.future;

finalize execute_payroll:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use employer_funding[r1] 0u64 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    sub r3 r2 into r5;
    set r5 into employer_funding[r1];
    get.or_use worker_balances[r0] 0u64 into r6;
    add r6 r2 into r7;
    set r7 into worker_balances[r0];

function verify_worker_balance:
    input r0 as address.private;
    async verify_worker_balance r0 into r1;
    output r1 as pniw_payroll.aleo/verify_worker_balance.future;

finalize verify_worker_balance:
    input r0 as address.public;
    contains worker_balances[r0] into r1;
    assert.eq r1 true;

function get_worker_balance:
    input r0 as address.private;
    async get_worker_balance r0 into r1;
    output r1 as pniw_payroll.aleo/get_worker_balance.future;

finalize get_worker_balance:
    input r0 as address.public;
    get.or_use worker_balances[r0] 0u64 into r1;
