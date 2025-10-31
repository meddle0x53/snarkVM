import credits.aleo;

program v888888_staking.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;

record token:
    owner as address.private;
    amount as u64.private;

struct Metadata:
    name as u128;
    symbol as u128;
    decimals as u8;

struct State:
    total_supply as u64;
    total_unstaking as u64;
    total_staking as u64;
    total_reward as u64;

struct Unbonding:
    microcredits as u64;
    height as u32;

struct Settings:
    stake_paused as boolean;
    global_paused as boolean;
    protocol_fee as u16;

mapping admins:
    key as address.public;
    value as boolean.public;

mapping operators:
    key as address.public;
    value as boolean.public;

mapping account:
    key as address.public;
    value as u64.public;

mapping state:
    key as boolean.public;
    value as State.public;

mapping unbonding:
    key as address.public;
    value as Unbonding.public;

mapping metadata:
    key as boolean.public;
    value as Metadata.public;

mapping settings:
    key as boolean.public;
    value as Settings.public;

function bond_public:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/bond_public r0 v888888_staking.aleo r1 into r2;
    async bond_public self.caller r1 r2 into r3;
    output r3 as v888888_staking.aleo/bond_public.future;

finalize bond_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/bond_public.future;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[v888888_staking.aleo] r3 into r4;
    await r2;
    get operators[r0] into r5;
    assert.eq r5 true;
    get settings[true] into r6;
    assert.eq r6.global_paused false;
    get state[true] into r7;
    sub r4.microcredits r7.total_staking into r8;
    cast r7.total_staking into r9 as u128;
    mul r9 10000u128 into r10;
    cast r8 into r11 as u128;
    cast r6.protocol_fee into r12 as u128;
    sub 10000u128 r12 into r13;
    mul r11 r13 into r14;
    add r10 r14 into r15;
    cast r6.protocol_fee into r16 as u128;
    cast r8 into r17 as u128;
    mul r16 r17 into r18;
    cast r7.total_supply into r19 as u128;
    mul r18 r19 into r20;
    div r20 r15 into r21;
    cast r21 into r22 as u64;
    get.or_use account[v888888_staking.aleo] 0u64 into r23;
    add r23 r22 into r24;
    set r24 into account[v888888_staking.aleo];
    add r7.total_supply r22 into r25;
    add r7.total_staking r8 into r26;
    add r7.total_reward r8 into r27;
    cast r25 r7.total_unstaking r26 r27 into r28 as State;
    set r28 into state[true];

function unbond_public:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/unbond_public v888888_staking.aleo r0 into r1;
    async unbond_public self.caller r0 r1 into r2;
    output r2 as v888888_staking.aleo/unbond_public.future;

finalize unbond_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/unbond_public.future;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[v888888_staking.aleo] r3 into r4;
    await r2;
    get operators[r0] into r5;
    assert.eq r5 true;
    get settings[true] into r6;
    assert.eq r6.global_paused false;
    get state[true] into r7;
    sub r4.microcredits r7.total_staking into r8;
    cast r7.total_staking into r9 as u128;
    mul r9 10000u128 into r10;
    cast r8 into r11 as u128;
    cast r6.protocol_fee into r12 as u128;
    sub 10000u128 r12 into r13;
    mul r11 r13 into r14;
    add r10 r14 into r15;
    cast r6.protocol_fee into r16 as u128;
    cast r8 into r17 as u128;
    mul r16 r17 into r18;
    cast r7.total_supply into r19 as u128;
    mul r18 r19 into r20;
    div r20 r15 into r21;
    cast r21 into r22 as u64;
    get.or_use account[v888888_staking.aleo] 0u64 into r23;
    add r23 r22 into r24;
    set r24 into account[v888888_staking.aleo];
    add r7.total_supply r22 into r25;
    add r7.total_staking r8 into r26;
    add r7.total_reward r8 into r27;
    cast r25 r7.total_unstaking r26 r27 into r28 as State;
    set r28 into state[true];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as v888888_staking.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use account[r0] 0u64 into r3;
    sub r3 r2 into r4;
    set r4 into account[r0];
    get.or_use account[r1] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into account[r1];

