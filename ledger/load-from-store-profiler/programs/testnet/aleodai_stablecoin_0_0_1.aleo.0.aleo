program aleodai_stablecoin_0_0_1.aleo;

mapping balances:
    key as address.public;
    value as u32.public;

mapping admins:
    key as address.public;
    value as boolean.public;

function mint_public:
    input r0 as address.public;
    input r1 as u32.public;
    assert.eq aleodai_vault_contract_0_0_1.aleo self.caller;
    async mint_public r0 r1 into r2;
    output r2 as aleodai_stablecoin_0_0_1.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u32.public;
    get.or_use balances[r0] 0u32 into r2;
    add r2 r1 into r3;
    set r3 into balances[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u32.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as aleodai_stablecoin_0_0_1.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u32.public;
    get.or_use balances[r0] 0u32 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    get.or_use balances[r1] 0u32 into r5;
    sub r3 r2 into r6;
    set r6 into balances[r0];
    add r5 r2 into r7;
    set r7 into balances[r1];

function transfer_public_as_signer:
    input r0 as address.public;
    input r1 as u32.public;
    async transfer_public_as_signer self.signer r0 r1 into r2;
    output r2 as aleodai_stablecoin_0_0_1.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u32.public;
    get.or_use balances[r0] 0u32 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    get.or_use balances[r1] 0u32 into r5;
    sub r3 r2 into r6;
    set r6 into balances[r0];
    add r5 r2 into r7;
    set r7 into balances[r1];

function burn_public:
    input r0 as address.public;
    input r1 as u32.public;
    async burn_public self.caller r0 r1 into r2;
    output r2 as aleodai_stablecoin_0_0_1.aleo/burn_public.future;

finalize burn_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u32.public;
    get.or_use admins[r0] false into r3;
    assert.eq r3 true;
    get.or_use balances[r1] 0u32 into r4;
    gte r4 r2 into r5;
    assert.eq r5 true;
    sub r4 r2 into r6;
    set r6 into balances[r1];
