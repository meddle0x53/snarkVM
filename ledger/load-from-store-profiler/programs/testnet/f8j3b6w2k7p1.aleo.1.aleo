import credits.aleo;
import token_registry.aleo;

program f8j3b6w2k7p1.aleo;

record avUSDG:
    owner as address.private;
    amount as u128.private;
    timestamp as u32.private;

record Reward:
    owner as address.private;
    randomizer as scalar.private;

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

mapping rewards:
    key as field.public;
    value as u128.public;

mapping apy:
    key as boolean.public;
    value as u128.public;

function lend:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.public;
    input r2 as u32.public;
    assert.eq 5983142094692128773510225623816045070304444621008302359049788306211838130558field r0.token_id;
    call token_registry.aleo/transfer_private_to_public f8j3b6w2k7p1.aleo r1 r0 into r3 r4;
    mul 3u32 r2 into r5;
    add r5 10u32 into r6;
    cast self.signer r1 r6 into r7 as avUSDG.record;
    async lend r2 r4 into r8;
    output r3 as token_registry.aleo/Token.record;
    output r7 as avUSDG.record;
    output r8 as f8j3b6w2k7p1.aleo/lend.future;

finalize lend:
    input r0 as u32.public;
    input r1 as token_registry.aleo/transfer_private_to_public.future;
    gte block.height r0 into r2;
    assert.eq r2 true;
    add r0 50u32 into r3;
    lt block.height r3 into r4;
    assert.eq r4 true;
    await r1;

function redeem:
    input r0 as avUSDG.record;
    input r1 as u32.public;
    input r2 as scalar.private;
    assert.eq r0.owner self.signer;
    call token_registry.aleo/transfer_public_to_private 5983142094692128773510225623816045070304444621008302359049788306211838130558field self.signer r0.amount false into r3 r4;
    mul 3u32 r1 into r5;
    add r5 10u32 into r6;
    sub r6 r0.timestamp into r7;
    commit.bhp256 self.signer r2 into r8 as field;
    async redeem r8 r7 r1 r4 into r9;
    output r3 as token_registry.aleo/Token.record;
    output r9 as f8j3b6w2k7p1.aleo/redeem.future;

finalize redeem:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as u32.public;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    gte block.height r2 into r4;
    assert.eq r4 true;
    add r2 50u32 into r5;
    lt block.height r5 into r6;
    assert.eq r6 true;
    get apy[true] into r7;
    is.neq r7 0u128 into r8;
    assert.eq r8 true;
    lte r7 1000u128 into r9;
    assert.eq r9 true;
    cast r1 into r10 as u128;
    mul r7 r10 into r11;
    div r11 3153600000u128 into r12;
    set r12 into rewards[r0];
    await r3;

function withdraw:
    input r0 as Reward.record;
    input r1 as u128.public;
    call token_registry.aleo/transfer_public_to_private 5983142094692128773510225623816045070304444621008302359049788306211838130558field self.signer r1 false into r2 r3;
    commit.bhp256 self.signer r0.randomizer into r4 as field;
    async withdraw r4 r1 r3 into r5;
    output r2 as token_registry.aleo/Token.record;
    output r5 as f8j3b6w2k7p1.aleo/withdraw.future;

finalize withdraw:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as token_registry.aleo/transfer_public_to_private.future;
    get rewards[r0] into r3;
    assert.eq r1 r3;
    await r2;
