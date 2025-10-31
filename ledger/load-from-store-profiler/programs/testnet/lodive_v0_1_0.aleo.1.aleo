import credits.aleo;

program lodive_v0_1_0.aleo;

record Tickets:
    owner as address.private;
    event_id as field.private;
    num_tickets as u32.private;
    ticket_price as u64.private;

record TicketRedemption:
    owner as address.private;
    receipt_code as scalar.private;

struct Venue:
    id as field;
    commission_rate as u8;
    venue_owner as field;

struct Event:
    id as field;
    venue_id as field;
    ticket_supply as u32;
    initial_ticket_supply as u32;
    ticket_price as u64;
    redeemed_tickets as u32;
    is_ended as boolean;
    is_refunded as boolean;
    is_verified as boolean;
    event_owner as field;
    is_in_progress as boolean;

struct TicketHolder:
    event_id as field;
    owner_hash as field;

mapping venues:
    key as field.public;
    value as Venue.public;

mapping events:
    key as field.public;
    value as Event.public;

mapping payouts:
    key as field.public;
    value as u64.public;

mapping redemptions:
    key as field.public;
    value as u32.public;

mapping tickets_sold:
    key as TicketHolder.public;
    value as u32.public;

function register_venue:
    input r0 as field.private;
    input r1 as u8.private;
    hash.bhp1024 self.caller into r2 as field;
    cast r0 r1 r2 into r3 as Venue;
    async register_venue r3 into r4;
    output r4 as lodive_v0_1_0.aleo/register_venue.future;

finalize register_venue:
    input r0 as Venue.public;
    contains venues[r0.id] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into venues[r0.id];
    contains payouts[r0.venue_owner] into r3;
    not r3 into r4;
    branch.eq r4 false to end_then_0_0;
    set 0u64 into payouts[r0.venue_owner];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function register_event:
    input r0 as field.private;
    input r1 as u32.private;
    input r2 as u64.private;
    input r3 as field.private;
    input r4 as field.private;
    cast r0 r3 r1 r1 r2 0u32 false false false r4 false into r5 as Event;
    hash.bhp1024 self.caller into r6 as field;
    async register_event r5 r6 into r7;
    output r7 as lodive_v0_1_0.aleo/register_event.future;

finalize register_event:
    input r0 as Event.public;
    input r1 as field.public;
    contains events[r0.id] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r0 into events[r0.id];
    get venues[r0.venue_id] into r4;
    assert.eq r1 r4.venue_owner;
    contains payouts[r0.event_owner] into r5;
    not r5 into r6;
    branch.eq r6 false to end_then_0_2;
    set 0u64 into payouts[r0.event_owner];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;

function buy_tickets:
    input r0 as field.private;
    input r1 as u32.private;
    input r2 as u64.private;
    input r3 as credits.aleo/credits.record;
    cast r1 into r4 as u64;
    mul r2 r4 into r5;
    call credits.aleo/transfer_private_to_public r3 lodive.aleo r5 into r6 r7;
    cast self.caller r0 r1 r2 into r8 as Tickets.record;
    hash.bhp1024 self.caller into r9 as field;
    async buy_tickets r0 r1 r2 r9 r7 into r10;
    output r8 as Tickets.record;
    output r6 as credits.aleo/credits.record;
    output r10 as lodive_v0_1_0.aleo/buy_tickets.future;

finalize buy_tickets:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as credits.aleo/transfer_private_to_public.future;
    get events[r0] into r5;
    is.eq r5.ticket_price r2 into r6;
    assert.eq r6 true;
    gte r5.ticket_supply r1 into r7;
    assert.eq r7 true;
    not r5.is_ended into r8;
    assert.eq r8 true;
    not r5.is_refunded into r9;
    assert.eq r9 true;
    hash.bhp1024 r5.event_owner into r10 as field;
    assert.neq r3 r10;
    get venues[r5.venue_id] into r11;
    hash.bhp1024 r11.venue_owner into r12 as field;
    assert.eq r3 r12;
    sub r5.ticket_supply r1 into r13;
    cast r5.id r5.venue_id r13 r5.initial_ticket_supply r5.ticket_price r5.redeemed_tickets r5.is_ended r5.is_refunded r5.is_verified r5.event_owner r5.is_in_progress into r14 as Event;
    set r14 into events[r0];
    await r4;
    get.or_use payouts[r5.id] 0u64 into r15;
    cast r1 into r16 as u64;
    mul r2 r16 into r17;
    add r15 r17 into r18;
    set r18 into payouts[r5.event_owner];
    cast r0 r3 into r19 as TicketHolder;
    get.or_use tickets_sold[r19] 0u32 into r20;
    add r20 r1 into r21;
    set r21 into tickets_sold[r19];

