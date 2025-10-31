import credits.aleo;

program h888888_staking.aleo;

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
    lock_reserve as u64;

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
    assert.neq r1 0u64;
    call credits.aleo/transfer_public_as_signer h888888_staking.aleo r1 into r2;
    call credits.aleo/bond_public r0 h888888_staking.aleo r1 into r3;
    async bond_public self.caller r1 r2 r3 into r4;
    output r4 as h888888_staking.aleo/bond_public.future;

finalize bond_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    input r3 as credits.aleo/bond_public.future;
    await r2;
    await r3;
    get settings[true] into r4;
    assert.eq r4.global_paused false;
    assert.eq r4.stake_paused false;
    get state[true] into r5;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r6 as bond_state;
    get.or_use credits.aleo/bonded[h888888_staking.aleo] r6 into r7;
    sub r7.microcredits r1 into r8;
    sub r8 r5.total_staking into r9;
    is.eq r5.total_supply 0u64 into r10;
    cast r5.total_staking into r11 as u128;
    mul r11 10000u128 into r12;
    cast r9 into r13 as u128;
    cast r4.protocol_fee into r14 as u128;
    sub 10000u128 r14 into r15;
    mul r13 r15 into r16;
    add r12 r16 into r17;
    ternary r10 1u128 r17 into r18;
    is.eq r5.total_supply 0u64 into r19;
    cast r4.protocol_fee into r20 as u128;
    cast r9 into r21 as u128;
    mul r20 r21 into r22;
    cast r5.total_supply into r23 as u128;
    mul r22 r23 into r24;
    ternary r19 0u128 r24 into r25;
    div r25 r18 into r26;
    cast r26 into r27 as u64;
    is.eq r5.total_supply 0u64 into r28;
    cast r8 into r29 as u128;
    ternary r28 1u128 r29 into r30;
    is.eq r5.total_supply 0u64 into r31;
    cast r1 into r32 as u128;
    add r5.total_supply r27 into r33;
    cast r33 into r34 as u128;
    mul r32 r34 into r35;
    div r35 r30 into r36;
    cast r36 into r37 as u64;
    ternary r31 r1 r37 into r38;
    assert.neq r38 0u64;
    add r5.total_supply r27 into r39;
    add r39 r38 into r40;
    add r5.total_reward r9 into r41;
    cast r40 r5.total_unstaking r7.microcredits r41 r5.lock_reserve into r42 as State;
    set r42 into state[true];
    get.or_use account[h888888_staking.aleo] 0u64 into r43;
    add r43 r27 into r44;
    set r44 into account[h888888_staking.aleo];
    get.or_use account[r0] 0u64 into r45;
    add r45 r38 into r46;
    set r46 into account[r0];

function unbond_public:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/unbond_public h888888_staking.aleo r0 into r1;
    async unbond_public self.caller r0 r1 into r2;
    output r2 as h888888_staking.aleo/unbond_public.future;

finalize unbond_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/unbond_public.future;
    await r2;
    get operators[r0] into r3;
    assert.eq r3 true;
    get settings[true] into r4;
    assert.eq r4.global_paused false;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r5 as bond_state;
    get.or_use credits.aleo/bonded[h888888_staking.aleo] r5 into r6;
    get state[true] into r7;
    add r6.microcredits r1 into r8;
    sub r8 r7.total_staking into r9;
    cast r7.total_staking into r10 as u128;
    mul r10 10000u128 into r11;
    cast r9 into r12 as u128;
    cast r4.protocol_fee into r13 as u128;
    sub 10000u128 r13 into r14;
    mul r12 r14 into r15;
    add r11 r15 into r16;
    cast r4.protocol_fee into r17 as u128;
    cast r9 into r18 as u128;
    mul r17 r18 into r19;
    cast r7.total_supply into r20 as u128;
    mul r19 r20 into r21;
    div r21 r16 into r22;
    cast r22 into r23 as u64;
    cast r1 into r24 as u128;
    add r7.total_supply r23 into r25;
    cast r25 into r26 as u128;
    mul r24 r26 into r27;
    add r6.microcredits r1 into r28;
    cast r28 into r29 as u128;
    add r27 r29 into r30;
    sub r30 1u128 into r31;
    add r6.microcredits r1 into r32;
    cast r32 into r33 as u128;
    div r31 r33 into r34;
    cast r34 into r35 as u64;
    get.or_use account[h888888_staking.aleo] 0u64 into r36;
    add r36 r23 into r37;
    sub r37 r35 into r38;
    set r38 into account[h888888_staking.aleo];
    add r7.total_supply r23 into r39;
    sub r39 r35 into r40;
    add r7.total_reward r9 into r41;
    cast r40 r7.total_unstaking r6.microcredits r41 r7.lock_reserve into r42 as State;
    set r42 into state[true];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as h888888_staking.aleo/transfer_public.future;

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
    output r5 as h888888_staking.aleo/transfer_private_to_public.future;

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
    output r3 as h888888_staking.aleo/transfer_public_to_private.future;

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

