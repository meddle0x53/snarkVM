program prediction_market_uwu.aleo;

record Market:
    owner as address.private;
    question as field.private;
    end_time as u64.private;
    yes_pool as u64.private;
    no_pool as u64.private;
    is_resolved as boolean.private;
    outcome as boolean.private;

record Position:
    owner as address.private;
    market_id as field.private;
    yes_tokens as u64.private;
    no_tokens as u64.private;

mapping market_owners:
    key as field.public;
    value as address.public;

mapping market_questions:
    key as field.public;
    value as field.public;

mapping market_end_times:
    key as field.public;
    value as u64.public;

mapping market_yes_pools:
    key as field.public;
    value as u64.public;

mapping market_no_pools:
    key as field.public;
    value as u64.public;

mapping market_resolved:
    key as field.public;
    value as boolean.public;

mapping market_outcomes:
    key as field.public;
    value as boolean.public;

mapping market_count:
    key as boolean.public;
    value as u64.public;

mapping market_by_index:
    key as u64.public;
    value as field.public;

function create_market:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u64.private;
    input r3 as u64.private;
    assert.eq self.caller r0;
    cast r0 r1 r2 r3 r3 false false into r4 as Market.record;
    async create_market r1 r0 r2 r3 into r5;
    output r4 as Market.record;
    output r5 as prediction_market_uwu.aleo/create_market.future;

finalize create_market:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    set r1 into market_owners[r0];
    set r0 into market_questions[r0];
    set r2 into market_end_times[r0];
    set r3 into market_yes_pools[r0];
    set r3 into market_no_pools[r0];
    set false into market_resolved[r0];
    set false into market_outcomes[r0];
    get.or_use market_count[true] 0u64 into r4;
    set r0 into market_by_index[r4];
    add r4 1u64 into r5;
    set r5 into market_count[true];

function get_market_info:
    input r0 as field.private;
    async get_market_info r0 into r1;
    output r1 as prediction_market_uwu.aleo/get_market_info.future;

finalize get_market_info:
    input r0 as field.public;
    get market_owners[r0] into r1;
    get market_questions[r0] into r2;
    get market_end_times[r0] into r3;
    get market_yes_pools[r0] into r4;
    get market_no_pools[r0] into r5;
    get market_resolved[r0] into r6;
    get market_outcomes[r0] into r7;

function get_total_markets:
    async get_total_markets into r0;
    output r0 as prediction_market_uwu.aleo/get_total_markets.future;

finalize get_total_markets:
    get.or_use market_count[true] 0u64 into r0;

function get_market_by_index:
    input r0 as u64.private;
    async get_market_by_index r0 into r1;
    output r1 as prediction_market_uwu.aleo/get_market_by_index.future;

finalize get_market_by_index:
    input r0 as u64.public;
    get market_by_index[r0] into r1;
    get market_owners[r1] into r2;
    get market_questions[r1] into r3;
    get market_end_times[r1] into r4;
    get market_yes_pools[r1] into r5;
    get market_no_pools[r1] into r6;
    get market_resolved[r1] into r7;
    get market_outcomes[r1] into r8;

function buy_yes_tokens:
    input r0 as Market.record;
    input r1 as Position.record;
    input r2 as u64.private;
    assert.eq r0.is_resolved false;
    mul r0.yes_pool r0.no_pool into r3;
    add r0.yes_pool r2 into r4;
    mul r2 r0.no_pool into r5;
    div r5 r4 into r6;
    sub r0.no_pool r6 into r7;
    cast r0.owner r0.question r0.end_time r4 r7 r0.is_resolved r0.outcome into r8 as Market.record;
    add r1.yes_tokens r6 into r9;
    cast r1.owner r1.market_id r9 r1.no_tokens into r10 as Position.record;
    sub r0.no_pool r6 into r11;
    async buy_yes_tokens r0.question r4 r11 into r12;
    output r8 as Market.record;
    output r10 as Position.record;
    output r12 as prediction_market_uwu.aleo/buy_yes_tokens.future;

finalize buy_yes_tokens:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u64.public;
    set r1 into market_yes_pools[r0];
    set r2 into market_no_pools[r0];

function buy_no_tokens:
    input r0 as Market.record;
    input r1 as Position.record;
    input r2 as u64.private;
    assert.eq r0.is_resolved false;
    mul r0.yes_pool r0.no_pool into r3;
    add r0.no_pool r2 into r4;
    mul r2 r0.yes_pool into r5;
    div r5 r4 into r6;
    sub r0.yes_pool r6 into r7;
    cast r0.owner r0.question r0.end_time r7 r4 r0.is_resolved r0.outcome into r8 as Market.record;
    add r1.no_tokens r6 into r9;
    cast r1.owner r1.market_id r1.yes_tokens r9 into r10 as Position.record;
    sub r0.yes_pool r6 into r11;
    async buy_no_tokens r0.question r11 r4 into r12;
    output r8 as Market.record;
    output r10 as Position.record;
    output r12 as prediction_market_uwu.aleo/buy_no_tokens.future;

finalize buy_no_tokens:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u64.public;
    set r1 into market_yes_pools[r0];
    set r2 into market_no_pools[r0];

function resolve_market:
    input r0 as Market.record;
    input r1 as boolean.private;
    assert.eq self.caller r0.owner;
    assert.eq r0.is_resolved false;
    cast r0.owner r0.question r0.end_time r0.yes_pool r0.no_pool true r1 into r2 as Market.record;
    async resolve_market r0.question r1 into r3;
    output r2 as Market.record;
    output r3 as prediction_market_uwu.aleo/resolve_market.future;

finalize resolve_market:
    input r0 as field.public;
    input r1 as boolean.public;
    set true into market_resolved[r0];
    set r1 into market_outcomes[r0];

function claim_yes_winnings:
    input r0 as Market.record;
    input r1 as Position.record;
    assert.eq r0.is_resolved true;
    assert.eq r0.outcome true;
    cast r1.owner r1.market_id 0u64 r1.no_tokens into r2 as Position.record;
    cast r0.owner r0.question r0.end_time r0.yes_pool r0.no_pool r0.is_resolved r0.outcome into r3 as Market.record;
    output r3 as Market.record;
    output r2 as Position.record;

function claim_no_winnings:
    input r0 as Market.record;
    input r1 as Position.record;
    assert.eq r0.is_resolved true;
    assert.eq r0.outcome false;
    cast r1.owner r1.market_id r1.yes_tokens 0u64 into r2 as Position.record;
    cast r0.owner r0.question r0.end_time r0.yes_pool r0.no_pool r0.is_resolved r0.outcome into r3 as Market.record;
    output r3 as Market.record;
    output r2 as Position.record;
