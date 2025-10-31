program token_test_zzz_xxx_1.aleo;

mapping balances:
    key as address.public;
    value as u64.public;

mapping admins:
    key as address.public;
    value as boolean.public;

function add_admin:
    input r0 as address.private;
    is.eq aleo1fglra93n8c022cz62rn70sx2xmqq8amfkfrmympw7tua6fusacps2wyntg self.caller into r1;
    assert.eq r1 true;
    async add_admin self.caller r0 into r2;
    output r2 as token_test_zzz_xxx_1.aleo/add_admin.future;

finalize add_admin:
    input r0 as address.public;
    input r1 as address.public;
    set true into admins[r1];

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    async mint_public r0 r1 self.caller into r2;
    output r2 as token_test_zzz_xxx_1.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as address.public;
    get.or_use admins[r2] false into r3;
    assert.eq r3 true;
    get.or_use balances[r0] 0u64 into r4;
    add r4 r1 into r5;
    set r5 into balances[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as token_test_zzz_xxx_1.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use balances[r0] 0u64 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    get.or_use balances[r1] 0u64 into r5;
    sub r3 r2 into r6;
    set r6 into balances[r0];
    add r5 r2 into r7;
    set r7 into balances[r1];

function burn_public:
    input r0 as address.public;
    input r1 as u64.public;
    async burn_public self.caller r0 r1 into r2;
    output r2 as token_test_zzz_xxx_1.aleo/burn_public.future;

finalize burn_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use admins[r0] false into r3;
    assert.eq r3 true;
    get.or_use balances[r1] 0u64 into r4;
    gte r4 r2 into r5;
    assert.eq r5 true;
    sub r4 r2 into r6;
    set r6 into balances[r1];
