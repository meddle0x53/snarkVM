import credits.aleo;
import token_registry.aleo;

program prediction_market_paris_zk.aleo;

record BetRecord:
    owner as address.private;
    market_id as field.private;
    chosen_option as u8.private;
    amount_paid as u64.private;
    tokens_received as u64.private;
    price_paid as u64.private;
    token_id as field.private;
    nonce as field.private;

record MarketReceipt:
    owner as address.private;
    market_id as field.private;
    yes_token_id as field.private;
    no_token_id as field.private;
    initial_yes_price as u64.private;
    initial_no_price as u64.private;
    creation_fee_paid as u64.private;
    question_title as field.private;

record RewardReceipt:
    owner as address.private;
    market_id as field.private;
    bet_nonce as field.private;
    reward_amount as u64.private;
    token_id as field.private;

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

struct Market:
    id as field;
    creator as address;
    question as field;
    yes_token_id as field;
    no_token_id as field;
    closing_block as u32;
    status as u8;
    winning_option as u8;
    yes_reserve as u64;
    no_reserve as u64;
    total_liquidity as u64;
    last_yes_price as u64;
    last_no_price as u64;
    trade_count as u32;

struct MarketTokenMetadata:
    market_id as field;
    yes_token_id as field;
    no_token_id as field;
    created_at as u32;
    question_hash as field;
    question_title as field;

mapping markets:
    key as field.public;
    value as Market.public;

mapping admin_fees:
    key as address.public;
    value as u64.public;

mapping claimed_bets:
    key as field.public;
    value as boolean.public;

mapping open_markets:
    key as u8.public;
    value as field.public;

mapping market_count:
    key as boolean.public;
    value as u8.public;

mapping trade_volume:
    key as field.public;
    value as u64.public;

mapping market_tokens:
    key as field.public;
    value as MarketTokenMetadata.public;

mapping token_holders:
    key as field.public;
    value as u128.public;

function create_market_with_auto_tokens:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as u64.private;
    input r4 as u64.private;
    input r5 as u32.private;
    input r6 as u64.public;
    add r0 1000field into r7;
    hash.bhp256 r7 into r8 as field;
    add r0 2000field into r9;
    hash.bhp256 r9 into r10 as field;
    sub 1000000u64 r3 into r11;
    mul r5 86400u32 into r12;
    cast self.signer r0 r8 r10 r3 r11 3000000u64 r2 into r13 as MarketReceipt.record;
    async create_market_with_auto_tokens r0 r1 r2 r8 r10 r3 r11 r4 r12 self.signer into r14;
    output r13 as MarketReceipt.record;
    output r14 as prediction_market_paris_zk.aleo/create_market_with_auto_tokens.future;

finalize create_market_with_auto_tokens:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as u64.public;
    input r6 as u64.public;
    input r7 as u64.public;
    input r8 as u32.public;
    input r9 as address.public;
    add block.height r8 into r10;
    mul r7 2u64 into r11;
    div r11 2u64 into r12;
    div r11 2u64 into r13;
    cast r0 r9 r1 r3 r4 r10 0u8 0u8 r12 r13 r7 r5 r6 0u32 into r14 as Market;
    cast r0 r3 r4 block.height r1 r2 into r15 as MarketTokenMetadata;
    set r14 into markets[r0];
    set r15 into market_tokens[r0];
    set 0u64 into trade_volume[r0];
    cast r9 into r16 as field;
    add r16 r3 into r17;
    hash.bhp256 r17 into r18 as field;
    cast r9 into r19 as field;
    add r19 r4 into r20;
    hash.bhp256 r20 into r21 as field;
    set 1000u128 into token_holders[r18];
    set 1000u128 into token_holders[r21];
    get.or_use admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r22;
    add r22 3000000u64 into r23;
    set r23 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];
    get.or_use market_count[true] 0u8 into r24;
    lt r24 100u8 into r25;
    branch.eq r25 false to end_then_0_0;
    set r0 into open_markets[r24];
    add r24 1u8 into r26;
    set r26 into market_count[true];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function buy_prediction_tokens:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as u64.private;
    input r4 as field.private;
    cast self.signer r0 r1 r2 0u64 0u64 0field r4 into r5 as BetRecord.record;
    async buy_prediction_tokens r0 r1 r2 r3 self.signer into r6;
    output r5 as BetRecord.record;
    output r6 as prediction_market_paris_zk.aleo/buy_prediction_tokens.future;

