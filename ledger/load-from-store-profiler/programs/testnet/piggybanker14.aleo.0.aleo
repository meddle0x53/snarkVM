import credits.aleo;

program piggybanker14.aleo;

struct Vault:
    amount as u64;
    token_id as field;
    start_time as u32;
    end_time as u32;

struct Identity:
    beneficiary as address;
    vault_id as u128;

mapping vaults:
    key as address.public;
    value as Vault.public;

function createvault:
    input r0 as u128.private;
    input r1 as u32.private;
    input r2 as u32.private;
    input r3 as u64.private;
    mul r2 144u32 into r4;
    cast self.signer r0 into r5 as Identity;
    add r1 r4 into r6;
    cast r3 3443843282313283355522573239085696902919850365217539366784739393210722344986field r1 r6 into r7 as Vault;
    call credits.aleo/transfer_public_as_signer piggybanker14.aleo r3 into r8;
    hash.psd2 r5 into r9 as address;
    async createvault r9 r7 r1 r8 into r10;
    output r10 as piggybanker14.aleo/createvault.future;

finalize createvault:
    input r0 as address.public;
    input r1 as Vault.public;
    input r2 as u32.public;
    input r3 as credits.aleo/transfer_public_as_signer.future;
    await r3;
    sub block.height r2 into r4;
    lt r4 144u32 into r5;
    assert.eq r5 true;
    contains vaults[r0] into r6;
    assert.neq true r6;
    set r1 into vaults[r0];

function deposit:
    input r0 as u128.private;
    input r1 as u64.private;
    call credits.aleo/transfer_public_as_signer piggybanker14.aleo r1 into r2;
    cast self.signer r0 into r3 as Identity;
    gt r1 0u64 into r4;
    assert.eq r4 true;
    hash.psd2 r3 into r5 as address;
    async deposit r5 r1 r2 into r6;
    output r6 as piggybanker14.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    await r2;
    contains vaults[r0] into r3;
    assert.eq r3 true;
    get vaults[r0] into r4;
    add r4.amount r1 into r5;
    cast r5 r4.token_id r4.start_time r4.end_time into r6 as Vault;
    set r6 into vaults[r0];

function withdraw:
    input r0 as u128.private;
    input r1 as address.private;
    input r2 as u64.private;
    cast r1 r0 into r3 as Identity;
    gt r2 0u64 into r4;
    assert.eq r4 true;
    call credits.aleo/transfer_public_to_private r1 r2 into r5 r6;
    hash.psd2 r3 into r7 as address;
    async withdraw r7 r2 r6 into r8;
    output r5 as credits.aleo/credits.record;
    output r8 as piggybanker14.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_to_private.future;
    await r2;
    contains vaults[r0] into r3;
    assert.eq r3 true;
    get vaults[r0] into r4;
    gt block.height r4.end_time into r5;
    assert.eq true r5;
    is.eq r4.amount r1 into r6;
    branch.eq r6 false to end_then_0_0;
    remove vaults[r0];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    sub r4.amount r1 into r7;
    cast r7 r4.token_id r4.start_time r4.end_time into r8 as Vault;
    set r8 into vaults[r0];
    position end_otherwise_0_1;
