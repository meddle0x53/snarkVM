import credits.aleo;

program puzzle_staking_v003.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;

struct withdrawal_state:
    microcredits as u64;
    claim_block as u32;

mapping is_initialized:
    key as u8.public;
    value as boolean.public;

mapping commission_percent:
    key as u8.public;
    value as u128.public;

mapping validator:
    key as u8.public;
    value as address.public;

mapping total_balance:
    key as u8.public;
    value as u64.public;

mapping pending_deposits:
    key as u8.public;
    value as u64.public;

mapping total_shares:
    key as u8.public;
    value as u64.public;

mapping delegator_shares:
    key as address.public;
    value as u64.public;

mapping pending_withdrawal:
    key as u8.public;
    value as u64.public;

mapping current_batch_height:
    key as u8.public;
    value as u32.public;

mapping withdrawals:
    key as address.public;
    value as withdrawal_state.public;

function initialize:
    input r0 as u128.public;
    input r1 as address.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    lt r0 1000u128 into r2;
    assert.eq r2 true;
    lte r0 500u128 into r3;
    assert.eq r3 true;
    assert.neq r1 puzzle_staking_v003.aleo;
    async initialize r0 r1 into r4;
    output r4 as puzzle_staking_v003.aleo/initialize.future;

finalize initialize:
    input r0 as u128.public;
    input r1 as address.public;
    get.or_use is_initialized[0u8] false into r2;
    assert.eq r2 false;
    set true into is_initialized[0u8];
    set r0 into commission_percent[0u8];
    set r1 into validator[0u8];
    set 0u64 into total_shares[0u8];
    set 0u64 into total_balance[0u8];
    set 0u64 into pending_withdrawal[0u8];
    set 0u64 into pending_withdrawal[1u8];
    set 0u32 into current_batch_height[0u8];

function initial_deposit:
    input r0 as u64.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    call credits.aleo/transfer_public_as_signer puzzle_staking_v003.aleo r0 into r1;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_v003.aleo r0 into r2;
    async initial_deposit r1 r2 r0 into r3;
    output r3 as puzzle_staking_v003.aleo/initial_deposit.future;

finalize initial_deposit:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as u64.public;
    await r0;
    await r1;
    get is_initialized[0u8] into r3;
    assert.eq r3 true;
    get.or_use total_balance[0u8] 0u64 into r4;
    get.or_use total_shares[0u8] 0u64 into r5;
    assert.eq r4 0u64;
    assert.eq r5 0u64;
    set r2 into total_balance[0u8];
    mul r2 1000u64 into r6;
    set r6 into total_shares[0u8];
    set r6 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];

function deposit_public:
    input r0 as u64.public;
    call credits.aleo/transfer_public_as_signer puzzle_staking_v003.aleo r0 into r1;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_v003.aleo r0 into r2;
    async deposit_public r1 r2 self.caller r0 into r3;
    output r3 as puzzle_staking_v003.aleo/deposit_public.future;

