import credits.aleo;

program raize_market_maker.aleo;

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
    outcome1_shares as u64;
    outcome2_shares as u64;
    outcome1_pool as u64;
    outcome2_pool as u64;
    is_settled as boolean;
    winning_outcome as u8;

mapping markets:
    key as u64.public;
    value as Market.public;

mapping market_count:
    key as field.public;
    value as u64.public;

mapping is_admin:
    key as address.public;
    value as boolean.public;

function create_market:
    input r0 as Market.private;
    async create_market r0 self.caller into r1;
    output r1 as raize_market_maker.aleo/create_market.future;

finalize create_market:
    input r0 as Market.public;
    input r1 as address.public;
    get.or_use is_admin[r1] false into r2;
    assert.eq r2 true;
    get.or_use market_count[0field] 0u64 into r3;
    cast r3 into r4 as u64;
    add r4 1u64 into r5;
    cast r5 r0.name r0.description r0.category r0.image r0.outcome_1 r0.outcome_2 0u64 0u64 0u64 0u64 false 0u8 into r6 as Market;
    set r6 into markets[r5];
    set r5 into market_count[0field];

function place_bet:
    input r0 as u64.private;
    input r1 as u8.private;
    input r2 as u64.private;
    cast raize_market_maker.aleo into r3 as address;
    call credits.aleo/transfer_public_as_signer r3 r2 into r4;
    async place_bet r4 r0 r1 r2 into r5;
    output r5 as raize_market_maker.aleo/place_bet.future;

finalize place_bet:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as u64.public;
    input r2 as u8.public;
    input r3 as u64.public;
    await r0;
    get markets[r1] into r4;
    not r4.is_settled into r5;
    assert.eq r5 true;
    is.eq r2 1u8 into r6;
    is.eq r2 2u8 into r7;
    or r6 r7 into r8;
    assert.eq r8 true;
    is.eq r2 1u8 into r9;
    branch.eq r9 false to end_then_0_0;
    add r4.outcome1_pool r3 into r10;
    add r4.outcome1_shares r3 into r11;
    cast r4.market_id r4.name r4.description r4.category r4.image r4.outcome_1 r4.outcome_2 r11 r4.outcome2_shares r10 r4.outcome2_pool r4.is_settled r4.winning_outcome into r12 as Market;
    set r12 into markets[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    add r4.outcome2_pool r3 into r13;
    add r4.outcome2_shares r3 into r14;
    cast r4.market_id r4.name r4.description r4.category r4.image r4.outcome_1 r4.outcome_2 r4.outcome1_shares r14 r4.outcome1_pool r13 r4.is_settled r4.winning_outcome into r15 as Market;
    set r15 into markets[r1];
    position end_otherwise_0_1;

function settle_market:
    input r0 as u64.private;
    input r1 as u8.private;
    async settle_market r0 r1 self.caller into r2;
    output r2 as raize_market_maker.aleo/settle_market.future;

finalize settle_market:
    input r0 as u64.public;
    input r1 as u8.public;
    input r2 as address.public;
    get markets[r0] into r3;
    get.or_use is_admin[r2] false into r4;
    assert.eq r4 true;
    not r3.is_settled into r5;
    assert.eq r5 true;
    is.eq r1 1u8 into r6;
    is.eq r1 2u8 into r7;
    or r6 r7 into r8;
    assert.eq r8 true;
    cast r3.market_id r3.name r3.description r3.category r3.image r3.outcome_1 r3.outcome_2 r3.outcome1_shares r3.outcome2_shares r3.outcome1_pool r3.outcome2_pool true r1 into r9 as Market;
    set r9 into markets[r0];
