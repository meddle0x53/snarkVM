program prediction_market.aleo;

record BetRecord:
    owner as address.private;
    market_id as field.private;
    chosen_option as u8.private;
    amount as u64.private;
    nonce as field.private;

record MarketReceipt:
    owner as address.private;
    market_id as field.private;
    creation_fee_paid as u64.private;

record RewardReceipt:
    owner as address.private;
    market_id as field.private;
    bet_nonce as field.private;
    reward_amount as u64.private;

struct Market:
    id as field;
    creator as address;
    question as field;
    options as [field; 5u32];
    num_options as u8;
    closing_block as u32;
    status as u8;
    winning_option as u8;
    total_pool as u64;
    option_pools as [u64; 5u32];

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

function create_market:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as [field; 5u32].private;
    input r3 as u8.private;
    input r4 as u32.private;
    input r5 as u64.public;
    gte r5 3000000u64 into r6;
    assert.eq r6 true;
    gte r3 2u8 into r7;
    assert.eq r7 true;
    lte r3 5u8 into r8;
    assert.eq r8 true;
    gt r4 0u32 into r9;
    assert.eq r9 true;
    lte r4 365u32 into r10;
    assert.eq r10 true;
    mul r4 86400u32 into r11;
    cast self.signer r0 3000000u64 into r12 as MarketReceipt.record;
    async create_market r0 r1 r2 r3 r11 self.signer into r13;
    output r12 as MarketReceipt.record;
    output r13 as prediction_market.aleo/create_market.future;

finalize create_market:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as [field; 5u32].public;
    input r3 as u8.public;
    input r4 as u32.public;
    input r5 as address.public;
    add block.height r4 into r6;
    cast 0u64 0u64 0u64 0u64 0u64 into r7 as [u64; 5u32];
    cast r0 r5 r1 r2 r3 r6 0u8 0u8 0u64 r7 into r8 as Market;
    set r8 into markets[r0];
    get.or_use admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r9;
    add r9 3000000u64 into r10;
    set r10 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];
    get.or_use market_count[true] 0u8 into r11;
    lt r11 100u8 into r12;
    branch.eq r12 false to end_then_0_0;
    set r0 into open_markets[r11];
    add r11 1u8 into r13;
    set r13 into market_count[true];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function place_bet:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as field.private;
    gte r2 3000000u64 into r4;
    assert.eq r4 true;
    gte r1 1u8 into r5;
    assert.eq r5 true;
    lte r1 5u8 into r6;
    assert.eq r6 true;
    cast self.signer r0 r1 r2 r3 into r7 as BetRecord.record;
    async place_bet r0 r1 r2 into r8;
    output r7 as BetRecord.record;
    output r8 as prediction_market.aleo/place_bet.future;

finalize place_bet:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as u64.public;
    get markets[r0] into r3;
    is.eq r3.status 0u8 into r4;
    assert.eq r4 true;
    lt block.height r3.closing_block into r5;
    assert.eq r5 true;
    lte r1 r3.num_options into r6;
    assert.eq r6 true;
    is.eq r1 1u8 into r7;
    is.eq r1 2u8 into r8;
    is.eq r1 3u8 into r9;
    is.eq r1 4u8 into r10;
    is.eq r1 5u8 into r11;
    add r3.option_pools[0u32] r2 into r12;
    ternary r7 r12 r3.option_pools[0u32] into r13;
    add r3.option_pools[1u32] r2 into r14;
    ternary r8 r14 r3.option_pools[1u32] into r15;
    add r3.option_pools[2u32] r2 into r16;
    ternary r9 r16 r3.option_pools[2u32] into r17;
    add r3.option_pools[3u32] r2 into r18;
    ternary r10 r18 r3.option_pools[3u32] into r19;
    add r3.option_pools[4u32] r2 into r20;
    ternary r11 r20 r3.option_pools[4u32] into r21;
    add r3.total_pool r2 into r22;
    cast r13 r15 r17 r19 r21 into r23 as [u64; 5u32];
    cast r3.id r3.creator r3.question r3.options r3.num_options r3.closing_block r3.status r3.winning_option r22 r23 into r24 as Market;
    set r24 into markets[r0];

function close_market_with_winner:
    input r0 as field.private;
    input r1 as u8.private;
    is.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj into r2;
    assert.eq r2 true;
    async close_market_with_winner r0 r1 into r3;
    output r3 as prediction_market.aleo/close_market_with_winner.future;

