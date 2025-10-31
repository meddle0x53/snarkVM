import credits.aleo;
import token_registry.aleo;

program just_take_record2.aleo;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

mapping allowed_programs:
    key as field.public;
    value as boolean.public;

function take_record:
    input r0 as token_registry.aleo/Token.record;
    async take_record r0.token_id into r1;
    output r1 as just_take_record2.aleo/take_record.future;

finalize take_record:
    input r0 as field.public;
    set true into allowed_programs[r0];
