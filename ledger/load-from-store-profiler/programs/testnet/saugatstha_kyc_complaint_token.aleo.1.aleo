import credits.aleo;
import token_registry.aleo;

program saugatstha_kyc_complaint_token.aleo;

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

record SpendLimit:
    owner as address.private;
    amount_spent as u128.private;
    epoch_spent as u32.private;

mapping has_minted:
    key as u8.public;
    value as boolean.public;

mapping kyc_aml_status:
    key as address.public;
    value as boolean.public;

function initialize:
    assert.eq self.caller aleo1rdszsdqcm3y0fztxzhpzqydqs07qgmtatl9slypyl0hw8lxpnyxqlrt2ct;
    call token_registry.aleo/register_token 71619063553950105623552field 71619063553950105623552u128 71619063553950105623552u128 6u8 1000000000000000u128 true saugatstha_kyc_complaint_token.aleo into r0;
    async initialize r0 into r1;
    output r1 as saugatstha_kyc_complaint_token.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo1rdszsdqcm3y0fztxzhpzqydqs07qgmtatl9slypyl0hw8lxpnyxqlrt2ct;
    call token_registry.aleo/mint_private 71619063553950105623552field aleo1rdszsdqcm3y0fztxzhpzqydqs07qgmtatl9slypyl0hw8lxpnyxqlrt2ct 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as saugatstha_kyc_complaint_token.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo1rdszsdqcm3y0fztxzhpzqydqs07qgmtatl9slypyl0hw8lxpnyxqlrt2ct;
    cast r0 0u128 0u32 into r1 as SpendLimit.record;
    output r1 as SpendLimit.record;

function register_kyc_aml:
    input r0 as address.private;
    assert.eq self.caller aleo1rdszsdqcm3y0fztxzhpzqydqs07qgmtatl9slypyl0hw8lxpnyxqlrt2ct;
    async register_kyc_aml r0 into r1;
    output r1 as saugatstha_kyc_complaint_token.aleo/register_kyc_aml.future;

finalize register_kyc_aml:
    input r0 as address.public;
    set true into kyc_aml_status[r0];
