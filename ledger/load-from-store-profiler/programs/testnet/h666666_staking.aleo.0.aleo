import credits.aleo;

program h666666_staking.aleo;

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
    assert.neq r1 0u64;
    call credits.aleo/transfer_public_as_signer h666666_staking.aleo r1 into r2;
    call credits.aleo/bond_public r0 h666666_staking.aleo r1 into r3;
    async bond_public self.caller r1 r2 r3 into r4;
    output r4 as h666666_staking.aleo/bond_public.future;

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
    get credits.aleo/bonded[h666666_staking.aleo] into r6;
    sub r6.microcredits r1 into r7;
    sub r7 r5.total_staking into r8;
    is.eq r5.total_supply 0u64 into r9;
    cast r5.total_staking into r10 as u128;
    mul r10 10000u128 into r11;
    cast r8 into r12 as u128;
    cast r4.protocol_fee into r13 as u128;
    sub 10000u128 r13 into r14;
    mul r12 r14 into r15;
    add r11 r15 into r16;
    ternary r9 1u128 r16 into r17;
    is.eq r5.total_supply 0u64 into r18;
    cast r4.protocol_fee into r19 as u128;
    cast r8 into r20 as u128;
    mul r19 r20 into r21;
    cast r5.total_supply into r22 as u128;
    mul r21 r22 into r23;
    ternary r18 0u128 r23 into r24;
    div r24 r17 into r25;
    cast r25 into r26 as u64;
    is.eq r5.total_supply 0u64 into r27;
    cast r7 into r28 as u128;
    ternary r27 1u128 r28 into r29;
    is.eq r5.total_supply 0u64 into r30;
    cast r1 into r31 as u128;
    add r5.total_supply r26 into r32;
    cast r32 into r33 as u128;
    mul r31 r33 into r34;
    div r34 r29 into r35;
    cast r35 into r36 as u64;
    ternary r30 r1 r36 into r37;
    add r5.total_supply r26 into r38;
    add r38 r37 into r39;
    add r5.total_reward r8 into r40;
    cast r39 r5.total_unstaking r6.microcredits r40 into r41 as State;
    set r41 into state[true];
    get.or_use account[h666666_staking.aleo] 0u64 into r42;
    add r42 r26 into r43;
    set r43 into account[h666666_staking.aleo];
    get.or_use account[r0] 0u64 into r44;
    add r44 r37 into r45;
    set r45 into account[r0];

function unbond_public:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/unbond_public h666666_staking.aleo r0 into r1;
    async unbond_public self.caller r0 r1 into r2;
    output r2 as h666666_staking.aleo/unbond_public.future;

finalize unbond_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/unbond_public.future;
    get credits.aleo/bonded[h666666_staking.aleo] into r3;
    await r2;
    get operators[r0] into r4;
    assert.eq r4 true;
    get settings[true] into r5;
    assert.eq r5.global_paused false;
    get state[true] into r6;
    sub r3.microcredits r6.total_staking into r7;
    cast r6.total_staking into r8 as u128;
    mul r8 10000u128 into r9;
    cast r7 into r10 as u128;
    cast r5.protocol_fee into r11 as u128;
    sub 10000u128 r11 into r12;
    mul r10 r12 into r13;
    add r9 r13 into r14;
    cast r5.protocol_fee into r15 as u128;
    cast r7 into r16 as u128;
    mul r15 r16 into r17;
    cast r6.total_supply into r18 as u128;
    mul r17 r18 into r19;
    div r19 r14 into r20;
    cast r20 into r21 as u64;
    cast r1 into r22 as u128;
    add r6.total_supply r21 into r23;
    cast r23 into r24 as u128;
    mul r22 r24 into r25;
    cast r3.microcredits into r26 as u128;
    add r25 r26 into r27;
    sub r27 1u128 into r28;
    cast r3.microcredits into r29 as u128;
    div r28 r29 into r30;
    cast r30 into r31 as u64;
    get.or_use account[h666666_staking.aleo] 0u64 into r32;
    add r32 r21 into r33;
    sub r33 r31 into r34;
    set r34 into account[h666666_staking.aleo];
    add r6.total_supply r21 into r35;
    sub r35 r31 into r36;
    sub r3.microcredits r1 into r37;
    add r6.total_reward r7 into r38;
    cast r36 r6.total_unstaking r37 r38 into r39 as State;
    set r39 into state[true];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as h666666_staking.aleo/transfer_public.future;

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
    output r5 as h666666_staking.aleo/transfer_private_to_public.future;

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
    output r3 as h666666_staking.aleo/transfer_public_to_private.future;

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

function staker_unbond_public_token:
    input r0 as u64.public;
    async staker_unbond_public_token self.caller r0 into r1;
    output r1 as h666666_staking.aleo/staker_unbond_public_token.future;

