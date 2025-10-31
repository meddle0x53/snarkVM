program basic_lottery_v3.aleo;

struct LotteryInfo:
    description as field;
    prize_amount as u64;
    total_pool as u64;
    is_drawn as boolean;

record LotteryTicket:
    owner as address.private;
    lottery_id as field.private;
    amount as u64.private;

record token:
    owner as address.private;
    amount as u64.private;

struct KeyInput:
    lottery_id as field;
    user as address;

mapping lottery_data:
    key as field.public;
    value as LotteryInfo.public;

mapping ticket_count:
    key as field.public;
    value as u64.public;

mapping participant_tickets:
    key as field.public;
    value as u64.public;

mapping winner_ticket:
    key as field.public;
    value as u64.public;

mapping prize_claimed:
    key as field.public;
    value as boolean.public;

mapping token_pool:
    key as field.public;
    value as u64.public;

mapping account:
    key as address.public;
    value as u64.public;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 into r2 as token.record;
    async mint_public r0 r1 into r3;
    output r2 as token.record;
    output r3 as basic_lottery_v3.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];

function create_lottery:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u64.private;
    async create_lottery r0 r1 r2 into r3;
    output r3 as basic_lottery_v3.aleo/create_lottery.future;

finalize create_lottery:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    cast r1 r2 0u64 false into r3 as LotteryInfo;
    set r3 into lottery_data[r0];
    set 0u64 into ticket_count[r0];
    set 0u64 into token_pool[r0];

function buy_ticket:
    input r0 as field.private;
    input r1 as token.record;
    input r2 as u64.private;
    assert.eq r1.owner self.caller;
    gte r1.amount r2 into r3;
    assert.eq r3 true;
    sub r1.amount r2 into r4;
    cast self.caller r4 into r5 as token.record;
    cast self.caller r0 r2 into r6 as LotteryTicket.record;
    output r6 as LotteryTicket.record;
    output r5 as token.record;

function register_ticket:
    input r0 as field.private;
    input r1 as LotteryTicket.record;
    input r2 as u64.private;
    assert.eq r1.owner self.caller;
    async register_ticket r0 self.caller r2 into r3;
    output r3 as basic_lottery_v3.aleo/register_ticket.future;

finalize register_ticket:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use ticket_count[r0] 0u64 into r3;
    add r3 1u64 into r4;
    cast r0 r1 into r5 as KeyInput;
    hash.bhp256 r5 into r6 as field;
    set r4 into participant_tickets[r6];
    get.or_use token_pool[r0] 0u64 into r7;
    add r7 r2 into r8;
    set r8 into token_pool[r0];
    get lottery_data[r0] into r9;
    add r9.total_pool r2 into r10;
    cast r9.description r9.prize_amount r10 r9.is_drawn into r11 as LotteryInfo;
    set r11 into lottery_data[r0];
    set r4 into ticket_count[r0];

function draw_winner:
    input r0 as field.private;
    async draw_winner r0 into r1;
    output r1 as basic_lottery_v3.aleo/draw_winner.future;

finalize draw_winner:
    input r0 as field.public;
    get lottery_data[r0] into r1;
    not r1.is_drawn into r2;
    assert.eq r2 true;
    get ticket_count[r0] into r3;
    gt r3 0u64 into r4;
    assert.eq r4 true;
    cast block.height into r5 as u64;
    hash.bhp256 r5 into r6 as field;
    cast r6 into r7 as u64;
    rem r7 r3 into r8;
    add r8 1u64 into r9;
    set r9 into winner_ticket[r0];
    cast r1.description r1.prize_amount r1.total_pool true into r10 as LotteryInfo;
    set r10 into lottery_data[r0];

function claim_prize:
    input r0 as field.private;
    input r1 as LotteryTicket.record;
    input r2 as u64.private;
    assert.eq r1.owner self.caller;
    cast self.caller r2 into r3 as token.record;
    async claim_prize r0 self.caller r2 into r4;
    output r3 as token.record;
    output r4 as basic_lottery_v3.aleo/claim_prize.future;

finalize claim_prize:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u64.public;
    get lottery_data[r0] into r3;
    assert.eq r3.is_drawn true;
    assert.eq r3.prize_amount r2;
    get.or_use prize_claimed[r0] false into r4;
    not r4 into r5;
    assert.eq r5 true;
    cast r0 r1 into r6 as KeyInput;
    hash.bhp256 r6 into r7 as field;
    get participant_tickets[r7] into r8;
    get winner_ticket[r0] into r9;
    assert.eq r8 r9;
    get token_pool[r0] into r10;
    gte r10 r3.prize_amount into r11;
    assert.eq r11 true;
    sub r10 r3.prize_amount into r12;
    set r12 into token_pool[r0];
    set true into prize_claimed[r0];