function transfer_some_tickets:
    input r0 as Tickets.record;
    input r1 as address.private;
    input r2 as u32.private;
    input r3 as credits.aleo/credits.record;
    cast r0.num_tickets into r4 as u64;
    mul r0.ticket_price r4 into r5;
    call credits.aleo/transfer_private r3 r1 r5 into r6 r7;
    cast r1 r0.event_id r0.num_tickets r0.ticket_price into r8 as Tickets.record;
    sub r0.num_tickets r2 into r9;
    cast r0.owner r0.event_id r9 r0.ticket_price into r10 as Tickets.record;
    hash.bhp1024 self.caller into r11 as field;
    hash.bhp1024 r1 into r12 as field;
    async transfer_some_tickets r0.event_id r11 r0.ticket_price r12 into r13;
    output r6 as credits.aleo/credits.record;
    output r7 as credits.aleo/credits.record;
    output r8 as Tickets.record;
    output r10 as Tickets.record;
    output r13 as lodive_v0_1_0.aleo/transfer_some_tickets.future;

finalize transfer_some_tickets:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as field.public;
    get events[r0] into r4;
    not r4.is_in_progress into r5;
    assert.eq r5 true;
    not r4.is_ended into r6;
    assert.eq r6 true;
    not r4.is_refunded into r7;
    assert.eq r7 true;
    not r4.is_verified into r8;
    assert.eq r8 true;
    is.eq r4.ticket_price r2 into r9;
    assert.eq r9 true;
    hash.bhp1024 r4.event_owner into r10 as field;
    assert.neq r1 r10;
    get venues[r4.venue_id] into r11;
    hash.bhp1024 r11.venue_owner into r12 as field;
    assert.eq r1 r12;
    hash.bhp1024 r4.event_owner into r13 as field;
    assert.neq r3 r13;

function transfer_all_tickets:
    input r0 as Tickets.record;
    input r1 as address.private;
    input r2 as credits.aleo/credits.record;
    cast r0.num_tickets into r3 as u64;
    mul r0.ticket_price r3 into r4;
    call credits.aleo/transfer_private r2 r1 r4 into r5 r6;
    cast r1 r0.event_id r0.num_tickets r0.ticket_price into r7 as Tickets.record;
    hash.bhp1024 self.caller into r8 as field;
    hash.bhp1024 r1 into r9 as field;
    async transfer_all_tickets r0.event_id r8 r0.ticket_price r9 into r10;
    output r5 as credits.aleo/credits.record;
    output r6 as credits.aleo/credits.record;
    output r7 as Tickets.record;
    output r10 as lodive_v0_1_0.aleo/transfer_all_tickets.future;

finalize transfer_all_tickets:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as field.public;
    get events[r0] into r4;
    not r4.is_in_progress into r5;
    assert.eq r5 true;
    not r4.is_ended into r6;
    assert.eq r6 true;
    not r4.is_refunded into r7;
    assert.eq r7 true;
    not r4.is_verified into r8;
    assert.eq r8 true;
    is.eq r4.ticket_price r2 into r9;
    assert.eq r9 true;
    hash.bhp1024 r4.event_owner into r10 as field;
    assert.neq r1 r10;
    get venues[r4.venue_id] into r11;
    hash.bhp1024 r11.venue_owner into r12 as field;
    assert.eq r1 r12;
    hash.bhp1024 r4.event_owner into r13 as field;
    assert.neq r3 r13;

function redeem_tickets:
    input r0 as Tickets.record;
    input r1 as u32.private;
    lte r1 r0.num_tickets into r2;
    assert.eq r2 true;
    sub r0.num_tickets r1 into r3;
    cast r0.owner r0.event_id r3 r0.ticket_price into r4 as Tickets.record;
    hash.bhp1024 r0 into r5 as scalar;
    cast r0.owner r5 into r6 as TicketRedemption.record;
    commit.bhp1024 self.caller r5 into r7 as field;
    async redeem_tickets r0.event_id r1 r7 into r8;
    output r6 as TicketRedemption.record;
    output r4 as Tickets.record;
    output r8 as lodive_v0_1_0.aleo/redeem_tickets.future;

finalize redeem_tickets:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as field.public;
    get events[r0] into r3;
    not r3.is_ended into r4;
    assert.eq r4 true;
    not r3.is_refunded into r5;
    assert.eq r5 true;
    not r3.is_verified into r6;
    assert.eq r6 true;
    add r3.redeemed_tickets r1 into r7;
    cast r3.id r3.venue_id r3.ticket_supply r3.initial_ticket_supply r3.ticket_price r7 r3.is_ended r3.is_refunded r3.is_verified r3.event_owner r3.is_in_progress into r8 as Event;
    set r8 into events[r0];
    set r1 into redemptions[r2];

