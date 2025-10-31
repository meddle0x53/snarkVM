import credits.aleo;
import token_registry.aleo;

program rissonsbank.aleo;

record Ticket:
    owner as address.private;
    id as field.private;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct Trade:
    give_token as field;
    want_token as field;
    give_amount as u128;
    want_amount as u128;
    is_mached as boolean;
    is_closed as boolean;

mapping book:
    key as field.public;
    value as Trade.public;

function open:
    input r0 as token_registry.aleo/Token.record;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as u128.private;
    call token_registry.aleo/transfer_private_to_public self.caller r0.amount r0 into r4 r5;
    cast self.caller r1 into r6 as Ticket.record;
    async open r5 r1 r0.token_id r2 r0.amount r3 into r7;
    output r6 as Ticket.record;
    output r7 as rissonsbank.aleo/open.future;

finalize open:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    input r5 as u128.public;
    await r0;
    contains book[r1] into r6;
    not r6 into r7;
    assert.eq r7 true;
    cast r2 r3 r4 r5 false false into r8 as Trade;
    set r8 into book[r1];

function mach:
    input r0 as token_registry.aleo/Token.record;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    call token_registry.aleo/transfer_private_to_public self.caller r0.amount r0 into r4 r5;
    call token_registry.aleo/transfer_public_to_private r2 self.caller r3 false into r6 r7;
    async mach r5 r7 r1 r0.token_id r0.amount into r8;
    output r6 as token_registry.aleo/Token.record;
    output r8 as rissonsbank.aleo/mach.future;

finalize mach:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as token_registry.aleo/transfer_public_to_private.future;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    await r0;
    await r1;
    get book[r2] into r5;
    not r5.is_mached into r6;
    assert.eq r6 true;
    not r5.is_closed into r7;
    assert.eq r7 true;
    is.eq r5.want_token r3 into r8;
    assert.eq r8 true;
    is.eq r5.want_amount r4 into r9;
    assert.eq r9 true;
    cast r5.give_token r5.want_token r5.give_amount r5.want_amount true false into r10 as Trade;
    set r10 into book[r2];

function retrieve:
    input r0 as Ticket.record;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u128.public;
    is.eq r0.owner self.caller into r5;
    assert.eq r5 true;
    call token_registry.aleo/transfer_public_to_private r2 self.caller r4 false into r6 r7;
    async retrieve r7 r0.id r1 r4 into r8;
    output r6 as token_registry.aleo/Token.record;
    output r8 as rissonsbank.aleo/retrieve.future;

finalize retrieve:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    await r0;
    get book[r1] into r4;
    is.eq r4.give_token r2 into r5;
    assert.eq r5 true;
    is.eq r4.want_amount r3 into r6;
    assert.eq r6 true;
    assert.eq r4.is_mached true;
    not r4.is_closed into r7;
    assert.eq r7 true;
    cast r4.give_token r4.want_token r4.give_amount r4.want_amount r4.is_mached true into r8 as Trade;
    set r8 into book[r1];

function cancel:
    input r0 as Ticket.record;
    input r1 as field.private;
    input r2 as u128.private;
    is.eq r0.owner self.caller into r3;
    assert.eq r3 true;
    call token_registry.aleo/transfer_public_to_private r1 self.caller r2 false into r4 r5;
    async cancel r5 r0.id r1 r2 into r6;
    output r4 as token_registry.aleo/Token.record;
    output r6 as rissonsbank.aleo/cancel.future;

finalize cancel:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    await r0;
    get book[r1] into r4;
    is.eq r4.give_token r2 into r5;
    assert.eq r5 true;
    is.eq r4.give_amount r3 into r6;
    assert.eq r6 true;
    not r4.is_mached into r7;
    assert.eq r7 true;
    not r4.is_closed into r8;
    assert.eq r8 true;
    cast r4.give_token r4.want_token r4.give_amount r4.want_amount r4.is_mached true into r9 as Trade;
    set r9 into book[r1];
