program privacy_onramp.aleo;

record PrivateToken:
    owner as address.private;
    amount as u64.private;

record ServiceWallet:
    owner as address.private;
    amount as u64.private;

mapping orders:
    key as field.public;
    value as u64.public;

function initialize:
    input r0 as u64.public;
    cast self.caller r0 into r1 as ServiceWallet.record;
    output r1 as ServiceWallet.record;

function convert_to_private:
    input r0 as ServiceWallet.record;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as field.public;
    gte r0.amount r2 into r4;
    assert.eq r4 true;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as ServiceWallet.record;
    cast r1 r2 into r7 as PrivateToken.record;
    async convert_to_private r3 r2 into r8;
    output r6 as ServiceWallet.record;
    output r7 as PrivateToken.record;
    output r8 as privacy_onramp.aleo/convert_to_private.future;

finalize convert_to_private:
    input r0 as field.public;
    input r1 as u64.public;
    set r1 into orders[r0];

function transfer:
    input r0 as PrivateToken.record;
    input r1 as address.public;
    input r2 as u64.public;
    assert.eq r0.owner self.caller;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    cast r1 r2 into r4 as PrivateToken.record;
    sub r0.amount r2 into r5;
    cast r0.owner r5 into r6 as PrivateToken.record;
    output r6 as PrivateToken.record;
    output r4 as PrivateToken.record;
