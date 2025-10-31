import credits.aleo;
import token_registry.aleo;

program trust_trust_trust.aleo;

record TrusteeConsent:
    owner as address.private;
    beneficiary as address.private;
    will_id as field.private;

record Will:
    owner as address.private;
    grantor as address.private;
    beneficiary as address.private;
    will_id as field.private;
    funding_token_id as field.private;
    funding_amount as u128.private;
    approvals_needed as u8.private;
    approvals_received as u8.private;
    good_after as u32.private;

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

mapping wrapped_id_to_unwrapped_id:
    key as field.public;
    value as field.public;

function balance_key:
    input r0 as address.private;
    input r1 as field.private;
    cast r0 r1 into r2 as TokenOwner;
    hash.bhp256 r2 into r3 as field;
    output r3 as field.private;

function get_wrapped_id:
    input r0 as field.private;
    hash.bhp256 r0 into r1 as field;
    output r1 as field.private;

function create_wrapper:
    input r0 as field.public;
    hash.bhp256 r0 into r1 as field;
    call token_registry.aleo/register_token r1 6928249226643524685988262274414u128 5722708u128 6u8 10000000000000000u128 false trust_trust_trust.aleo into r2;
    async create_wrapper r1 r0 r2 into r3;
    output r3 as trust_trust_trust.aleo/create_wrapper.future;

finalize create_wrapper:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as token_registry.aleo/register_token.future;
    set r1 into wrapped_id_to_unwrapped_id[r0];
    await r2;

function wrap_public:
    input r0 as field.public;
    input r1 as u128.public;
    hash.bhp256 r0 into r2 as field;
    call token_registry.aleo/mint_public r2 self.caller r1 0u32 into r3;
    call token_registry.aleo/transfer_from_public r0 self.caller trust_trust_trust.aleo r1 into r4;
    async wrap_public r3 r4 into r5;
    output r5 as trust_trust_trust.aleo/wrap_public.future;

finalize wrap_public:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as token_registry.aleo/transfer_from_public.future;
    await r0;
    await r1;

function unwrap_public:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    call token_registry.aleo/burn_public r0 self.caller r2 into r3;
    call token_registry.aleo/transfer_public r1 self.caller r2 into r4;
    async unwrap_public r0 r1 r3 r4 into r5;
    output r5 as trust_trust_trust.aleo/unwrap_public.future;

finalize unwrap_public:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as token_registry.aleo/burn_public.future;
    input r3 as token_registry.aleo/transfer_public.future;
    get wrapped_id_to_unwrapped_id[r0] into r4;
    assert.eq r1 r4;
    await r2;
    await r3;

closure dead_address:
    input r0 as u64;
    hash.ped128 r0 into r1 as address;
    output r1 as address;

function generate_dead_address:
    input r0 as u64.private;
    call dead_address r0 into r1;
    output r1 as address.private;

function transfer:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.private;
    input r3 as u64.private;
    call token_registry.aleo/transfer_from_public r0 self.caller r2 r1 into r4;
    call dead_address r3 into r5;
    is.eq r2 r5 into r6;
    ternary r6 r1 0u128 into r7;
    call token_registry.aleo/mint_private r0 self.caller r7 false 0u32 into r8 r9;
    async transfer r4 r9 into r10;
    output r8 as token_registry.aleo/Token.record;
    output r10 as trust_trust_trust.aleo/transfer.future;

finalize transfer:
    input r0 as token_registry.aleo/transfer_from_public.future;
    input r1 as token_registry.aleo/mint_private.future;
    await r0;
    await r1;

function unwrap_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as field.private;
    input r2 as u128.private;
    call token_registry.aleo/transfer_public_to_private r1 self.caller r2 false into r3 r4;
    call token_registry.aleo/burn_private r0 r2 into r5 r6;
    async unwrap_private r4 r6 into r7;
    output r3 as token_registry.aleo/Token.record;
    output r5 as token_registry.aleo/Token.record;
    output r7 as trust_trust_trust.aleo/unwrap_private.future;

finalize unwrap_private:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as token_registry.aleo/burn_private.future;
    await r0;
    await r1;

function trust_setup:
    input r0 as token_registry.aleo/Token.record;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u64.private;
    input r4 as u8.private;
    input r5 as u32.private;
    cast self.caller self.caller r1 r2 r0.token_id r0.amount r4 0u8 r5 into r6 as Will.record;
    output r6 as Will.record;

function add_trustee:
    input r0 as Will.record;
    input r1 as address.private;
    cast r0.owner r0.grantor r0.beneficiary r0.will_id r0.funding_token_id r0.funding_amount r0.approvals_needed r0.approvals_received r0.good_after into r2 as Will.record;
    cast r1 r0.beneficiary r0.will_id into r3 as TrusteeConsent.record;
    output r2 as Will.record;
    output r3 as TrusteeConsent.record;

function trustee_consents:
    input r0 as TrusteeConsent.record;
    cast r0.beneficiary r0.beneficiary r0.will_id into r1 as TrusteeConsent.record;
    output r1 as TrusteeConsent.record;

function register_approval:
    input r0 as Will.record;
    input r1 as TrusteeConsent.record;
    is.eq r0.will_id r1.will_id into r2;
    assert.eq r2 true;
    add r0.approvals_received 1u8 into r3;
    cast r0.owner r0.grantor r0.beneficiary r0.will_id r0.funding_token_id r0.funding_amount r0.approvals_needed r3 r0.good_after into r4 as Will.record;
    output r4 as Will.record;

function cash_out:
    input r0 as Will.record;
    input r1 as u32.private;
    lte r0.good_after r1 into r2;
    assert.eq r2 true;
    gte r0.approvals_received r0.approvals_needed into r3;
    assert.eq r3 true;
    call token_registry.aleo/mint_private r0.funding_token_id self.caller r0.funding_amount false 0u32 into r4 r5;
    async cash_out r5 r1 into r6;
    output r4 as token_registry.aleo/Token.record;
    output r6 as trust_trust_trust.aleo/cash_out.future;

finalize cash_out:
    input r0 as token_registry.aleo/mint_private.future;
    input r1 as u32.public;
    await r0;
    lt r1 block.height into r2;
    assert.eq r2 true;
