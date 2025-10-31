import credits.aleo;

program exchg_test_v1_10.aleo;

struct Balance:
    walletAddress as address;
    token_id as field;

record OrderbookRecord:
    owner as address.public;
    book as field.public;
    timestamp as u128.public;
    hash as field.public;

record TradeRecord:
    owner as address.public;
    book as field.public;
    timestamp as u128.public;
    hash as field.public;

struct TokenInfo:
    name as field;
    symbol as field;
    decimals as u8;

struct OBState:
    user as address;
    timestamp as u128;
    hash as field;

struct Trade:
    user as address;
    timestamp as u128;
    hash as field;

struct Message:
    field_1 as field;
    field_2 as field;
    field_3 as field;
    field_4 as field;
    field_5 as field;

struct Order:
    token_in as TokenInfo;
    token_out as TokenInfo;
    amount_in as u128;
    amount_out as u128;
    sender as address;
    receiver as address;

mapping initialized:
    key as boolean.public;
    value as boolean.public;

mapping contract_owner:
    key as boolean.public;
    value as address.public;

mapping zkx_tokens:
    key as TokenInfo.public;
    value as boolean.public;

mapping balances:
    key as Balance.public;
    value as u128.public;

mapping total_supply:
    key as TokenInfo.public;
    value as u128.public;

mapping token_count:
    key as boolean.public;
    value as u64.public;

mapping orderbook_state:
    key as field.public;
    value as OBState.public;

mapping trade_history_state:
    key as field.public;
    value as Trade.public;

function initialize:
    async initialize into r0;
    output r0 as exchg_test_v1_10.aleo/initialize.future;

finalize initialize:
    get.or_use initialized[true] false into r0;
    not r0 into r1;
    assert.eq r1 true;
    set aleo135kcktuu6grws7a3myg62rk7d5r5lmu8y4s5u4r3n37jjpjkmvqqgqe78s into contract_owner[true];
    set true into initialized[true];

function create_token:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    input r3 as u128.public;
    cast r0 r1 r2 into r4 as TokenInfo;
    async create_token r4 into r5;
    output r4 as TokenInfo.private;
    output r5 as exchg_test_v1_10.aleo/create_token.future;

finalize create_token:
    input r0 as TokenInfo.public;
    contains zkx_tokens[r0] into r1;
    not r1 into r2;
    assert.eq r2 true;
    get.or_use token_count[true] 0u64 into r3;
    add r3 1u64 into r4;
    set r4 into token_count[true];
    set true into zkx_tokens[r0];
    set 0u128 into total_supply[r0];

function mint_token_public:
    input r0 as TokenInfo.public;
    input r1 as address.public;
    input r2 as u128.public;
    gt r2 0u128 into r3;
    assert.eq r3 true;
    cast r1 r0.symbol into r4 as Balance;
    async mint_token_public r0 r4 r2 into r5;
    output r5 as exchg_test_v1_10.aleo/mint_token_public.future;

finalize mint_token_public:
    input r0 as TokenInfo.public;
    input r1 as Balance.public;
    input r2 as u128.public;
    contains zkx_tokens[r0] into r3;
    assert.eq r3 true;
    get.or_use balances[r1] 0u128 into r4;
    add r4 r2 into r5;
    set r5 into balances[r1];
    get total_supply[r0] into r6;
    add r6 r2 into r7;
    set r7 into total_supply[r0];

function swap:
    input r0 as TokenInfo.public;
    input r1 as TokenInfo.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as address.public;
    input r5 as address.public;
    assert.neq r0 r1;
    gt r2 0u128 into r6;
    assert.eq r6 true;
    gt r3 0u128 into r7;
    assert.eq r7 true;
    async swap r0 r1 r2 r3 r4 r5 into r8;
    output r8 as exchg_test_v1_10.aleo/swap.future;

finalize swap:
    input r0 as TokenInfo.public;
    input r1 as TokenInfo.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as address.public;
    input r5 as address.public;
    cast r4 r0.symbol into r6 as Balance;
    get.or_use balances[r6] 0u128 into r7;
    sub r7 r2 into r8;
    set r8 into balances[r6];
    cast r4 r1.symbol into r9 as Balance;
    get.or_use balances[r9] 0u128 into r10;
    add r10 r3 into r11;
    set r11 into balances[r9];
    cast r5 r0.symbol into r12 as Balance;
    get.or_use balances[r12] 0u128 into r13;
    add r13 r2 into r14;
    set r14 into balances[r12];
    cast r5 r1.symbol into r15 as Balance;
    get.or_use balances[r15] 0u128 into r16;
    sub r16 r3 into r17;
    set r17 into balances[r15];

