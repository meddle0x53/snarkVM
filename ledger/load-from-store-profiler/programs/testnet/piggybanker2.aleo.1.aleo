import credits.aleo;

program piggybanker2.aleo;

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
    input r2 as u128.private;
    mul r1 144u32 into r3;
    add r0 r3 into r4;
    cast self.signer r2 3443843282313283355522573239085696902919850365217539366784739393210722344986field r0 r4 into r5 as Vault.record;
    async createvault r0 self.signer r2 into r6;
    output r5 as Vault.record;
    output r6 as piggybanker2.aleo/createvault.future;

finalize createvault:
    input r0 as u32.public;
    input r1 as address.public;
    input r2 as u128.public;
    sub block.height r0 into r3;
    lt r3 72u32 into r4;
    assert.eq true r4;
    get.or_use balance[r1] 0u128 into r5;
    gt r2 0u128 into r6;
    assert.eq true r6;
    lte r2 r5 into r7;
    assert.eq true r7;
    sub r5 r2 into r8;
    set r8 into balance[r1];

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
    output r6 as piggybanker2.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u32.public;
    gt block.height r2 into r3;
    assert.eq true r3;
    get.or_use balance[r0] 0u128 into r4;
    add r4 r1 into r5;
    set r5 into balance[r0];
