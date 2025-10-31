import credits.aleo;
import staking_v1.aleo;

program staker_v1_b.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;

struct unbond_state:
    microcredits as u64;
    height as u32;

struct Settings:
    unstake_wait as u32;
    stake_paused as boolean;
    global_paused as boolean;
    max_reward_per_notify as u64;
    protocol_fee as u16;
    fee_account as address;

struct StakerState:
    total_pulled as u64;
    total_pushed as u64;
    total_reward as u64;

mapping admins:
    key as address.public;
    value as boolean.public;

mapping operators:
    key as address.public;
    value as boolean.public;

mapping state:
    key as boolean.public;
    value as StakerState.public;

function notify_reward:
    input r0 as u64.public;
    call staking_v1.aleo/notify_reward r0 into r1;
    async notify_reward self.caller r0 r1 into r2;
    output r2 as staker_v1_b.aleo/notify_reward.future;

finalize notify_reward:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as staking_v1.aleo/notify_reward.future;
    await r2;
    get operators[r0] into r3;
    assert.eq r3 true;
    get.or_use credits.aleo/account[staker_v1_b.aleo] 0u64 into r4;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r5 as bond_state;
    get.or_use credits.aleo/bonded[staker_v1_b.aleo] r5 into r6;
    cast 0u64 0u32 into r7 as unbond_state;
    get.or_use credits.aleo/unbonding[staker_v1_b.aleo] r7 into r8;
    get state[true] into r9;
    add r4 r6.microcredits into r10;
    add r10 r8.microcredits into r11;
    add r11 r9.total_pushed into r12;
    sub r12 r9.total_pulled into r13;
    sub r13 r9.total_reward into r14;
    lte r1 r14 into r15;
    assert.eq r15 true;
    add r9.total_reward r1 into r16;
    cast r9.total_pulled r9.total_pushed r16 into r17 as StakerState;
    set r17 into state[true];

function set_admin:
    input r0 as address.public;
    input r1 as boolean.public;
    assert.neq self.caller r0;
    async set_admin self.caller r0 r1 into r2;
    output r2 as staker_v1_b.aleo/set_admin.future;

finalize set_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get admins[r0] into r3;
    assert.eq r3 true;
    set r2 into admins[r1];

function init:
    assert.eq self.caller aleo18jfrqsz4m853grpgzflrlzdkcm9art926668g80vd9ruyzv8rsqqlchzyj;
    async init into r0;
    output r0 as staker_v1_b.aleo/init.future;

finalize init:
    contains admins[aleo18jfrqsz4m853grpgzflrlzdkcm9art926668g80vd9ruyzv8rsqqlchzyj] into r0;
    assert.eq r0 false;
    set true into admins[aleo18jfrqsz4m853grpgzflrlzdkcm9art926668g80vd9ruyzv8rsqqlchzyj];
    set true into operators[aleo18jfrqsz4m853grpgzflrlzdkcm9art926668g80vd9ruyzv8rsqqlchzyj];
    cast 0u64 0u64 0u64 into r1 as StakerState;
    set r1 into state[true];

function bond:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    lte r2 r1 into r3;
    assert.eq r3 true;
    call staking_v1.aleo/pull_aleo r2 into r4;
    call credits.aleo/bond_public r0 staker_v1_b.aleo r1 into r5;
    async bond self.caller r2 r4 r5 into r6;
    output r6 as staker_v1_b.aleo/bond.future;

finalize bond:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as staking_v1.aleo/pull_aleo.future;
    input r3 as credits.aleo/bond_public.future;
    await r2;
    await r3;
    get operators[r0] into r4;
    assert.eq r4 true;
    get state[true] into r5;
    add r5.total_pulled r1 into r6;
    cast r6 r5.total_pushed r5.total_reward into r7 as StakerState;
    set r7 into state[true];

function unbond:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/unbond_public staker_v1_b.aleo r0 into r1;
    async unbond self.caller r1 into r2;
    output r2 as staker_v1_b.aleo/unbond.future;

finalize unbond:
    input r0 as address.public;
    input r1 as credits.aleo/unbond_public.future;
    await r1;
    get operators[r0] into r2;
    assert.eq r2 true;

function claim:
    call credits.aleo/claim_unbond_public staker_v1_b.aleo into r0;
    async claim self.caller r0 into r1;
    output r1 as staker_v1_b.aleo/claim.future;

finalize claim:
    input r0 as address.public;
    input r1 as credits.aleo/claim_unbond_public.future;
    await r1;
    get operators[r0] into r2;
    assert.eq r2 true;

function push_aleo:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/transfer_public staking_v1.aleo r0 into r1;
    async push_aleo self.caller r0 r1 into r2;
    output r2 as staker_v1_b.aleo/push_aleo.future;

finalize push_aleo:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public.future;
    await r2;
    get operators[r0] into r3;
    assert.eq r3 true;
    get state[true] into r4;
    add r4.total_pushed r1 into r5;
    cast r4.total_pulled r5 r4.total_reward into r6 as StakerState;
    set r6 into state[true];

function claim_and_push:
    input r0 as u64.public;
    call credits.aleo/claim_unbond_public staker_v1_b.aleo into r1;
    call credits.aleo/transfer_public staking_v1.aleo r0 into r2;
    async claim_and_push self.caller r0 r1 r2 into r3;
    output r3 as staker_v1_b.aleo/claim_and_push.future;

finalize claim_and_push:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/claim_unbond_public.future;
    input r3 as credits.aleo/transfer_public.future;
    await r2;
    await r3;
    get operators[r0] into r4;
    assert.eq r4 true;
    get state[true] into r5;
    add r5.total_pushed r1 into r6;
    cast r5.total_pulled r6 r5.total_reward into r7 as StakerState;
    set r7 into state[true];

function set_operator:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_operator self.caller r0 r1 into r2;
    output r2 as staker_v1_b.aleo/set_operator.future;

finalize set_operator:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get admins[r0] into r3;
    assert.eq r3 true;
    set r2 into operators[r1];
