import credits.aleo;
import token_registry.aleo;

program compliant_token.aleo;

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

record TokenLocked:
    owner as address.private;
    locked_time as u32.private;

mapping has_minted:
    key as u8.public;
    value as boolean.public;

mapping has_spend_limit:
    key as field.public;
    value as boolean.public;

function transfer_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as SpendLimit.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    input r5 as TokenLocked.record;
    lt r1.epoch_spent r4 into r6;
    add r2 r1.amount_spent into r7;
    ternary r6 r2 r7 into r8;
    lte r8 10000000000u128 into r9;
    assert.eq r9 true;
    cast r1.owner r8 r4 into r10 as SpendLimit.record;
    call token_registry.aleo/prehook_private r0 r2 4294967295u32 into r11 r12 r13;
    call token_registry.aleo/transfer_private r3 r2 r12 into r14 r15 r16;
    async transfer_private r13 r16 r4 r5.locked_time into r17;
    output r10 as SpendLimit.record;
    output r11 as token_registry.aleo/Token.record;
    output r14 as token_registry.aleo/Token.record;
    output r15 as token_registry.aleo/Token.record;
    output r17 as compliant_token.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as u32.public;
    input r3 as u32.public;
    await r0;
    await r1;
    rem block.height 28800u32 into r4;
    gte r4 r3 into r5;
    assert.eq r5 true;
    assert.eq r2 r4;

function initialize:
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    call token_registry.aleo/register_token 71619063553950105623552field 71619063553950105623552u128 71619063553950105623552u128 6u8 10000000000000000u128 true compliant_token.aleo into r0;
    async initialize r0 into r1;
    output r1 as compliant_token.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    call token_registry.aleo/mint_private 71619063553950105623552field aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as compliant_token.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function set_lock_time:
    input r0 as u32.private;
    input r1 as address.private;
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    cast r1 r0 into r2 as TokenLocked.record;
    output r2 as TokenLocked.record;

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    cast r0 0u128 0u32 into r1 as SpendLimit.record;
    output r1 as SpendLimit.record;
