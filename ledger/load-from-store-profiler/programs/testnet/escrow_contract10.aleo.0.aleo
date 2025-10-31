import credits.aleo;

program escrow_contract10.aleo;

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
    gt r1 0u64 into r2;
    assert.eq r2 true;
    cast r0 self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r1 0u8 into r3 as Job;
    call credits.aleo/transfer_public self.signer r1 into r4;
    async create_job r0 self.caller r1 r4 into r5;
    output r3 as Job.private;
    output r5 as escrow_contract10.aleo/create_job.future;

finalize create_job:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as credits.aleo/transfer_public.future;
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
    output r1 as escrow_contract10.aleo/accept_job.future;

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
    output r1 as escrow_contract10.aleo/complete_job.future;

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
    call credits.aleo/transfer_public r1 r2 into r3;
    async release_payment r3 r0 self.caller r1 r2 into r4;
    output r4 as escrow_contract10.aleo/release_payment.future;

finalize release_payment:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as u64.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as u64.public;
    await r0;
    get escrow_accounts[r2] into r5;
    sub r5 r4 into r6;
    set r6 into escrow_accounts[r2];
    set 0u64 into job_escrow[r1];
    get jobs[r1] into r7;
    is.eq r7.payment_amount r4 into r8;
    assert.eq r8 true;
    is.eq r7.job_id r1 into r9;
    assert.eq r9 true;
    cast r7.job_id r7.employer r7.freelancer r7.payment_amount 4u8 into r10 as Job;
    set r10 into jobs[r1];

function dispute_job:
    input r0 as u64.private;
    async dispute_job r0 self.caller into r1;
    output r1 as escrow_contract10.aleo/dispute_job.future;

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
    output r2 as escrow_contract10.aleo/resolve_dispute.future;

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
    branch.eq r2 false to end_then_0_0;
    get.or_use escrow_accounts[r3.employer] 0u64 into r9;
    add r9 r8 into r10;
    set r10 into escrow_accounts[r3.employer];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    get.or_use escrow_accounts[r3.freelancer] 0u64 into r11;
    add r11 r8 into r12;
    set r12 into escrow_accounts[r3.freelancer];
    position end_otherwise_0_1;
    set 0u64 into job_escrow[r0];

function get_job:
    input r0 as u64.private;
    async get_job r0 into r1;
    output r1 as escrow_contract10.aleo/get_job.future;

finalize get_job:
    input r0 as u64.public;
    get jobs[r0] into r1;

function get_escrow_balance:
    input r0 as address.private;
    async get_escrow_balance r0 into r1;
    output r1 as escrow_contract10.aleo/get_escrow_balance.future;

finalize get_escrow_balance:
    input r0 as address.public;
    get.or_use escrow_accounts[r0] 0u64 into r1;