finalize deposit_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as address.public;
    input r3 as u64.public;
    await r0;
    await r1;
    cast puzzle_staking_v003.aleo 0u64 into r4 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v003.aleo] r4 into r5;
    get.or_use total_balance[0u8] 0u64 into r6;
    get.or_use total_shares[0u8] 0u64 into r7;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r8;
    cast r5.microcredits into r9 as i64;
    cast r6 into r10 as i64;
    cast r3 into r11 as i64;
    add r10 r11 into r12;
    sub r9 r12 into r13;
    gt r13 0i64 into r14;
    cast r13 into r15 as u64;
    ternary r14 r15 0u64 into r16;
    get commission_percent[0u8] into r17;
    gt r16 0u64 into r18;
    cast r16 into r19 as u128;
    mul r19 r17 into r20;
    div r20 1000u128 into r21;
    cast r21 into r22 as u64;
    ternary r18 r22 0u64 into r23;
    sub r16 r23 into r24;
    cast r6 into r25 as u128;
    cast r24 into r26 as u128;
    add r25 r26 into r27;
    gt r16 0u64 into r28;
    cast r23 into r29 as u128;
    cast r7 into r30 as u128;
    is.eq r30 0u128 into r31;
    cast 1000u64 into r32 as u128;
    mul r29 r32 into r33;
    cast r33 into r34 as u64;
    mul r29 r30 into r35;
    div r35 r27 into r36;
    cast r36 into r37 as u64;
    ternary r31 r34 r37 into r38;
    ternary r28 r38 0u64 into r39;
    add r8 r39 into r40;
    set r40 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];
    add r7 r39 into r41;
    cast r27 into r42 as u64;
    add r42 r23 into r43;
    cast r43 into r44 as u128;
    cast r3 into r45 as u128;
    cast r41 into r46 as u128;
    is.eq r46 0u128 into r47;
    cast 1000u64 into r48 as u128;
    mul r45 r48 into r49;
    cast r49 into r50 as u64;
    mul r45 r46 into r51;
    div r51 r44 into r52;
    cast r52 into r53 as u64;
    ternary r47 r50 r53 into r54;
    gte r54 1u64 into r55;
    assert.eq r55 true;
    get.or_use delegator_shares[r2] 0u64 into r56;
    add r56 r54 into r57;
    set r57 into delegator_shares[r2];
    add r41 r54 into r58;
    set r58 into total_shares[0u8];
    add r43 r3 into r59;
    set r59 into total_balance[0u8];

function withdraw_public:
    input r0 as u64.public;
    input r1 as u64.public;
    call credits.aleo/unbond_public puzzle_staking_v003.aleo r1 into r2;
    async withdraw_public r2 r0 r1 self.caller into r3;
    output r3 as puzzle_staking_v003.aleo/withdraw_public.future;

finalize withdraw_public:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as address.public;
    await r0;
    get.or_use total_balance[0u8] 0u64 into r4;
    get.or_use total_shares[0u8] 0u64 into r5;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r6;
    cast puzzle_staking_v003.aleo 0u64 into r7 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v003.aleo] r7 into r8;
    cast r8.microcredits into r9 as i64;
    cast r4 into r10 as i64;
    sub r9 r10 into r11;
    gt r11 0i64 into r12;
    cast r11 into r13 as u64;
    ternary r12 r13 0u64 into r14;
    get commission_percent[0u8] into r15;
    gt r14 0u64 into r16;
    cast r14 into r17 as u128;
    mul r17 r15 into r18;
    div r18 1000u128 into r19;
    cast r19 into r20 as u64;
    ternary r16 r20 0u64 into r21;
    sub r14 r21 into r22;
    cast r4 into r23 as u128;
    cast r22 into r24 as u128;
    add r23 r24 into r25;
    gt r14 0u64 into r26;
    cast r21 into r27 as u128;
    cast r5 into r28 as u128;
    is.eq r28 0u128 into r29;
    cast 1000u64 into r30 as u128;
    mul r27 r30 into r31;
    cast r31 into r32 as u64;
    mul r27 r28 into r33;
    div r33 r25 into r34;
    cast r34 into r35 as u64;
    ternary r29 r32 r35 into r36;
    ternary r26 r36 0u64 into r37;
    add r6 r37 into r38;
    set r38 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];
    add r5 r37 into r39;
    cast r25 into r40 as u64;
    add r40 r21 into r41;
    get.or_use delegator_shares[r3] 0u64 into r42;
    gte r42 r1 into r43;
    assert.eq r43 true;
    cast r1 into r44 as u128;
    cast r41 into r45 as u128;
    mul r44 r45 into r46;
    cast r39 into r47 as u128;
    div r46 r47 into r48;
    cast r48 into r49 as u64;
    sub r42 r1 into r50;
    set r50 into delegator_shares[r3];
    sub r39 r1 into r51;
    sub r41 r49 into r52;
    set r51 into total_shares[0u8];
    set r52 into total_balance[0u8];
    add block.height 360u32 into r53;
    cast r49 r53 into r54 as withdrawal_state;
    set r54 into withdrawals[r3];

