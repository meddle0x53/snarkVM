import credits.aleo;
import token_registry.aleo;

program second_assignement.aleo;

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
    call token_registry.aleo/register_token 816833123field 82462020551622442035522468669263693962u128 506097522914230528u128 6u8 1000000u128 false self.signer into r0;
    async initialize r0 into r1;
    output r1 as second_assignement.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.public;
    input r1 as u32.public;
    gte r1 50000u32 into r2;
    assert.eq r2 true;
    mul r0 10000u128 into r3;
    call token_registry.aleo/transfer_public 3443843282313283355522573239085696902919850365217539366784739393210722344986field aleo1udqhkkr39eprzfg9dgkkv3mwve27590qtss9rfafcpuse9tsxqgslxjqmv r3 into r4;
    call token_registry.aleo/mint_public 816833123field self.signer r0 0u32 into r5;
    async mint r4 r5 into r6;
    output r6 as second_assignement.aleo/mint.future;

finalize mint:
    input r0 as token_registry.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    await r0;
    await r1;

function update_admin:
    input r0 as address.public;
    call token_registry.aleo/update_token_management 816833123field r0 self.signer into r1;
    async update_admin r1 into r2;
    output r2 as second_assignement.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
