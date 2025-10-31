program basic_lottery_v2.aleo;

struct LotteryInfo:
    description as field;
    prize_amount as u64;

record LotteryTicket:
    owner as address.private;

record PrizeToken:
    owner as address.private;
    amount as u64.private;

mapping participants_count:
    key as field.public;
    value as u64.public;

mapping winner_ticket:
    key as field.public;
    value as u64.public;

mapping lottery_data:
    key as field.public;
    value as LotteryInfo.public;

mapping lottery_pool:
    key as field.public;
    value as u64.public;

mapping participant_tickets:
    key as field.public;
    value as u64.public;

function create_lottery:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u64.private;
    async create_lottery r0 r1 r2 into r3;
    output r3 as basic_lottery_v2.aleo/create_lottery.future;

finalize create_lottery:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    set 0u64 into participants_count[r0];
    set 0u64 into winner_ticket[r0];
    cast r1 r2 into r3 as LotteryInfo;
    set r3 into lottery_data[r0];
    set 0u64 into lottery_pool[r0];

function buy_ticket:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as PrizeToken.record;
    input r3 as u64.private;
    assert.eq self.caller r1;
    assert.eq r2.owner r1;
    gte r2.amount r3 into r4;
    assert.eq r4 true;
    cast r1 into r5 as LotteryTicket.record;
    sub r2.amount r3 into r6;
    cast r1 r6 into r7 as PrizeToken.record;
    async buy_ticket r0 r1 self.caller r3 into r8;
    output r5 as LotteryTicket.record;
    output r7 as PrizeToken.record;
    output r8 as basic_lottery_v2.aleo/buy_ticket.future;

finalize buy_ticket:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as u64.public;
    assert.eq r2 r1;
    get.or_use participants_count[r0] 0u64 into r4;
    add r4 1u64 into r5;
    set r5 into participants_count[r0];
    hash.bhp256 r1 into r6 as field;
    add r0 r6 into r7;
    hash.bhp256 r7 into r8 as field;
    set r5 into participant_tickets[r8];
    get.or_use lottery_pool[r0] 0u64 into r9;
    add r9 r3 into r10;
    set r10 into lottery_pool[r0];

function draw_winner:
    input r0 as field.private;
    async draw_winner r0 into r1;
    output r1 as basic_lottery_v2.aleo/draw_winner.future;

finalize draw_winner:
    input r0 as field.public;
    get.or_use participants_count[r0] 0u64 into r1;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    cast block.height into r3 as u64;
    hash.bhp256 r3 into r4 as field;
    cast r4 into r5 as u64;
    rem r5 r1 into r6;
    add r6 1u64 into r7;
    set r7 into winner_ticket[r0];

function claim_prize:
    input r0 as field.private;
    input r1 as LotteryTicket.record;
    input r2 as u64.private;
    cast r1.owner r2 into r3 as PrizeToken.record;
    async claim_prize r0 r1.owner r2 into r4;
    output r3 as PrizeToken.record;
    output r4 as basic_lottery_v2.aleo/claim_prize.future;

finalize claim_prize:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u64.public;
    hash.bhp256 r1 into r3 as field;
    add r0 r3 into r4;
    hash.bhp256 r4 into r5 as field;
    get participant_tickets[r5] into r6;
    get.or_use winner_ticket[r0] 0u64 into r7;
    get lottery_data[r0] into r8;
    is.eq r2 r8.prize_amount into r9;
    assert.eq r9 true;
    is.eq r6 r7 into r10;
    assert.eq r10 true;
    get.or_use lottery_pool[r0] 0u64 into r11;
    gte r11 r2 into r12;
    assert.eq r12 true;
    sub r11 r2 into r13;
    set r13 into lottery_pool[r0];
