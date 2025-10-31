import credits.aleo;
import token_registry.aleo;

program prediction_market_paris_vf.aleo;

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
    gte r6 3000000u64 into r7;
    assert.eq r7 true;
    gt r5 0u32 into r8;
    assert.eq r8 true;
    lte r5 365u32 into r9;
    assert.eq r9 true;
    gt r3 0u64 into r10;
    lt r3 1000000u64 into r11;
    and r10 r11 into r12;
    assert.eq r12 true;
    gte r4 10000000u64 into r13;
    assert.eq r13 true;
    add r0 1000field into r14;
    hash.bhp256 r14 into r15 as field;
    add r0 2000field into r16;
    hash.bhp256 r16 into r17 as field;
    sub 1000000u64 r3 into r18;
    mul r5 86400u32 into r19;
    cast self.signer r0 r15 r17 r3 r18 3000000u64 r2 into r20 as MarketReceipt.record;
    async create_market_with_auto_tokens r0 r1 r2 r15 r17 r3 r18 r4 r19 self.signer into r21;
    output r20 as MarketReceipt.record;
    output r21 as prediction_market_paris_vf.aleo/create_market_with_auto_tokens.future;

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
    mul r7 1000000u64 into r11;
    div r11 r5 into r12;
    mul r7 1000000u64 into r13;
    div r13 r6 into r14;
    cast r0 r9 r1 r3 r4 r10 0u8 0u8 r12 r14 r7 r5 r6 0u32 into r15 as Market;
    cast r0 r3 r4 block.height r1 r2 into r16 as MarketTokenMetadata;
    set r15 into markets[r0];
    set r16 into market_tokens[r0];
    set 0u64 into trade_volume[r0];
    cast r9 into r17 as field;
    add r17 r3 into r18;
    hash.bhp256 r18 into r19 as field;
    cast r9 into r20 as field;
    add r20 r4 into r21;
    hash.bhp256 r21 into r22 as field;
    get.or_use token_holders[r19] 0u128 into r23;
    get.or_use token_holders[r22] 0u128 into r24;
    add r23 100000u128 into r25;
    set r25 into token_holders[r19];
    add r24 100000u128 into r26;
    set r26 into token_holders[r22];
    get.or_use admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r27;
    add r27 3000000u64 into r28;
    set r28 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];
    get.or_use market_count[true] 0u8 into r29;
    lt r29 100u8 into r30;
    branch.eq r30 false to end_then_0_0;
    set r0 into open_markets[r29];
    add r29 1u8 into r31;
    set r31 into market_count[true];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function buy_prediction_tokens:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as u64.private;
    input r4 as field.private;
    gte r2 1000000u64 into r5;
    assert.eq r5 true;
    is.eq r1 1u8 into r6;
    is.eq r1 2u8 into r7;
    or r6 r7 into r8;
    assert.eq r8 true;
    cast self.signer r0 r1 r2 0u64 0u64 0field r4 into r9 as BetRecord.record;
    async buy_prediction_tokens r0 r1 r2 r3 self.signer into r10;
    output r9 as BetRecord.record;
    output r10 as prediction_market_paris_vf.aleo/buy_prediction_tokens.future;