finalize buy_prediction_tokens:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as address.public;
    get markets[r0] into r5;
    get market_tokens[r0] into r6;
    mul r2 3000u64 into r7;
    div r7 1000000u64 into r8;
    sub r2 r8 into r9;
    mul r5.yes_reserve r5.no_reserve into r10;
    add r5.no_reserve r9 into r11;
    add r5.yes_reserve r9 into r12;
    is.eq r1 1u8 into r13;
    add r5.yes_reserve r9 into r14;
    div r10 r11 into r15;
    ternary r13 r14 r15 into r16;
    is.eq r1 1u8 into r17;
    div r10 r16 into r18;
    add r5.no_reserve r9 into r19;
    ternary r17 r18 r19 into r20;
    is.eq r1 1u8 into r21;
    sub r5.no_reserve r20 into r22;
    sub r5.yes_reserve r16 into r23;
    ternary r21 r22 r23 into r24;
    is.eq r1 1u8 into r25;
    ternary r25 r6.yes_token_id r6.no_token_id into r26;
    cast r4 into r27 as field;
    add r27 r26 into r28;
    hash.bhp256 r28 into r29 as field;
    get.or_use token_holders[r29] 0u128 into r30;
    cast r24 into r31 as u128;
    add r30 r31 into r32;
    set r32 into token_holders[r29];
    add r5.total_liquidity r9 into r33;
    is.eq r1 1u8 into r34;
    mul r16 1000000u64 into r35;
    add r16 r20 into r36;
    div r35 r36 into r37;
    ternary r34 r37 r5.last_yes_price into r38;
    is.eq r1 2u8 into r39;
    mul r20 1000000u64 into r40;
    add r16 r20 into r41;
    div r40 r41 into r42;
    ternary r39 r42 r5.last_no_price into r43;
    add r5.trade_count 1u32 into r44;
    cast r5.id r5.creator r5.question r5.yes_token_id r5.no_token_id r5.closing_block r5.status r5.winning_option r16 r20 r33 r38 r43 r44 into r45 as Market;
    set r45 into markets[r0];
    get.or_use trade_volume[r0] 0u64 into r46;
    add r46 r2 into r47;
    set r47 into trade_volume[r0];
    get.or_use admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r48;
    add r48 r8 into r49;
    set r49 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function sell_prediction_tokens:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as u64.private;
    input r4 as field.private;
    cast self.signer r0 r1 0u64 r2 0u64 0field r4 into r5 as BetRecord.record;
    async sell_prediction_tokens r0 r1 r2 r3 self.signer into r6;
    output r5 as BetRecord.record;
    output r6 as prediction_market_paris_zk.aleo/sell_prediction_tokens.future;

finalize sell_prediction_tokens:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as address.public;
    get markets[r0] into r5;
    get market_tokens[r0] into r6;
    is.eq r1 1u8 into r7;
    ternary r7 r6.yes_token_id r6.no_token_id into r8;
    cast r4 into r9 as field;
    add r9 r8 into r10;
    hash.bhp256 r10 into r11 as field;
    get token_holders[r11] into r12;
    mul r5.yes_reserve r5.no_reserve into r13;
    is.eq r1 1u8 into r14;
    sub r5.yes_reserve r2 into r15;
    sub r5.no_reserve r2 into r16;
    div r13 r16 into r17;
    ternary r14 r15 r17 into r18;
    is.eq r1 1u8 into r19;
    div r13 r18 into r20;
    sub r5.no_reserve r2 into r21;
    ternary r19 r20 r21 into r22;
    is.eq r1 1u8 into r23;
    sub r22 r5.no_reserve into r24;
    sub r18 r5.yes_reserve into r25;
    ternary r23 r24 r25 into r26;
    mul r26 3000u64 into r27;
    div r27 1000000u64 into r28;
    sub r26 r28 into r29;
    cast r2 into r30 as u128;
    sub r12 r30 into r31;
    set r31 into token_holders[r11];
    is.eq r1 1u8 into r32;
    mul r18 1000000u64 into r33;
    add r18 r22 into r34;
    div r33 r34 into r35;
    ternary r32 r35 r5.last_yes_price into r36;
    is.eq r1 2u8 into r37;
    mul r22 1000000u64 into r38;
    add r18 r22 into r39;
    div r38 r39 into r40;
    ternary r37 r40 r5.last_no_price into r41;
    add r5.trade_count 1u32 into r42;
    cast r5.id r5.creator r5.question r5.yes_token_id r5.no_token_id r5.closing_block r5.status r5.winning_option r18 r22 r5.total_liquidity r36 r41 r42 into r43 as Market;
    set r43 into markets[r0];
    get.or_use trade_volume[r0] 0u64 into r44;
    add r44 r29 into r45;
    set r45 into trade_volume[r0];
    get.or_use admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r46;
    add r46 r28 into r47;
    set r47 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function resolve_market_with_tokens:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.public;
    async resolve_market_with_tokens r0 r1 into r3;
    output r3 as prediction_market_paris_zk.aleo/resolve_market_with_tokens.future;

