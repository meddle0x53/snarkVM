import credits.aleo;

program deaddropper.aleo;

struct Package:
    amount as u64;
    token_id as field;

struct Identity:
    beneficiary as address;
    vault_id as u128;

mapping drops:
    key as address.public;
    value as Package.public;

function dropper:
    input r0 as u128.private;
    input r1 as u64.private;
    cast r1 into r2 as u128;
    sub 314159265358979323846264u128 r2 into r3;
    sub r3 r0 into r4;
    hash.psd2 r4 into r5 as address;
    cast r5 r0 into r6 as Identity;
    cast r1 3443843282313283355522573239085696902919850365217539366784739393210722344986field into r7 as Package;
    call credits.aleo/transfer_public_as_signer deaddropper.aleo r1 into r8;
    hash.psd2 r6 into r9 as address;
    async dropper r9 r7 r8 into r10;
    output r10 as deaddropper.aleo/dropper.future;

finalize dropper:
    input r0 as address.public;
    input r1 as Package.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    await r2;
    contains drops[r0] into r3;
    assert.neq true r3;
    set r1 into drops[r0];

function magnet:
    input r0 as u128.private;
    input r1 as u128.private;
    add r1 r0 into r2;
    sub 314159265358979323846264u128 r2 into r3;
    cast r3 into r4 as u64;
    hash.psd2 r1 into r5 as address;
    cast r5 r0 into r6 as Identity;
    call credits.aleo/transfer_public_as_signer self.signer r4 into r7;
    hash.psd2 r6 into r8 as address;
    async magnet r8 r7 into r9;
    output r9 as deaddropper.aleo/magnet.future;

finalize magnet:
    input r0 as address.public;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    await r1;
    contains drops[r0] into r2;
    assert.eq true r2;
    remove drops[r0];
