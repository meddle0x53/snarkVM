import credits.aleo;

program aleo_multisig.aleo;

struct Wallet:
    wallet_address as address;
    owners as [address; 16u32];
    threshold as u8;

struct Transfer:
    wallet_address as address;
    to as address;
    amount as u64;
    confirmations as u8;

record Signer:
    owner as address.private;
    wallet_address as address.private;
    transfer_id as field.private;

mapping wallets:
    key as address.public;
    value as Wallet.public;

mapping balances:
    key as address.public;
    value as u64.public;

mapping transfers:
    key as field.public;
    value as Transfer.public;

function create_wallet:
    input r0 as [address; 16u32].private;
    input r1 as u8.private;
    async create_wallet r0 r1 into r2;
    output r2 as aleo_multisig.aleo/create_wallet.future;

finalize create_wallet:
    input r0 as [address; 16u32].public;
    input r1 as u8.public;
    rand.chacha into r2 as address;
    cast r2 r0 r1 into r3 as Wallet;
    set r3 into wallets[r2];
    set 0u64 into balances[r2];

function deposit:
    input r0 as address.private;
    input r1 as u64.private;
    call credits.aleo/transfer_public_as_signer aleo_multisig.aleo r1 into r2;
    async deposit r0 r1 r2 into r3;
    output r3 as aleo_multisig.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    contains balances[r0] into r3;
    assert.eq r3 true;
    get balances[r0] into r4;
    add r4 r1 into r5;
    set r5 into balances[r0];
    await r2;

function create_transfer:
    input r0 as Wallet.private;
    input r1 as address.private;
    input r2 as u64.private;
    input r3 as field.private;
    cast r0.owners[0u32] r0.wallet_address r3 into r4 as Signer.record;
    cast r0.owners[1u32] r0.wallet_address r3 into r5 as Signer.record;
    cast r0.owners[2u32] r0.wallet_address r3 into r6 as Signer.record;
    cast r0.owners[3u32] r0.wallet_address r3 into r7 as Signer.record;
    cast r0.owners[4u32] r0.wallet_address r3 into r8 as Signer.record;
    cast r0.owners[5u32] r0.wallet_address r3 into r9 as Signer.record;
    cast r0.owners[6u32] r0.wallet_address r3 into r10 as Signer.record;
    cast r0.owners[7u32] r0.wallet_address r3 into r11 as Signer.record;
    cast r0.owners[8u32] r0.wallet_address r3 into r12 as Signer.record;
    cast r0.owners[9u32] r0.wallet_address r3 into r13 as Signer.record;
    cast r0.owners[10u32] r0.wallet_address r3 into r14 as Signer.record;
    cast r0.owners[11u32] r0.wallet_address r3 into r15 as Signer.record;
    cast r0.owners[12u32] r0.wallet_address r3 into r16 as Signer.record;
    cast r0.owners[13u32] r0.wallet_address r3 into r17 as Signer.record;
    async create_transfer r0 r1 r2 r3 self.signer into r18;
    output r4 as Signer.record;
    output r5 as Signer.record;
    output r6 as Signer.record;
    output r7 as Signer.record;
    output r8 as Signer.record;
    output r9 as Signer.record;
    output r10 as Signer.record;
    output r11 as Signer.record;
    output r12 as Signer.record;
    output r13 as Signer.record;
    output r14 as Signer.record;
    output r15 as Signer.record;
    output r16 as Signer.record;
    output r17 as Signer.record;
    output r18 as aleo_multisig.aleo/create_transfer.future;

