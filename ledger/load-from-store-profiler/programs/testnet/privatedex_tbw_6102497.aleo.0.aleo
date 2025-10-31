import credits.aleo;
import token_registry.aleo;

program privatedex_tbw_6102497.aleo;

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
    assert.eq self.caller aleo1h7k3ttm6avttrgujp75wxfd5jf3ztmf9xcr4k6h6j9wj8z65uy9scuqkv8;
    call token_registry.aleo/register_token 23720122240807475field 23720122240807475u128 23720122240807475u128 6u8 1000000000000000u128 false privatedex_tbw_6102497.aleo into r0;
    call token_registry.aleo/mint_public 23720122240807475field self.caller 1000000000000000u128 0u32 into r1;
    async initialize r0 r1 into r2;
    output r2 as privatedex_tbw_6102497.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;

function initialize2:
    assert.eq self.caller aleo1h7k3ttm6avttrgujp75wxfd5jf3ztmf9xcr4k6h6j9wj8z65uy9scuqkv8;
    call token_registry.aleo/set_role 23720122240807475field privatedex_tbw_6102497.aleo 3u8 into r0;
    call token_registry.aleo/mint_public 23720122240807475field self.caller 1000000000000000u128 0u32 into r1;
    async initialize2 r0 r1 into r2;
    output r2 as privatedex_tbw_6102497.aleo/initialize2.future;

finalize initialize2:
    input r0 as token_registry.aleo/set_role.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;
