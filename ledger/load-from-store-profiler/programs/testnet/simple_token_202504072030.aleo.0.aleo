program simple_token_202504072030.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    mul r2 1u64 into r3;
    div r3 10000u64 into r4;
    sub r2 r4 into r5;
    sub r0.amount r2 into r6;
    cast r0.owner r6 into r7 as Token.record;
    cast r1 r5 into r8 as Token.record;
    output r7 as Token.record;
    output r8 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw;
    async mint_public r0 r1 into r2;
    output r2 as simple_token_202504072030.aleo/mint_public.future;

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
    output r2 as simple_token_202504072030.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    mul r2 1u64 into r3;
    div r3 10000u64 into r4;
    get.or_use balance[aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw] 0u64 into r5;
    add r5 r4 into r6;
    set r6 into balance[aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw];
    get.or_use balance[r1] 0u64 into r7;
    add r7 r2 into r8;
    sub r8 r4 into r9;
    set r9 into balance[r1];
    get.or_use balance[r0] 0u64 into r10;
    sub r10 r2 into r11;
    set r11 into balance[r0];

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as Token.record;
    async transfer_private_to_public r1 r2 into r5;
    output r4 as Token.record;
    output r5 as simple_token_202504072030.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    mul r1 1u64 into r2;
    div r2 10000u64 into r3;
    get.or_use balance[aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw] 0u64 into r4;
    add r4 r3 into r5;
    set r5 into balance[aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw];
    get.or_use balance[r0] 0u64 into r6;
    add r6 r1 into r7;
    sub r7 r3 into r8;
    set r8 into balance[r0];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as Token.record;
    async transfer_public_to_private self.caller r1 into r3;
    output r2 as Token.record;
    output r3 as simple_token_202504072030.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into balance[r0];
