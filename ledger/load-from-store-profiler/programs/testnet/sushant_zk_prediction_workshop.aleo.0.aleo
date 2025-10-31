import credits.aleo;

program sushant_zk_prediction_workshop.aleo;

struct PredictionStake:
    account as address;
    token_id as field;
    event_id as field;

struct Event:
    outcome as boolean;
    resolved as boolean;
    total_yes_stake as u64;
    total_no_stake as u64;

mapping admin:
    key as boolean.public;
    value as address.public;

mapping status:
    key as boolean.public;
    value as u8.public;

mapping stake_limit:
    key as boolean.public;
    value as u64.public;

mapping user_stake:
    key as field.public;
    value as u64.public;

mapping stake_time:
    key as field.public;
    value as u32.public;

mapping events:
    key as field.public;
    value as Event.public;

mapping decay_factor:
    key as boolean.public;
    value as u32.public;

function initialize:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    async initialize r0 r1 into r3;
    output r3 as sushant_zk_prediction_workshop.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    input r1 as u64.public;
    contains admin[true] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r0 into admin[true];
    set r1 into stake_limit[true];
    set 0u8 into status[true];
    set 100u32 into decay_factor[true];

function create_event:
    input r0 as field.private;
    async create_event self.caller r0 into r1;
    output r1 as sushant_zk_prediction_workshop.aleo/create_event.future;

finalize create_event:
    input r0 as address.public;
    input r1 as field.public;
    get admin[true] into r2;
    assert.eq r0 r2;
    contains events[r1] into r3;
    not r3 into r4;
    assert.eq r4 true;
    cast false false 0u64 0u64 into r5 as Event;
    set r5 into events[r1];

function stake_public:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as boolean.private;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    call credits.aleo/transfer_public_as_signer sushant_zk_prediction_workshop.aleo r1 into r4;
    async stake_public self.caller r0 r1 r2 11111111111111111111field r4 into r5;
    output r5 as sushant_zk_prediction_workshop.aleo/stake_public.future;

finalize stake_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as boolean.public;
    input r4 as field.public;
    input r5 as credits.aleo/transfer_public_as_signer.future;
    await r5;
    get status[true] into r6;
    assert.eq r6 1u8;
    get stake_limit[true] into r7;
    lte r2 r7 into r8;
    assert.eq r8 true;
    contains events[r1] into r9;
    assert.eq r9 true;
    get events[r1] into r10;
    not r10.resolved into r11;
    assert.eq r11 true;
    cast r0 r4 r1 into r12 as PredictionStake;
    hash.bhp256 r12 into r13 as field;
    get.or_use user_stake[r13] 0u64 into r14;
    add r14 r2 into r15;
    set r15 into user_stake[r13];
    set block.height into stake_time[r13];
    add r10.total_yes_stake r2 into r16;
    ternary r3 r16 r10.total_yes_stake into r17;
    add r10.total_no_stake r2 into r18;
    ternary r3 r10.total_no_stake r18 into r19;
    cast r10.outcome r10.resolved r17 r19 into r20 as Event;
    set r20 into events[r1];

function resolve_event:
    input r0 as field.private;
    input r1 as boolean.private;
    async resolve_event self.caller r0 r1 into r2;
    output r2 as sushant_zk_prediction_workshop.aleo/resolve_event.future;

finalize resolve_event:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as boolean.public;
    get admin[true] into r3;
    assert.eq r0 r3;
    get status[true] into r4;
    assert.eq r4 1u8;
    contains events[r1] into r5;
    assert.eq r5 true;
    get events[r1] into r6;
    not r6.resolved into r7;
    assert.eq r7 true;
    cast r2 true r6.total_yes_stake r6.total_no_stake into r8 as Event;
    set r8 into events[r1];

function claim_public:
    input r0 as field.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    call credits.aleo/transfer_public self.caller r1 into r3;
    async claim_public self.caller r0 r1 11111111111111111111field r3 into r4;
    output r4 as sushant_zk_prediction_workshop.aleo/claim_public.future;

finalize claim_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as credits.aleo/transfer_public.future;
    await r4;
    get status[true] into r5;
    assert.eq r5 1u8;
    contains events[r1] into r6;
    assert.eq r6 true;
    get events[r1] into r7;
    assert.eq r7.resolved true;
    cast r0 r3 r1 into r8 as PredictionStake;
    hash.bhp256 r8 into r9 as field;
    get.or_use user_stake[r9] 0u64 into r10;
    gt r10 0u64 into r11;
    assert.eq r11 true;
    get.or_use stake_time[r9] 0u32 into r12;
    sub block.height r12 into r13;
    div r13 100u32 into r14;
    shr r10 r14 into r15;
    ternary r7.outcome r7.total_yes_stake r7.total_no_stake into r16;
    ternary r7.outcome r7.total_no_stake r7.total_yes_stake into r17;
    lte r15 r7.total_yes_stake into r18;
    is.eq r18 r7.outcome into r19;
    assert.eq r19 true;
    add r17 r16 into r20;
    mul r15 r20 into r21;
    div r21 r16 into r22;
    lte r2 r22 into r23;
    assert.eq r23 true;
    sub r10 r15 into r24;
    set r24 into user_stake[r9];

function unpause:
    async unpause self.caller into r0;
    output r0 as sushant_zk_prediction_workshop.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 1u8 into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as sushant_zk_prediction_workshop.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 0u8 into status[true];

function change_limit:
    input r0 as u64.private;
    async change_limit self.caller r0 into r1;
    output r1 as sushant_zk_prediction_workshop.aleo/change_limit.future;

finalize change_limit:
    input r0 as address.public;
    input r1 as u64.public;
    get admin[true] into r2;
    assert.eq r0 r2;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    set r1 into stake_limit[true];

function withdraw:
    input r0 as u64.private;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async withdraw r0 self.caller r1 into r2;
    output r2 as sushant_zk_prediction_workshop.aleo/withdraw.future;

finalize withdraw:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as credits.aleo/transfer_public.future;
    await r2;
    get admin[true] into r3;
    assert.eq r1 r3;
