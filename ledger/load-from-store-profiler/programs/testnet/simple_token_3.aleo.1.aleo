import credits.aleo;
import token_registry.aleo;

program simple_token_3.aleo;

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
    call token_registry.aleo/register_token 216163108181field 216163108180u128 5526356u128 6u8 1000000000000000u128 false simple_token_3.aleo into r0;
    async initialize r0 into r1;
    output r1 as simple_token_3.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_public:
    call token_registry.aleo/mint_public 4846247369341682005field aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu 1000000000000000u128 4294967295u32 into r0;
    async mint_public r0 into r1;
    output r1 as simple_token_3.aleo/mint_public.future;

finalize mint_public:
    input r0 as token_registry.aleo/mint_public.future;
    await r0;