function transfer_private:
    input r0 as token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as token.record;
    cast r1 r2 into r5 as token.record;
    output r4 as token.record;
    output r5 as token.record;

function transfer_private_to_public:
    input r0 as token.record;
    input r1 as address.public;
    input r2 as u64.public;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as token.record;
    async transfer_private_to_public r1 r2 into r5;
    output r4 as token.record;
    output r5 as v888888_staking.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];

function transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 into r2 as token.record;
    async transfer_public_to_private self.caller r1 into r3;
    output r2 as token.record;
    output r3 as v888888_staking.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into account[r0];

function join:
    input r0 as token.record;
    input r1 as token.record;
    add r0.amount r1.amount into r2;
    cast r0.owner r2 into r3 as token.record;
    output r3 as token.record;

function split:
    input r0 as token.record;
    input r1 as u64.private;
    sub r0.amount r1 into r2;
    cast r0.owner r1 into r3 as token.record;
    cast r0.owner r2 into r4 as token.record;
    output r3 as token.record;
    output r4 as token.record;

function staker_bond_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.neq r1 0u64;
    call credits.aleo/transfer_public_as_signer v888888_staking.aleo r1 into r2;
    async staker_bond_public self.caller r1 r2 into r3;
    output r3 as v888888_staking.aleo/staker_bond_public.future;

finalize staker_bond_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    await r2;
    get settings[true] into r3;
    assert.eq r3.global_paused false;
    assert.eq r3.stake_paused false;
    get state[true] into r4;
    is.eq r4.total_supply 0u64 into r5;
    cast r4.total_staking into r6 as u128;
    ternary r5 1u128 r6 into r7;
    is.eq r4.total_supply 0u64 into r8;
    cast r1 into r9 as u128;
    cast r4.total_supply into r10 as u128;
    mul r9 r10 into r11;
    div r11 r7 into r12;
    cast r12 into r13 as u64;
    ternary r8 r1 r13 into r14;
    add r4.total_supply r14 into r15;
    add r4.total_staking r1 into r16;
    cast r15 r4.total_unstaking r16 r4.total_reward into r17 as State;
    set r17 into state[true];
    get.or_use account[r0] 0u64 into r18;
    add r18 r14 into r19;
    set r19 into account[r0];

function staker_unbond_public_token:
    input r0 as u64.public;
    async staker_unbond_public_token self.caller r0 into r1;
    output r1 as v888888_staking.aleo/staker_unbond_public_token.future;

finalize staker_unbond_public_token:
    input r0 as address.public;
    input r1 as u64.public;
    get settings[true] into r2;
    assert.eq r2.global_paused false;
    assert.eq r2.stake_paused false;
    get state[true] into r3;
    cast r1 into r4 as u128;
    cast r3.total_staking into r5 as u128;
    mul r4 r5 into r6;
    cast r3.total_supply into r7 as u128;
    div r6 r7 into r8;
    cast r8 into r9 as u64;
    get.or_use account[r0] 0u64 into r10;
    sub r10 r1 into r11;
    set r11 into account[r0];
    sub r3.total_supply r1 into r12;
    add r3.total_unstaking r9 into r13;
    sub r3.total_staking r9 into r14;
    cast r12 r13 r14 r3.total_reward into r15 as State;
    set r15 into state[true];
    cast 0u64 0u32 into r16 as Unbonding;
    get.or_use unbonding[r0] r16 into r17;
    add r17.microcredits r9 into r18;
    add block.height 360u32 into r19;
    cast r18 r19 into r20 as Unbonding;
    set r20 into unbonding[r0];

function staker_withdraw:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async staker_withdraw self.caller r0 r1 into r2;
    output r2 as v888888_staking.aleo/staker_withdraw.future;

finalize staker_withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public.future;
    await r2;
    get settings[true] into r3;
    assert.eq r3.global_paused false;
    assert.eq r3.stake_paused false;
    get unbonding[r0] into r4;
    gte block.height r4.height into r5;
    assert.eq r5 true;
    sub r4.microcredits r1 into r6;
    cast r6 r4.height into r7 as Unbonding;
    set r7 into unbonding[r0];
    get state[true] into r8;
    sub r8.total_unstaking r1 into r9;
    cast r8.total_supply r9 r8.total_staking r8.total_reward into r10 as State;
    set r10 into state[true];

