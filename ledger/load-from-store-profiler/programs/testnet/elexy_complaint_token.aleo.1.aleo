import credits.aleo;
import token_registry.aleo;

program elexy_complaint_token.aleo;

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

mapping has_spend_limit:
    key as field.public;
    value as boolean.public;

mapping transfer_locks:
    key as address.public;
    value as u32.public;

mapping compliance_proofs:
    key as address.public;
    value as field.public;

mapping kyc_whitelist:
    key as address.public;
    value as boolean.public;

mapping restricted_jurisdictions:
    key as field.public;
    value as boolean.public;

function transfer_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as SpendLimit.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as field.private;
    input r5 as u32.public;
    lt r1.epoch_spent r5 into r6;
    add r2 r1.amount_spent into r7;
    ternary r6 r2 r7 into r8;
    lte r8 10000000000u128 into r9;
    assert.eq r9 true;
    cast r1.owner r8 r5 into r10 as SpendLimit.record;
    call token_registry.aleo/prehook_private r0 r2 4294967295u32 into r11 r12 r13;
    call token_registry.aleo/transfer_private r3 r2 r12 into r14 r15 r16;
    async transfer_private r13 r16 r5 self.caller r3 r4 into r17;
    output r10 as SpendLimit.record;
    output r11 as token_registry.aleo/Token.record;
    output r14 as token_registry.aleo/Token.record;
    output r15 as token_registry.aleo/Token.record;
    output r17 as elexy_complaint_token.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as u32.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as field.public;
    await r0;
    await r1;
    rem block.height 28800u32 into r6;
    assert.eq r2 r6;
    contains kyc_whitelist[r3] into r7;
    contains kyc_whitelist[r4] into r8;
    and r7 r8 into r9;
    assert.eq r9 true;
    contains restricted_jurisdictions[r5] into r10;
    not r10 into r11;
    assert.eq r11 true;

function initialize:
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    call token_registry.aleo/register_token 71619063553950105623552field 71619063553950105623552u128 71619063553950105623552u128 6u8 10000000000000000u128 true elexy_complaint_token.aleo into r0;
    async initialize r0 into r1;
    output r1 as elexy_complaint_token.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    call token_registry.aleo/mint_private 71619063553950105623552field aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as elexy_complaint_token.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    cast r0 0u128 0u32 into r1 as SpendLimit.record;
    output r1 as SpendLimit.record;

function approve_kyc:
    input r0 as address.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    async approve_kyc r0 into r1;
    output r1 as elexy_complaint_token.aleo/approve_kyc.future;

finalize approve_kyc:
    input r0 as address.public;
    set true into kyc_whitelist[r0];

function blacklist_user:
    input r0 as address.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    async blacklist_user r0 into r1;
    output r1 as elexy_complaint_token.aleo/blacklist_user.future;

finalize blacklist_user:
    input r0 as address.public;
    remove kyc_whitelist[r0];

function restrict_jurisdiction:
    input r0 as field.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    async restrict_jurisdiction r0 into r1;
    output r1 as elexy_complaint_token.aleo/restrict_jurisdiction.future;

finalize restrict_jurisdiction:
    input r0 as field.public;
    set true into restricted_jurisdictions[r0];

function remove_jurisdiction_restriction:
    input r0 as field.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    async remove_jurisdiction_restriction r0 into r1;
    output r1 as elexy_complaint_token.aleo/remove_jurisdiction_restriction.future;

finalize remove_jurisdiction_restriction:
    input r0 as field.public;
    remove restricted_jurisdictions[r0];

function set_timelock:
    input r0 as address.private;
    input r1 as u32.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    async set_timelock r0 r1 into r2;
    output r2 as elexy_complaint_token.aleo/set_timelock.future;

finalize set_timelock:
    input r0 as address.public;
    input r1 as u32.public;
    set r1 into transfer_locks[r0];

function store_compliance_proof:
    input r0 as address.private;
    input r1 as field.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    async store_compliance_proof r0 r1 into r2;
    output r2 as elexy_complaint_token.aleo/store_compliance_proof.future;

finalize store_compliance_proof:
    input r0 as address.public;
    input r1 as field.public;
    set r1 into compliance_proofs[r0];

function get_compliance_proof:
    input r0 as address.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    async get_compliance_proof r0 into r1;
    output r1 as elexy_complaint_token.aleo/get_compliance_proof.future;

finalize get_compliance_proof:
    input r0 as address.public;
    get compliance_proofs[r0] into r1;
