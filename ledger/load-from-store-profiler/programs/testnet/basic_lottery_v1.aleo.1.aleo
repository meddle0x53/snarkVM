program basic_lottery_v1.aleo;

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

mapping participant_tickets:
    key as field.public;
    value as u64.public;

function create_lottery:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u64.private;
    async create_lottery r0 r1 r2 into r3;
    output r3 as basic_lottery_v1.aleo/create_lottery.future;

finalize create_lottery:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    set 0u64 into participants_count[r0];
    set 0u64 into winner_ticket[r0];
    cast r1 r2 into r3 as LotteryInfo;
    set r3 into lottery_data[r0];

function buy_ticket:
    input r0 as field.private;
    input r1 as address.private;
    cast r1 into r2 as LotteryTicket.record;
    async buy_ticket r0 r1 self.caller into r3;
    output r2 as LotteryTicket.record;
    output r3 as basic_lottery_v1.aleo/buy_ticket.future;

finalize buy_ticket:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    assert.eq r2 r1;
    get.or_use participants_count[r0] 0u64 into r3;
    add r3 1u64 into r4;
    set r4 into participants_count[r0];
    hash.bhp256 r1 into r5 as field;
    add r0 r5 into r6;
    hash.bhp256 r6 into r7 as field;
    set r4 into participant_tickets[r7];

function draw_winner:
    input r0 as field.private;
    async draw_winner r0 into r1;
    output r1 as basic_lottery_v1.aleo/draw_winner.future;

finalize draw_winner:
    input r0 as field.public;
    get.or_use participants_count[r0] 0u64 into r1;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    hash.bhp256 block.height into r3 as field;
    cast r3 into r4 as u64;
    rem r4 r1 into r5;
    add r5 1u64 into r6;
    set r6 into winner_ticket[r0];

function claim_prize:
    input r0 as field.private;
    input r1 as LotteryTicket.record;
    input r2 as u64.private;
    cast r1.owner r2 into r3 as PrizeToken.record;
    async claim_prize r0 r1.owner r2 into r4;
    output r3 as PrizeToken.record;
    output r4 as basic_lottery_v1.aleo/claim_prize.future;

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
