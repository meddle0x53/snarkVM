import credits.aleo;
import token_registry.aleo;

program arc21_assignement5.aleo;

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
    assert.eq self.caller aleo1lyc6mmc4f9mzchu8yzudp8vrfx5tfmcnc0yv5ygrlutrnnx7mq8s343cwq;
    call token_registry.aleo/register_token 173765353765376563field 86737666361807723019642759672494526464u128 86633601612313353851139632512578760704u128 10u8 1000000000u128 true arc21_assignement5.aleo into r0;
    async initialize r0 into r1;
    output r1 as arc21_assignement5.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.private;
    gte r0 5u128 into r1;
    assert.eq r1 true;
    div r0 5u128 into r2;
    call token_registry.aleo/mint_public 173765353765376563field self.signer r2 4294967295u32 into r3;
    call token_registry.aleo/transfer_public 3443843282313283355522573239085696902919850365217539366784739393210722344986field arc21_assignement5.aleo r2 into r4;
    async mint r3 r4 into r5;
    output r5 as arc21_assignement5.aleo/mint.future;

finalize mint:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as token_registry.aleo/transfer_public.future;
    gte block.height 1000u32 into r2;
    assert.eq r2 true;
    await r0;
    await r1;

function update_admin:
    input r0 as address.private;
    is.eq self.signer aleo1lyc6mmc4f9mzchu8yzudp8vrfx5tfmcnc0yv5ygrlutrnnx7mq8s343cwq into r1;
    assert.eq r1 true;
    call token_registry.aleo/update_token_management 173765353765376563field r0 arc21_assignement5.aleo into r2;
    async update_admin r2 into r3;
    output r3 as arc21_assignement5.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