function claim_withdrawal_public:
    input r0 as u64.public;
    call credits.aleo/claim_unbond_public puzzle_staking_v003.aleo into r1;
    call credits.aleo/transfer_public self.caller r0 into r2;
    async claim_withdrawal_public r1 r2 self.caller r0 into r3;
    output r3 as puzzle_staking_v003.aleo/claim_withdrawal_public.future;

finalize claim_withdrawal_public:
    input r0 as credits.aleo/claim_unbond_public.future;
    input r1 as credits.aleo/transfer_public.future;
    input r2 as address.public;
    input r3 as u64.public;
    await r0;
    await r1;
    get withdrawals[r2] into r4;
    gte block.height r4.claim_block into r5;
    assert.eq r5 true;
    assert.eq r4.microcredits r3;
    remove withdrawals[r2];

function get_commission_test:
    input r0 as u128.private;
    input r1 as u128.private;
    mul r0 r1 into r2;
    div r2 1000u128 into r3;
    cast r3 into r4 as u64;
    output r4 as u64.private;

function calculate_new_shares_test:
    input r0 as u128.private;
    input r1 as u128.private;
    input r2 as u128.private;
    input r3 as u128.private;
    add r0 r1 into r4;
    add r4 r2 into r5;
    mul r3 r5 into r6;
    div r6 r4 into r7;
    sub r7 r3 into r8;
    cast r8 into r9 as u64;
    output r9 as u64.private;

function set_commission_percent:
    input r0 as u128.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    lt r0 1000u128 into r1;
    assert.eq r1 true;
    lte r0 500u128 into r2;
    assert.eq r2 true;
    async set_commission_percent r0 into r3;
    output r3 as puzzle_staking_v003.aleo/set_commission_percent.future;

finalize set_commission_percent:
    input r0 as u128.public;
    get.or_use total_balance[0u8] 0u64 into r1;
    get.or_use total_shares[0u8] 0u64 into r2;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r3;
    cast puzzle_staking_v003.aleo 0u64 into r4 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v003.aleo] r4 into r5;
    cast r5.microcredits into r6 as i64;
    cast r1 into r7 as i64;
    sub r6 r7 into r8;
    gt r8 0i64 into r9;
    cast r8 into r10 as u64;
    ternary r9 r10 0u64 into r11;
    get commission_percent[0u8] into r12;
    cast r11 into r13 as u128;
    mul r13 r12 into r14;
    div r14 1000u128 into r15;
    cast r15 into r16 as u64;
    sub r11 r16 into r17;
    cast r1 into r18 as u128;
    cast r17 into r19 as u128;
    add r18 r19 into r20;
    cast r16 into r21 as u128;
    cast r2 into r22 as u128;
    is.eq r22 0u128 into r23;
    cast 1000u64 into r24 as u128;
    mul r21 r24 into r25;
    cast r25 into r26 as u64;
    mul r21 r22 into r27;
    div r27 r20 into r28;
    cast r28 into r29 as u64;
    ternary r23 r26 r29 into r30;
    add r3 r30 into r31;
    set r31 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];
    add r2 r30 into r32;
    set r32 into total_shares[0u8];
    cast r20 into r33 as u64;
    add r33 r16 into r34;
    set r34 into total_balance[0u8];
    set r0 into commission_percent[0u8];

function set_next_validator:
    input r0 as address.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    assert.neq r0 puzzle_staking_v003.aleo;
    async set_next_validator r0 into r1;
    output r1 as puzzle_staking_v003.aleo/set_next_validator.future;

finalize set_next_validator:
    input r0 as address.public;
    set r0 into validator[1u8];

function claim_commission:
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    async claim_commission into r0;
    output r0 as puzzle_staking_v003.aleo/claim_commission.future;

