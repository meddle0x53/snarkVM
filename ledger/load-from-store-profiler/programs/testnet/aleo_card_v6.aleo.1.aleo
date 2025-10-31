program aleo_card_v6.aleo;

record card:
    owner as address.private;
    number as u64.private;
    cvv as u8.private;
    amt as u64.private;

struct CardDATA:
    card_owner as address;
    food as u64;
    travel as u64;
    estate as u64;
    stocks as u64;

struct ITEM_ID:
    food_id as u64;
    travel_id as u64;
    estate_id as u64;
    stocks_id as u64;

struct GlobalState:
    next_token_id as field;
    admin as address;

struct TestToken:
    name as field;
    symbol as field;
    decimals as u8;
    faucet_circulating_supply as u64;
    faucet_total_supply as u64;
    admin as address;

mapping account:
    key as address.public;
    value as u64.public;

mapping asset_owner:
    key as address.public;
    value as u32.public;

mapping card_data:
    key as u64.public;
    value as CardDATA.public;

mapping item_id:
    key as u64.public;
    value as ITEM_ID.public;

mapping global_state:
    key as boolean.public;
    value as GlobalState.public;

mapping test_token:
    key as u64.public;
    value as TestToken.public;

function init:
    input r0 as boolean.private;
    async init self.caller into r1;
    output self.caller as address.private;
    output r1 as aleo_card_v6.aleo/init.future;

finalize init:
    input r0 as address.public;
    cast 0field aleo1jqr7wrn8554wg55sc4hp24sdtthnrmm8ugvxjux7r6tthu9mnvyqmue050 into r1 as GlobalState;
    get.or_use global_state[true] r1 into r2;
    assert.eq r2.next_token_id 0field;
    assert.eq r0 r2.admin;
    cast 1field r2.admin into r3 as GlobalState;
    set r3 into global_state[true];
    get.or_use account[r0] 0u64 into r4;
    is.eq r4 0u64 into r5;
    assert.eq r5 true;
    add r4 6000000u64 into r6;
    set r6 into account[r0];
    add 0u64 6000000u64 into r7;
    cast 4577111110111112111108121field 4577111110111112111108121field 6u8 r7 10000000u64 r2.admin into r8 as TestToken;
    set r8 into test_token[10000000u64];

function change_admin:
    input r0 as address.private;
    async change_admin self.caller into r1;
    output r0 as address.private;
    output r1 as aleo_card_v6.aleo/change_admin.future;

finalize change_admin:
    input r0 as address.public;
    get global_state[true] into r1;
    assert.eq r0 r1.admin;
    cast r1.next_token_id r0 into r2 as GlobalState;
    set r2 into global_state[true];

function generate_card:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u8.private;
    assert.eq self.caller r0;
    hash.bhp256 r0 into r3 as field;
    hash.bhp256 r0 into r4 as u64;
    hash.bhp256 r2 into r5 as u8;
    cast r0 r4 r5 0u64 into r6 as card.record;
    output r6 as card.record;

function get_faucet:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u8.private;
    assert.eq self.caller r0;
    hash.bhp256 r0 into r3 as u64;
    hash.bhp256 r0 into r4 as u8;
    cast r0 r3 r4 1000u64 into r5 as card.record;
    async get_faucet r0 1000u64 into r6;
    output r5 as card.record;
    output r6 as aleo_card_v6.aleo/get_faucet.future;

finalize get_faucet:
    input r0 as address.public;
    input r1 as u64.public;
    cast 4577111110111112111108121field 4577111110111112111108121field 6u8 0u64 0u64 aleo1jqr7wrn8554wg55sc4hp24sdtthnrmm8ugvxjux7r6tthu9mnvyqmue050 into r2 as TestToken;
    get.or_use test_token[10000000u64] r2 into r3;
    get account[r0] into r4;
    or r4 0u64 into r5;
    assert.eq r5 0u64;
    lte r3.faucet_circulating_supply 4000000u64 into r6;
    assert.eq r6 true;
    get.or_use account[r0] 0u64 into r7;
    add r7 r1 into r8;
    set r8 into account[r0];
    add r3.faucet_circulating_supply r1 into r9;
    cast r3.name r3.symbol r3.decimals r9 r3.faucet_total_supply r3.admin into r10 as TestToken;
    set r10 into test_token[10000000u64];

function purchasing_estate:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u8.private;
    assert.eq self.caller r0;
    async purchasing_estate r0 r1 r2 into r3;
    output r3 as aleo_card_v6.aleo/purchasing_estate.future;

finalize purchasing_estate:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u8.public;
    get account[r0] into r3;
    or r3 0u64 into r4;
    assert.neq r4 0u64;
    cast r0 0u64 0u64 0u64 0u64 into r5 as CardDATA;
    get.or_use card_data[r1] r5 into r6;
    cast 0u64 0u64 0u64 0u64 into r7 as ITEM_ID;
    get.or_use item_id[r1] r7 into r8;
    hash.bhp256 r0 into r9 as u64;
    add r9 10111511697116101u64 into r10;
    hash.bhp256 r10 into r11 as u64;
    sub r4 500u64 into r12;
    set r12 into account[r0];
    add r6.estate 500u64 into r13;
    cast r0 r6.food r6.travel r13 r6.stocks into r14 as CardDATA;
    set r14 into card_data[r1];
    cast r8.food_id r8.travel_id r11 r8.stocks_id into r15 as ITEM_ID;
    set r15 into item_id[r1];

function send_estate_asset:
    input r0 as address.private;
    input r1 as u64.private;
    async send_estate_asset self.caller r0 r1 into r2;
    output r2 as aleo_card_v6.aleo/send_estate_asset.future;

finalize send_estate_asset:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    assert.neq r0 r1;
    hash.bhp256 r0 into r3 as u64;
    hash.bhp256 r1 into r4 as u64;
    cast 0u64 0u64 0u64 0u64 into r5 as ITEM_ID;
    get.or_use item_id[r2] r5 into r6;
    is.eq r6.estate_id r2 into r7;
    assert.eq r7 true;
    add r3 10111511697116101u64 into r8;
    hash.bhp256 r8 into r9 as u64;
    cast r6.food_id r6.travel_id r9 r6.stocks_id into r10 as ITEM_ID;
    set r10 into item_id[r4];
    remove item_id[r3];
