import credits.aleo;
import token_registry.aleo;

program basic_token.aleo;

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
    assert.eq self.caller aleo15xd9tee983ts3urff8j22q64wvcyc8geakghyc3ew5u0v8jfuqgs958t6d;
    call token_registry.aleo/register_token 4846247369341682005field 4846247369341682004u128 4846247369341682004u128 6u8 1000000000000000u128 false basic_token.aleo into r0;
    call token_registry.aleo/mint_public 4846247369341682005field aleo15xd9tee983ts3urff8j22q64wvcyc8geakghyc3ew5u0v8jfuqgs958t6d 1000000000000000u128 4294967295u32 into r1;
    async initialize r0 r1 into r2;
    output r2 as basic_token.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;