function claim:
    call credits.aleo/claim_unbond_public v888888_staking.aleo into r0;
    async claim self.caller r0 into r1;
    output r1 as v888888_staking.aleo/claim.future;

finalize claim:
    input r0 as address.public;
    input r1 as credits.aleo/claim_unbond_public.future;
    await r1;
    get operators[r0] into r2;
    assert.eq r2 true;
    get settings[true] into r3;
    assert.eq r3.global_paused false;

function ts_unbond_public:
    input r0 as u64.public;
    call credits.aleo/unbond_public v888888_staking.aleo r0 into r1;
    async ts_unbond_public self.caller r0 r1 into r2;
    output r2 as v888888_staking.aleo/ts_unbond_public.future;

finalize ts_unbond_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/unbond_public.future;
    await r2;
    get operators[r0] into r3;
    assert.eq r3 true;

function ts_withdraw:
    input r0 as u64.public;
    call credits.aleo/transfer_public aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn r0 into r1;
    async ts_withdraw self.caller r0 r1 into r2;
    output r2 as v888888_staking.aleo/ts_withdraw.future;

finalize ts_withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public.future;
    await r2;
    get operators[r0] into r3;
    assert.eq r3 true;

function withdraw:
    input r0 as u64.public;
    call credits.aleo/transfer_public aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn r0 into r1;
    async withdraw self.caller r0 r1 into r2;
    output r2 as v888888_staking.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public.future;
    await r2;
    get operators[r0] into r3;
    assert.eq r3 true;
    get settings[true] into r4;
    assert.eq r4.global_paused false;
    get state[true] into r5;
    get.or_use credits.aleo/account[v888888_staking.aleo] 0u64 into r6;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r7 as bond_state;
    get.or_use credits.aleo/bonded[v888888_staking.aleo] r7 into r8;
    add r6 r8.microcredits into r9;
    add r5.total_staking r5.total_unstaking into r10;
    gte r9 r10 into r11;
    assert.eq r11 true;
    cast r1 into r12 as u128;
    cast r5.total_supply into r13 as u128;
    mul r12 r13 into r14;
    cast r5.total_staking into r15 as u128;
    div r14 r15 into r16;
    cast r16 into r17 as u64;
    get.or_use account[v888888_staking.aleo] 0u64 into r18;
    sub r18 r17 into r19;
    set r19 into account[v888888_staking.aleo];
    sub r5.total_supply r17 into r20;
    sub r5.total_staking r1 into r21;
    cast r20 r5.total_unstaking r21 r5.total_reward into r22 as State;
    set r22 into state[true];

function init:
    assert.eq self.caller aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn;
    async init into r0;
    output r0 as v888888_staking.aleo/init.future;

finalize init:
    contains admins[aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn] into r0;
    assert.eq r0 false;
    set true into operators[aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn];
    cast 374843189140063161707513515818446439u128 310335268207u128 6u8 into r1 as Metadata;
    set r1 into metadata[true];
    set true into admins[aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn];
    cast 0u64 0u64 0u64 0u64 into r2 as State;
    set r2 into state[true];
    cast false false 200u16 into r3 as Settings;
    set r3 into settings[true];

function set_operator:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_operator self.caller r0 r1 into r2;
    output r2 as v888888_staking.aleo/set_operator.future;

finalize set_operator:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get admins[r0] into r3;
    assert.eq r3 true;
    set r2 into operators[r1];

function update_settings:
    input r0 as Settings.public;
    lte r0.protocol_fee 1000u16 into r1;
    assert.eq r1 true;
    async update_settings self.caller r0 into r2;
    output r2 as v888888_staking.aleo/update_settings.future;

finalize update_settings:
    input r0 as address.public;
    input r1 as Settings.public;
    get admins[r0] into r2;
    assert.eq r2 true;
    set r1 into settings[true];
