program zerosecure_wallet_manager.aleo;

record Wallet:
    owner as address.private;
    wallet_address as address.private;
    owners as [address; 8u32].private;
    threshold as u8.private;
    sequence as u64.private;

mapping wallet_sequence:
    key as field.public;
    value as u64.public;

mapping wallet_exists:
    key as field.public;
    value as boolean.public;

function create_wallet:
    input r0 as address.private;
    input r1 as [address; 8u32].private;
    input r2 as u8.private;
    is.neq r1[0u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r3;
    ternary r3 1u8 0u8 into r4;
    add 0u8 r4 into r5;
    is.neq r1[1u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r6;
    ternary r6 1u8 0u8 into r7;
    add r5 r7 into r8;
    is.neq r1[2u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r9;
    ternary r9 1u8 0u8 into r10;
    add r8 r10 into r11;
    is.neq r1[3u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r12;
    ternary r12 1u8 0u8 into r13;
    add r11 r13 into r14;
    is.neq r1[4u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r15;
    ternary r15 1u8 0u8 into r16;
    add r14 r16 into r17;
    is.neq r1[5u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r18;
    ternary r18 1u8 0u8 into r19;
    add r17 r19 into r20;
    is.neq r1[6u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r21;
    ternary r21 1u8 0u8 into r22;
    add r20 r22 into r23;
    is.neq r1[7u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r24;
    ternary r24 1u8 0u8 into r25;
    add r23 r25 into r26;
    lte r2 r26 into r27;
    gte r2 1u8 into r28;
    and r27 r28 into r29;
    assert.eq r29 true;
    cast r1[0u32] r0 r1 r2 0u64 into r30 as Wallet.record;
    cast r1[1u32] r0 r1 r2 0u64 into r31 as Wallet.record;
    cast r1[2u32] r0 r1 r2 0u64 into r32 as Wallet.record;
    cast r1[3u32] r0 r1 r2 0u64 into r33 as Wallet.record;
    cast r1[4u32] r0 r1 r2 0u64 into r34 as Wallet.record;
    cast r1[5u32] r0 r1 r2 0u64 into r35 as Wallet.record;
    cast r1[6u32] r0 r1 r2 0u64 into r36 as Wallet.record;
    cast r1[7u32] r0 r1 r2 0u64 into r37 as Wallet.record;
    hash.bhp256 r0 into r38 as field;
    async create_wallet r38 into r39;
    output r30 as Wallet.record;
    output r31 as Wallet.record;
    output r32 as Wallet.record;
    output r33 as Wallet.record;
    output r34 as Wallet.record;
    output r35 as Wallet.record;
    output r36 as Wallet.record;
    output r37 as Wallet.record;
    output r39 as zerosecure_wallet_manager.aleo/create_wallet.future;

finalize create_wallet:
    input r0 as field.public;
    contains wallet_exists[r0] into r1;
    assert.eq r1 false;
    set 0u64 into wallet_sequence[r0];
    set true into wallet_exists[r0];

function create_new_wallet:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as [address; 8u32].private;
    input r3 as u8.private;
    input r4 as u64.private;
    cast r0 r1 r2 r3 r4 into r5 as Wallet.record;
    output r5 as Wallet.record;
