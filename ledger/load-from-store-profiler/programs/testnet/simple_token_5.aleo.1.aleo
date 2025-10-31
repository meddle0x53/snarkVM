import credits.aleo;
import token_registry.aleo;

program simple_token_5.aleo;

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
    input r0 as field.private;
    assert.eq self.caller aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu;
    call token_registry.aleo/register_token r0 216163108180u128 5526356u128 6u8 1000000000000000u128 false simple_token_5.aleo into r1;
    call token_registry.aleo/set_role 216163108181field aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu 1u8 into r2;
    async initialize r1 r2 into r3;
    output r3 as simple_token_5.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as token_registry.aleo/set_role.future;
    await r0;
    await r1;

function mint_public:
    call token_registry.aleo/mint_public 4846247369341682005field aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu 1000000000000000u128 4294967295u32 into r0;
    async mint_public r0 into r1;
    output r1 as simple_token_5.aleo/mint_public.future;

finalize mint_public:
    input r0 as token_registry.aleo/mint_public.future;
    await r0;