function claim_refund:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as Tickets.record;
    input r3 as address.private;
    input r4 as u8.private;
    assert.eq r2.owner self.caller;
    call credits.aleo/transfer_public_to_private self.caller r1 into r5 r6;
    hash.bhp1024 self.caller into r7 as field;
    async claim_refund r0 r7 r1 r2.num_tickets r6 into r8;
    output r5 as credits.aleo/credits.record;
    output r8 as lodive_v0_1_0.aleo/claim_refund.future;

finalize claim_refund:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as u32.public;
    input r4 as credits.aleo/transfer_public_to_private.future;
    get events[r0] into r5;
    not r5.is_ended into r6;
    assert.eq r6 true;
    not r5.is_verified into r7;
    assert.eq r7 true;
    assert.eq r5.is_refunded true;
    cast r0 r1 into r8 as TicketHolder;
    get tickets_sold[r8] into r9;
    assert.eq r3 r9;
    await r4;

function claim_payout:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as u8.private;
    cast r3 into r4 as u64;
    mul r1 r4 into r5;
    div r5 100u64 into r6;
    sub r1 r6 into r7;
    call credits.aleo/transfer_public_to_private self.caller r7 into r8 r9;
    call credits.aleo/transfer_public_to_private r2 r6 into r10 r11;
    hash.bhp1024 self.caller into r12 as field;
    hash.bhp1024 r2 into r13 as field;
    async claim_payout r0 r12 r1 r13 r3 r9 r11 into r14;
    output r8 as credits.aleo/credits.record;
    output r10 as credits.aleo/credits.record;
    output r14 as lodive_v0_1_0.aleo/claim_payout.future;

finalize claim_payout:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as u8.public;
    input r5 as credits.aleo/transfer_public_to_private.future;
    input r6 as credits.aleo/transfer_public_to_private.future;
    get events[r0] into r7;
    assert.eq r7.is_verified true;
    hash.bhp1024 r7.event_owner into r8 as field;
    assert.eq r1 r8;
    get venues[r7.venue_id] into r9;
    hash.bhp1024 r9.venue_owner into r10 as field;
    assert.eq r3 r10;
    assert.eq r4 r9.commission_rate;
    get payouts[r0] into r11;
    assert.eq r11 r2;
    await r5;
    await r6;

function verify_event:
    input r0 as field.private;
    hash.bhp1024 self.caller into r1 as field;
    async verify_event r0 r1 into r2;
    output r2 as lodive_v0_1_0.aleo/verify_event.future;

finalize verify_event:
    input r0 as field.public;
    input r1 as field.public;
    get events[r0] into r2;
    get venues[r2.venue_id] into r3;
    hash.bhp1024 r3.venue_owner into r4 as field;
    assert.eq r1 r4;
    not r2.is_verified into r5;
    assert.eq r5 true;
    not r2.is_refunded into r6;
    assert.eq r6 true;
    not r2.is_ended into r7;
    assert.eq r7 true;
    cast r2.id r2.venue_id r2.ticket_supply r2.initial_ticket_supply r2.ticket_price r2.redeemed_tickets true false true r2.event_owner r2.is_in_progress into r8 as Event;
    set r8 into events[r0];

function start_event:
    input r0 as field.private;
    hash.bhp1024 self.caller into r1 as field;
    async start_event r0 r1 into r2;
    output r2 as lodive_v0_1_0.aleo/start_event.future;

finalize start_event:
    input r0 as field.public;
    input r1 as field.public;
    get events[r0] into r2;
    get venues[r2.venue_id] into r3;
    hash.bhp1024 r3.venue_owner into r4 as field;
    assert.eq r1 r4;
    cast r2.id r2.venue_id r2.ticket_supply r2.initial_ticket_supply r2.ticket_price r2.redeemed_tickets false false true r2.event_owner true into r5 as Event;
    set r5 into events[r0];

function end_event:
    input r0 as field.private;
    hash.bhp1024 self.caller into r1 as field;
    async end_event r0 r1 into r2;
    output r2 as lodive_v0_1_0.aleo/end_event.future;

finalize end_event:
    input r0 as field.public;
    input r1 as field.public;
    get events[r0] into r2;
    get venues[r2.venue_id] into r3;
    hash.bhp1024 r3.venue_owner into r4 as field;
    assert.eq r1 r4;
    cast r2.id r2.venue_id r2.ticket_supply r2.initial_ticket_supply r2.ticket_price r2.redeemed_tickets true false false r2.event_owner false into r5 as Event;
    set r5 into events[r0];
