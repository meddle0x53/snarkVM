import credits.aleo;

program escrow_advanced.aleo;

mapping balances:
    key as address.public;
    value as u64.public;

mapping authorized_recipients:
    key as address.public;
    value as boolean.public;

function deposit_and_lock:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public self.signer r1 into r2;
    async deposit_and_lock r2 self.caller r0 r1 into r3;
    output r3 as escrow_advanced.aleo/deposit_and_lock.future;

finalize deposit_and_lock:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as u64.public;
    await r0;
    get.or_use balances[r1] 0u64 into r4;
    add r4 r3 into r5;
    set r5 into balances[r1];
    set true into authorized_recipients[r2];

function release_to_recipient:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public_as_signer self.caller r1 into r2;
    async release_to_recipient r2 r0 r1 into r3;
    output r3 as escrow_advanced.aleo/release_to_recipient.future;

finalize release_to_recipient:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get.or_use authorized_recipients[r1] false into r3;
    assert.eq r3 true;
    get.or_use balances[r1] 0u64 into r4;
    gte r4 r2 into r5;
    assert.eq r5 true;
    sub r4 r2 into r6;
    set r6 into balances[r1];
    is.eq r4 0u64 into r7;
    assert.eq r7 true;
    set false into authorized_recipients[r1];
