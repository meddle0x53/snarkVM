import credits.aleo;

program piggybanker4.aleo;

record Credits:
    owner as address.private;
    amount as u64.private;
    token_id as field.private;

record Vault:
    owner as address.private;
    amount as u128.private;
    token_id as field.private;
    start_time as u32.private;
    end_time as u32.private;

mapping balance:
    key as address.public;
    value as u128.public;

function createvault:
    input r0 as u32.private;
    input r1 as u32.private;
    mul r1 144u32 into r2;
    add r0 r2 into r3;
    cast self.signer 0u128 3443843282313283355522573239085696902919850365217539366784739393210722344986field r0 r3 into r4 as Vault.record;
    async createvault r0 into r5;
    output r4 as Vault.record;
    output r5 as piggybanker4.aleo/createvault.future;

finalize createvault:
    input r0 as u32.public;
    sub block.height r0 into r1;
    lt r1 144u32 into r2;
    assert.eq true r2;

function privatize:
    input r0 as u64.public;
    cast self.signer r0 3443843282313283355522573239085696902919850365217539366784739393210722344986field into r1 as Credits.record;
    async privatize 3443843282313283355522573239085696902919850365217539366784739393210722344986field r0 self.signer into r2;
    output r1 as Credits.record;
    output r2 as piggybanker4.aleo/privatize.future;

finalize privatize:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as address.public;
    cast r1 into r3 as u128;
    get.or_use balance[r2] 0u128 into r4;
    gte r4 r3 into r5;
    assert.eq true r5;
    sub r4 r3 into r6;
    set r6 into balance[r2];
    assert.eq r0 3443843282313283355522573239085696902919850365217539366784739393210722344986field;
    gt r3 0u128 into r7;
    assert.eq true r7;

function deposit:
    input r0 as Vault.record;
    input r1 as Credits.record;
    input r2 as u128.private;
    cast r2 into r3 as u64;
    add r0.amount r2 into r4;
    cast r0.owner r4 r0.token_id r0.start_time r0.end_time into r5 as Vault.record;
    sub r1.amount r3 into r6;
    cast r1.owner r6 3443843282313283355522573239085696902919850365217539366784739393210722344986field into r7 as Credits.record;
    assert.eq self.signer r0.owner;
    async deposit self.signer r2 into r8;
    output r5 as Vault.record;
    output r7 as Credits.record;
    output r8 as piggybanker4.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as u128.public;
    get.or_use balance[r0] 0u128 into r2;
    gt r1 0u128 into r3;
    assert.eq true r3;
    lte r1 r2 into r4;
    assert.eq true r4;
    sub r2 r1 into r5;
    set r5 into balance[r0];

function withdraw:
    input r0 as Vault.record;
    input r1 as u128.private;
    gt r0.amount 0u128 into r2;
    assert.eq true r2;
    lte r1 r0.amount into r3;
    assert.eq true r3;
    sub r0.amount r1 into r4;
    cast r0.owner r4 r0.token_id r0.start_time r0.end_time into r5 as Vault.record;
    async withdraw self.signer r1 r0.end_time into r6;
    output r5 as Vault.record;
    output r6 as piggybanker4.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u32.public;
    gt block.height r2 into r3;
    assert.eq true r3;
    get.or_use balance[r0] 0u128 into r4;
    add r4 r1 into r5;
    set r5 into balance[r0];
