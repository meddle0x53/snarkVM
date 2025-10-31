import credits.aleo;
import token_registry.aleo;
import zero_wallet_manager_v7.aleo;

program zero_transfer_manager_v7.aleo;

record ConfirmTransferTicket:
    owner as address.private;
    wallet_address as address.private;
    token_id as field.private;
    to as address.private;
    amount as u128.private;
    transfer_id as field.private;
    threshold as u8.private;

record ExecuteTransferTicket:
    owner as address.private;
    wallet_address as address.private;
    token_id as field.private;
    to as address.private;
    amount as u128.private;
    transfer_id as field.private;
    threshold as u8.private;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct TransferStatus:
    confirmations as u8;

struct BalanceKey:
    wallet_address as address;
    token_id as field;

mapping transfers_status:
    key as field.public;
    value as TransferStatus.public;

mapping balances:
    key as field.public;
    value as u128.public;

function deposit_token_public:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    cast r0 r1 into r3 as BalanceKey;
    hash.bhp256 r3 into r4 as field;
    call token_registry.aleo/transfer_public_as_signer r1 zero_transfer_manager_v7.aleo r2 into r5;
    async deposit_token_public r4 r2 r5 into r6;
    output r6 as zero_transfer_manager_v7.aleo/deposit_token_public.future;

finalize deposit_token_public:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as token_registry.aleo/transfer_public_as_signer.future;
    get.or_use balances[r0] 0u128 into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];
    await r2;

function deposit_token_private:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as token_registry.aleo/Token.record;
    cast r0 r2.token_id into r3 as BalanceKey;
    hash.bhp256 r3 into r4 as field;
    call token_registry.aleo/transfer_private_to_public zero_transfer_manager_v7.aleo r1 r2 into r5 r6;
    async deposit_token_private r4 r1 r6 into r7;
    output r5 as token_registry.aleo/Token.record;
    output r7 as zero_transfer_manager_v7.aleo/deposit_token_private.future;

finalize deposit_token_private:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as token_registry.aleo/transfer_private_to_public.future;
    get.or_use balances[r0] 0u128 into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];
    await r2;

function deposit_aleo_public:
    input r0 as address.private;
    input r1 as u128.private;
    cast r0 3443843282313283355522573239085696902919850365217539366784739393210722344986field into r2 as BalanceKey;
    hash.bhp256 r2 into r3 as field;
    cast r1 into r4 as u64;
    call credits.aleo/transfer_public_as_signer zero_transfer_manager_v7.aleo r4 into r5;
    async deposit_aleo_public r3 r1 r5 into r6;
    output r6 as zero_transfer_manager_v7.aleo/deposit_aleo_public.future;

finalize deposit_aleo_public:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    get.or_use balances[r0] 0u128 into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];
    await r2;

function deposit_aleo_private:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as credits.aleo/credits.record;
    cast r0 3443843282313283355522573239085696902919850365217539366784739393210722344986field into r3 as BalanceKey;
    hash.bhp256 r3 into r4 as field;
    cast r1 into r5 as u64;
    call credits.aleo/transfer_private_to_public r2 zero_transfer_manager_v7.aleo r5 into r6 r7;
    async deposit_aleo_private r4 r1 r7 into r8;
    output r6 as credits.aleo/credits.record;
    output r8 as zero_transfer_manager_v7.aleo/deposit_aleo_private.future;

finalize deposit_aleo_private:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_private_to_public.future;
    get.or_use balances[r0] 0u128 into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];
    await r2;

