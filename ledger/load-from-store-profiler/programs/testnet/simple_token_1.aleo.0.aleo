import credits.aleo;
import token_registry.aleo;

program simple_token_1.aleo;

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

function initialize:
    assert.eq self.caller aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu;
    call token_registry.aleo/register_token 211868140885field 211868140884u128 5526356u128 6u8 1000000000000000u128 false simple_token_1.aleo into r0;
    call token_registry.aleo/mint_public 4846247369341682005field aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu 1000000000000000u128 4294967295u32 into r1;
    async initialize r0 r1 into r2;
    output r2 as simple_token_1.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;
