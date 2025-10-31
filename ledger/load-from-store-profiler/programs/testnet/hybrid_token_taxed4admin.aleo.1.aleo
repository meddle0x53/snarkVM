program hybrid_token_taxed4admin.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo192hxl5vd8qt28fzyyf4y9uxhggurn366aed7v20vpjyvyxpdeyqsdusdru;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as Token.record;
    mul r2 15u64 into r5;
    div r5 10000u64 into r6;
    sub r2 r6 into r7;
    cast aleo192hxl5vd8qt28fzyyf4y9uxhggurn366aed7v20vpjyvyxpdeyqsdusdru r6 into r8 as Token.record;
    cast r1 r7 into r9 as Token.record;
    output r4 as Token.record;
    output r9 as Token.record;
    output r8 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo192hxl5vd8qt28fzyyf4y9uxhggurn366aed7v20vpjyvyxpdeyqsdusdru;
    async mint_public r0 r1 into r2;
    output r2 as hybrid_token_taxed4admin.aleo/mint_public.future;

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
    output r2 as hybrid_token_taxed4admin.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use balance[r1] 0u64 into r3;
    mul r2 15u64 into r4;
    div r4 10000u64 into r5;
    sub r2 r5 into r6;
    get.or_use balance[aleo192hxl5vd8qt28fzyyf4y9uxhggurn366aed7v20vpjyvyxpdeyqsdusdru] 0u64 into r7;
    add r7 r5 into r8;
    set r8 into balance[aleo192hxl5vd8qt28fzyyf4y9uxhggurn366aed7v20vpjyvyxpdeyqsdusdru];
    add r3 r6 into r9;
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
    output r5 as hybrid_token_taxed4admin.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    mul r1 15u64 into r3;
    div r3 10000u64 into r4;
    sub r1 r4 into r5;
    get.or_use balance[aleo192hxl5vd8qt28fzyyf4y9uxhggurn366aed7v20vpjyvyxpdeyqsdusdru] 0u64 into r6;
    add r6 r4 into r7;
    set r7 into balance[aleo192hxl5vd8qt28fzyyf4y9uxhggurn366aed7v20vpjyvyxpdeyqsdusdru];
    add r2 r5 into r8;
    set r8 into balance[r0];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    mul r1 15u64 into r2;
    div r2 10000u64 into r3;
    sub r1 r3 into r4;
    cast aleo192hxl5vd8qt28fzyyf4y9uxhggurn366aed7v20vpjyvyxpdeyqsdusdru r3 into r5 as Token.record;
    cast r0 r4 into r6 as Token.record;
    async transfer_public_to_private self.caller r1 into r7;
    output r6 as Token.record;
    output r5 as Token.record;
    output r7 as hybrid_token_taxed4admin.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into balance[r0];
