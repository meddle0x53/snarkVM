import credits.aleo;
import token_registry.aleo;

program sushant_zk_prediction_market.aleo;

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
    output r3 as sushant_zk_prediction_market.aleo/initialize.future;

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

function stake_public:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as boolean.private;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    call credits.aleo/transfer_public_as_signer sushant_zk_prediction_market.aleo r1 into r4;
    async stake_public self.caller r0 r1 r2 11111111111111111111field r4 into r5;
    output r5 as sushant_zk_prediction_market.aleo/stake_public.future;

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
    cast r0 r4 r1 into r9 as PredictionStake;
    hash.bhp256 r9 into r10 as field;
    cast false false 0u64 0u64 into r11 as Event;
    get.or_use events[r1] r11 into r12;
    not r12.resolved into r13;
    assert.eq r13 true;
    get.or_use user_stake[r10] 0u64 into r14;
    add r14 r2 into r15;
    set r15 into user_stake[r10];
    set block.height into stake_time[r10];
    add r12.total_yes_stake r2 into r16;
    ternary r3 r16 r12.total_yes_stake into r17;
    add r12.total_no_stake r2 into r18;
    ternary r3 r12.total_no_stake r18 into r19;
    cast r12.outcome r12.resolved r17 r19 into r20 as Event;
    set r20 into events[r1];

function resolve_event:
    input r0 as field.private;
    input r1 as boolean.private;
    async resolve_event self.caller r0 r1 into r2;
    output r2 as sushant_zk_prediction_market.aleo/resolve_event.future;

finalize resolve_event:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as boolean.public;
    get admin[true] into r3;
    assert.eq r0 r3;
    get status[true] into r4;
    assert.eq r4 1u8;
    cast false false 0u64 0u64 into r5 as Event;
    get.or_use events[r1] r5 into r6;
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
    output r4 as sushant_zk_prediction_market.aleo/claim_public.future;

finalize claim_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as credits.aleo/transfer_public.future;
    await r4;
    get status[true] into r5;
    assert.eq r5 1u8;
    get events[r1] into r6;
    assert.eq r6.resolved true;
    cast r0 r3 r1 into r7 as PredictionStake;
    hash.bhp256 r7 into r8 as field;
    get.or_use user_stake[r8] 0u64 into r9;
    gt r9 0u64 into r10;
    assert.eq r10 true;
    get.or_use stake_time[r8] 0u32 into r11;
    sub block.height r11 into r12;
    div r12 100u32 into r13;
    shr r9 r13 into r14;
    ternary r6.outcome r6.total_yes_stake r6.total_no_stake into r15;
    ternary r6.outcome r6.total_no_stake r6.total_yes_stake into r16;
    lte r14 r6.total_yes_stake into r17;
    is.eq r17 r6.outcome into r18;
    assert.eq r18 true;
    add r16 r15 into r19;
    mul r14 r19 into r20;
    div r20 r15 into r21;
    lte r2 r21 into r22;
    assert.eq r22 true;
    sub r9 r14 into r23;
    set r23 into user_stake[r8];

function unpause:
    async unpause self.caller into r0;
    output r0 as sushant_zk_prediction_market.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 1u8 into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as sushant_zk_prediction_market.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 0u8 into status[true];

function change_limit:
    input r0 as u64.private;
    async change_limit self.caller r0 into r1;
    output r1 as sushant_zk_prediction_market.aleo/change_limit.future;

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
    output r2 as sushant_zk_prediction_market.aleo/withdraw.future;

finalize withdraw:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as credits.aleo/transfer_public.future;
    await r2;
    get admin[true] into r3;
    assert.eq r1 r3;
