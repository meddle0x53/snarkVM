import credits.aleo;
import token_registry.aleo;

program zsociety_token_v3.aleo;

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

struct Balance:
    token_id as field;
    account as address;
    balance as u128;
    authorized_until as u32;

mapping account_already_claimed:
    key as address.public;
    value as u128.public;

mapping balances:
    key as u8.public;
    value as u128.public;

mapping has_minted:
    key as u8.public;
    value as boolean.public;

function transfer_public_as_signer:
    input r0 as address.public;
    input r1 as u128.public;
    cast self.signer 777field into r2 as TokenOwner;
    call token_registry.aleo/prehook_public r2 r1 4294967295u32 into r3;
    call token_registry.aleo/transfer_public_as_signer 777field r0 r1 into r4;
    async transfer_public_as_signer self.signer r0 r1 r3 r4 into r5;
    output r5 as zsociety_token_v3.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as token_registry.aleo/prehook_public.future;
    input r4 as token_registry.aleo/transfer_public_as_signer.future;
    cast r0 777field into r5 as TokenOwner;
    hash.bhp256 r5 into r6 as field;
    cast 0field aleo1wamjqlka7d0gazlxdys6n8e8zeee3ymedwvw8elvh7529kwd45rq0plgax 0u128 4294967295u32 into r7 as Balance;
    get.or_use token_registry.aleo/balances[r6] r7 into r8;
    gt r8.balance 0u128 into r9;
    assert.eq r9 true;
    div r2 r8.balance into r10;
    get.or_use account_already_claimed[r0] 0u128 into r11;
    get.or_use account_already_claimed[r1] 0u128 into r12;
    sub r11 r10 into r13;
    add r12 r10 into r14;
    set r13 into account_already_claimed[r0];
    set r14 into account_already_claimed[r1];
    await r3;
    await r4;

function mint_public:
    assert.eq self.caller aleo1wamjqlka7d0gazlxdys6n8e8zeee3ymedwvw8elvh7529kwd45rq0plgax;
    call token_registry.aleo/mint_public 777field aleo1wamjqlka7d0gazlxdys6n8e8zeee3ymedwvw8elvh7529kwd45rq0plgax 1000000000000u128 4294967295u32 into r0;
    async mint_public r0 into r1;
    output r1 as zsociety_token_v3.aleo/mint_public.future;

finalize mint_public:
    input r0 as token_registry.aleo/mint_public.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function initialize_token:
    assert.eq self.caller aleo1wamjqlka7d0gazlxdys6n8e8zeee3ymedwvw8elvh7529kwd45rq0plgax;
    call token_registry.aleo/register_token 777field 8814511368454894713u128 1515410521u128 6u8 1000000000000u128 true zsociety_token_v3.aleo into r0;
    async initialize_token r0 into r1;
    output r1 as zsociety_token_v3.aleo/initialize_token.future;

finalize initialize_token:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function withdraw_income_as_signer:
    input r0 as u64.public;
    call credits.aleo/transfer_public self.signer r0 into r1;
    async withdraw_income_as_signer r0 self.signer r1 into r2;
    output r2 as zsociety_token_v3.aleo/withdraw_income_as_signer.future;

finalize withdraw_income_as_signer:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as credits.aleo/transfer_public.future;
    cast r1 777field into r3 as TokenOwner;
    hash.bhp256 r3 into r4 as field;
    cast 0field aleo1wamjqlka7d0gazlxdys6n8e8zeee3ymedwvw8elvh7529kwd45rq0plgax 0u128 4294967295u32 into r5 as Balance;
    get.or_use token_registry.aleo/balances[r4] r5 into r6;
    get.or_use credits.aleo/account[zsociety_token_v3.aleo] 0u64 into r7;
    get.or_use balances[0u8] 0u128 into r8;
    cast r7 into r9 as u128;
    add r9 r8 into r10;
    get.or_use account_already_claimed[r1] 0u128 into r11;
    mul r6.balance r10 into r12;
    div r12 1000000000000u128 into r13;
    sub r13 r11 into r14;
    cast r0 into r15 as u128;
    lte r15 r14 into r16;
    assert.eq r16 true;
    add r8 r15 into r17;
    add r11 r15 into r18;
    set r17 into balances[0u8];
    set r18 into account_already_claimed[r1];
    await r2;