finalize close_market_with_winner:
    input r0 as field.public;
    input r1 as u8.public;
    get markets[r0] into r2;
    is.eq r2.status 0u8 into r3;
    assert.eq r3 true;
    gte block.height r2.closing_block into r4;
    assert.eq r4 true;
    gte r1 1u8 into r5;
    lte r1 r2.num_options into r6;
    and r5 r6 into r7;
    assert.eq r7 true;
    cast r2.id r2.creator r2.question r2.options r2.num_options r2.closing_block 1u8 r1 r2.total_pool r2.option_pools into r8 as Market;
    set r8 into markets[r0];

function cancel_market:
    input r0 as field.private;
    is.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj into r1;
    assert.eq r1 true;
    async cancel_market r0 into r2;
    output r2 as prediction_market.aleo/cancel_market.future;

finalize cancel_market:
    input r0 as field.public;
    get markets[r0] into r1;
    is.eq r1.status 0u8 into r2;
    assert.eq r2 true;
    cast r1.id r1.creator r1.question r1.options r1.num_options r1.closing_block 2u8 r1.winning_option r1.total_pool r1.option_pools into r3 as Market;
    set r3 into markets[r0];

function mark_market_invalid:
    input r0 as field.private;
    is.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj into r1;
    assert.eq r1 true;
    async mark_market_invalid r0 into r2;
    output r2 as prediction_market.aleo/mark_market_invalid.future;

finalize mark_market_invalid:
    input r0 as field.public;
    get markets[r0] into r1;
    is.eq r1.status 0u8 into r2;
    assert.eq r2 true;
    cast r1.id r1.creator r1.question r1.options r1.num_options r1.closing_block 3u8 r1.winning_option r1.total_pool r1.option_pools into r3 as Market;
    set r3 into markets[r0];

function claim_winnings:
    input r0 as BetRecord.record;
    cast r0.owner r0.market_id r0.nonce 0u64 into r1 as RewardReceipt.record;
    async claim_winnings r0.market_id r0.chosen_option r0.amount r0.nonce r0.owner into r2;
    output r1 as RewardReceipt.record;
    output r2 as prediction_market.aleo/claim_winnings.future;

finalize claim_winnings:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as address.public;
    get markets[r0] into r5;
    is.eq r5.status 1u8 into r6;
    is.eq r5.status 2u8 into r7;
    or r6 r7 into r8;
    is.eq r5.status 3u8 into r9;
    or r8 r9 into r10;
    assert.eq r10 true;
    get.or_use claimed_bets[r3] false into r11;
    not r11 into r12;
    assert.eq r12 true;
    set true into claimed_bets[r3];
    is.eq r5.status 1u8 into r13;
    branch.eq r13 false to end_then_0_2;
    is.eq r1 r5.winning_option into r14;
    assert.eq r14 true;
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;

function claim_refund:
    input r0 as BetRecord.record;
    cast r0.owner r0.market_id r0.nonce r0.amount into r1 as RewardReceipt.record;
    async claim_refund r0.market_id r0.amount r0.nonce into r2;
    output r1 as RewardReceipt.record;
    output r2 as prediction_market.aleo/claim_refund.future;

finalize claim_refund:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as field.public;
    get markets[r0] into r3;
    is.eq r3.status 2u8 into r4;
    assert.eq r4 true;
    get.or_use claimed_bets[r2] false into r5;
    not r5 into r6;
    assert.eq r6 true;
    set true into claimed_bets[r2];

function reveal_market_results:
    input r0 as field.private;
    async reveal_market_results r0 into r1;
    output r1 as prediction_market.aleo/reveal_market_results.future;

finalize reveal_market_results:
    input r0 as field.public;
    get markets[r0] into r1;

function withdraw_admin_fees:
    input r0 as u64.private;
    is.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj into r1;
    assert.eq r1 true;
    async withdraw_admin_fees r0 into r2;
    output r2 as prediction_market.aleo/withdraw_admin_fees.future;

finalize withdraw_admin_fees:
    input r0 as u64.public;
    get admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] into r1;
    gte r1 r0 into r2;
    assert.eq r2 true;
    sub r1 r0 into r3;
    set r3 into admin_fees[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function list_open_markets:
    async list_open_markets into r0;
    output r0 as prediction_market.aleo/list_open_markets.future;

finalize list_open_markets:
    get.or_use market_count[true] 0u8 into r0;
