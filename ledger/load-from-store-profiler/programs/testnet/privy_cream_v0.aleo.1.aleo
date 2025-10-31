import credits.aleo;
import token_registry.aleo;

program privy_cream_v0.aleo;

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
    assert.eq self.caller aleo1crdy6ehw4s66erc7y2028052vg42n8hdn836l26xj7qghtrqhq9ss64p50;
    call token_registry.aleo/register_token 4846247369341682006field 289143079245u128 289143079245u128 6u8 3000000000000u128 false privy_cream_v0.aleo into r0;
    call token_registry.aleo/mint_public 4846247369341682006field aleo1crdy6ehw4s66erc7y2028052vg42n8hdn836l26xj7qghtrqhq9ss64p50 3000000000000u128 4294967295u32 into r1;
    async initialize r0 r1 into r2;
    output r2 as privy_cream_v0.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;
