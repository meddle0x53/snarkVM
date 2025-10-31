program basic_token_gianfranco.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balances_public:
    key as address.public;
    value as u64.public;

function mint_publicj:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1zwmh60286u8fhcagjwvvtr2es73j4ws372jarzvn644pycljaygqszla6u;
    async mint_publicj r0 r1 into r2;
    output r2 as basic_token_gianfranco.aleo/mint_publicj.future;

finalize mint_publicj:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balances_public[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balances_public[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as basic_token_gianfranco.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use balances_public[r0] 0u64 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    sub r3 r2 into r5;
    set r5 into balances_public[r0];
    get.or_use balances_public[r1] 0u64 into r6;
    add r6 r2 into r7;
    set r7 into balances_public[r1];

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1zwmh60286u8fhcagjwvvtr2es73j4ws372jarzvn644pycljaygqszla6u;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    cast r1 r2 into r3 as Token.record;
    sub r0.amount r2 into r4;
    cast r1 r4 into r5 as Token.record;
    output r3 as Token.record;
    output r5 as Token.record;

function public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as Token.record;
    async public_to_private self.caller r1 into r3;
    output r2 as Token.record;
    output r3 as basic_token_gianfranco.aleo/public_to_private.future;

finalize public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balances_public[r0] 0u64 into r2;
    gte r2 r1 into r3;
    assert.eq r3 true;
    sub r2 r1 into r4;
    set r4 into balances_public[r0];

function private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as Token.record;
    async private_to_public r1 r2 into r5;
    output r4 as Token.record;
    output r5 as basic_token_gianfranco.aleo/private_to_public.future;

finalize private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balances_public[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balances_public[r0];
