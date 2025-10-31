import credits.aleo;

program h555555_staking.aleo;

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
    call credits.aleo/transfer_public_as_signer h555555_staking.aleo r1 into r2;
    call credits.aleo/bond_public r0 h555555_staking.aleo r1 into r3;
    async bond_public self.caller r1 r2 r3 into r4;
    output r4 as h555555_staking.aleo/bond_public.future;

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
    get.or_use credits.aleo/bonded[h555555_staking.aleo] r6 into r7;
    sub r7.microcredits r1 into r8;
    is.eq r8 0u64 into r9;
    ternary r9 r5.total_staking r8 into r10;
    sub r10 r5.total_staking into r11;
    is.eq r5.total_supply 0u64 into r12;
    cast r5.total_staking into r13 as u128;
    mul r13 10000u128 into r14;
    cast r11 into r15 as u128;
    cast r4.protocol_fee into r16 as u128;
    sub 10000u128 r16 into r17;
    mul r15 r17 into r18;
    add r14 r18 into r19;
    ternary r12 1u128 r19 into r20;
    is.eq r5.total_supply 0u64 into r21;
    cast r4.protocol_fee into r22 as u128;
    cast r11 into r23 as u128;
    mul r22 r23 into r24;
    cast r5.total_supply into r25 as u128;
    mul r24 r25 into r26;
    ternary r21 0u128 r26 into r27;
    div r27 r20 into r28;
    cast r28 into r29 as u64;
    is.eq r5.total_supply 0u64 into r30;
    cast r10 into r31 as u128;
    ternary r30 1u128 r31 into r32;
    is.eq r5.total_supply 0u64 into r33;
    cast r1 into r34 as u128;
    add r5.total_supply r29 into r35;
    cast r35 into r36 as u128;
    mul r34 r36 into r37;
    div r37 r32 into r38;
    cast r38 into r39 as u64;
    ternary r33 r1 r39 into r40;
    add r5.total_supply r29 into r41;
    add r41 r40 into r42;
    add r5.total_reward r11 into r43;
    cast r42 r5.total_unstaking r7.microcredits r43 into r44 as State;
    set r44 into state[true];
    get.or_use account[h555555_staking.aleo] 0u64 into r45;
    add r45 r29 into r46;
    set r46 into account[h555555_staking.aleo];
    get.or_use account[r0] 0u64 into r47;
    add r47 r40 into r48;
    set r48 into account[r0];

function unbond_public:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/unbond_public h555555_staking.aleo r0 into r1;
    async unbond_public self.caller r0 r1 into r2;
    output r2 as h555555_staking.aleo/unbond_public.future;

finalize unbond_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/unbond_public.future;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[h555555_staking.aleo] r3 into r4;
    sub r4.microcredits r1 into r5;
    gte r5 10000000000u64 into r6;
    assert.eq r6 true;
    await r2;
    get operators[r0] into r7;
    assert.eq r7 true;
    get settings[true] into r8;
    assert.eq r8.global_paused false;
    get state[true] into r9;
    sub r4.microcredits r9.total_staking into r10;
    cast r9.total_staking into r11 as u128;
    mul r11 10000u128 into r12;
    cast r10 into r13 as u128;
    cast r8.protocol_fee into r14 as u128;
    sub 10000u128 r14 into r15;
    mul r13 r15 into r16;
    add r12 r16 into r17;
    cast r8.protocol_fee into r18 as u128;
    cast r10 into r19 as u128;
    mul r18 r19 into r20;
    cast r9.total_supply into r21 as u128;
    mul r20 r21 into r22;
    div r22 r17 into r23;
    cast r23 into r24 as u64;
    cast r1 into r25 as u128;
    add r9.total_supply r24 into r26;
    cast r26 into r27 as u128;
    mul r25 r27 into r28;
    cast r4.microcredits into r29 as u128;
    add r28 r29 into r30;
    sub r30 1u128 into r31;
    cast r4.microcredits into r32 as u128;
    div r31 r32 into r33;
    cast r33 into r34 as u64;
    get.or_use account[h555555_staking.aleo] 0u64 into r35;
    add r35 r24 into r36;
    sub r36 r34 into r37;
    set r37 into account[h555555_staking.aleo];
    add r9.total_supply r24 into r38;
    sub r38 r34 into r39;
    sub r4.microcredits r1 into r40;
    add r9.total_reward r10 into r41;
    cast r39 r9.total_unstaking r40 r41 into r42 as State;
    set r42 into state[true];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as h555555_staking.aleo/transfer_public.future;

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
    output r5 as h555555_staking.aleo/transfer_private_to_public.future;

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
    output r3 as h555555_staking.aleo/transfer_public_to_private.future;

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
    output r1 as h555555_staking.aleo/staker_unbond_public_token.future;

