program my_awesome_test_token_unmars.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    mul r2 15u64 into r3;
    div r3 10000u64 into r4;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as Token.record;
    sub r2 r4 into r7;
    cast r1 r7 into r8 as Token.record;
    cast aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px r4 into r9 as Token.record;
    output r6 as Token.record;
    output r8 as Token.record;
    output r9 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px;
    async mint_public r0 r1 into r2;
    output r2 as my_awesome_test_token_unmars.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    mul r1 15u64 into r2;
    div r2 10000u64 into r3;
    async transfer_public self.caller r0 r1 r3 into r4;
    output r4 as my_awesome_test_token_unmars.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    get.or_use balance[r0] 0u64 into r4;
    sub r4 r2 into r5;
    set r5 into balance[r0];
    get.or_use balance[r1] 0u64 into r6;
    sub r2 r3 into r7;
    add r6 r7 into r8;
    set r8 into balance[r1];
    get.or_use balance[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px] 0u64 into r9;
    add r9 r3 into r10;
    set r10 into balance[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px];

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    mul r2 15u64 into r3;
    div r3 10000u64 into r4;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as Token.record;
    async transfer_private_to_public r1 r2 r4 into r7;
    output r6 as Token.record;
    output r7 as my_awesome_test_token_unmars.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    sub r1 r2 into r4;
    add r3 r4 into r5;
    set r5 into balance[r0];
    get.or_use balance[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px] 0u64 into r6;
    add r6 r2 into r7;
    set r7 into balance[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    mul r1 15u64 into r2;
    div r2 10000u64 into r3;
    sub r1 r3 into r4;
    cast r0 r4 into r5 as Token.record;
    async transfer_public_to_private self.caller r1 r3 into r6;
    output r5 as Token.record;
    output r6 as my_awesome_test_token_unmars.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    sub r3 r1 into r4;
    set r4 into balance[r0];
    get.or_use balance[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into balance[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px];
