import credits.aleo;

program rntokenforchrysalis.aleo;

mapping balances:
    key as address.public;
    value as u64.public;

mapping staked_tokens:
    key as address.public;
    value as u64.public;

function deposit:
    input r0 as u64.public;
    gte r0 1u64 into r1;
    assert.eq r1 true;
    cast r0 into r2 as u64;
    call credits.aleo/transfer_public_as_signer rntokenforchrysalis.aleo r2 into r3;
    cast r0 into r4 as u64;
    async deposit r3 self.signer r4 into r5;
    output r5 as rntokenforchrysalis.aleo/deposit.future;

finalize deposit:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get.or_use balances[r1] 0u64 into r3;
    add r3 r2 into r4;
    set r4 into balances[r1];

function get_staked_tokens:
    input r0 as address.public;
    async get_staked_tokens r0 into r1;
    output r1 as rntokenforchrysalis.aleo/get_staked_tokens.future;

finalize get_staked_tokens:
    input r0 as address.public;
    get.or_use staked_tokens[r0] 0u64 into r1;
