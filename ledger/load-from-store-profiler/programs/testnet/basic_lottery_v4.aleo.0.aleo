program basic_lottery_v4.aleo;

struct LotteryInfo:
    description as field;
    prize_amount as u64;
    total_pool as u64;
    is_drawn as boolean;
    ticket_price as u64;

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

mapping lottery_admin:
    key as field.public;
    value as address.public;

mapping max_participants:
    key as field.public;
    value as u64.public;

mapping has_submitted:
    key as address.public;
    value as boolean.public;

mapping submission_ended:
    key as field.public;
    value as boolean.public;

mapping combined_seed_hash:
    key as field.public;
    value as field.public;

mapping seed_count:
    key as field.public;
    value as u64.public;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 into r2 as token.record;
    async mint_public r0 r1 into r3;
    output r2 as token.record;
    output r3 as basic_lottery_v4.aleo/mint_public.future;

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
    input r3 as u64.private;
    input r4 as u64.private;
    gt r4 0u64 into r5;
    assert.eq r5 true;
    gt r3 0u64 into r6;
    assert.eq r6 true;
    gt r2 0u64 into r7;
    assert.eq r7 true;
    async create_lottery r0 r1 r2 r3 r4 self.caller into r8;
    output r8 as basic_lottery_v4.aleo/create_lottery.future;

finalize create_lottery:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    input r5 as address.public;
    cast r1 r2 0u64 false r4 into r6 as LotteryInfo;
    contains lottery_data[r0] into r7;
    not r7 into r8;
    assert.eq r8 true;
    set r6 into lottery_data[r0];
    set 0u64 into ticket_count[r0];
    set 0u64 into token_pool[r0];
    set r5 into lottery_admin[r0];
    set r3 into max_participants[r0];
    set 0u64 into seed_count[r0];
    set false into submission_ended[r0];
    set 0field into combined_seed_hash[r0];

function buy_ticket:
    input r0 as field.private;
    input r1 as token.record;
    input r2 as u64.private;
    assert.eq r1.owner self.caller;
    gte r1.amount r2 into r3;
    assert.eq r3 true;
    gt r2 0u64 into r4;
    assert.eq r4 true;
    cast self.caller r0 r2 into r5 as LotteryTicket.record;
    sub r1.amount r2 into r6;
    cast self.caller r6 into r7 as token.record;
    async buy_ticket r0 self.caller r1.amount r6 r2 into r8;
    output r5 as LotteryTicket.record;
    output r8 as basic_lottery_v4.aleo/buy_ticket.future;

finalize buy_ticket:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    contains lottery_data[r0] into r5;
    assert.eq r5 true;
    get lottery_data[r0] into r6;
    not r6.is_drawn into r7;
    assert.eq r7 true;
    assert.eq r4 r6.ticket_price;
    get.or_use account[r1] 0u64 into r8;
    gte r8 r2 into r9;
    assert.eq r9 true;
    sub r8 r2 into r10;
    add r10 r3 into r11;
    set r11 into account[r1];

function register_ticket:
    input r0 as field.private;
    input r1 as LotteryTicket.record;
    input r2 as u64.private;
    assert.eq r1.owner self.caller;
    assert.eq r1.lottery_id r0;
    assert.eq r1.amount r2;
    async register_ticket r0 self.caller r2 into r3;
    output r3 as basic_lottery_v4.aleo/register_ticket.future;

finalize register_ticket:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use has_submitted[r1] false into r3;
    assert.eq r3 true;
    contains lottery_data[r0] into r4;
    assert.eq r4 true;
    get.or_use ticket_count[r0] 0u64 into r5;
    get max_participants[r0] into r6;
    lt r5 r6 into r7;
    assert.eq r7 true;
    add r5 1u64 into r8;
    cast r0 r1 into r9 as KeyInput;
    hash.bhp256 r9 into r10 as field;
    set r8 into participant_tickets[r10];
    get.or_use token_pool[r0] 0u64 into r11;
    add r11 r2 into r12;
    set r12 into token_pool[r0];
    get lottery_data[r0] into r13;
    not r13.is_drawn into r14;
    assert.eq r14 true;
    add r13.total_pool r2 into r15;
    cast r13.description r13.prize_amount r15 r13.is_drawn r13.ticket_price into r16 as LotteryInfo;
    set r16 into lottery_data[r0];
    set r8 into ticket_count[r0];

function submit_seed:
    input r0 as field.private;
    input r1 as field.private;
    async submit_seed r0 self.caller r1 into r2;
    output r2 as basic_lottery_v4.aleo/submit_seed.future;

finalize submit_seed:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    get.or_use submission_ended[r0] false into r3;
    not r3 into r4;
    assert.eq r4 true;
    get.or_use has_submitted[r1] false into r5;
    not r5 into r6;
    assert.eq r6 true;
    get.or_use seed_count[r0] 0u64 into r7;
    get max_participants[r0] into r8;
    lt r7 r8 into r9;
    assert.eq r9 true;
    get.or_use combined_seed_hash[r0] 0field into r10;
    add r10 r2 into r11;
    hash.psd2 r11 into r12 as field;
    set r12 into combined_seed_hash[r0];
    add r7 1u64 into r13;
    set r13 into seed_count[r0];
    set true into has_submitted[r1];

function end_submission_phase:
    input r0 as field.private;
    async end_submission_phase r0 self.caller into r1;
    output r1 as basic_lottery_v4.aleo/end_submission_phase.future;

finalize end_submission_phase:
    input r0 as field.public;
    input r1 as address.public;
    get lottery_admin[r0] into r2;
    assert.eq r1 r2;
    set true into submission_ended[r0];

function draw_winner:
    input r0 as field.private;
    async draw_winner r0 self.caller into r1;
    output r1 as basic_lottery_v4.aleo/draw_winner.future;

finalize draw_winner:
    input r0 as field.public;
    input r1 as address.public;
    get lottery_admin[r0] into r2;
    assert.eq r1 r2;
    get lottery_data[r0] into r3;
    not r3.is_drawn into r4;
    assert.eq r4 true;
    get.or_use submission_ended[r0] false into r5;
    assert.eq r5 true;
    get ticket_count[r0] into r6;
    gt r6 0u64 into r7;
    assert.eq r7 true;
    rem block.height 10000u32 into r8;
    cast r8 into r9 as field;
    hash.bhp256 r9 into r10 as field;
    get combined_seed_hash[r0] into r11;
    add r11 r10 into r12;
    hash.bhp256 r12 into r13 as u64;
    cast r6 into r14 as u64;
    rem r13 r14 into r15;
    cast r15 into r16 as u64;
    add r16 1u64 into r17;
    set r17 into winner_ticket[r0];
    cast r3.description r3.prize_amount r3.total_pool true r3.ticket_price into r18 as LotteryInfo;
    set r18 into lottery_data[r0];

function claim_prize:
    input r0 as field.private;
    input r1 as LotteryTicket.record;
    input r2 as u64.private;
    assert.eq r1.owner self.caller;
    cast self.caller r2 into r3 as token.record;
    async claim_prize r0 self.caller r2 into r4;
    output r3 as token.record;
    output r4 as basic_lottery_v4.aleo/claim_prize.future;

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
    get.or_use account[r1] 0u64 into r13;
    add r13 r2 into r14;
    set r14 into account[r1];
