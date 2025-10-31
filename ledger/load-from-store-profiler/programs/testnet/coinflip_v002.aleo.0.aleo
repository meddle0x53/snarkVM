import credits.aleo;

program coinflip_v002.aleo;

record Toss:
    owner as address.private;
    coin as boolean.private;
    amount as u64.private;

mapping amount_limit:
    key as boolean.public;
    value as u64.public;

mapping admin:
    key as boolean.public;
    value as address.public;

mapping status:
    key as boolean.public;
    value as u8.public;

mapping user_amount:
    key as field.public;
    value as u64.public;

mapping user_status:
    key as field.public;
    value as boolean.public;

function initialize:
    input r0 as address.private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    async initialize r0 r1 into r3;
    output r3 as coinflip_v002.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    input r1 as u64.public;
    contains admin[true] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r0 into admin[true];
    set r1 into amount_limit[true];
    set 0u8 into status[true];

function bet:
    input r0 as credits.aleo/credits.record;
    input r1 as u64.private;
    input r2 as boolean.private;
    call credits.aleo/transfer_private_to_public r0 coinflip_v002.aleo r1 into r3 r4;
    cast self.caller r2 r1 into r5 as Toss.record;
    async bet r1 r4 into r6;
    output r3 as credits.aleo/credits.record;
    output r5 as Toss.record;
    output r6 as coinflip_v002.aleo/bet.future;

finalize bet:
    input r0 as u64.public;
    input r1 as credits.aleo/transfer_private_to_public.future;
    await r1;
    assert.eq true true;
    get credits.aleo/account[coinflip_v002.aleo] into r2;
    get status[true] into r3;
    assert.eq r3 1u8;
    get amount_limit[true] into r4;
    lte r0 r4 into r5;
    assert.eq r5 true;
    mul r0 2u64 into r6;
    gte r2 r6 into r7;
    assert.eq r7 true;

function reveal:
    input r0 as Toss.record;
    mul r0.amount 2u64 into r1;
    hash.bhp256 r0.owner into r2 as field;
    async reveal r0.coin r2 r0.amount into r3;
    output r3 as coinflip_v002.aleo/reveal.future;

finalize reveal:
    input r0 as boolean.public;
    input r1 as field.public;
    input r2 as u64.public;
    rand.chacha into r3 as boolean;
    is.eq r3 r0 into r4;
    branch.eq r4 false to end_then_0_0;
    get.or_use user_amount[r1] 0u64 into r5;
    mul r2 2u64 into r6;
    add r5 r6 into r7;
    set r7 into user_amount[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    set 0u64 into user_amount[r1];
    position end_otherwise_0_1;

function claim:
    input r0 as u64.private;
    call credits.aleo/transfer_public_to_private self.caller r0 into r1 r2;
    hash.bhp256 self.caller into r3 as field;
    async claim r2 r3 r0 into r4;
    output r1 as credits.aleo/credits.record;
    output r4 as coinflip_v002.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as u64.public;
    await r0;
    get user_amount[r1] into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    get.or_use user_amount[r1] 0u64 into r5;
    sub r5 r2 into r6;
    set r6 into user_amount[r1];

function unpause:
    async unpause self.caller into r0;
    output r0 as coinflip_v002.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 1u8 into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as coinflip_v002.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get admin[true] into r1;
    assert.eq r0 r1;
    set 0u8 into status[true];