finalize claim_commission:
    get.or_use total_balance[0u8] 0u64 into r0;
    get.or_use total_shares[0u8] 0u64 into r1;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r2;
    cast puzzle_staking_v003.aleo 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v003.aleo] r3 into r4;
    cast r4.microcredits into r5 as i64;
    cast r0 into r6 as i64;
    sub r5 r6 into r7;
    gt r7 0i64 into r8;
    cast r7 into r9 as u64;
    ternary r8 r9 0u64 into r10;
    get commission_percent[0u8] into r11;
    cast r10 into r12 as u128;
    mul r12 r11 into r13;
    div r13 1000u128 into r14;
    cast r14 into r15 as u64;
    sub r10 r15 into r16;
    cast r0 into r17 as u128;
    cast r16 into r18 as u128;
    add r17 r18 into r19;
    cast r15 into r20 as u128;
    cast r1 into r21 as u128;
    is.eq r21 0u128 into r22;
    cast 1000u64 into r23 as u128;
    mul r20 r23 into r24;
    cast r24 into r25 as u64;
    mul r20 r21 into r26;
    div r26 r19 into r27;
    cast r27 into r28 as u64;
    ternary r22 r25 r28 into r29;
    add r2 r29 into r30;
    set r30 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];
    add r1 r29 into r31;
    set r31 into total_shares[0u8];
    cast r19 into r32 as u64;
    add r32 r15 into r33;
    set r33 into total_balance[0u8];

function get_new_batch_height_test:
    input r0 as u32.private;
    add r0 1000u32 into r1;
    output r1 as u32.private;

function create_withdraw_claim:
    input r0 as u64.public;
    async create_withdraw_claim r0 self.caller into r1;
    output r1 as puzzle_staking_v003.aleo/create_withdraw_claim.future;

finalize create_withdraw_claim:
    input r0 as u64.public;
    input r1 as address.public;
    contains withdrawals[r1] into r2;
    assert.eq r2 false;
    get.or_use total_balance[0u8] 0u64 into r3;
    get.or_use total_shares[0u8] 0u64 into r4;
    get.or_use delegator_shares[r1] 0u64 into r5;
    gte r5 r0 into r6;
    assert.eq r6 true;
    cast puzzle_staking_v003.aleo 0u64 into r7 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v003.aleo] r7 into r8;
    cast r8.microcredits into r9 as i64;
    cast r3 into r10 as i64;
    sub r9 r10 into r11;
    gt r11 0i64 into r12;
    cast r11 into r13 as u64;
    ternary r12 r13 0u64 into r14;
    get commission_percent[0u8] into r15;
    cast r14 into r16 as u128;
    mul r16 r15 into r17;
    div r17 1000u128 into r18;
    cast r18 into r19 as u64;
    sub r14 r19 into r20;
    cast r3 into r21 as u128;
    cast r20 into r22 as u128;
    add r21 r22 into r23;
    gt r14 0u64 into r24;
    cast r19 into r25 as u128;
    cast r4 into r26 as u128;
    is.eq r26 0u128 into r27;
    cast 1000u64 into r28 as u128;
    mul r25 r28 into r29;
    cast r29 into r30 as u64;
    mul r25 r26 into r31;
    div r31 r23 into r32;
    cast r32 into r33 as u64;
    ternary r27 r30 r33 into r34;
    ternary r24 r34 0u64 into r35;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r36;
    add r36 r35 into r37;
    set r37 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];
    add r4 r35 into r38;
    cast r23 into r39 as u64;
    add r39 r19 into r40;
    cast r0 into r41 as u128;
    cast r40 into r42 as u128;
    mul r41 r42 into r43;
    cast r38 into r44 as u128;
    div r43 r44 into r45;
    cast r45 into r46 as u64;
    sub r5 r0 into r47;
    set r47 into delegator_shares[r1];
    sub r38 r0 into r48;
    set r48 into total_shares[0u8];
    sub r40 r46 into r49;
    set r49 into total_balance[0u8];
    add block.height 360u32 into r50;
    cast r46 r50 into r51 as withdrawal_state;
    set r51 into withdrawals[r1];
    get.or_use pending_withdrawal[1u8] 0u64 into r52;
    add r52 r46 into r53;
    set r53 into pending_withdrawal[1u8];
