import credits.aleo;
import token_registry.aleo;

program compliant_token_jet_artistic.aleo;

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
    kyc_level as u8.private;
    jurisdiction as u8.private;

mapping has_minted:
    key as u8.public;
    value as boolean.public;

mapping has_spend_limit:
    key as field.public;
    value as boolean.public;

mapping kyc_verified:
    key as address.public;
    value as u8.public;

mapping jurisdiction_status:
    key as address.public;
    value as u8.public;

mapping blacklisted:
    key as address.public;
    value as boolean.public;

function transfer_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as SpendLimit.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    gte r1.kyc_level 1u8 into r5;
    assert.eq r5 true;
    gt r2 1000000u128 into r6;
    is.eq r1.kyc_level 2u8 into r7;
    not r6 into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    assert.eq r1.jurisdiction 1u8;
    lt r1.epoch_spent r4 into r10;
    add r2 r1.amount_spent into r11;
    ternary r10 r2 r11 into r12;
    lte r12 10000000000u128 into r13;
    assert.eq r13 true;
    cast r1.owner r12 r4 r1.kyc_level r1.jurisdiction into r14 as SpendLimit.record;
    call token_registry.aleo/prehook_private r0 r2 4294967295u32 into r15 r16 r17;
    call token_registry.aleo/transfer_private r3 r2 r16 into r18 r19 r20;
    async transfer_private r17 r20 r4 into r21;
    output r14 as SpendLimit.record;
    output r15 as token_registry.aleo/Token.record;
    output r18 as token_registry.aleo/Token.record;
    output r19 as token_registry.aleo/Token.record;
    output r21 as compliant_token_jet_artistic.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as u32.public;
    await r0;
    await r1;
    rem block.height 28800u32 into r3;
    assert.eq r2 r3;

function initialize:
    assert.eq self.caller aleo1qe55y62l5qkprxfppnjepsuwxtxfjyxvaft0wkqakswst8lstuxsjf0l4x;
    call token_registry.aleo/register_token 71619063553950105623552field 71619063553950105623552u128 71619063553950105623552u128 6u8 10000000000000000u128 true compliant_token_jet_artistic.aleo into r0;
    async initialize r0 into r1;
    output r1 as compliant_token_jet_artistic.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo1qe55y62l5qkprxfppnjepsuwxtxfjyxvaft0wkqakswst8lstuxsjf0l4x;
    call token_registry.aleo/mint_private 71619063553950105623552field aleo1qe55y62l5qkprxfppnjepsuwxtxfjyxvaft0wkqakswst8lstuxsjf0l4x 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as compliant_token_jet_artistic.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo1qe55y62l5qkprxfppnjepsuwxtxfjyxvaft0wkqakswst8lstuxsjf0l4x;
    cast r0 0u128 0u32 0u8 0u8 into r1 as SpendLimit.record;
    async issue_limit r0 into r2;
    output r1 as SpendLimit.record;
    output r2 as compliant_token_jet_artistic.aleo/issue_limit.future;

finalize issue_limit:
    input r0 as address.public;
    get.or_use kyc_verified[r0] 0u8 into r1;
    get.or_use jurisdiction_status[r0] 0u8 into r2;
    gte r1 1u8 into r3;
    assert.eq r3 true;
    assert.eq r2 1u8;
    get.or_use blacklisted[r0] false into r4;
    not r4 into r5;
    assert.eq r5 true;

function set_kyc_status:
    input r0 as address.private;
    input r1 as u8.private;
    assert.eq self.caller aleo1qe55y62l5qkprxfppnjepsuwxtxfjyxvaft0wkqakswst8lstuxsjf0l4x;
    lte r1 2u8 into r2;
    assert.eq r2 true;
    async set_kyc_status r0 r1 into r3;
    output r3 as compliant_token_jet_artistic.aleo/set_kyc_status.future;

finalize set_kyc_status:
    input r0 as address.public;
    input r1 as u8.public;
    set r1 into kyc_verified[r0];

function set_jurisdiction:
    input r0 as address.private;
    input r1 as u8.private;
    assert.eq self.caller aleo1qe55y62l5qkprxfppnjepsuwxtxfjyxvaft0wkqakswst8lstuxsjf0l4x;
    lte r1 2u8 into r2;
    assert.eq r2 true;
    async set_jurisdiction r0 r1 into r3;
    output r3 as compliant_token_jet_artistic.aleo/set_jurisdiction.future;

finalize set_jurisdiction:
    input r0 as address.public;
    input r1 as u8.public;
    set r1 into jurisdiction_status[r0];

function set_blacklist_status:
    input r0 as address.private;
    input r1 as boolean.private;
    assert.eq self.caller aleo1qe55y62l5qkprxfppnjepsuwxtxfjyxvaft0wkqakswst8lstuxsjf0l4x;
    async set_blacklist_status r0 r1 into r2;
    output r2 as compliant_token_jet_artistic.aleo/set_blacklist_status.future;

finalize set_blacklist_status:
    input r0 as address.public;
    input r1 as boolean.public;
    set r1 into blacklisted[r0];
