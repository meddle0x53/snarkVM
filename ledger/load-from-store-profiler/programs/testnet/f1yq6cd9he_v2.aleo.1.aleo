program f1yq6cd9he_v2.aleo;

record Pass:
    owner as address.private;
    issuer as address.private;
    field1 as u32.private;
    field2 as u32.private;

record Report:
    owner as address.private;
    sender as address.private;
    recipient as address.private;
    amount as u128.private;

record Token:
    owner as address.private;
    amount as u128.private;

function get_pass:
    input r0 as address.private;
    cast r0 self.caller 1u32 0u32 into r1 as Pass.record;
    async get_pass self.caller into r2;
    output r1 as Pass.record;
    output r2 as f1yq6cd9he_v2.aleo/get_pass.future;

finalize get_pass:
    input r0 as address.public;
    assert.eq true true;

function get_token:
    input r0 as address.private;
    cast r0 10u128 into r1 as Token.record;
    async get_token self.caller into r2;
    output r1 as Token.record;
    output r2 as f1yq6cd9he_v2.aleo/get_token.future;

finalize get_token:
    input r0 as address.public;
    assert.eq true true;

function transfer_private:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as Token.record;
    input r3 as Pass.record;
    cast r3.owner self.caller r3.field1 r3.field2 into r4 as Pass.record;
    sub r2.amount r1 into r5;
    cast r2.owner r5 into r6 as Token.record;
    cast r0 r1 into r7 as Token.record;
    gt r1 2u128 into r8;
    cast aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn self.caller r0 r1 into r9 as Report.record;
    async transfer_private into r10;
    output r4 as Pass.record;
    output r7 as Token.record;
    output r6 as Token.record;
    output r10 as f1yq6cd9he_v2.aleo/transfer_private.future;

finalize transfer_private:
    assert.eq true true;
