program ego_token.aleo;

record token:
    owner as address.private;
    amount as u64.private;

mapping account:
    key as address.public;
    value as u64.public;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    async mint_public r0 r1 into r2;
    output r2 as ego_token.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    set r3 into account[r0];

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as token.record;
    output r2 as token.record;

function transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    async transfer_public r0 r1 r2 into r3;
    output r3 as ego_token.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get account[r0] into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    get.or_use account[r1] 0u64 into r5;
    add r5 r2 into r6;
    gte r6 r5 into r7;
    assert.eq r7 true;
    sub r3 r2 into r8;
    set r8 into account[r0];
    set r6 into account[r1];

function transfer_private:
    input r0 as token.record;
    input r1 as address.private;
    input r2 as u64.private;
    assert.eq r0.owner self.caller;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    cast r1 r2 into r4 as token.record;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as token.record;
    output r6 as token.record;
    output r4 as token.record;
