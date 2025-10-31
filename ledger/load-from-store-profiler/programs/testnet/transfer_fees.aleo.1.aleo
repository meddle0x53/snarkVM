program transfer_fees.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1zt7gv58x2ny7vw7anugllr6p6jev7ayw8hlcj08rpcg0hcypxqqsdxwth5;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    mul r2 0u64 into r4;
    add r3 r4 into r5;
    cast r0.owner r5 into r6 as Token.record;
    sub r2 r4 into r7;
    cast r1 r7 into r8 as Token.record;
    output r6 as Token.record;
    output r8 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1zt7gv58x2ny7vw7anugllr6p6jev7ayw8hlcj08rpcg0hcypxqqsdxwth5;
    async mint_public r0 r1 into r2;
    output r2 as transfer_fees.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as transfer_fees.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    mul r2 0u64 into r3;
    get.or_use balance[r1] 0u64 into r4;
    add r4 r2 into r5;
    sub r5 r3 into r6;
    set r6 into balance[r1];
    get.or_use balance[r0] 0u64 into r7;
    sub r7 r2 into r8;
    add r8 r3 into r9;
    set r9 into balance[r0];

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    mul r2 0u64 into r3;
    sub r0.amount r2 into r4;
    add r4 r3 into r5;
    cast r0.owner r5 into r6 as Token.record;
    async transfer_private_to_public r1 r2 r3 into r7;
    output r6 as Token.record;
    output r7 as transfer_fees.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    add r3 r1 into r4;
    sub r4 r2 into r5;
    set r5 into balance[r0];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    mul r1 0u64 into r2;
    sub r1 r2 into r3;
    cast r0 r3 into r4 as Token.record;
    async transfer_public_to_private self.caller r1 r2 into r5;
    output r4 as Token.record;
    output r5 as transfer_fees.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    sub r3 r1 into r4;
    add r4 r2 into r5;
    set r5 into balance[r0];