finalize staker_unbond_public_token:
    input r0 as address.public;
    input r1 as u64.public;
    get settings[true] into r2;
    assert.eq r2.global_paused false;
    assert.eq r2.stake_paused false;
    get state[true] into r3;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r4 as bond_state;
    get.or_use credits.aleo/bonded[h555555_staking.aleo] r4 into r5;
    is.neq r5.microcredits 0u64 into r6;
    ternary r6 r5.microcredits r3.total_staking into r7;
    sub r7 r3.total_staking into r8;
    cast r3.total_staking into r9 as u128;
    mul r9 10000u128 into r10;
    cast r8 into r11 as u128;
    cast r2.protocol_fee into r12 as u128;
    sub 10000u128 r12 into r13;
    mul r11 r13 into r14;
    add r10 r14 into r15;
    cast r2.protocol_fee into r16 as u128;
    cast r8 into r17 as u128;
    mul r16 r17 into r18;
    cast r3.total_supply into r19 as u128;
    mul r18 r19 into r20;
    div r20 r15 into r21;
    cast r21 into r22 as u64;
    cast r1 into r23 as u128;
    cast r7 into r24 as u128;
    mul r23 r24 into r25;
    cast r3.total_supply into r26 as u128;
    cast r22 into r27 as u128;
    add r26 r27 into r28;
    div r25 r28 into r29;
    cast r29 into r30 as u64;
    branch.eq r6 false to end_then_0_0;
    get.or_use account[h555555_staking.aleo] 0u64 into r31;
    add r31 r22 into r32;
    add r32 r1 into r33;
    set r33 into account[h555555_staking.aleo];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    get.or_use account[r0] 0u64 into r34;
    sub r34 r1 into r35;
    set r35 into account[r0];
    add r3.total_supply r22 into r36;
    add r3.total_unstaking r30 into r37;
    add r3.total_reward r8 into r38;
    cast r36 r37 r7 r38 into r39 as State;
    set r39 into state[true];
    cast 0u64 0u32 into r40 as Unbonding;
    get.or_use unbonding[r0] r40 into r41;
    add r41.microcredits r30 into r42;
    add block.height 360u32 into r43;
    cast r42 r43 into r44 as Unbonding;
    set r44 into unbonding[r0];

function staker_withdraw:
    input r0 as u64.public;
    assert.neq r0 0u64;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async staker_withdraw self.caller r0 r1 into r2;
    output r2 as h555555_staking.aleo/staker_withdraw.future;

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
    call credits.aleo/unbond_public h555555_staking.aleo r0 into r1;
    async unbond_all_public self.caller r0 r1 into r2;
    output r2 as h555555_staking.aleo/unbond_all_public.future;

finalize unbond_all_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/unbond_public.future;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[h555555_staking.aleo] r3 into r4;
    sub r4.microcredits r1 into r5;
    lt r5 10000000000u64 into r6;
    assert.eq r6 true;
    await r2;
    get operators[r0] into r7;
    assert.eq r7 true;
    get settings[true] into r8;
    assert.eq r8.global_paused false;
    get state[true] into r9;
    sub r4.microcredits r9.total_staking into r10;
    cast r9.total_staking into r11 as u128;
    mul r11 10000u128 into r12;
    cast r10 into r13 as u128;
    cast r8.protocol_fee into r14 as u128;
    sub 10000u128 r14 into r15;
    mul r13 r15 into r16;
    add r12 r16 into r17;
    cast r8.protocol_fee into r18 as u128;
    cast r10 into r19 as u128;
    mul r18 r19 into r20;
    cast r9.total_supply into r21 as u128;
    mul r20 r21 into r22;
    div r22 r17 into r23;
    cast r23 into r24 as u64;
    get.or_use account[h555555_staking.aleo] 0u64 into r25;
    set 0u64 into account[h555555_staking.aleo];
    cast r25 into r26 as u128;
    cast r24 into r27 as u128;
    add r26 r27 into r28;
    cast r9.total_supply into r29 as u128;
    cast r24 into r30 as u128;
    add r29 r30 into r31;
    mul r28 r31 into r32;
    cast r9.total_staking into r33 as u128;
    cast r10 into r34 as u128;
    add r33 r34 into r35;
    div r32 r35 into r36;
    cast r36 into r37 as u64;
    sub r9.total_supply r25 into r38;
    sub r9.total_staking r37 into r39;
    add r9.total_reward r10 into r40;
    cast r38 r9.total_unstaking r39 r40 into r41 as State;
    set r41 into state[true];

function claim:
    call credits.aleo/claim_unbond_public h555555_staking.aleo into r0;
    async claim self.caller r0 into r1;
    output r1 as h555555_staking.aleo/claim.future;

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
    output r2 as h555555_staking.aleo/withdraw.future;

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
    get.or_use credits.aleo/account[h555555_staking.aleo] 0u64 into r6;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r7 as bond_state;
    get.or_use credits.aleo/bonded[h555555_staking.aleo] r7 into r8;
    add r6 r8.microcredits into r9;
    add r5.total_staking r5.total_unstaking into r10;
    gte r9 r10 into r11;
    assert.eq r11 true;

function init:
    assert.eq self.caller aleo1jy8a94js2s3apzehh7esashq290hgpw95ngr4tg08nwa8s3gkspsvqr8vn;
    async init into r0;
    output r0 as h555555_staking.aleo/init.future;

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
    output r2 as h555555_staking.aleo/set_operator.future;

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
    output r2 as h555555_staking.aleo/update_settings.future;

finalize update_settings:
    input r0 as address.public;
    input r1 as Settings.public;
    get admins[r0] into r2;
    assert.eq r2 true;
    set r1 into settings[true];