finalize staker_unbond_public_token:
    input r0 as address.public;
    input r1 as u64.public;
    get settings[true] into r2;
    assert.eq r2.global_paused false;
    assert.eq r2.stake_paused false;
    get state[true] into r3;
    get credits.aleo/bonded[h666666_staking.aleo] into r4;
    is.neq r4.microcredits 0u64 into r5;
    ternary r5 r4.microcredits r3.total_staking into r6;
    sub r6 r3.total_staking into r7;
    cast r3.total_staking into r8 as u128;
    mul r8 10000u128 into r9;
    cast r7 into r10 as u128;
    cast r2.protocol_fee into r11 as u128;
    sub 10000u128 r11 into r12;
    mul r10 r12 into r13;
    add r9 r13 into r14;
    cast r2.protocol_fee into r15 as u128;
    cast r7 into r16 as u128;
    mul r15 r16 into r17;
    cast r3.total_supply into r18 as u128;
    mul r17 r18 into r19;
    div r19 r14 into r20;
    cast r20 into r21 as u64;
    cast r1 into r22 as u128;
    cast r6 into r23 as u128;
    mul r22 r23 into r24;
    cast r3.total_supply into r25 as u128;
    cast r21 into r26 as u128;
    add r25 r26 into r27;
    div r24 r27 into r28;
    cast r28 into r29 as u64;
    branch.eq r5 false to end_then_0_0;
    get.or_use account[h666666_staking.aleo] 0u64 into r30;
    add r30 r21 into r31;
    add r31 r1 into r32;
    set r32 into account[h666666_staking.aleo];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    get.or_use account[r0] 0u64 into r33;
    sub r33 r1 into r34;
    set r34 into account[r0];
    add r3.total_supply r21 into r35;
    add r3.total_unstaking r29 into r36;
    add r3.total_reward r7 into r37;
    cast r35 r36 r6 r37 into r38 as State;
    set r38 into state[true];
    cast 0u64 0u32 into r39 as Unbonding;
    get.or_use unbonding[r0] r39 into r40;
    add r40.microcredits r29 into r41;
    add block.height 360u32 into r42;
    cast r41 r42 into r43 as Unbonding;
    set r43 into unbonding[r0];

function staker_withdraw:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async staker_withdraw self.caller r0 r1 into r2;
    output r2 as h666666_staking.aleo/staker_withdraw.future;

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

function unbond_all_public:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/unbond_public h666666_staking.aleo r0 into r1;
    async unbond_all_public self.caller r0 r1 into r2;
    output r2 as h666666_staking.aleo/unbond_all_public.future;

finalize unbond_all_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/unbond_public.future;
    get credits.aleo/bonded[h666666_staking.aleo] into r3;
    sub r3.microcredits r1 into r4;
    lt r4 10000000000u64 into r5;
    assert.eq r5 true;
    await r2;
    get operators[r0] into r6;
    assert.eq r6 true;
    get settings[true] into r7;
    assert.eq r7.global_paused false;
    get state[true] into r8;
    sub r3.microcredits r8.total_staking into r9;
    cast r8.total_staking into r10 as u128;
    mul r10 10000u128 into r11;
    cast r9 into r12 as u128;
    cast r7.protocol_fee into r13 as u128;
    sub 10000u128 r13 into r14;
    mul r12 r14 into r15;
    add r11 r15 into r16;
    cast r7.protocol_fee into r17 as u128;
    cast r9 into r18 as u128;
    mul r17 r18 into r19;
    cast r8.total_supply into r20 as u128;
    mul r19 r20 into r21;
    div r21 r16 into r22;
    cast r22 into r23 as u64;
    get.or_use account[h666666_staking.aleo] 0u64 into r24;
    set 0u64 into account[h666666_staking.aleo];
    cast r24 into r25 as u128;
    cast r23 into r26 as u128;
    add r25 r26 into r27;
    cast r8.total_supply into r28 as u128;
    cast r23 into r29 as u128;
    add r28 r29 into r30;
    mul r27 r30 into r31;
    cast r8.total_staking into r32 as u128;
    cast r9 into r33 as u128;
    add r32 r33 into r34;
    div r31 r34 into r35;
    cast r35 into r36 as u64;
    sub r8.total_supply r24 into r37;
    sub r8.total_staking r36 into r38;
    add r8.total_reward r9 into r39;
    cast r37 r8.total_unstaking r38 r39 into r40 as State;
    set r40 into state[true];

function claim:
    call credits.aleo/claim_unbond_public h666666_staking.aleo into r0;
    async claim self.caller r0 into r1;
    output r1 as h666666_staking.aleo/claim.future;

finalize claim:
    input r0 as address.public;
    input r1 as credits.aleo/claim_unbond_public.future;
    await r1;
    get operators[r0] into r2;
    assert.eq r2 true;
    get settings[true] into r3;
    assert.eq r3.global_paused false;

function withdraw:
    input r0 as u64.public;
    call credits.aleo/transfer_public aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn r0 into r1;
    async withdraw self.caller r0 r1 into r2;
    output r2 as h666666_staking.aleo/withdraw.future;

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
    get.or_use credits.aleo/account[h666666_staking.aleo] 0u64 into r6;
    get credits.aleo/bonded[h666666_staking.aleo] into r7;
    add r6 r7.microcredits into r8;
    add r5.total_staking r5.total_unstaking into r9;
    gte r8 r9 into r10;
    assert.eq r10 true;

function init:
    assert.eq self.caller aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn;
    async init into r0;
    output r0 as h666666_staking.aleo/init.future;

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
    output r2 as h666666_staking.aleo/set_operator.future;

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
    output r2 as h666666_staking.aleo/update_settings.future;

finalize update_settings:
    input r0 as address.public;
    input r1 as Settings.public;
    get admins[r0] into r2;
    assert.eq r2 true;
    set r1 into settings[true];
