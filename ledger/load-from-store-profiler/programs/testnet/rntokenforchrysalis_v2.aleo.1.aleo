import credits.aleo;

program rntokenforchrysalis_v2.aleo;

mapping balances:
    key as address.public;
    value as u64.public;

mapping staked_tokens:
    key as address.public;
    value as u64.public;

mapping staking_time:
    key as address.public;
    value as u32.public;

mapping reward_amount:
    key as address.public;
    value as u64.public;

function deposit:
    input r0 as u64.public;
    gte r0 1u64 into r1;
    assert.eq r1 true;
    cast r0 into r2 as u64;
    call credits.aleo/transfer_public_as_signer rntokenforchrysalis_v2.aleo r2 into r3;
    cast r0 into r4 as u64;
    async deposit r3 self.signer r4 into r5;
    output r5 as rntokenforchrysalis_v2.aleo/deposit.future;

finalize deposit:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get.or_use balances[r1] 0u64 into r3;
    add r3 r2 into r4;
    set r4 into balances[r1];
    set block.height into staking_time[r1];

function unstake:
    input r0 as u64.public;
    gt r0 0u64 into r1;
    assert.eq r1 true;
    cast r0 into r2 as u64;
    call credits.aleo/transfer_public_as_signer self.signer r2 into r3;
    cast r0 into r4 as u64;
    async unstake r3 self.signer r4 into r5;
    output r5 as rntokenforchrysalis_v2.aleo/unstake.future;

finalize unstake:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use balances[r1] 0u64 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    get.or_use balances[r1] 0u64 into r5;
    sub r5 r2 into r6;
    set r6 into balances[r1];
    set block.height into staking_time[r1];
    await r0;

function claim:
    input r0 as u64.private;
    cast r0 into r1 as u64;
    call credits.aleo/transfer_public_as_signer self.signer r1 into r2;
    cast r0 into r3 as u64;
    async claim r2 self.signer r3 into r4;
    output r4 as rntokenforchrysalis_v2.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use balances[r1] 0u64 into r3;
    get.or_use staking_time[r1] 0u32 into r4;
    sub block.height r4 into r5;
    cast r5 into r6 as u64;
    mul r3 r6 into r7;
    mul r7 1u64 into r8;
    gt r8 0u64 into r9;
    assert.eq r9 true;
    await r0;
    set block.height into staking_time[r1];

function claimable_amount:
    input r0 as address.private;
    async claimable_amount r0 into r1;
    output r1 as rntokenforchrysalis_v2.aleo/claimable_amount.future;

finalize claimable_amount:
    input r0 as address.public;
    get.or_use balances[r0] 0u64 into r1;
    get.or_use staking_time[r0] 0u32 into r2;
    sub block.height r2 into r3;
    cast r3 into r4 as u64;
    mul r1 r4 into r5;
    mul r5 1u64 into r6;
    set r6 into reward_amount[r0];
    get.or_use reward_amount[r0] 0u64 into r7;

function get_staked_tokens:
    input r0 as address.public;
    async get_staked_tokens r0 into r1;
    output r1 as rntokenforchrysalis_v2.aleo/get_staked_tokens.future;

finalize get_staked_tokens:
    input r0 as address.public;
    get.or_use staked_tokens[r0] 0u64 into r1;
