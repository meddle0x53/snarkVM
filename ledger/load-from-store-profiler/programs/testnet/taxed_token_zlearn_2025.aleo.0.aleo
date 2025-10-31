program taxed_token_zlearn_2025.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

closure calculate_tax:
    input r0 as u64;
    mul r0 15u64 into r1;
    div r1 10000u64 into r2;
    output r2 as u64;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    call calculate_tax r2 into r3;
    sub r2 r3 into r4;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as Token.record;
    cast r1 r4 into r7 as Token.record;
    cast aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f r3 into r8 as Token.record;
    output r6 as Token.record;
    output r7 as Token.record;
    output r8 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f;
    async mint_public r0 r1 into r2;
    output r2 as taxed_token_zlearn_2025.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    call calculate_tax r1 into r2;
    sub r1 r2 into r3;
    async transfer_public self.caller r0 r3 r2 into r4;
    output r4 as taxed_token_zlearn_2025.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    get.or_use balance[r1] 0u64 into r4;
    add r4 r2 into r5;
    set r5 into balance[r1];
    get.or_use balance[aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f] 0u64 into r6;
    add r6 r3 into r7;
    set r7 into balance[aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f];
    get.or_use balance[r0] 0u64 into r8;
    add r2 r3 into r9;
    sub r8 r9 into r10;
    set r10 into balance[r0];

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    call calculate_tax r2 into r3;
    sub r2 r3 into r4;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as Token.record;
    async transfer_private_to_public r1 r4 r3 into r7;
    output r6 as Token.record;
    output r7 as taxed_token_zlearn_2025.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    add r3 r1 into r4;
    set r4 into balance[r0];
    get.or_use balance[aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into balance[aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    call calculate_tax r1 into r2;
    sub r1 r2 into r3;
    cast r0 r3 into r4 as Token.record;
    async transfer_public_to_private self.caller r1 r2 into r5;
    output r4 as Token.record;
    output r5 as taxed_token_zlearn_2025.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    sub r3 r1 into r4;
    set r4 into balance[r0];
    get.or_use balance[aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into balance[aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f];
