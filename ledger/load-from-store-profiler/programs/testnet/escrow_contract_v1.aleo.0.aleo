program escrow_contract_v1.aleo;

struct Job:
    job_id as u64;
    employer as address;
    freelancer as address;
    payment_amount as u64;
    status as u8;

mapping job_escrow:
    key as u64.public;
    value as u64.public;

mapping jobs:
    key as u64.public;
    value as Job.public;

function create_job:
    input r0 as u64.private;
    input r1 as u64.private;
    cast r0 self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r1 0u8 into r2 as Job;
    async create_job r0 self.caller r1 into r3;
    output r2 as Job.private;
    output r3 as escrow_contract_v1.aleo/create_job.future;

finalize create_job:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    cast r0 r1 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r2 0u8 into r3 as Job;
    set r3 into jobs[r0];
    set r2 into job_escrow[r0];

function accept_job:
    input r0 as u64.private;
    async accept_job r0 self.caller into r1;
    output r1 as escrow_contract_v1.aleo/accept_job.future;

finalize accept_job:
    input r0 as u64.public;
    input r1 as address.public;
    get jobs[r0] into r2;
    is.eq r2.status 0u8 into r3;
    assert.eq r3 true;
    cast r2.job_id r2.employer r1 r2.payment_amount 1u8 into r4 as Job;
    set r4 into jobs[r0];

function complete_job:
    input r0 as u64.private;
    async complete_job r0 self.caller into r1;
    output r1 as escrow_contract_v1.aleo/complete_job.future;

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
    async release_payment r0 self.caller into r1;
    output r1 as escrow_contract_v1.aleo/release_payment.future;

finalize release_payment:
    input r0 as u64.public;
    input r1 as address.public;
    get jobs[r0] into r2;
    is.eq r2.employer r1 into r3;
    assert.eq r3 true;
    is.eq r2.status 2u8 into r4;
    assert.eq r4 true;
    get job_escrow[r0] into r5;
    set 0u64 into job_escrow[r0];

function dispute_job:
    input r0 as u64.private;
    async dispute_job r0 self.caller into r1;
    output r1 as escrow_contract_v1.aleo/dispute_job.future;

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
    output r2 as escrow_contract_v1.aleo/resolve_dispute.future;

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
    set 0u64 into job_escrow[r0];

function get_job:
    input r0 as u64.private;
    async get_job r0 into r1;
    output r1 as escrow_contract_v1.aleo/get_job.future;

finalize get_job:
    input r0 as u64.public;
    get jobs[r0] into r1;
