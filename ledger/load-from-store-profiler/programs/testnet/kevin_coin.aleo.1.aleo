import credits.aleo;
import multi_token_support_program.aleo;

program kevin_coin.aleo;

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
    call multi_token_support_program.aleo/register_token 1388502066965316061518field 1388502066965316061518u128 1388502066965316061518u128 4u8 500000000000000u128 true kevin_coin.aleo into r0;
    call multi_token_support_program.aleo/mint_public 1388502066965316061518field aleo15xd9tee983ts3urff8j22q64wvcyc8geakghyc3ew5u0v8jfuqgs958t6d 500000000000000u128 4294967295u32 into r1;
    async initialize r0 r1 into r2;
    output r2 as kevin_coin.aleo/initialize.future;

finalize initialize:
    input r0 as multi_token_support_program.aleo/register_token.future;
    input r1 as multi_token_support_program.aleo/mint_public.future;
    await r0;
    await r1;
