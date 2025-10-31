import credits.aleo;
import multi_token_support_programv1.aleo;
import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;

program ans_credit_transfer.aleo;

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

struct data:
    metadata as [field; 4u32];

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as field;

struct NameTokenPair:
    name_hash as field;
    token_id as field;

mapping domain_credits:
    key as field.public;
    value as u64.public;

mapping domain_tokens:
    key as field.public;
    value as u128.public;

function transfer_credits:
    input r0 as field.private;
    input r1 as [u128; 2u32].private;
    input r2 as u64.private;
    input r3 as credits.aleo/credits.record;
    call credits.aleo/transfer_private_to_public r3 ans_credit_transfer.aleo r2 into r4 r5;
    hash.psd2 r1 into r6 as scalar;
    commit.bhp256 r0 r6 into r7 as field;
    async transfer_credits r5 r7 r2 into r8;
    output r4 as credits.aleo/credits.record;
    output r8 as ans_credit_transfer.aleo/transfer_credits.future;

finalize transfer_credits:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    input r2 as u64.public;
    await r0;
    get.or_use domain_credits[r1] 0u64 into r3;
    add r3 r2 into r4;
    set r4 into domain_credits[r1];

function transfer_credits_public:
    input r0 as field.private;
    input r1 as [u128; 2u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public ans_credit_transfer.aleo r2 into r3;
    hash.psd2 r1 into r4 as scalar;
    commit.bhp256 r0 r4 into r5 as field;
    async transfer_credits_public r3 r5 r2 into r6;
    output r6 as ans_credit_transfer.aleo/transfer_credits_public.future;

finalize transfer_credits_public:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as u64.public;
    await r0;
    get.or_use domain_credits[r1] 0u64 into r3;
    add r3 r2 into r4;
    set r4 into domain_credits[r1];

function transfer_credits_as_signer:
    input r0 as field.private;
    input r1 as [u128; 2u32].private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_as_signer ans_credit_transfer.aleo r2 into r3;
    hash.psd2 r1 into r4 as scalar;
    commit.bhp256 r0 r4 into r5 as field;
    async transfer_credits_as_signer r3 r5 r2 into r6;
    output r6 as ans_credit_transfer.aleo/transfer_credits_as_signer.future;

finalize transfer_credits_as_signer:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as field.public;
    input r2 as u64.public;
    await r0;
    get.or_use domain_credits[r1] 0u64 into r3;
    add r3 r2 into r4;
    set r4 into domain_credits[r1];

function claim_credits_private:
    input r0 as address.private;
    input r1 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r2 as [u128; 2u32].private;
    input r3 as u64.private;
    call credits.aleo/transfer_public_to_private r0 r3 into r4 r5;
    hash.psd2 r2 into r6 as scalar;
    call aleo_name_service_registry_v4.aleo/check r1 into r7;
    hash.bhp256 r1.data into r8 as field;
    commit.bhp256 r8 0scalar into r9 as field;
    commit.bhp256 r9 r6 into r10 as field;
    async claim_credits_private r5 r10 r3 into r11;
    output r4 as credits.aleo/credits.record;
    output r11 as ans_credit_transfer.aleo/claim_credits_private.future;

finalize claim_credits_private:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as u64.public;
    await r0;
    get domain_credits[r1] into r3;
    sub r3 r2 into r4;
    set r4 into domain_credits[r1];

function claim_credits_public:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as [u128; 2u32].private;
    input r3 as u64.private;
    call credits.aleo/transfer_public r0 r3 into r4;
    hash.psd2 r2 into r5 as scalar;
    commit.bhp256 r1 r5 into r6 as field;
    async claim_credits_public r4 r1 self.caller r6 r3 into r7;
    output r7 as ans_credit_transfer.aleo/claim_credits_public.future;

finalize claim_credits_public:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as u64.public;
    await r0;
    get aleo_name_service_registry_v4.aleo/nft_owners[r1] into r5;
    assert.eq r2 r5;
    get domain_credits[r3] into r6;
    sub r6 r4 into r7;
    set r7 into domain_credits[r3];

function claim_credits_as_signer:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as [u128; 2u32].private;
    input r3 as u64.private;
    call credits.aleo/transfer_public r0 r3 into r4;
    hash.psd2 r2 into r5 as scalar;
    commit.bhp256 r1 r5 into r6 as field;
    async claim_credits_as_signer r4 r1 self.signer r6 r3 into r7;
    output r7 as ans_credit_transfer.aleo/claim_credits_as_signer.future;

finalize claim_credits_as_signer:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as u64.public;
    await r0;
    get aleo_name_service_registry_v4.aleo/nft_owners[r1] into r5;
    assert.eq r2 r5;
    get domain_credits[r3] into r6;
    sub r6 r4 into r7;
    set r7 into domain_credits[r3];

function transfer_token:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as [u128; 2u32].private;
    input r3 as u128.private;
    input r4 as multi_token_support_programv1.aleo/Token.record;
    call multi_token_support_programv1.aleo/transfer_private_to_public ans_credit_transfer.aleo r3 r4 into r5 r6;
    hash.psd2 r2 into r7 as scalar;
    cast r1 r0 into r8 as NameTokenPair;
    commit.bhp256 r8 r7 into r9 as field;
    async transfer_token r6 r9 r3 into r10;
    output r5 as multi_token_support_programv1.aleo/Token.record;
    output r10 as ans_credit_transfer.aleo/transfer_token.future;

finalize transfer_token:
    input r0 as multi_token_support_programv1.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    input r2 as u128.public;
    await r0;
    get.or_use domain_tokens[r1] 0u128 into r3;
    add r3 r2 into r4;
    set r4 into domain_tokens[r1];

function transfer_token_public:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as [u128; 2u32].private;
    input r3 as u128.private;
    call multi_token_support_programv1.aleo/transfer_public r0 ans_credit_transfer.aleo r3 into r4;
    hash.psd2 r2 into r5 as scalar;
    cast r1 r0 into r6 as NameTokenPair;
    commit.bhp256 r6 r5 into r7 as field;
    async transfer_token_public r4 r7 r3 into r8;
    output r8 as ans_credit_transfer.aleo/transfer_token_public.future;

finalize transfer_token_public:
    input r0 as multi_token_support_programv1.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as u128.public;
    await r0;
    get.or_use domain_tokens[r1] 0u128 into r3;
    add r3 r2 into r4;
    set r4 into domain_tokens[r1];

function transfer_token_as_signer:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as [u128; 2u32].private;
    input r3 as u128.private;
    call multi_token_support_programv1.aleo/transfer_public_as_signer r0 ans_credit_transfer.aleo r3 into r4;
    hash.psd2 r2 into r5 as scalar;
    cast r1 r0 into r6 as NameTokenPair;
    commit.bhp256 r6 r5 into r7 as field;
    async transfer_token_as_signer r4 r7 r3 into r8;
    output r8 as ans_credit_transfer.aleo/transfer_token_as_signer.future;

finalize transfer_token_as_signer:
    input r0 as multi_token_support_programv1.aleo/transfer_public_as_signer.future;
    input r1 as field.public;
    input r2 as u128.public;
    await r0;
    get.or_use domain_tokens[r1] 0u128 into r3;
    add r3 r2 into r4;
    set r4 into domain_tokens[r1];

function claim_token_private:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r3 as [u128; 2u32].private;
    input r4 as u128.private;
    input r5 as boolean.private;
    call multi_token_support_programv1.aleo/transfer_public_to_private r1 r0 r4 r5 into r6 r7;
    hash.psd2 r3 into r8 as scalar;
    call aleo_name_service_registry_v4.aleo/check r2 into r9;
    hash.bhp256 r2.data into r10 as field;
    commit.bhp256 r10 0scalar into r11 as field;
    cast r11 r1 into r12 as NameTokenPair;
    commit.bhp256 r12 r8 into r13 as field;
    async claim_token_private r7 r13 r4 into r14;
    output r6 as multi_token_support_programv1.aleo/Token.record;
    output r14 as ans_credit_transfer.aleo/claim_token_private.future;

finalize claim_token_private:
    input r0 as multi_token_support_programv1.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as u128.public;
    await r0;
    get domain_tokens[r1] into r3;
    sub r3 r2 into r4;
    set r4 into domain_tokens[r1];

function claim_token_public:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as [u128; 2u32].private;
    input r4 as u128.private;
    call multi_token_support_programv1.aleo/transfer_public r1 r0 r4 into r5;
    hash.psd2 r3 into r6 as scalar;
    cast r2 r1 into r7 as NameTokenPair;
    commit.bhp256 r7 r6 into r8 as field;
    async claim_token_public r5 r2 self.caller r8 r4 into r9;
    output r9 as ans_credit_transfer.aleo/claim_token_public.future;

finalize claim_token_public:
    input r0 as multi_token_support_programv1.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as u128.public;
    await r0;
    get aleo_name_service_registry_v4.aleo/nft_owners[r1] into r5;
    assert.eq r2 r5;
    get domain_tokens[r3] into r6;
    sub r6 r4 into r7;
    set r7 into domain_tokens[r3];

function claim_token_as_signer:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as [u128; 2u32].private;
    input r4 as u128.private;
    call multi_token_support_programv1.aleo/transfer_public r1 r0 r4 into r5;
    hash.psd2 r3 into r6 as scalar;
    cast r2 r1 into r7 as NameTokenPair;
    commit.bhp256 r7 r6 into r8 as field;
    async claim_token_as_signer r5 r2 self.signer r8 r4 into r9;
    output r9 as ans_credit_transfer.aleo/claim_token_as_signer.future;

finalize claim_token_as_signer:
    input r0 as multi_token_support_programv1.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as u128.public;
    await r0;
    get aleo_name_service_registry_v4.aleo/nft_owners[r1] into r5;
    assert.eq r2 r5;
    get domain_tokens[r3] into r6;
    sub r6 r4 into r7;
    set r7 into domain_tokens[r3];
