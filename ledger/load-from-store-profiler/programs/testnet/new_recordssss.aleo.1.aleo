program new_recordssss.aleo;

record Token:
    owner as address.private;
    token_id as u32.private;

mapping token:
    key as boolean.public;
    value as u32.public;

function get_record:
    input r0 as u32.private;
    cast self.signer r0 into r1 as Token.record;
    output r1 as Token.record;

function throw_error:
    async throw_error into r0;
    output r0 as new_recordssss.aleo/throw_error.future;

finalize throw_error:
    contains token[true] into r0;
    assert.eq r0 true;
