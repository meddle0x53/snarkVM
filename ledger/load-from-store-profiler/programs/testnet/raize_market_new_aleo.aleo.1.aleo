import credits.aleo;

program raize_market_new_aleo.aleo;

struct Outcome:
    name as field;
    description as field;
    image as field;
    category as field;

struct Market:
    market_id as u64;
    name as field;
    description as field;
    category as field;
    image as field;
    outcome_1 as Outcome;
    outcome_2 as Outcome;
    outcome1_pool as u64;
    outcome2_pool as u64;
    is_settled as boolean;
    winning_outcome as u8;

record Bet:
    owner as address.private;
    market_id as u64.private;
    outcome as u8.private;
    amount_paid as u64.private;

mapping markets:
    key as u64.public;
    value as Market.public;

mapping market_count:
    key as field.public;
    value as u64.public;

mapping is_admin:
    key as address.public;
    value as boolean.public;

mapping user_winnings:
    key as address.public;
    value as u64.public;

function create_market:
    input r0 as Market.private;
    async create_market r0 self.caller into r1;
    output r1 as raize_market_new_aleo.aleo/create_market.future;

finalize create_market:
    input r0 as Market.public;
    input r1 as address.public;
    get.or_use market_count[0field] 0u64 into r2;
    cast r2 into r3 as u64;
    add r3 1u64 into r4;
    cast r4 r0.name r0.description r0.category r0.image r0.outcome_1 r0.outcome_2 0u64 0u64 false 0u8 into r5 as Market;
    set r5 into markets[r4];
    set r4 into market_count[0field];

function place_bet:
    input r0 as u64.private;
    input r1 as u8.private;
    input r2 as u64.private;
    cast raize_market_new_aleo.aleo into r3 as address;
    call credits.aleo/transfer_public_as_signer r3 r2 into r4;
    cast self.caller r0 r1 r2 into r5 as Bet.record;
    async place_bet r4 r0 r1 r2 self.caller into r6;
    output r5 as Bet.record;
    output r6 as raize_market_new_aleo.aleo/place_bet.future;

finalize place_bet:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as u64.public;
    input r2 as u8.public;
    input r3 as u64.public;
    input r4 as address.public;
    await r0;
    get markets[r1] into r5;
    not r5.is_settled into r6;
    assert.eq r6 true;
    is.eq r2 1u8 into r7;
    is.eq r2 2u8 into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    is.eq r2 1u8 into r10;
    branch.eq r10 false to end_then_0_0;
    add r5.outcome1_pool r3 into r11;
    cast r5.market_id r5.name r5.description r5.category r5.image r5.outcome_1 r5.outcome_2 r11 r5.outcome2_pool r5.is_settled r5.winning_outcome into r12 as Market;
    set r12 into markets[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    add r5.outcome2_pool r3 into r13;
    cast r5.market_id r5.name r5.description r5.category r5.image r5.outcome_1 r5.outcome_2 r5.outcome1_pool r13 r5.is_settled r5.winning_outcome into r14 as Market;
    set r14 into markets[r1];
    position end_otherwise_0_1;

function settle_market:
    input r0 as u64.private;
    input r1 as u8.private;
    async settle_market r0 r1 self.caller into r2;
    output r2 as raize_market_new_aleo.aleo/settle_market.future;

finalize settle_market:
    input r0 as u64.public;
    input r1 as u8.public;
    input r2 as address.public;
    get markets[r0] into r3;
    not r3.is_settled into r4;
    assert.eq r4 true;
    is.eq r1 1u8 into r5;
    is.eq r1 2u8 into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    cast r3.market_id r3.name r3.description r3.category r3.image r3.outcome_1 r3.outcome_2 r3.outcome1_pool r3.outcome2_pool true r1 into r8 as Market;
    set r8 into markets[r0];

function set_user_winnings:
    input r0 as Bet.record;
    async set_user_winnings r0.market_id r0.outcome r0.amount_paid self.caller into r1;
    output r1 as raize_market_new_aleo.aleo/set_user_winnings.future;

finalize set_user_winnings:
    input r0 as u64.public;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as address.public;
    get markets[r0] into r4;
    assert.eq r4.is_settled true;
    is.eq r1 r4.winning_outcome into r5;
    assert.eq r5 true;
    add r4.outcome1_pool r4.outcome2_pool into r6;
    is.eq r1 1u8 into r7;
    ternary r7 r4.outcome1_pool r4.outcome2_pool into r8;
    mul r6 r2 into r9;
    div r9 r8 into r10;
    get.or_use user_winnings[r3] 0u64 into r11;
    add r10 r11 into r12;
    set r12 into user_winnings[r3];

function claim_winnings:
    input r0 as u64.private;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async claim_winnings r1 self.caller into r2;
    output r2 as raize_market_new_aleo.aleo/claim_winnings.future;

finalize claim_winnings:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    await r0;
    set 0u64 into user_winnings[r1];