finalize create_transfer:
    input r0 as Wallet.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as address.public;
    contains transfers[r3] into r5;
    assert.eq r5 false;
    get wallets[r0.wallet_address] into r6;
    assert.eq r0 r6;
    is.eq r0.owners[0u32] r4 into r7;
    is.eq r0.owners[1u32] r4 into r8;
    is.eq r0.owners[2u32] r4 into r9;
    is.eq r0.owners[3u32] r4 into r10;
    is.eq r0.owners[4u32] r4 into r11;
    is.eq r0.owners[5u32] r4 into r12;
    is.eq r0.owners[6u32] r4 into r13;
    is.eq r0.owners[7u32] r4 into r14;
    is.eq r0.owners[8u32] r4 into r15;
    is.eq r0.owners[9u32] r4 into r16;
    is.eq r0.owners[10u32] r4 into r17;
    is.eq r0.owners[11u32] r4 into r18;
    is.eq r0.owners[12u32] r4 into r19;
    is.eq r0.owners[13u32] r4 into r20;
    ternary r20 true false into r21;
    ternary r19 true r21 into r22;
    ternary r18 true r22 into r23;
    ternary r17 true r23 into r24;
    ternary r16 true r24 into r25;
    ternary r15 true r25 into r26;
    ternary r14 true r26 into r27;
    ternary r13 true r27 into r28;
    ternary r12 true r28 into r29;
    ternary r11 true r29 into r30;
    ternary r10 true r30 into r31;
    ternary r9 true r31 into r32;
    ternary r8 true r32 into r33;
    ternary r7 true r33 into r34;
    assert.eq r34 true;
    cast r0.wallet_address r1 r2 1u8 into r35 as Transfer;
    set r35 into transfers[r3];

function confirm_transfer:
    input r0 as Signer.record;
    assert.eq r0.owner self.signer;
    async confirm_transfer r0.transfer_id r0.owner into r1;
    output r1 as aleo_multisig.aleo/confirm_transfer.future;

finalize confirm_transfer:
    input r0 as field.public;
    input r1 as address.public;
    contains transfers[r0] into r2;
    assert.eq r2 true;
    get transfers[r0] into r3;
    add r3.confirmations 1u8 into r4;
    cast r3.wallet_address r3.to r3.amount r4 into r5 as Transfer;
    set r5 into transfers[r0];

function execute_transfer:
    input r0 as Transfer.private;
    input r1 as field.private;
    call credits.aleo/transfer_public r0.to r0.amount into r2;
    async execute_transfer r0 r1 r2 self.signer into r3;
    output r3 as aleo_multisig.aleo/execute_transfer.future;

finalize execute_transfer:
    input r0 as Transfer.public;
    input r1 as field.public;
    input r2 as credits.aleo/transfer_public.future;
    input r3 as address.public;
    contains transfers[r1] into r4;
    assert.eq r4 true;
    get transfers[r1] into r5;
    assert.eq r0.wallet_address r5.wallet_address;
    assert.eq r0.to r5.to;
    assert.eq r0.amount r5.amount;
    get wallets[r5.wallet_address] into r6;
    is.eq r6.owners[0u32] r3 into r7;
    is.eq r6.owners[1u32] r3 into r8;
    is.eq r6.owners[2u32] r3 into r9;
    is.eq r6.owners[3u32] r3 into r10;
    is.eq r6.owners[4u32] r3 into r11;
    is.eq r6.owners[5u32] r3 into r12;
    is.eq r6.owners[6u32] r3 into r13;
    is.eq r6.owners[7u32] r3 into r14;
    is.eq r6.owners[8u32] r3 into r15;
    is.eq r6.owners[9u32] r3 into r16;
    is.eq r6.owners[10u32] r3 into r17;
    is.eq r6.owners[11u32] r3 into r18;
    is.eq r6.owners[12u32] r3 into r19;
    is.eq r6.owners[13u32] r3 into r20;
    ternary r20 true false into r21;
    ternary r19 true r21 into r22;
    ternary r18 true r22 into r23;
    ternary r17 true r23 into r24;
    ternary r16 true r24 into r25;
    ternary r15 true r25 into r26;
    ternary r14 true r26 into r27;
    ternary r13 true r27 into r28;
    ternary r12 true r28 into r29;
    ternary r11 true r29 into r30;
    ternary r10 true r30 into r31;
    ternary r9 true r31 into r32;
    ternary r8 true r32 into r33;
    ternary r7 true r33 into r34;
    assert.eq r34 true;
    gte r5.confirmations r6.threshold into r35;
    assert.eq r35 true;
    get balances[r5.wallet_address] into r36;
    gte r36 r5.amount into r37;
    assert.eq r37 true;
    sub r36 r5.amount into r38;
    set r38 into balances[r5.wallet_address];
    remove transfers[r1];
    await r2;
