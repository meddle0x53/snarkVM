program taxed_token_eden.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    mul r2 15u64 into r3;
    div r3 10000u64 into r4;
    sub r2 r4 into r5;
    gte r2 r4 into r6;
    assert.eq r6 true;
    gte r0.amount r2 into r7;
    assert.eq r7 true;
    sub r0.amount r2 into r8;
    cast r0.owner r8 into r9 as Token.record;
    cast r1 r5 into r10 as Token.record;
    cast aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg r4 into r11 as Token.record;
    output r10 as Token.record;
    output r9 as Token.record;
    output r11 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg;
    async mint_public r0 r1 into r2;
    output r2 as taxed_token_eden.aleo/mint_public.future;

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
    output r2 as taxed_token_eden.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    mul r2 15u64 into r3;
    div r3 10000u64 into r4;
    sub r2 r4 into r5;
    gte r2 r4 into r6;
    assert.eq r6 true;
    get.or_use balance[r1] 0u64 into r7;
    add r7 r5 into r8;
    set r8 into balance[r1];
    get.or_use balance[r0] 0u64 into r9;
    gte r9 r2 into r10;
    assert.eq r10 true;
    sub r9 r2 into r11;
    set r11 into balance[r0];
    get.or_use balance[aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg] 0u64 into r12;
    add r12 r4 into r13;
    set r13 into balance[aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg];

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    sub r0.amount r2 into r4;
    cast r0.owner r4 into r5 as Token.record;
    async transfer_private_to_public r1 r2 into r6;
    output r5 as Token.record;
    output r6 as taxed_token_eden.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    mul r1 15u64 into r2;
    div r2 10000u64 into r3;
    sub r1 r3 into r4;
    gte r1 r3 into r5;
    assert.eq r5 true;
    get.or_use balance[r0] 0u64 into r6;
    add r6 r4 into r7;
    set r7 into balance[r0];
    get.or_use balance[aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg] 0u64 into r8;
    add r8 r3 into r9;
    set r9 into balance[aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    mul r1 15u64 into r2;
    div r2 10000u64 into r3;
    sub r1 r3 into r4;
    gte r1 r3 into r5;
    assert.eq r5 true;
    cast r0 r4 into r6 as Token.record;
    async transfer_public_to_private self.caller r1 r3 into r7;
    output r6 as Token.record;
    output r7 as taxed_token_eden.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    gte r3 r1 into r4;
    assert.eq r4 true;
    sub r3 r1 into r5;
    set r5 into balance[r0];
    get.or_use balance[aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg] 0u64 into r6;
    add r6 r2 into r7;
    set r7 into balance[aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg];

function main:
    cast aleo1rjanc8ke4y89fp3rqcu0ydvxv7hkgs3h0u8c9gczgnzvc8y0xcrs03vrcg 1000u64 into r0 as Token.record;
    output r0 as Token.record;
