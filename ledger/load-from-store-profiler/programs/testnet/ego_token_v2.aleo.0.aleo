program ego_token_v2.aleo;

record token:
    owner as address.private;
    amount as u64.private;

mapping account:
    key as address.public;
    value as u64.public;

mapping contract_owner:
    key as field.public;
    value as address.public;

function initialize:
    input r0 as address.public;
    async initialize r0 into r1;
    output r1 as ego_token_v2.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    get.or_use contract_owner[0field] aleo130upke6jfngjhgh5fkpt3ezfa52qeghlkr7dphfrj2gxyyrxxsxst5042z into r1;
    assert.eq r1 aleo130upke6jfngjhgh5fkpt3ezfa52qeghlkr7dphfrj2gxyyrxxsxst5042z;
    set r0 into contract_owner[0field];

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    async mint_public self.caller r0 r1 into r2;
    output r2 as ego_token_v2.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get contract_owner[0field] into r3;
    assert.eq r0 r3;
    get.or_use account[r1] 0u64 into r4;
    add r4 r2 into r5;
    gte r5 r4 into r6;
    assert.eq r6 true;
    set r5 into account[r1];

function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as token.record;
    output r2 as token.record;

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as ego_token_v2.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get account[r0] into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    get.or_use account[r1] 0u64 into r5;
    add r5 r2 into r6;
    gte r6 r5 into r7;
    assert.eq r7 true;
    sub r3 r2 into r8;
    set r8 into account[r0];
    set r6 into account[r1];

function transfer_private:
    input r0 as token.record;
    input r1 as address.private;
    input r2 as u64.private;
    assert.eq r0.owner self.caller;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    cast r1 r2 into r4 as token.record;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as token.record;
    output r6 as token.record;
    output r4 as token.record;
