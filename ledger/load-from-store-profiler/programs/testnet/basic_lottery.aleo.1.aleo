program basic_lottery.aleo;

record LotteryTicket:
    owner as address.private;
    ticket_number as u64.private;

record PrizeToken:
    owner as address.private;
    amount as u64.private;

mapping participants_count:
    key as field.public;
    value as u64.public;

mapping winner_ticket:
    key as field.public;
    value as u64.public;

mapping participant_tickets:
    key as field.public;
    value as u64.public;

function create_lottery:
    input r0 as field.private;
    async create_lottery r0 into r1;
    output r1 as basic_lottery.aleo/create_lottery.future;

finalize create_lottery:
    input r0 as field.public;
    set 0u64 into participants_count[r0];
    set 0u64 into winner_ticket[r0];

function buy_ticket:
    input r0 as field.private;
    input r1 as address.private;
    cast r1 0u64 into r2 as LotteryTicket.record;
    async buy_ticket r0 r1 self.caller into r3;
    output r2 as LotteryTicket.record;
    output r3 as basic_lottery.aleo/buy_ticket.future;

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
    output r1 as basic_lottery.aleo/draw_winner.future;

finalize draw_winner:
    input r0 as field.public;
    get.or_use participants_count[r0] 0u64 into r1;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    cast block.height into r3 as u64;
    rem r3 r1 into r4;
    add r4 1u64 into r5;
    set r5 into winner_ticket[r0];

function claim_prize:
    input r0 as field.private;
    input r1 as LotteryTicket.record;
    input r2 as u64.private;
    cast r1.owner r2 into r3 as PrizeToken.record;
    async claim_prize r0 r1.ticket_number r1.owner r2 into r4;
    output r3 as PrizeToken.record;
    output r4 as basic_lottery.aleo/claim_prize.future;

finalize claim_prize:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as address.public;
    input r3 as u64.public;
    get.or_use winner_ticket[r0] 0u64 into r4;
    assert.eq r1 r4;
