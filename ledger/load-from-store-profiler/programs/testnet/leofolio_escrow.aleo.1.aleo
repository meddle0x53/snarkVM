import credits.aleo;

program leofolio_escrow.aleo;

struct Job:
    job_id as u64;
    employer as address;
    freelancer as address;
    payment_amount as u64;
    status as u8;

mapping escrow_accounts:
    key as address.public;
    value as u64.public;

mapping job_escrow:
    key as u64.public;
    value as u64.public;

mapping jobs:
    key as u64.public;
    value as Job.public;

function create_job:
    input r0 as u64.private;
    input r1 as u64.private;
    input r2 as address.private;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    cast r0 self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r1 0u8 into r4 as Job;
    call credits.aleo/transfer_public_as_signer r2 r1 into r5;
    async create_job r0 self.caller r1 r5 into r6;
    output r4 as Job.private;
    output r6 as leofolio_escrow.aleo/create_job.future;

finalize create_job:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as credits.aleo/transfer_public_as_signer.future;
    await r3;
    get.or_use escrow_accounts[r1] 0u64 into r4;
    add r4 r2 into r5;
    set r5 into escrow_accounts[r1];
    cast r0 r1 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r2 0u8 into r6 as Job;
    set r6 into jobs[r0];
    set r2 into job_escrow[r0];

function accept_job:
    input r0 as u64.private;
    async accept_job r0 self.caller into r1;
    output r1 as leofolio_escrow.aleo/accept_job.future;

finalize accept_job:
    input r0 as u64.public;
    input r1 as address.public;
    get jobs[r0] into r2;
    is.eq r2.status 0u8 into r3;
    assert.eq r3 true;
    is.eq r2.freelancer aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r4;
    assert.eq r4 true;
    cast r2.job_id r2.employer r1 r2.payment_amount 1u8 into r5 as Job;
    set r5 into jobs[r0];

function complete_job:
    input r0 as u64.private;
    async complete_job r0 self.caller into r1;
    output r1 as leofolio_escrow.aleo/complete_job.future;

finalize complete_job:
    input r0 as u64.public;
    input r1 as address.public;
    get jobs[r0] into r2;
    is.eq r2.freelancer r1 into r3;
    assert.eq r3 true;
    is.eq r2.status 1u8 into r4;
    assert.eq r4 true;
    cast r2.job_id r2.employer r2.freelancer r2.payment_amount 2u8 into r5 as Job;
    set r5 into jobs[r0];

function release_payment:
    input r0 as u64.private;
    input r1 as address.private;
    input r2 as u64.private;
    mul r2 2u64 into r3;
    div r3 100u64 into r4;
    sub r2 r4 into r5;
    call credits.aleo/transfer_public aleo1ay42zt26vu3s5ah3njra6z5adnu724m9aeg2f0wmvru9fndh2s8sc908dh r4 into r6;
    call credits.aleo/transfer_public r1 r5 into r7;
    async release_payment r6 r7 r0 self.caller r1 r2 r4 into r8;
    output r8 as leofolio_escrow.aleo/release_payment.future;

finalize release_payment:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as credits.aleo/transfer_public.future;
    input r2 as u64.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as u64.public;
    input r6 as u64.public;
    await r0;
    await r1;
    get escrow_accounts[r3] into r7;
    sub r7 r5 into r8;
    set r8 into escrow_accounts[r3];
    set 0u64 into job_escrow[r2];
    get jobs[r2] into r9;
    is.eq r9.status 2u8 into r10;
    assert.eq r10 true;
    is.eq r9.payment_amount r5 into r11;
    assert.eq r11 true;
    is.eq r9.job_id r2 into r12;
    assert.eq r12 true;
    cast r9.job_id r9.employer r9.freelancer r9.payment_amount 4u8 into r13 as Job;
    set r13 into jobs[r2];

function dispute_job:
    input r0 as u64.private;
    async dispute_job r0 self.caller into r1;
    output r1 as leofolio_escrow.aleo/dispute_job.future;

finalize dispute_job:
    input r0 as u64.public;
    input r1 as address.public;
    get jobs[r0] into r2;
    is.eq r2.employer r1 into r3;
    is.eq r2.freelancer r1 into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    is.eq r2.status 1u8 into r6;
    assert.eq r6 true;
    cast r2.job_id r2.employer r2.freelancer r2.payment_amount 3u8 into r7 as Job;
    set r7 into jobs[r0];

function resolve_dispute:
    input r0 as u64.private;
    input r1 as boolean.private;
    async resolve_dispute r0 self.caller r1 into r2;
    output r2 as leofolio_escrow.aleo/resolve_dispute.future;

finalize resolve_dispute:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get jobs[r0] into r3;
    is.eq r3.status 3u8 into r4;
    assert.eq r4 true;
    is.eq r3.employer r1 into r5;
    is.eq r3.freelancer r1 into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    get job_escrow[r0] into r8;
    mul r8 2u64 into r9;
    div r9 100u64 into r10;
    sub r8 r10 into r11;
    branch.eq r2 false to end_then_0_0;
    get.or_use escrow_accounts[r3.employer] 0u64 into r12;
    add r12 r11 into r13;
    set r13 into escrow_accounts[r3.employer];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    get.or_use escrow_accounts[r3.freelancer] 0u64 into r14;
    add r14 r11 into r15;
    set r15 into escrow_accounts[r3.freelancer];
    position end_otherwise_0_1;
    get.or_use escrow_accounts[aleo1ay42zt26vu3s5ah3njra6z5adnu724m9aeg2f0wmvru9fndh2s8sc908dh] 0u64 into r16;
    add r16 r10 into r17;
    set r17 into escrow_accounts[aleo1ay42zt26vu3s5ah3njra6z5adnu724m9aeg2f0wmvru9fndh2s8sc908dh];
    set 0u64 into job_escrow[r0];

function get_job:
    input r0 as u64.private;
    async get_job r0 into r1;
    output r1 as leofolio_escrow.aleo/get_job.future;

finalize get_job:
    input r0 as u64.public;
    get jobs[r0] into r1;

function get_escrow_balance:
    input r0 as address.private;
    async get_escrow_balance r0 into r1;
    output r1 as leofolio_escrow.aleo/get_escrow_balance.future;

finalize get_escrow_balance:
    input r0 as address.public;
    get.or_use escrow_accounts[r0] 0u64 into r1;
