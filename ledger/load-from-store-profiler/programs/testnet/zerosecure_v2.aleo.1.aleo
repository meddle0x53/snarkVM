import credits.aleo;

program zerosecure_v2.aleo;

record Wallet:
    owner as address.private;
    wallet_address as address.private;
    owners as [address; 8u32].private;
    threshold as u8.private;

record ConfirmTransferTicket:
    owner as address.private;
    wallet_address as address.private;
    to as address.private;
    amount as u64.private;
    transfer_id as field.private;
    threshold as u8.private;

record ExecuteTransferTicket:
    owner as address.private;
    wallet_address as address.private;
    to as address.private;
    amount as u64.private;
    transfer_id as field.private;
    threshold as u8.private;

struct TransferStatus:
    confirmations as u8;

mapping balances:
    key as field.public;
    value as u64.public;

mapping transfers_status:
    key as field.public;
    value as TransferStatus.public;

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
    cast r1[0u32] r0 r1 r2 into r30 as Wallet.record;
    cast r1[1u32] r0 r1 r2 into r31 as Wallet.record;
    cast r1[2u32] r0 r1 r2 into r32 as Wallet.record;
    cast r1[3u32] r0 r1 r2 into r33 as Wallet.record;
    cast r1[4u32] r0 r1 r2 into r34 as Wallet.record;
    cast r1[5u32] r0 r1 r2 into r35 as Wallet.record;
    cast r1[6u32] r0 r1 r2 into r36 as Wallet.record;
    cast r1[7u32] r0 r1 r2 into r37 as Wallet.record;
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
    output r39 as zerosecure_v2.aleo/create_wallet.future;

finalize create_wallet:
    input r0 as field.public;
    contains balances[r0] into r1;
    assert.eq r1 false;
    set 0u64 into balances[r0];

function deposit_public:
    input r0 as address.private;
    input r1 as u64.private;
    hash.bhp256 r0 into r2 as field;
    call credits.aleo/transfer_public_as_signer zerosecure_v2.aleo r1 into r3;
    async deposit_public r2 r1 r3 into r4;
    output r4 as zerosecure_v2.aleo/deposit_public.future;

finalize deposit_public:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    get balances[r0] into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];
    await r2;

function deposit_private:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as credits.aleo/credits.record;
    hash.bhp256 r0 into r3 as field;
    call credits.aleo/transfer_private_to_public r2 zerosecure_v2.aleo r1 into r4 r5;
    async deposit_private r3 r1 r5 into r6;
    output r4 as credits.aleo/credits.record;
    output r6 as zerosecure_v2.aleo/deposit_private.future;

finalize deposit_private:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_private_to_public.future;
    get balances[r0] into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];
    await r2;

function create_transfer:
    input r0 as Wallet.record;
    input r1 as address.private;
    input r2 as u64.private;
    input r3 as field.private;
    is.eq r0.owner r0.owners[0u32] into r4;
    ternary r4 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[0u32] into r5;
    cast r5 r0.wallet_address r1 r2 r3 r0.threshold into r6 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[1u32] into r7;
    ternary r7 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[1u32] into r8;
    cast r8 r0.wallet_address r1 r2 r3 r0.threshold into r9 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[2u32] into r10;
    ternary r10 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[2u32] into r11;
    cast r11 r0.wallet_address r1 r2 r3 r0.threshold into r12 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[3u32] into r13;
    ternary r13 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[3u32] into r14;
    cast r14 r0.wallet_address r1 r2 r3 r0.threshold into r15 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[4u32] into r16;
    ternary r16 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[4u32] into r17;
    cast r17 r0.wallet_address r1 r2 r3 r0.threshold into r18 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[5u32] into r19;
    ternary r19 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[5u32] into r20;
    cast r20 r0.wallet_address r1 r2 r3 r0.threshold into r21 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[6u32] into r22;
    ternary r22 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[6u32] into r23;
    cast r23 r0.wallet_address r1 r2 r3 r0.threshold into r24 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[7u32] into r25;
    ternary r25 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[7u32] into r26;
    cast r26 r0.wallet_address r1 r2 r3 r0.threshold into r27 as ConfirmTransferTicket.record;
    cast r0.owner r0.wallet_address r1 r2 r3 r0.threshold into r28 as ExecuteTransferTicket.record;
    hash.bhp256 r0.wallet_address into r29 as field;
    cast r0.owner r0.wallet_address r0.owners r0.threshold into r30 as Wallet.record;
    async create_transfer r29 r3 r2 into r31;
    output r30 as Wallet.record;
    output r28 as ExecuteTransferTicket.record;
    output r6 as ConfirmTransferTicket.record;
    output r9 as ConfirmTransferTicket.record;
    output r12 as ConfirmTransferTicket.record;
    output r15 as ConfirmTransferTicket.record;
    output r18 as ConfirmTransferTicket.record;
    output r21 as ConfirmTransferTicket.record;
    output r24 as ConfirmTransferTicket.record;
    output r27 as ConfirmTransferTicket.record;
    output r31 as zerosecure_v2.aleo/create_transfer.future;

finalize create_transfer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    get balances[r0] into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    contains transfers_status[r1] into r5;
    assert.eq r5 false;
    cast 1u8 into r6 as TransferStatus;
    set r6 into transfers_status[r1];

function confirm_transfer:
    input r0 as ConfirmTransferTicket.record;
    cast r0.owner r0.wallet_address r0.to r0.amount r0.transfer_id r0.threshold into r1 as ExecuteTransferTicket.record;
    async confirm_transfer r0.transfer_id into r2;
    output r1 as ExecuteTransferTicket.record;
    output r2 as zerosecure_v2.aleo/confirm_transfer.future;

finalize confirm_transfer:
    input r0 as field.public;
    get transfers_status[r0] into r1;
    add r1.confirmations 1u8 into r2;
    cast r2 into r3 as TransferStatus;
    set r3 into transfers_status[r0];

function execute_transfer:
    input r0 as ExecuteTransferTicket.record;
    hash.bhp256 r0.wallet_address into r1 as field;
    call credits.aleo/transfer_public_to_private r0.to r0.amount into r2 r3;
    async execute_transfer r1 r0.transfer_id r0.threshold r0.amount r3 into r4;
    output r2 as credits.aleo/credits.record;
    output r4 as zerosecure_v2.aleo/execute_transfer.future;

finalize execute_transfer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    input r3 as u64.public;
    input r4 as credits.aleo/transfer_public_to_private.future;
    get transfers_status[r1] into r5;
    gte r5.confirmations r2 into r6;
    assert.eq r6 true;
    get balances[r0] into r7;
    gte r7 r3 into r8;
    assert.eq r8 true;
    sub r7 r3 into r9;
    set r9 into balances[r0];
    remove transfers_status[r1];
    await r4;
