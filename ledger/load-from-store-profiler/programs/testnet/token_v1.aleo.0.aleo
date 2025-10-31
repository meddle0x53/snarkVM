import credits.aleo;

program token_v1.aleo;

record token:
    owner as address.private;
    amount as u64.private;

mapping account:
    key as address.public;
    value as u64.public;

mapping supply:
    key as boolean.public;
    value as u64.public;

mapping limit:
    key as boolean.public;
    value as u64.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as token_v1.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use account[r0] 0u64 into r3;
    sub r3 r2 into r4;
    set r4 into account[r0];
    get.or_use account[r1] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into account[r1];

function transfer_private:
    input r0 as token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as token.record;
    cast r1 r2 into r5 as token.record;
    output r4 as token.record;
    output r5 as token.record;

function transfer_private_to_public:
    input r0 as token.record;
    input r1 as address.public;
    input r2 as u64.public;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as token.record;
    async transfer_private_to_public r1 r2 into r5;
    output r4 as token.record;
    output r5 as token_v1.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];

function transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 into r2 as token.record;
    async transfer_public_to_private self.caller r1 into r3;
    output r2 as token.record;
    output r3 as token_v1.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into account[r0];

function initialize:
    input r0 as u64.public;
    input r1 as u64.public;
    async initialize r0 r1 self.caller into r2;
    output r2 as token_v1.aleo/initialize.future;

finalize initialize:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as address.public;
    is.eq r2 handler_v1.aleo into r3;
    assert.eq r3 true;
    set r0 into limit[true];
    set r1 into limit[false];

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public_as_signer handler_v1.aleo r1 into r2;
    async mint_public r0 r1 self.caller r2 into r3;
    output r3 as token_v1.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as address.public;
    input r3 as credits.aleo/transfer_public_as_signer.future;
    await r3;
    is.eq r2 handler_v1.aleo into r4;
    assert.eq r4 true;
    get.or_use limit[true] 0u64 into r5;
    get.or_use limit[false] 0u64 into r6;
    lte r1 r6 into r7;
    assert.eq r7 true;
    get.or_use supply[false] 0u64 into r8;
    add r1 r8 into r9;
    lte r9 r5 into r10;
    assert.eq r10 true;
    add r1 r8 into r11;
    set r11 into supply[false];
    get.or_use account[r0] 0u64 into r12;
    add r12 r1 into r13;
    set r13 into account[r0];

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as token.record;
    output r2 as token.record;
