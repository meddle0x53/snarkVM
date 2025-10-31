program assignment1_javelotl.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1wnszlq467vmnm4cktmquwrqje24j9ek29yk84seuwgl42swhsupqw4glaj;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    mul 0u64 r2 into r4;
    sub r2 r4 into r5;
    cast r0.owner r3 into r6 as Token.record;
    cast r1 r5 into r7 as Token.record;
    cast aleo1wnszlq467vmnm4cktmquwrqje24j9ek29yk84seuwgl42swhsupqw4glaj r4 into r8 as Token.record;
    output r6 as Token.record;
    output r7 as Token.record;
    output r8 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1wnszlq467vmnm4cktmquwrqje24j9ek29yk84seuwgl42swhsupqw4glaj;
    async mint_public r0 r1 into r2;
    output r2 as assignment1_javelotl.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    mul 0u64 r1 into r2;
    sub r1 r2 into r3;
    async transfer_public self.caller r0 r3 into r4;
    output r4 as assignment1_javelotl.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use balance[r1] 0u64 into r3;
    add r3 r2 into r4;
    set r4 into balance[r1];
    get.or_use balance[r0] 0u64 into r5;
    sub r5 r2 into r6;
    set r6 into balance[r0];

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    mul 0u64 r2 into r3;
    sub r2 r3 into r4;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as Token.record;
    async transfer_private_to_public r1 r4 into r7;
    output r6 as Token.record;
    output r7 as assignment1_javelotl.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    mul 0u64 r1 into r2;
    sub r1 r2 into r3;
    cast r0 r3 into r4 as Token.record;
    async transfer_public_to_private self.caller r1 into r5;
    output r4 as Token.record;
    output r5 as assignment1_javelotl.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into balance[r0];
