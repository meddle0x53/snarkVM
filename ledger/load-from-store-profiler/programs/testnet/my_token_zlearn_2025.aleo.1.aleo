import credits.aleo;
import token_registry.aleo;

program my_token_zlearn_2025.aleo;

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
    call token_registry.aleo/register_token 829108928091814567field 1554521931324370666830u128 5526603u128 6u8 1000000000000u128 false aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f into r0;
    async initialize r0 into r1;
    output r1 as my_token_zlearn_2025.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint:
    input r0 as u128.private;
    cast r0 into r1 as u64;
    mul 10000000u64 r1 into r2;
    cast r2 into r3 as u128;
    call token_registry.aleo/transfer_public 3443843282313283355522573239085696902919850365217539366784739393210722344986field aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f r3 into r4;
    call token_registry.aleo/mint_public 829108928091814567field self.signer r0 1234u32 into r5;
    async mint r4 r5 into r6;
    output r6 as my_token_zlearn_2025.aleo/mint.future;

finalize mint:
    input r0 as token_registry.aleo/transfer_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    gte block.height 500000u32 into r2;
    assert.eq r2 true;
    await r0;
    await r1;

function update_admin:
    input r0 as address.public;
    call token_registry.aleo/update_token_management 829108928091814567field r0 aleo13jngfgyf86v3ke097ar4hdpkqmlvd3r7lzutkdaexcq2u76uzv8qud0z2f into r1;
    async update_admin r1 into r2;
    output r2 as my_token_zlearn_2025.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
