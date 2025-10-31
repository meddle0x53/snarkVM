import credits.aleo;

program piggybanker7.aleo;

record Vault:
    owner as address.private;
    amount as u128.private;
    token_id as field.private;
    start_time as u32.private;
    end_time as u32.private;

mapping balance:
    key as address.public;
    value as u128.public;

mapping account:
    key as address.public;
    value as u64.public;

function createvault:
    input r0 as u32.private;
    input r1 as u32.private;
    mul r1 144u32 into r2;
    add r0 r2 into r3;
    cast self.signer 0u128 3443843282313283355522573239085696902919850365217539366784739393210722344986field r0 r3 into r4 as Vault.record;
    async createvault r0 into r5;
    output r4 as Vault.record;
    output r5 as piggybanker7.aleo/createvault.future;

finalize createvault:
    input r0 as u32.public;
    sub block.height r0 into r1;
    lt r1 144u32 into r2;
    assert.eq true r2;

function privatize:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public_to_private r0 r1 into r2 r3;
    async privatize r3 self.signer r1 into r4;
    output r2 as credits.aleo/credits.record;
    output r4 as piggybanker7.aleo/privatize.future;

finalize privatize:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get.or_use account[r1] 0u64 into r3;
    gt r2 0u64 into r4;
    assert.eq true r4;
    gte r3 r2 into r5;
    assert.eq true r5;
    sub r3 r2 into r6;
    set r6 into account[r1];

function deposit:
    input r0 as Vault.record;
    input r1 as address.private;
    input r2 as u128.private;
    cast r2 into r3 as u64;
    add r0.amount r2 into r4;
    cast r0.owner r4 r0.token_id r0.start_time r0.end_time into r5 as Vault.record;
    assert.eq r1 r0.owner;
    async deposit r1 r2 into r6;
    output r5 as Vault.record;
    output r6 as piggybanker7.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as u128.public;
    get.or_use account[r0] 0u64 into r2;
    cast r2 into r3 as u128;
    gt r1 0u128 into r4;
    assert.eq true r4;
    gte r3 r1 into r5;
    assert.eq true r5;
    sub r3 r1 into r6;
    cast r6 into r7 as u64;
    set r7 into account[r0];

function withdraw:
    input r0 as Vault.record;
