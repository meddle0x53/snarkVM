import credits.aleo;

program piggybanker11.aleo;

record Vault:
    owner as address.private;
    amount as u128.private;
    token_id as field.private;
    start_time as u32.private;
    end_time as u32.private;

mapping account:
    key as address.public;
    value as u64.public;

function rdeposit:
    input r0 as credits.aleo/credits.record;
    input r1 as Vault.record;
    input r2 as u64.private;
    call credits.aleo/transfer_private_to_public r0 piggybanker11.aleo r2 into r3 r4;
    cast r2 into r5 as u128;
    add r1.amount r5 into r6;
    cast r1.owner r6 r1.token_id r1.start_time r1.end_time into r7 as Vault.record;
    async rdeposit r4 into r8;
    output r3 as credits.aleo/credits.record;
    output r7 as Vault.record;
    output r8 as piggybanker11.aleo/rdeposit.future;

finalize rdeposit:
    input r0 as credits.aleo/transfer_private_to_public.future;
    await r0;

function deposit:
    input r0 as Vault.record;
    input r1 as u64.private;
    call credits.aleo/transfer_public_as_signer piggybanker11.aleo r1 into r2;
    cast r1 into r3 as u128;
    add r0.amount r3 into r4;
    cast r0.owner r4 r0.token_id r0.start_time r0.end_time into r5 as Vault.record;
    async deposit r2 into r6;
    output r5 as Vault.record;
    output r6 as piggybanker11.aleo/deposit.future;

finalize deposit:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    await r0;

function createvault:
    input r0 as u32.private;
    input r1 as u32.private;
    mul r1 144u32 into r2;
    add r0 r2 into r3;
    cast self.signer 0u128 3443843282313283355522573239085696902919850365217539366784739393210722344986field r0 r3 into r4 as Vault.record;
    async createvault r0 into r5;
    output r4 as Vault.record;
    output r5 as piggybanker11.aleo/createvault.future;

finalize createvault:
    input r0 as u32.public;
    sub block.height r0 into r1;
    lt r1 144u32 into r2;
    assert.eq true r2;

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
    output r10 as piggybanker11.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as u32.public;
    await r0;
    gt block.height r1 into r2;
    assert.eq true r2;