finalize resolve_market_with_tokens:
    input r0 as field.public;
    input r1 as u8.public;
    get markets[r0] into r2;
    cast r2.id r2.creator r2.question r2.yes_token_id r2.no_token_id r2.closing_block 2u8 r1 r2.yes_reserve r2.no_reserve r2.total_liquidity r2.last_yes_price r2.last_no_price r2.trade_count into r3 as Market;
    set r3 into markets[r0];

function claim_token_winnings:
    input r0 as field.private;
    input r1 as u128.private;
    cast self.signer r0 0field 0u64 0field into r2 as RewardReceipt.record;
    async claim_token_winnings r0 r1 self.signer into r3;
    output r2 as RewardReceipt.record;
    output r3 as prediction_market_paris_zk.aleo/claim_token_winnings.future;

finalize claim_token_winnings:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    get markets[r0] into r3;
    get market_tokens[r0] into r4;
    is.eq r3.winning_option 1u8 into r5;
    ternary r5 r4.yes_token_id r4.no_token_id into r6;
    cast r2 into r7 as field;
    add r7 r6 into r8;
    hash.bhp256 r8 into r9 as field;
    get token_holders[r9] into r10;
    sub r10 r1 into r11;
    set r11 into token_holders[r9];

function get_price_quote:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.private;
    async get_price_quote r0 r1 r2 into r3;
    output r3 as prediction_market_paris_zk.aleo/get_price_quote.future;

finalize get_price_quote:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as u64.public;
    get markets[r0] into r3;
    mul r2 3000u64 into r4;
    div r4 1000000u64 into r5;
    sub r2 r5 into r6;
    mul r3.yes_reserve r3.no_reserve into r7;
    add r3.yes_reserve r6 into r8;
    div r7 r8 into r9;
    add r3.no_reserve r6 into r10;
    div r7 r10 into r11;

function close_market_with_winner:
    input r0 as field.private;
    input r1 as u8.private;
    async close_market_with_winner r0 r1 into r2;
    output r2 as prediction_market_paris_zk.aleo/close_market_with_winner.future;

finalize close_market_with_winner:
    input r0 as field.public;
    input r1 as u8.public;
    get markets[r0] into r2;
    cast r2.id r2.creator r2.question r2.yes_token_id r2.no_token_id r2.closing_block 1u8 r1 r2.yes_reserve r2.no_reserve r2.total_liquidity r2.last_yes_price r2.last_no_price r2.trade_count into r3 as Market;
    set r3 into markets[r0];

function cancel_market:
    input r0 as field.private;
    async cancel_market r0 into r1;
    output r1 as prediction_market_paris_zk.aleo/cancel_market.future;

finalize cancel_market:
    input r0 as field.public;
    get markets[r0] into r1;
    cast r1.id r1.creator r1.question r1.yes_token_id r1.no_token_id r1.closing_block 3u8 r1.winning_option r1.yes_reserve r1.no_reserve r1.total_liquidity r1.last_yes_price r1.last_no_price r1.trade_count into r2 as Market;
    set r2 into markets[r0];

function withdraw_admin_fees:
    input r0 as u64.private;
    async withdraw_admin_fees r0 into r1;
    output r1 as prediction_market_paris_zk.aleo/withdraw_admin_fees.future;

finalize withdraw_admin_fees:
    input r0 as u64.public;
    get admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] into r1;
    sub r1 r0 into r2;
    set r2 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function get_open_market_count:
    async get_open_market_count into r0;
    output r0 as prediction_market_paris_zk.aleo/get_open_market_count.future;

finalize get_open_market_count:
    get.or_use market_count[true] 0u8 into r0;

function get_market_id_at_index:
    input r0 as u8.private;
    async get_market_id_at_index r0 into r1;
    output r1 as prediction_market_paris_zk.aleo/get_market_id_at_index.future;

finalize get_market_id_at_index:
    input r0 as u8.public;
    get open_markets[r0] into r1;

function get_market_details:
    input r0 as field.private;
    async get_market_details r0 into r1;
    output r1 as prediction_market_paris_zk.aleo/get_market_details.future;

finalize get_market_details:
    input r0 as field.public;
    get markets[r0] into r1;
    get market_tokens[r0] into r2;
    get.or_use trade_volume[r0] 0u64 into r3;

function is_market_still_active:
    input r0 as field.private;
    async is_market_still_active r0 into r1;
    output r1 as prediction_market_paris_zk.aleo/is_market_still_active.future;

finalize is_market_still_active:
    input r0 as field.public;
    get markets[r0] into r1;

function get_current_prices:
    input r0 as field.private;
    async get_current_prices r0 into r1;
    output r1 as prediction_market_paris_zk.aleo/get_current_prices.future;

finalize get_current_prices:
    input r0 as field.public;
    get markets[r0] into r1;
