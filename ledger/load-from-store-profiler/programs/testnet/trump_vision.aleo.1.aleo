program trump_vision.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    mul r2 17u64 into r4;
    div r4 10000u64 into r5;
    sub r2 r5 into r6;
    sub r0.amount r2 into r7;
    cast r0.owner r7 into r8 as Token.record;
    cast r1 r6 into r9 as Token.record;
    cast aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa r5 into r10 as Token.record;
    output r8 as Token.record;
    output r9 as Token.record;
    output r10 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa;
    async mint_public r0 r1 into r2;
    output r2 as trump_vision.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    mul r1 17u64 into r2;
    div r2 10000u64 into r3;
    sub r1 r3 into r4;
    async transfer_public self.caller r0 r4 r3 into r5;
    output r5 as trump_vision.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    get.or_use balance[r1] 0u64 into r4;
    add r4 r2 into r5;
    set r5 into balance[r1];
    get.or_use balance[aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa] 0u64 into r6;
    add r6 r3 into r7;
    set r7 into balance[aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa];
    get.or_use balance[r0] 0u64 into r8;
    add r2 r3 into r9;
    sub r8 r9 into r10;
    set r10 into balance[r0];

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    mul r2 17u64 into r4;
    div r4 10000u64 into r5;
    sub r2 r5 into r6;
    sub r0.amount r2 into r7;
    cast r0.owner r7 into r8 as Token.record;
    async transfer_private_to_public r1 r6 r5 into r9;
    output r8 as Token.record;
    output r9 as trump_vision.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    add r3 r1 into r4;
    set r4 into balance[r0];
    get.or_use balance[aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into balance[aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    mul r1 17u64 into r2;
    div r2 10000u64 into r3;
    sub r1 r3 into r4;
    cast r0 r4 into r5 as Token.record;
    async transfer_public_to_private self.caller r1 r3 into r6;
    output r5 as Token.record;
    output r6 as trump_vision.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    sub r3 r1 into r4;
    set r4 into balance[r0];
    get.or_use balance[aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into balance[aleo1rg4fegw2xlg4h5k238lcfpgnsecdgdq49g5yx4hf22grwvavgvxs2uxufa];