finalize buy_prediction_tokens:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as address.public;
    get markets[r0] into r5;
    get market_tokens[r0] into r6;
    is.eq r5.status 0u8 into r7;
    assert.eq r7 true;
    lt block.height r5.closing_block into r8;
    assert.eq r8 true;
    mul r2 3000u64 into r9;
    div r9 1000000u64 into r10;
    sub r2 r10 into r11;
    mul r5.yes_reserve r5.no_reserve into r12;
    is.eq r1 1u8 into r13;
    add r5.yes_reserve r11 into r14;
    add r5.no_reserve r11 into r15;
    div r12 r15 into r16;
    ternary r13 r14 r16 into r17;
    is.eq r1 1u8 into r18;
    div r12 r17 into r19;
    add r5.no_reserve r11 into r20;
    ternary r18 r19 r20 into r21;
    is.eq r1 1u8 into r22;
    sub r5.no_reserve r21 into r23;
    sub r5.yes_reserve r17 into r24;
    ternary r22 r23 r24 into r25;
    mul r11 1000000u64 into r26;
    div r26 r25 into r27;
    gte r25 r3 into r28;
    assert.eq r28 true;
    is.eq r1 1u8 into r29;
    ternary r29 r6.yes_token_id r6.no_token_id into r30;
    add r5.total_liquidity r11 into r31;
    is.eq r1 1u8 into r32;
    ternary r32 r27 r5.last_yes_price into r33;
    is.eq r1 2u8 into r34;
    ternary r34 r27 r5.last_no_price into r35;
    add r5.trade_count 1u32 into r36;
    cast r5.id r5.creator r5.question r5.yes_token_id r5.no_token_id r5.closing_block r5.status r5.winning_option r17 r21 r31 r33 r35 r36 into r37 as Market;
    set r37 into markets[r0];
    cast r4 into r38 as field;
    add r38 r30 into r39;
    hash.bhp256 r39 into r40 as field;
    get.or_use token_holders[r40] 0u128 into r41;
    cast r25 into r42 as u128;
    add r41 r42 into r43;
    set r43 into token_holders[r40];
    get.or_use trade_volume[r0] 0u64 into r44;
    add r44 r2 into r45;
    set r45 into trade_volume[r0];
    get.or_use admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r46;
    add r46 r10 into r47;
    set r47 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function sell_prediction_tokens:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as u64.private;
    input r4 as field.private;
    gt r2 0u64 into r5;
    assert.eq r5 true;
    is.eq r1 1u8 into r6;
    is.eq r1 2u8 into r7;
    or r6 r7 into r8;
    assert.eq r8 true;
    cast self.signer r0 r1 0u64 r2 0u64 0field r4 into r9 as BetRecord.record;
    async sell_prediction_tokens r0 r1 r2 r3 self.signer into r10;
    output r9 as BetRecord.record;
    output r10 as prediction_market_paris_vf.aleo/sell_prediction_tokens.future;

finalize sell_prediction_tokens:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as address.public;
    get markets[r0] into r5;
    get market_tokens[r0] into r6;
    is.eq r5.status 0u8 into r7;
    assert.eq r7 true;
    lt block.height r5.closing_block into r8;
    assert.eq r8 true;
    is.eq r1 1u8 into r9;
    ternary r9 r6.yes_token_id r6.no_token_id into r10;
    cast r4 into r11 as field;
    add r11 r10 into r12;
    hash.bhp256 r12 into r13 as field;
    get token_holders[r13] into r14;
    cast r2 into r15 as u128;
    gte r14 r15 into r16;
    assert.eq r16 true;
    mul r5.yes_reserve r5.no_reserve into r17;
    is.eq r1 1u8 into r18;
    add r5.no_reserve r2 into r19;
    div r17 r19 into r20;
    add r5.yes_reserve r2 into r21;
    ternary r18 r20 r21 into r22;
    is.eq r1 1u8 into r23;
    add r5.no_reserve r2 into r24;
    div r17 r22 into r25;
    ternary r23 r24 r25 into r26;
    is.eq r1 1u8 into r27;
    sub r5.yes_reserve r22 into r28;
    sub r5.no_reserve r26 into r29;
    ternary r27 r28 r29 into r30;
    mul r30 3000u64 into r31;
    div r31 1000000u64 into r32;
    sub r30 r32 into r33;
    gte r33 r3 into r34;
    assert.eq r34 true;
    cast r2 into r35 as u128;
    sub r14 r35 into r36;
    set r36 into token_holders[r13];
    add r5.trade_count 1u32 into r37;
    cast r5.id r5.creator r5.question r5.yes_token_id r5.no_token_id r5.closing_block r5.status r5.winning_option r22 r26 r5.total_liquidity r5.last_yes_price r5.last_no_price r37 into r38 as Market;
    set r38 into markets[r0];
    get.or_use admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r39;
    add r39 r32 into r40;
    set r40 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function resolve_market_with_tokens:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.public;
    is.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj into r3;
    assert.eq r3 true;
    gte r2 1000000u64 into r4;
    assert.eq r4 true;
    is.eq r1 1u8 into r5;
    is.eq r1 2u8 into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    async resolve_market_with_tokens r0 r1 into r8;
    output r8 as prediction_market_paris_vf.aleo/resolve_market_with_tokens.future;

finalize resolve_market_with_tokens:
    input r0 as field.public;
    input r1 as u8.public;
    get markets[r0] into r2;
    is.eq r2.status 0u8 into r3;
    assert.eq r3 true;
    gte block.height r2.closing_block into r4;
    assert.eq r4 true;
    cast r2.id r2.creator r2.question r2.yes_token_id r2.no_token_id r2.closing_block 2u8 r1 r2.yes_reserve r2.no_reserve r2.total_liquidity r2.last_yes_price r2.last_no_price r2.trade_count into r5 as Market;
    set r5 into markets[r0];

