program leo_ramzy_chibani.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

mapping balance:
    key as address.public;
    value as u64.public;

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer_private:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    cast r2 into r3 as u128;
    mul r3 15u128 into r4;
    div r4 10000u128 into r5;
    cast r5 into r6 as u64;
    sub r2 r6 into r7;
    sub r0.amount r2 into r8;
    cast r0.owner r8 into r9 as Token.record;
    cast r1 r7 into r10 as Token.record;
    output r9 as Token.record;
    output r10 as Token.record;

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj;
    async mint_public r0 r1 into r2;
    output r2 as leo_ramzy_chibani.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    cast r1 into r2 as u128;
    mul r2 15u128 into r3;
    div r3 10000u128 into r4;
    cast r4 into r5 as u64;
    sub r1 r5 into r6;
    async transfer_public self.caller r0 r6 r5 into r7;
    output r7 as leo_ramzy_chibani.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    get.or_use balance[r1] 0u64 into r4;
    add r4 r2 into r5;
    set r5 into balance[r1];
    get.or_use balance[r0] 0u64 into r6;
    add r2 r3 into r7;
    sub r6 r7 into r8;
    set r8 into balance[r0];
    get.or_use balance[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r9;
    add r9 r3 into r10;
    set r10 into balance[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function transfer_private_to_public:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    cast r2 into r3 as u128;
    mul r3 15u128 into r4;
    div r4 10000u128 into r5;
    cast r5 into r6 as u64;
    sub r2 r6 into r7;
    sub r0.amount r2 into r8;
    cast r0.owner r8 into r9 as Token.record;
    async transfer_private_to_public r1 r7 r6 into r10;
    output r9 as Token.record;
    output r10 as leo_ramzy_chibani.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    add r3 r1 into r4;
    set r4 into balance[r0];
    get.or_use balance[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into balance[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r1 into r2 as u128;
    mul r2 15u128 into r3;
    div r3 10000u128 into r4;
    cast r4 into r5 as u64;
    sub r1 r5 into r6;
    cast r0 r6 into r7 as Token.record;
    async transfer_public_to_private self.caller r6 r5 into r8;
    output r7 as Token.record;
    output r8 as leo_ramzy_chibani.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balance[r0] 0u64 into r3;
    add r1 r2 into r4;
    sub r3 r4 into r5;
    set r5 into balance[r0];
    get.or_use balance[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj] 0u64 into r6;
    add r6 r2 into r7;
    set r7 into balance[aleo12l0r3y89h30ts35d68mzf0ak35zepxw58gns2t4607a8a3jy65qs9gxuuj];
