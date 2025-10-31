import credits.aleo;

program aleo_multisig_v4.aleo;

record Wallet:
    owner as address.private;
    wallet_address as address.private;
    owners as [address; 8u32].private;
    threshold as u8.private;

record TransferSigner:
    owner as address.private;
    wallet_address as address.private;
    transfer_id as field.private;

struct Transfer:
    to as address;
    amount as u64;
    confirmations as u8;

mapping balances:
    key as field.public;
    value as u64.public;

mapping transfers:
    key as field.public;
    value as Transfer.public;

function create_wallet:
    input r0 as address.private;
    input r1 as [address; 8u32].private;
    input r2 as u8.private;
    lte r2 8u8 into r3;
    gte r2 1u8 into r4;
    and r3 r4 into r5;
    assert.eq r5 true;
    cast r1[0u32] r0 r1 r2 into r6 as Wallet.record;
    cast r1[1u32] r0 r1 r2 into r7 as Wallet.record;
    cast r1[2u32] r0 r1 r2 into r8 as Wallet.record;
    cast r1[3u32] r0 r1 r2 into r9 as Wallet.record;
    cast r1[4u32] r0 r1 r2 into r10 as Wallet.record;
    cast r1[5u32] r0 r1 r2 into r11 as Wallet.record;
    cast r1[6u32] r0 r1 r2 into r12 as Wallet.record;
    cast r1[7u32] r0 r1 r2 into r13 as Wallet.record;
    hash.bhp256 r0 into r14 as field;
    async create_wallet r14 into r15;
    output r6 as Wallet.record;
    output r7 as Wallet.record;
    output r8 as Wallet.record;
    output r9 as Wallet.record;
    output r10 as Wallet.record;
    output r11 as Wallet.record;
    output r12 as Wallet.record;
    output r13 as Wallet.record;
    output r15 as aleo_multisig_v4.aleo/create_wallet.future;

finalize create_wallet:
    input r0 as field.public;
    contains balances[r0] into r1;
    assert.eq r1 false;
    set 0u64 into balances[r0];

function deposit_public:
    input r0 as address.private;
    input r1 as u64.private;
    hash.bhp256 r0 into r2 as field;
    call credits.aleo/transfer_public_as_signer aleo_multisig_v4.aleo r1 into r3;
    async deposit_public r2 r1 r3 into r4;
    output r4 as aleo_multisig_v4.aleo/deposit_public.future;

finalize deposit_public:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    contains balances[r0] into r3;
    assert.eq r3 true;
    get balances[r0] into r4;
    add r4 r1 into r5;
    set r5 into balances[r0];
    await r2;

function deposit_private:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as credits.aleo/credits.record;
    hash.bhp256 r0 into r3 as field;
    call credits.aleo/transfer_private_to_public r2 aleo_multisig_v4.aleo r1 into r4 r5;
    async deposit_private r3 r1 r5 into r6;
    output r4 as credits.aleo/credits.record;
    output r6 as aleo_multisig_v4.aleo/deposit_private.future;

finalize deposit_private:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_private_to_public.future;
    contains balances[r0] into r3;
    assert.eq r3 true;
    get balances[r0] into r4;
    add r4 r1 into r5;
    set r5 into balances[r0];
    await r2;

function create_transfer:
    input r0 as Wallet.record;
    input r1 as address.private;
    input r2 as u64.private;
    input r3 as field.private;
    cast r0.owners[0u32] r0.wallet_address r3 into r4 as TransferSigner.record;
    cast r0.owners[1u32] r0.wallet_address r3 into r5 as TransferSigner.record;
    cast r0.owners[2u32] r0.wallet_address r3 into r6 as TransferSigner.record;
    cast r0.owners[3u32] r0.wallet_address r3 into r7 as TransferSigner.record;
    cast r0.owners[4u32] r0.wallet_address r3 into r8 as TransferSigner.record;
    cast r0.owners[5u32] r0.wallet_address r3 into r9 as TransferSigner.record;
    cast r0.owners[6u32] r0.wallet_address r3 into r10 as TransferSigner.record;
    cast r0.owners[7u32] r0.wallet_address r3 into r11 as TransferSigner.record;
    hash.bhp256 r3 into r12 as field;
    hash.bhp256 r0.wallet_address into r13 as field;
    add r13 r12 into r14;
    hash.bhp256 r14 into r15 as field;
    hash.bhp256 r1 into r16 as field;
    add r16 r12 into r17;
    hash.bhp256 r17 into r18 as address;
    cast r0.owner r0.wallet_address r0.owners r0.threshold into r19 as Wallet.record;
    async create_transfer r13 r15 r18 r2 into r20;
    output r19 as Wallet.record;
    output r4 as TransferSigner.record;
    output r5 as TransferSigner.record;
    output r6 as TransferSigner.record;
    output r7 as TransferSigner.record;
    output r8 as TransferSigner.record;
    output r9 as TransferSigner.record;
    output r10 as TransferSigner.record;
    output r11 as TransferSigner.record;
    output r20 as aleo_multisig_v4.aleo/create_transfer.future;

finalize create_transfer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as u64.public;
    get balances[r0] into r4;
    gte r4 r3 into r5;
    assert.eq r5 true;
    contains transfers[r1] into r6;
    assert.eq r6 false;
    cast r2 r3 0u8 into r7 as Transfer;
    set r7 into transfers[r1];

function confirm_transfer:
    input r0 as TransferSigner.record;
    hash.bhp256 r0.wallet_address into r1 as field;
    hash.bhp256 r0.transfer_id into r2 as field;
    add r1 r2 into r3;
    hash.bhp256 r3 into r4 as field;
    async confirm_transfer r4 into r5;
    output r5 as aleo_multisig_v4.aleo/confirm_transfer.future;

finalize confirm_transfer:
    input r0 as field.public;
    get transfers[r0] into r1;
    add r1.confirmations 1u8 into r2;
    cast r1.to r1.amount r2 into r3 as Transfer;
    set r3 into transfers[r0];

function execute_transfer:
    input r0 as Wallet.record;
    input r1 as Transfer.private;
    input r2 as address.private;
    input r3 as field.private;
    gte r1.confirmations r0.threshold into r4;
    assert.eq r4 true;
    hash.bhp256 r0.wallet_address into r5 as field;
    hash.bhp256 r3 into r6 as field;
    add r5 r6 into r7;
    hash.bhp256 r7 into r8 as field;
    call credits.aleo/transfer_public_to_private r2 r1.amount into r9 r10;
    cast r0.owner r0.wallet_address r0.owners r0.threshold into r11 as Wallet.record;
    async execute_transfer r5 r8 r1 r10 into r12;
    output r9 as credits.aleo/credits.record;
    output r11 as Wallet.record;
    output r12 as aleo_multisig_v4.aleo/execute_transfer.future;

finalize execute_transfer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as Transfer.public;
    input r3 as credits.aleo/transfer_public_to_private.future;
    get transfers[r1] into r4;
    assert.eq r2 r4;
    get balances[r0] into r5;
    gte r5 r2.amount into r6;
    assert.eq r6 true;
    sub r5 r2.amount into r7;
    set r7 into balances[r0];
    remove transfers[r1];
    await r3;
