program random_record_generator.aleo;

record Token:
    owner as address.private;
    amount as u128.private;
    token_id as field.private;
    external_authorization_required as boolean.private;
    authorized_until as u32.private;

function give_token:
    cast self.signer 10000000000u128 1068104870852223474792716721054209526718172707571751136410402215071671722040field false 4294967295u32 into r0 as Token.record;
    output r0 as Token.record;
