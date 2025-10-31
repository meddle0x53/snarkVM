import credits.aleo;
import token_registry.aleo;

program aplbtest94.aleo;

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
    call token_registry.aleo/register_token 2939230203908012121331field 548998256723037837545028u128 1095781442u128 6u8 1000000000000000u128 false aplbtest94.aleo into r0;
    async initialize r0 into r1;
    output r1 as aplbtest94.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_public:
    input r0 as u128.private;
    mul r0 100000u128 into r1;
    div r1 1000000u128 into r2;
    cast r2 into r3 as u64;
    call credits.aleo/transfer_public_as_signer aleo1xfvzdlxj7r38adsxprkkasxwpm9a9u6dmfznrmzvdueapmwfmqzsprsxgh r3 into r4;
    call token_registry.aleo/mint_public 2939230203908012121331field self.caller r0 4294967295u32 into r5;
    async mint_public r0 r4 r5 into r6;
    output r6 as aplbtest94.aleo/mint_public.future;

finalize mint_public:
    input r0 as u128.public;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    input r2 as token_registry.aleo/mint_public.future;
    gte block.height 7200000u32 into r3;
    assert.eq r3 true;
    await r1;
    await r2;

function mint_private:
    input r0 as u128.private;
    mul r0 100000u128 into r1;
    div r1 1000000u128 into r2;
    cast r2 into r3 as u64;
    call credits.aleo/transfer_public_as_signer aleo1xfvzdlxj7r38adsxprkkasxwpm9a9u6dmfznrmzvdueapmwfmqzsprsxgh r3 into r4;
    call token_registry.aleo/mint_private 2939230203908012121331field self.caller r0 false 4294967295u32 into r5 r6;
    async mint_private r0 r4 r6 into r7;
    output r5 as token_registry.aleo/Token.record;
    output r7 as aplbtest94.aleo/mint_private.future;

finalize mint_private:
    input r0 as u128.public;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    input r2 as token_registry.aleo/mint_private.future;
    gte block.height 7200000u32 into r3;
    assert.eq r3 true;
    await r1;
    await r2;

function update_admin:
    input r0 as address.private;
    assert.eq self.caller aleo1xfvzdlxj7r38adsxprkkasxwpm9a9u6dmfznrmzvdueapmwfmqzsprsxgh;
    call token_registry.aleo/update_token_management 2939230203908012121331field r0 r0 into r1;
    async update_admin r1 into r2;
    output r2 as aplbtest94.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