function staker_unbond_public:
    input r0 as u64.public;
    async staker_unbond_public self.caller r0 into r1;
    output r1 as h888888_staking.aleo/staker_unbond_public.future;

finalize staker_unbond_public:
    input r0 as address.public;
    input r1 as u64.public;
    get settings[true] into r2;
    assert.eq r2.global_paused false;
    assert.eq r2.stake_paused false;
    get state[true] into r3;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r4 as bond_state;
    get.or_use credits.aleo/bonded[h888888_staking.aleo] r4 into r5;
    sub r5.microcredits r3.total_staking into r6;
    cast r3.total_staking into r7 as u128;
    mul r7 10000u128 into r8;
    cast r6 into r9 as u128;
    cast r2.protocol_fee into r10 as u128;
    sub 10000u128 r10 into r11;
    mul r9 r11 into r12;
    add r8 r12 into r13;
    cast r2.protocol_fee into r14 as u128;
    cast r6 into r15 as u128;
    mul r14 r15 into r16;
    cast r3.total_supply into r17 as u128;
    mul r16 r17 into r18;
    div r18 r13 into r19;
    cast r19 into r20 as u64;
    cast r1 into r21 as u128;
    add r3.total_supply r20 into r22;
    cast r22 into r23 as u128;
    mul r21 r23 into r24;
    cast r5.microcredits into r25 as u128;
    add r24 r25 into r26;
    sub r26 1u128 into r27;
    cast r5.microcredits into r28 as u128;
    div r27 r28 into r29;
    cast r29 into r30 as u64;
    assert.neq r30 0u64;
    get.or_use account[h888888_staking.aleo] 0u64 into r31;
    add r31 r20 into r32;
    add r32 r30 into r33;
    set r33 into account[h888888_staking.aleo];
    get.or_use account[r0] 0u64 into r34;
    sub r34 r30 into r35;
    set r35 into account[r0];
    add r3.total_supply r20 into r36;
    add r3.total_unstaking r1 into r37;
    add r3.total_reward r6 into r38;
    add r3.lock_reserve r1 into r39;
    cast r36 r37 r5.microcredits r38 r39 into r40 as State;
    set r40 into state[true];
    cast 0u64 0u32 into r41 as Unbonding;
    get.or_use unbonding[r0] r41 into r42;
    add r42.microcredits r1 into r43;
    add block.height 360u32 into r44;
    cast r43 r44 into r45 as Unbonding;
    set r45 into unbonding[r0];

function staker_unbond_public_token:
    input r0 as u64.public;
    async staker_unbond_public_token self.caller r0 into r1;
    output r1 as h888888_staking.aleo/staker_unbond_public_token.future;

