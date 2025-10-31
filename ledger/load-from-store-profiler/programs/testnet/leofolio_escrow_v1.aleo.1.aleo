import credits.aleo;
import token_registry.aleo;

program leofolio_escrow_v1.aleo;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct Job:
    job_id as field;
    employer as address;
    freelancer as address;
    payment_amount as u128;
    token_id as field;
    status as u8;

struct JobParticipant:
    account as address;
    job_id as field;

mapping jobs:
    key as field.public;
    value as Job.public;

mapping job_escrow:
    key as field.public;
    value as u128.public;

mapping escrow_accounts:
    key as address.public;
    value as u128.public;

mapping roles:
    key as field.public;
    value as u8.public;

function create_job:
    input r0 as field.private;
    input r1 as u128.private;
    cast r0 self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r1 0field 0u8 into r2 as Job;
    cast self.caller r0 into r3 as JobParticipant;
    hash.bhp256 r3 into r4 as field;
    async create_job r0 r2 self.caller r1 r4 into r5;
    output r2 as Job.private;
    output r5 as leofolio_escrow_v1.aleo/create_job.future;

finalize create_job:
    input r0 as field.public;
    input r1 as Job.public;
    input r2 as address.public;
    input r3 as u128.public;
    input r4 as field.public;
    set r1 into jobs[r0];
    set 1u8 into roles[r4];
    set r3 into job_escrow[r0];

function accept_job:
    input r0 as field.private;
    cast self.caller r0 into r1 as JobParticipant;
    hash.bhp256 r1 into r2 as field;
    cast r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc self.caller 0u128 0field 1u8 into r3 as Job;
    async accept_job r0 self.caller r2 into r4;
    output r3 as Job.private;
    output r4 as leofolio_escrow_v1.aleo/accept_job.future;

finalize accept_job:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    get jobs[r0] into r3;
    is.eq r3.status 0u8 into r4;
    assert.eq r4 true;
    cast r3.job_id r3.employer r1 r3.payment_amount r3.token_id 1u8 into r5 as Job;
    set r5 into jobs[r0];
    set 2u8 into roles[r2];

function complete_job:
    input r0 as field.private;
    cast self.caller r0 into r1 as JobParticipant;
    hash.bhp256 r1 into r2 as field;
    cast r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc self.caller 0u128 0field 2u8 into r3 as Job;
    async complete_job r0 self.caller r2 into r4;
    output r3 as Job.private;
    output r4 as leofolio_escrow_v1.aleo/complete_job.future;

finalize complete_job:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    get jobs[r0] into r3;
    is.eq r3.freelancer r1 into r4;
    assert.eq r4 true;
    get roles[r2] into r5;
    is.eq r5 2u8 into r6;
    assert.eq r6 true;
    is.eq r3.status 1u8 into r7;
    assert.eq r7 true;
    cast r3.job_id r3.employer r3.freelancer r3.payment_amount r3.token_id 2u8 into r8 as Job;
    set r8 into jobs[r0];

function release_payment:
    input r0 as field.private;
    cast self.caller r0 into r1 as JobParticipant;
    hash.bhp256 r1 into r2 as field;
    async release_payment r0 self.caller r2 into r3;
    output r3 as leofolio_escrow_v1.aleo/release_payment.future;

finalize release_payment:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    get jobs[r0] into r3;
    is.eq r3.employer r1 into r4;
    assert.eq r4 true;
    get roles[r2] into r5;
    is.eq r5 1u8 into r6;
    assert.eq r6 true;
    is.eq r3.status 2u8 into r7;
    assert.eq r7 true;
    get job_escrow[r0] into r8;
    gt r8 0u128 into r9;
    assert.eq r9 true;
    set 0u128 into job_escrow[r0];

function dispute_job:
    input r0 as field.private;
    cast self.caller r0 into r1 as JobParticipant;
    hash.bhp256 r1 into r2 as field;
    cast r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0field 3u8 into r3 as Job;
    async dispute_job r0 self.caller r2 into r4;
    output r3 as Job.private;
    output r4 as leofolio_escrow_v1.aleo/dispute_job.future;

finalize dispute_job:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    get jobs[r0] into r3;
    is.eq r3.employer r1 into r4;
    is.eq r3.freelancer r1 into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    get roles[r2] into r7;
    is.eq r7 1u8 into r8;
    is.eq r7 2u8 into r9;
    or r8 r9 into r10;
    assert.eq r10 true;
    is.eq r3.status 1u8 into r11;
    assert.eq r11 true;
    cast r3.job_id r3.employer r3.freelancer r3.payment_amount r3.token_id 3u8 into r12 as Job;
    set r12 into jobs[r0];

function resolve_dispute:
    input r0 as field.private;
    input r1 as boolean.private;
    cast self.caller r0 into r2 as JobParticipant;
    hash.bhp256 r2 into r3 as field;
    async resolve_dispute r0 self.caller r1 r3 into r4;
    output r4 as leofolio_escrow_v1.aleo/resolve_dispute.future;

finalize resolve_dispute:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as boolean.public;
    input r3 as field.public;
    get jobs[r0] into r4;
    is.eq r4.status 3u8 into r5;
    assert.eq r5 true;
    get roles[r3] into r6;
    is.eq r6 3u8 into r7;
    assert.eq r7 true;
    get job_escrow[r0] into r8;
    set 0u128 into job_escrow[r0];

function view_job:
    input r0 as field.private;
    cast r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u128 0field 0u8 into r1 as Job;
    output r1 as Job.private;