function batch_swap:
    input r0 as [Order; 2u32].private;
    input r1 as u8.private;
    async batch_swap r0 r1 into r2;
    output r2 as exchg_test_v1_10.aleo/batch_swap.future;

finalize batch_swap:
    input r0 as [Order; 2u32].public;
    input r1 as u8.public;
    cast r0[0u32].sender r0[0u32].token_in.symbol into r2 as Balance;
    get.or_use balances[r2] 0u128 into r3;
    sub r3 r0[0u32].amount_in into r4;
    set r4 into balances[r2];
    cast r0[0u32].sender r0[0u32].token_out.symbol into r5 as Balance;
    get.or_use balances[r5] 0u128 into r6;
    add r6 r0[0u32].amount_out into r7;
    set r7 into balances[r5];
    cast r0[0u32].receiver r0[0u32].token_in.symbol into r8 as Balance;
    get.or_use balances[r8] 0u128 into r9;
    add r9 r0[0u32].amount_in into r10;
    set r10 into balances[r8];
    cast r0[0u32].receiver r0[0u32].token_out.symbol into r11 as Balance;
    get.or_use balances[r11] 0u128 into r12;
    sub r12 r0[0u32].amount_out into r13;
    set r13 into balances[r11];
    cast r0[1u32].sender r0[1u32].token_in.symbol into r14 as Balance;
    get.or_use balances[r14] 0u128 into r15;
    sub r15 r0[1u32].amount_in into r16;
    set r16 into balances[r14];
    cast r0[1u32].sender r0[1u32].token_out.symbol into r17 as Balance;
    get.or_use balances[r17] 0u128 into r18;
    add r18 r0[1u32].amount_out into r19;
    set r19 into balances[r17];
    cast r0[1u32].receiver r0[1u32].token_in.symbol into r20 as Balance;
    get.or_use balances[r20] 0u128 into r21;
    add r21 r0[1u32].amount_in into r22;
    set r22 into balances[r20];
    cast r0[1u32].receiver r0[1u32].token_out.symbol into r23 as Balance;
    get.or_use balances[r23] 0u128 into r24;
    sub r24 r0[1u32].amount_out into r25;
    set r25 into balances[r23];

function deposit:
    input r0 as address.private;
    input r1 as TokenInfo.private;
    input r2 as u128.private;
    is.eq r1.symbol 1095517519field into r3;
    cast r2 into r4 as u64;
    ternary r3 r4 0u64 into r5;
    call credits.aleo/transfer_public_as_signer exchg_test_v1_10.aleo r5 into r6;
    async deposit r0 r1 r2 r6 into r7;
    output r7 as exchg_test_v1_10.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as TokenInfo.public;
    input r2 as u128.public;
    input r3 as credits.aleo/transfer_public_as_signer.future;
    await r3;
    cast r0 r1.symbol into r4 as Balance;
    get.or_use balances[r4] 0u128 into r5;
    add r5 r2 into r6;
    set r6 into balances[r4];

function withdraw:
    input r0 as address.private;
    input r1 as TokenInfo.private;
    input r2 as u128.private;
    is.eq r1.symbol 1095517519field into r3;
    cast r2 into r4 as u64;
    ternary r3 r4 0u64 into r5;
    call credits.aleo/transfer_public self.caller r5 into r6;
    async withdraw r0 r1 r2 r6 into r7;
    output r7 as exchg_test_v1_10.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as TokenInfo.public;
    input r2 as u128.public;
    input r3 as credits.aleo/transfer_public.future;
    cast r0 r1.symbol into r4 as Balance;
    get.or_use balances[r4] 0u128 into r5;
    sub r5 r2 into r6;
    set r6 into balances[r4];
    await r3;

function update_order_book:
    input r0 as field.private;
    input r1 as OBState.private;
    cast r1.user r0 r1.timestamp r1.hash into r2 as OrderbookRecord.record;
    async update_order_book r0 r1 into r3;
    output r2 as OrderbookRecord.record;
    output r3 as exchg_test_v1_10.aleo/update_order_book.future;

finalize update_order_book:
    input r0 as field.public;
    input r1 as OBState.public;
    set r1 into orderbook_state[r0];

function update_trades_merkle_root:
    input r0 as field.private;
    input r1 as Trade.private;
    cast r1.user r0 r1.timestamp r1.hash into r2 as TradeRecord.record;
    async update_trades_merkle_root r0 r1 into r3;
    output r2 as TradeRecord.record;
    output r3 as exchg_test_v1_10.aleo/update_trades_merkle_root.future;

finalize update_trades_merkle_root:
    input r0 as field.public;
    input r1 as Trade.public;
    set r1 into trade_history_state[r0];
