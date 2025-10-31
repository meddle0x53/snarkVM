import credits.aleo;

program piggybanker10.aleo;

record Vault:
    owner as address.private;
    amount as u128.private;
    token_id as field.private;
    start_time as u32.private;
    end_time as u32.private;

mapping account:
    key as address.public;
    value as u64.public;

function rcreatevault:
    input r0 as credits.aleo/credits.record;
    input r1 as u32.private;
    input r2 as u32.private;
    input r3 as u64.private;
    call credits.aleo/transfer_private_to_public r0 piggybanker10.aleo r3 into r4 r5;
    mul r2 144u32 into r6;
    cast r3 into r7 as u128;
    add r1 r6 into r8;
    cast self.signer r7 3443843282313283355522573239085696902919850365217539366784739393210722344986field r1 r8 into r9 as Vault.record;
    async rcreatevault r5 r1 into r10;
    output r4 as credits.aleo/credits.record;
    output r9 as Vault.record;
    output r10 as piggybanker10.aleo/rcreatevault.future;

finalize rcreatevault:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as u32.public;
    await r0;
    sub block.height r1 into r2;
    lt r2 144u32 into r3;
    assert.eq true r3;

function createvault:
    input r0 as u32.private;
    input r1 as u32.private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_as_signer piggybanker10.aleo r2 into r3;
    mul r1 144u32 into r4;
    cast r2 into r5 as u128;
    add r0 r4 into r6;
    cast self.signer r5 3443843282313283355522573239085696902919850365217539366784739393210722344986field r0 r6 into r7 as Vault.record;
    async createvault r3 r0 into r8;
    output r7 as Vault.record;
    output r8 as piggybanker10.aleo/createvault.future;

finalize createvault:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as u32.public;
    await r0;
    sub block.height r1 into r2;
    lt r2 144u32 into r3;
    assert.eq true r3;

function withdraw:
    input r0 as Vault.record;
    input r1 as address.public;
    input r2 as u128.public;
    gt r0.amount 0u128 into r3;
    assert.eq true r3;
    lte r2 r0.amount into r4;
    assert.eq true r4;
    sub r0.amount r2 into r5;
    cast r0.owner r5 r0.token_id r0.start_time r0.end_time into r6 as Vault.record;
    cast r2 into r7 as u64;
    call credits.aleo/transfer_public_to_private r0.owner r7 into r8 r9;
    async withdraw r9 r0.end_time into r10;
    output r6 as Vault.record;
    output r8 as credits.aleo/credits.record;
    output r10 as piggybanker10.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as u32.public;
    await r0;
    gt block.height r1 into r2;
    assert.eq true r2;