function claim_token_winnings:
    input r0 as field.private;
    input r1 as u128.private;
    cast self.signer r0 0field 0u64 0field into r2 as RewardReceipt.record;
    async claim_token_winnings r0 r1 self.signer into r3;
    output r2 as RewardReceipt.record;
    output r3 as prediction_market_paris_vf.aleo/claim_token_winnings.future;

finalize claim_token_winnings:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    get markets[r0] into r3;
    get market_tokens[r0] into r4;
    is.eq r3.status 2u8 into r5;
    assert.eq r5 true;
    is.eq r3.winning_option 1u8 into r6;
    ternary r6 r4.yes_token_id r4.no_token_id into r7;
    cast r2 into r8 as field;
    add r8 r7 into r9;
    hash.bhp256 r9 into r10 as field;
    get token_holders[r10] into r11;
    gte r11 r1 into r12;
    assert.eq r12 true;
    sub r11 r1 into r13;
    set r13 into token_holders[r10];

function get_price_quote:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.private;
    async get_price_quote r0 r1 r2 into r3;
    output r3 as prediction_market_paris_vf.aleo/get_price_quote.future;

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
    is.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj into r2;
    assert.eq r2 true;
    is.eq r1 1u8 into r3;
    is.eq r1 2u8 into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    async close_market_with_winner r0 r1 into r6;
    output r6 as prediction_market_paris_vf.aleo/close_market_with_winner.future;

finalize close_market_with_winner:
    input r0 as field.public;
    input r1 as u8.public;
    get markets[r0] into r2;
    is.eq r2.status 0u8 into r3;
    assert.eq r3 true;
    gte block.height r2.closing_block into r4;
    assert.eq r4 true;
    cast r2.id r2.creator r2.question r2.yes_token_id r2.no_token_id r2.closing_block 1u8 r1 r2.yes_reserve r2.no_reserve r2.total_liquidity r2.last_yes_price r2.last_no_price r2.trade_count into r5 as Market;
    set r5 into markets[r0];

function cancel_market:
    input r0 as field.private;
    is.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj into r1;
    assert.eq r1 true;
    async cancel_market r0 into r2;
    output r2 as prediction_market_paris_vf.aleo/cancel_market.future;

finalize cancel_market:
    input r0 as field.public;
    get markets[r0] into r1;
    is.eq r1.status 0u8 into r2;
    assert.eq r2 true;
    cast r1.id r1.creator r1.question r1.yes_token_id r1.no_token_id r1.closing_block 3u8 r1.winning_option r1.yes_reserve r1.no_reserve r1.total_liquidity r1.last_yes_price r1.last_no_price r1.trade_count into r3 as Market;
    set r3 into markets[r0];

function withdraw_admin_fees:
    input r0 as u64.private;
    is.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj into r1;
    assert.eq r1 true;
    async withdraw_admin_fees r0 into r2;
    output r2 as prediction_market_paris_vf.aleo/withdraw_admin_fees.future;

finalize withdraw_admin_fees:
    input r0 as u64.public;
    get admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] into r1;
    gte r1 r0 into r2;
    assert.eq r2 true;
    sub r1 r0 into r3;
    set r3 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function get_open_market_count:
    async get_open_market_count into r0;
    output r0 as prediction_market_paris_vf.aleo/get_open_market_count.future;

finalize get_open_market_count:
    get.or_use market_count[true] 0u8 into r0;

function get_market_id_at_index:
    input r0 as u8.private;
    async get_market_id_at_index r0 into r1;
    output r1 as prediction_market_paris_vf.aleo/get_market_id_at_index.future;

finalize get_market_id_at_index:
    input r0 as u8.public;
    get open_markets[r0] into r1;

function get_market_details:
    input r0 as field.private;
    async get_market_details r0 into r1;
    output r1 as prediction_market_paris_vf.aleo/get_market_details.future;

finalize get_market_details:
    input r0 as field.public;
    get markets[r0] into r1;
    get market_tokens[r0] into r2;
    get.or_use trade_volume[r0] 0u64 into r3;
    is.eq r1.status 0u8 into r4;
    assert.eq r4 true;
    lt block.height r1.closing_block into r5;
    assert.eq r5 true;

function is_market_still_active:
    input r0 as field.private;
    async is_market_still_active r0 into r1;
    output r1 as prediction_market_paris_vf.aleo/is_market_still_active.future;

finalize is_market_still_active:
    input r0 as field.public;
    get markets[r0] into r1;

function get_current_prices:
    input r0 as field.private;
    async get_current_prices r0 into r1;
    output r1 as prediction_market_paris_vf.aleo/get_current_prices.future;

finalize get_current_prices:
    input r0 as field.public;
    get markets[r0] into r1;
    is.eq r1.status 0u8 into r2;
    assert.eq r2 true;