finalize staker_unbond_public_token:
    input r0 as address.public;
    input r1 as u64.public;
    get settings[true] into r2;
    assert.eq r2.global_paused false;
    assert.eq r2.stake_paused false;
    get state[true] into r3;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r4 as bond_state;
    get.or_use credits.aleo/bonded[h888888_staking.aleo] r4 into r5;
    sub r5.microcredits r3.total_staking into r6;
    cast r3.total_staking into r7 as u128;
    mul r7 10000u128 into r8;
    cast r6 into r9 as u128;
    cast r2.protocol_fee into r10 as u128;
    sub 10000u128 r10 into r11;
    mul r9 r11 into r12;
    add r8 r12 into r13;
    cast r2.protocol_fee into r14 as u128;
    cast r6 into r15 as u128;
    mul r14 r15 into r16;
    cast r3.total_supply into r17 as u128;
    mul r16 r17 into r18;
    div r18 r13 into r19;
    cast r19 into r20 as u64;
    cast r1 into r21 as u128;
    cast r5.microcredits into r22 as u128;
    mul r21 r22 into r23;
    cast r3.total_supply into r24 as u128;
    cast r20 into r25 as u128;
    add r24 r25 into r26;
    div r23 r26 into r27;
    add r3.total_supply r20 into r28;
    cast r28 into r29 as u128;
    mul r27 r29 into r30;
    cast r5.microcredits into r31 as u128;
    add r30 r31 into r32;
    sub r32 1u128 into r33;
    cast r5.microcredits into r34 as u128;
    div r33 r34 into r35;
    cast r35 into r36 as u64;
    assert.neq r36 0u64;
    get.or_use account[h888888_staking.aleo] 0u64 into r37;
    add r37 r20 into r38;
    add r38 r36 into r39;
    set r39 into account[h888888_staking.aleo];
    get.or_use account[r0] 0u64 into r40;
    sub r40 r36 into r41;
    set r41 into account[r0];
    cast r27 into r42 as u64;
    add r3.total_supply r20 into r43;
    add r3.total_unstaking r42 into r44;
    add r3.total_reward r6 into r45;
    add r3.lock_reserve r42 into r46;
    cast r43 r44 r5.microcredits r45 r46 into r47 as State;
    set r47 into state[true];
    cast 0u64 0u32 into r48 as Unbonding;
    get.or_use unbonding[r0] r48 into r49;
    add r49.microcredits r42 into r50;
    add block.height 360u32 into r51;
    cast r50 r51 into r52 as Unbonding;
    set r52 into unbonding[r0];

function staker_withdraw:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async staker_withdraw self.caller r0 r1 into r2;
    output r2 as h888888_staking.aleo/staker_withdraw.future;

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
    sub r8.lock_reserve r1 into r10;
    cast r8.total_supply r9 r8.total_staking r8.total_reward r10 into r11 as State;
    set r11 into state[true];

function claim:
    call credits.aleo/claim_unbond_public h888888_staking.aleo into r0;
    async claim self.caller r0 into r1;
    output r1 as h888888_staking.aleo/claim.future;

finalize claim:
    input r0 as address.public;
    input r1 as credits.aleo/claim_unbond_public.future;
    await r1;
    get operators[r0] into r2;
    assert.eq r2 true;
    get settings[true] into r3;
    assert.eq r3.global_paused false;

function deposit:
    input r0 as u64.public;
    call credits.aleo/transfer_public_as_signer h888888_staking.aleo r0 into r1;
    async deposit self.caller r0 r1 into r2;
    output r2 as h888888_staking.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    await r2;
    get operators[r0] into r3;
    assert.eq r3 true;
    get settings[true] into r4;
    assert.eq r4.global_paused false;

function withdraw:
    input r0 as u64.public;
    call credits.aleo/transfer_public aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn r0 into r1;
    async withdraw self.caller r0 r1 into r2;
    output r2 as h888888_staking.aleo/withdraw.future;

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
    get.or_use credits.aleo/account[h888888_staking.aleo] 0u64 into r6;
    gte r6 r5.lock_reserve into r7;
    assert.eq r7 true;

function init:
    assert.eq self.caller aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn;
    async init into r0;
    output r0 as h888888_staking.aleo/init.future;

finalize init:
    contains admins[aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn] into r0;
    assert.eq r0 false;
    set true into operators[aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn];
    cast 374843189140063161707513515818446439u128 310335268207u128 6u8 into r1 as Metadata;
    set r1 into metadata[true];
    set true into admins[aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn];
    cast 0u64 0u64 0u64 0u64 0u64 into r2 as State;
    set r2 into state[true];
    cast false false 200u16 into r3 as Settings;
    set r3 into settings[true];

function set_operator:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_operator self.caller r0 r1 into r2;
    output r2 as h888888_staking.aleo/set_operator.future;

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
    output r2 as h888888_staking.aleo/update_settings.future;

finalize update_settings:
    input r0 as address.public;
    input r1 as Settings.public;
    get admins[r0] into r2;
    assert.eq r2 true;
    set r1 into settings[true];
