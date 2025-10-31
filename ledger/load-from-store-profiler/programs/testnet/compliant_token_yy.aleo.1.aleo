import credits.aleo;
import token_registry.aleo;

program compliant_token_yy.aleo;

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

mapping jurisdiction_whitelist:
    key as address.public;
    value as boolean.public;

mapping kyc_verified:
    key as address.public;
    value as boolean.public;

function transfer_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as SpendLimit.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    lt r1.epoch_spent r4 into r5;
    add r2 r1.amount_spent into r6;
    ternary r5 r2 r6 into r7;
    lte r7 10000000000u128 into r8;
    assert.eq r8 true;
    cast r1.owner r7 r4 into r9 as SpendLimit.record;
    call token_registry.aleo/prehook_private r0 r2 4294967295u32 into r10 r11 r12;
    call token_registry.aleo/transfer_private r3 r2 r11 into r13 r14 r15;
    async transfer_private r12 r15 r4 r3 into r16;
    output r9 as SpendLimit.record;
    output r10 as token_registry.aleo/Token.record;
    output r13 as token_registry.aleo/Token.record;
    output r14 as token_registry.aleo/Token.record;
    output r16 as compliant_token_yy.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as u32.public;
    input r3 as address.public;
    await r0;
    await r1;
    rem block.height 28800u32 into r4;
    assert.eq r2 r4;
    contains jurisdiction_whitelist[r3] into r5;
    assert.eq r5 true;
    contains kyc_verified[r3] into r6;
    assert.eq r6 true;

function initialize:
    assert.eq self.caller aleo1q2q3r9hz956y5efz876ndfa6c2lm5pynufwktmjy3kt9h2hhasxstk9yt7;
    call token_registry.aleo/register_token 71619063553950105623552field 71619063553950105623552u128 71619063553950105623552u128 6u8 10000000000000000u128 true compliant_token_yy.aleo into r0;
    async initialize r0 into r1;
    output r1 as compliant_token_yy.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo1q2q3r9hz956y5efz876ndfa6c2lm5pynufwktmjy3kt9h2hhasxstk9yt7;
    call token_registry.aleo/mint_private 71619063553950105623552field aleo1q2q3r9hz956y5efz876ndfa6c2lm5pynufwktmjy3kt9h2hhasxstk9yt7 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as compliant_token_yy.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo1q2q3r9hz956y5efz876ndfa6c2lm5pynufwktmjy3kt9h2hhasxstk9yt7;
    cast r0 0u128 0u32 into r1 as SpendLimit.record;
    async issue_limit r0 into r2;
    output r1 as SpendLimit.record;
    output r2 as compliant_token_yy.aleo/issue_limit.future;

finalize issue_limit:
    input r0 as address.public;
    contains kyc_verified[r0] into r1;
    assert.eq r1 true;

function add_to_whitelist:
    input r0 as address.private;
    assert.eq self.caller aleo1q2q3r9hz956y5efz876ndfa6c2lm5pynufwktmjy3kt9h2hhasxstk9yt7;
    async add_to_whitelist r0 into r1;
    output r1 as compliant_token_yy.aleo/add_to_whitelist.future;

finalize add_to_whitelist:
    input r0 as address.public;
    set true into jurisdiction_whitelist[r0];

function remove_from_whitelist:
    input r0 as address.private;
    assert.eq self.caller aleo1q2q3r9hz956y5efz876ndfa6c2lm5pynufwktmjy3kt9h2hhasxstk9yt7;
    async remove_from_whitelist r0 into r1;
    output r1 as compliant_token_yy.aleo/remove_from_whitelist.future;

finalize remove_from_whitelist:
    input r0 as address.public;
    remove jurisdiction_whitelist[r0];

function add_to_kyc_verified:
    input r0 as address.private;
    assert.eq self.caller aleo1q2q3r9hz956y5efz876ndfa6c2lm5pynufwktmjy3kt9h2hhasxstk9yt7;
    async add_to_kyc_verified r0 into r1;
    output r1 as compliant_token_yy.aleo/add_to_kyc_verified.future;

finalize add_to_kyc_verified:
    input r0 as address.public;
    set true into kyc_verified[r0];

function remove_from_kyc_verified:
    input r0 as address.private;
    assert.eq self.caller aleo1q2q3r9hz956y5efz876ndfa6c2lm5pynufwktmjy3kt9h2hhasxstk9yt7;
    async remove_from_kyc_verified r0 into r1;
    output r1 as compliant_token_yy.aleo/remove_from_kyc_verified.future;

finalize remove_from_kyc_verified:
    input r0 as address.public;
    remove kyc_verified[r0];
