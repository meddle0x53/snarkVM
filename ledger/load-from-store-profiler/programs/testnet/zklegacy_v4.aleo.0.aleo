program zklegacy_v4.aleo;

record TestamentRecord:
    owner as address.private;
    testament_id as field.private;
    role as u8.private;
    private_data as field.private;

struct Testament:
    id as field;
    testator_address as address;
    executor_address as address;
    oracle_address as address;
    ipfs_hash as field;
    creation_timestamp as u32;
    status as u8;

struct KeyRelease:
    testament_id as field;
    death_confirmed as boolean;
    death_timestamp as u32;
    oracle_signature as field;

struct ExecutorAccess:
    oracle_signature as field;
    death_timestamp as u32;

mapping testaments:
    key as field.public;
    value as Testament.public;

mapping key_releases:
    key as field.public;
    value as KeyRelease.public;

mapping executor_access:
    key as field.public;
    value as ExecutorAccess.public;

mapping death_confirmations:
    key as field.public;
    value as boolean.public;

mapping testament_count:
    key as boolean.public;
    value as u32.public;

function create_testament:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as field.public;
    assert.neq self.caller r1;
    assert.neq self.caller r2;
    assert.neq r1 r2;
    cast r0 self.caller r1 r2 r3 0u32 0u8 into r4 as Testament;
    cast self.caller r0 0u8 0field into r5 as TestamentRecord.record;
    cast r1 r0 1u8 r3 into r6 as TestamentRecord.record;
    async create_testament r0 r4 into r7;
    output r5 as TestamentRecord.record;
    output r6 as TestamentRecord.record;
    output r7 as zklegacy_v4.aleo/create_testament.future;

finalize create_testament:
    input r0 as field.public;
    input r1 as Testament.public;
    cast r1.id r1.testator_address r1.executor_address r1.oracle_address r1.ipfs_hash block.height r1.status into r2 as Testament;
    contains testaments[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r2 into testaments[r0];
    get.or_use testament_count[true] 0u32 into r5;
    add r5 1u32 into r6;
    set r6 into testament_count[true];

function confirm_death:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as field.public;
    cast r0 true r1 r2 into r3 as KeyRelease;
    async confirm_death r0 r3 self.caller into r4;
    output r4 as zklegacy_v4.aleo/confirm_death.future;

finalize confirm_death:
    input r0 as field.public;
    input r1 as KeyRelease.public;
    input r2 as address.public;
    get testaments[r0] into r3;
    assert.eq r3.status 0u8;
    assert.eq r2 r3.oracle_address;
    contains key_releases[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    lte r1.death_timestamp block.height into r6;
    assert.eq r6 true;
    set r1 into key_releases[r0];
    cast r1.oracle_signature r1.death_timestamp into r7 as ExecutorAccess;
    set r7 into executor_access[r0];
    set true into death_confirmations[r0];

function claim_access:
    input r0 as field.public;
    input r1 as TestamentRecord.record;
    assert.eq r1.role 1u8;
    assert.eq r1.testament_id r0;
    assert.eq r1.owner self.caller;
    async claim_access r0 into r2;
    cast self.caller r0 3u8 0field into r3 as TestamentRecord.record;
    output r3 as TestamentRecord.record;
    output r2 as zklegacy_v4.aleo/claim_access.future;

finalize claim_access:
    input r0 as field.public;
    contains executor_access[r0] into r1;
    assert.eq r1 true;
    get executor_access[r0] into r2;
    gt r2.death_timestamp 0u32 into r3;
    assert.eq r3 true;

function execute_testament:
    input r0 as field.public;
    input r1 as TestamentRecord.record;
    assert.eq r1.role 3u8;
    assert.eq r1.testament_id r0;
    assert.eq r1.owner self.caller;
    cast self.caller r0 3u8 1field into r2 as TestamentRecord.record;
    async execute_testament r0 into r3;
    output r2 as TestamentRecord.record;
    output r3 as zklegacy_v4.aleo/execute_testament.future;

finalize execute_testament:
    input r0 as field.public;
    get testaments[r0] into r1;
    assert.eq r1.status 0u8;
    get.or_use death_confirmations[r0] false into r2;
    assert.eq r2 true;
    get executor_access[r0] into r3;
    cast r1.id r1.testator_address r1.executor_address r1.oracle_address r1.ipfs_hash r1.creation_timestamp 1u8 into r4 as Testament;
    set r4 into testaments[r0];

function cancel_testament:
    input r0 as field.public;
    input r1 as TestamentRecord.record;
    assert.eq r1.role 0u8;
    assert.eq r1.testament_id r0;
    assert.eq r1.owner self.caller;
    cast self.caller r0 0u8 2field into r2 as TestamentRecord.record;
    async cancel_testament r0 into r3;
    output r2 as TestamentRecord.record;
    output r3 as zklegacy_v4.aleo/cancel_testament.future;

finalize cancel_testament:
    input r0 as field.public;
    get testaments[r0] into r1;
    assert.eq r1.status 0u8;
    cast r1.id r1.testator_address r1.executor_address r1.oracle_address r1.ipfs_hash r1.creation_timestamp 2u8 into r2 as Testament;
    set r2 into testaments[r0];
