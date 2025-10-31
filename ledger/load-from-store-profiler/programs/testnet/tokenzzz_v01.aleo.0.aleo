program tokenzzz_v01.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping account:
    key as address.public;
    value as u64.public;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    async mint_public r0 r1 into r2;
    output r2 as tokenzzz_v01.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as Token.record;
    async mint_private into r3;
    output r2 as Token.record;
    output r3 as tokenzzz_v01.aleo/mint_private.future;

finalize mint_private:
    assert.eq true true;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as Token.record;
    cast r1 r2 into r5 as Token.record;
    async transfer_private into r6;
    output r4 as Token.record;
    output r5 as Token.record;
    output r6 as tokenzzz_v01.aleo/transfer_private.future;

finalize transfer_private:
    assert.eq true true;

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as tokenzzz_v01.aleo/transfer_public.future;

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