function create_transfer:
    input r0 as zero_wallet_manager_v7.aleo/Wallet.record;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as u128.private;
    input r4 as field.private;
    is.eq r0.owner r0.owners[0u32] into r5;
    ternary r5 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[0u32] into r6;
    cast r6 r0.wallet_address r1 r2 r3 r4 r0.threshold into r7 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[1u32] into r8;
    ternary r8 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[1u32] into r9;
    cast r9 r0.wallet_address r1 r2 r3 r4 r0.threshold into r10 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[2u32] into r11;
    ternary r11 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[2u32] into r12;
    cast r12 r0.wallet_address r1 r2 r3 r4 r0.threshold into r13 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[3u32] into r14;
    ternary r14 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[3u32] into r15;
    cast r15 r0.wallet_address r1 r2 r3 r4 r0.threshold into r16 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[4u32] into r17;
    ternary r17 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[4u32] into r18;
    cast r18 r0.wallet_address r1 r2 r3 r4 r0.threshold into r19 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[5u32] into r20;
    ternary r20 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[5u32] into r21;
    cast r21 r0.wallet_address r1 r2 r3 r4 r0.threshold into r22 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[6u32] into r23;
    ternary r23 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[6u32] into r24;
    cast r24 r0.wallet_address r1 r2 r3 r4 r0.threshold into r25 as ConfirmTransferTicket.record;
    is.eq r0.owner r0.owners[7u32] into r26;
    ternary r26 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[7u32] into r27;
    cast r27 r0.wallet_address r1 r2 r3 r4 r0.threshold into r28 as ConfirmTransferTicket.record;
    cast r0.owner r0.wallet_address r1 r2 r3 r4 r0.threshold into r29 as ExecuteTransferTicket.record;
    cast r0.wallet_address r1 into r30 as BalanceKey;
    hash.bhp256 r30 into r31 as field;
    hash.bhp256 r0.wallet_address into r32 as field;
    call zero_wallet_manager_v7.aleo/refresh_wallet_record r0 into r33;
    async create_transfer r32 r31 r4 r3 r0.sequence into r34;
    output r33 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r29 as ExecuteTransferTicket.record;
    output r7 as ConfirmTransferTicket.record;
    output r10 as ConfirmTransferTicket.record;
    output r13 as ConfirmTransferTicket.record;
    output r16 as ConfirmTransferTicket.record;
    output r19 as ConfirmTransferTicket.record;
    output r22 as ConfirmTransferTicket.record;
    output r25 as ConfirmTransferTicket.record;
    output r28 as ConfirmTransferTicket.record;
    output r34 as zero_transfer_manager_v7.aleo/create_transfer.future;

finalize create_transfer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u64.public;
    get balances[r1] into r5;
    gte r5 r3 into r6;
    assert.eq r6 true;
    contains transfers_status[r2] into r7;
    assert.eq r7 false;
    get zero_wallet_manager_v7.aleo/wallet_sequence[r0] into r8;
    is.eq r8 r4 into r9;
    assert.eq r9 true;
    cast 1u8 into r10 as TransferStatus;
    set r10 into transfers_status[r2];

function confirm_transfer:
    input r0 as ConfirmTransferTicket.record;
    cast r0.owner r0.wallet_address r0.token_id r0.to r0.amount r0.transfer_id r0.threshold into r1 as ExecuteTransferTicket.record;
    async confirm_transfer r0.transfer_id into r2;
    output r1 as ExecuteTransferTicket.record;
    output r2 as zero_transfer_manager_v7.aleo/confirm_transfer.future;

finalize confirm_transfer:
    input r0 as field.public;
    get transfers_status[r0] into r1;
    add r1.confirmations 1u8 into r2;
    cast r2 into r3 as TransferStatus;
    set r3 into transfers_status[r0];

function execute_aleo_transfer:
    input r0 as ExecuteTransferTicket.record;
    assert.eq r0.token_id 3443843282313283355522573239085696902919850365217539366784739393210722344986field;
    cast r0.wallet_address r0.token_id into r1 as BalanceKey;
    hash.bhp256 r1 into r2 as field;
    cast r0.amount into r3 as u64;
    call credits.aleo/transfer_public_to_private r0.to r3 into r4 r5;
    async execute_aleo_transfer r2 r0.transfer_id r0.threshold r0.amount r5 into r6;
    output r4 as credits.aleo/credits.record;
    output r6 as zero_transfer_manager_v7.aleo/execute_aleo_transfer.future;

finalize execute_aleo_transfer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    input r3 as u128.public;
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

function execute_token_transfer:
    input r0 as ExecuteTransferTicket.record;
    input r1 as boolean.private;
    assert.neq r0.token_id 3443843282313283355522573239085696902919850365217539366784739393210722344986field;
    cast r0.wallet_address r0.token_id into r2 as BalanceKey;
    hash.bhp256 r2 into r3 as field;
    call token_registry.aleo/transfer_public_to_private r0.token_id r0.to r0.amount r1 into r4 r5;
    async execute_token_transfer r3 r0.transfer_id r0.threshold r0.amount r5 into r6;
    output r4 as token_registry.aleo/Token.record;
    output r6 as zero_transfer_manager_v7.aleo/execute_token_transfer.future;

finalize execute_token_transfer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    input r3 as u128.public;
    input r4 as token_registry.aleo/transfer_public_to_private.future;
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

function mint_ConfirmTransferTicket:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as address.private;
    input r4 as u128.private;
    input r5 as field.private;
    input r6 as u8.private;
    cast r0 r1 r2 r3 r4 r5 r6 into r7 as ConfirmTransferTicket.record;
    output r7 as ConfirmTransferTicket.record;

function mint_ExecuteTransferTicket:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as address.private;
    input r4 as u128.private;
    input r5 as field.private;
    input r6 as u8.private;
    cast r0 r1 r2 r3 r4 r5 r6 into r7 as ExecuteTransferTicket.record;
    output r7 as ExecuteTransferTicket.record;
