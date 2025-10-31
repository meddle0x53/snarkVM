import credits.aleo;
import token_registry.aleo;

program floflo_dex.aleo;

record Receipt:
    owner as address.private;
    order_id as field.private;

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

struct Order:
    sold_token_id as field;
    bought_token_id as field;
    sold_token_amount as u128;
    bought_token_amount as u128;
    accepted as boolean;
    withdrawn as boolean;

mapping orders:
    key as field.public;
    value as Order.public;

function create_order:
    input r0 as token_registry.aleo/Token.record;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as u128.private;
    call token_registry.aleo/transfer_private_to_public self.caller r0.amount r0 into r4 r5;
    cast self.caller r1 into r6 as Receipt.record;
    async create_order r5 r1 r0.token_id r2 r0.amount r3 into r7;
    output r6 as Receipt.record;
    output r7 as floflo_dex.aleo/create_order.future;

finalize create_order:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    input r5 as u128.public;
    await r0;
    contains orders[r1] into r6;
    not r6 into r7;
    assert.eq r7 true;
    cast r2 r3 r4 r5 false false into r8 as Order;
    set r8 into orders[r1];

function accept_order:
    input r0 as token_registry.aleo/Token.record;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    call token_registry.aleo/transfer_private_to_public self.caller r0.amount r0 into r4 r5;
    call token_registry.aleo/transfer_public_to_private r2 self.caller r3 false into r6 r7;
    async accept_order r5 r7 r1 r0.token_id r0.amount into r8;
    output r6 as token_registry.aleo/Token.record;
    output r8 as floflo_dex.aleo/accept_order.future;

finalize accept_order:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as token_registry.aleo/transfer_public_to_private.future;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    await r0;
    await r1;
    get orders[r2] into r5;
    not r5.accepted into r6;
    assert.eq r6 true;
    not r5.withdrawn into r7;
    assert.eq r7 true;
    is.eq r5.bought_token_id r3 into r8;
    assert.eq r8 true;
    is.eq r5.bought_token_amount r4 into r9;
    assert.eq r9 true;
    cast r5.sold_token_id r5.bought_token_id r5.sold_token_amount r5.bought_token_amount true false into r10 as Order;
    set r10 into orders[r2];

function withdraw:
    input r0 as Receipt.record;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u128.public;
    call token_registry.aleo/transfer_public_to_private r2 self.caller r4 false into r5 r6;
    async withdraw r6 r0.order_id r1 r4 into r7;
    output r5 as token_registry.aleo/Token.record;
    output r7 as floflo_dex.aleo/withdraw.future;

finalize withdraw:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    await r0;
    get orders[r1] into r4;
    is.eq r4.sold_token_id r2 into r5;
    assert.eq r5 true;
    is.eq r4.bought_token_amount r3 into r6;
    assert.eq r6 true;
    assert.eq r4.accepted true;
    not r4.withdrawn into r7;
    assert.eq r7 true;
    cast r4.sold_token_id r4.bought_token_id r4.sold_token_amount r4.bought_token_amount r4.accepted true into r8 as Order;
    set r8 into orders[r1];

function delete_order:
    input r0 as Receipt.record;
    input r1 as field.private;
    input r2 as u128.private;
    is.eq r0.owner self.caller into r3;
    assert.eq r3 true;
    call token_registry.aleo/transfer_public_to_private r1 self.caller r2 false into r4 r5;
    async delete_order r5 r0.order_id r1 r2 into r6;
    output r4 as token_registry.aleo/Token.record;
    output r6 as floflo_dex.aleo/delete_order.future;

finalize delete_order:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    await r0;
    get orders[r1] into r4;
    is.eq r4.sold_token_id r2 into r5;
    assert.eq r5 true;
    is.eq r4.sold_token_amount r3 into r6;
    assert.eq r6 true;
    not r4.accepted into r7;
    assert.eq r7 true;
    not r4.withdrawn into r8;
    assert.eq r8 true;
    cast r4.sold_token_id r4.bought_token_id r4.sold_token_amount r4.bought_token_amount r4.accepted true into r9 as Order;
    set r9 into orders[r1];
