program q4_hackathon_mint_duck_tokens.aleo;

record token:
    owner as address.private;
    amount as u64.private;
    edition as u8.private;

mapping account:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u8.private;
    cast r0 r1 r2 into r3 as token.record;
    output r3 as token.record;

function transfer_private_to_public:
    input r0 as token.record;
    input r1 as address.public;
    input r2 as u64.public;
    sub r0.amount r2 into r3;
    cast r0.owner r3 r0.edition into r4 as token.record;
    cast r0.edition into r5 as u64;
    sub 5u64 r5 into r6;
    mul r6 r2 into r7;
    async transfer_private_to_public r1 r7 into r8;
    output r4 as token.record;
    output r8 as q4_hackathon_mint_duck_tokens.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];
