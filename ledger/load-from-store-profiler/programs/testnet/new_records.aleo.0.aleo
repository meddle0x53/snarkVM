program new_records.aleo;

record Token:
    owner as address.private;
    token_id as u32.private;

function get_record:
    input r0 as u32.private;
    cast self.signer r0 into r1 as Token.record;
    output r1 as Token.record;
