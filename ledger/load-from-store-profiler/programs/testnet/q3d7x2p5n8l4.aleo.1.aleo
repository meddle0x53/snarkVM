import credits.aleo;
import token_registry.aleo;

program q3d7x2p5n8l4.aleo;

record avUSDG:
    owner as address.private;
    amount as u128.private;
    timestamp as u32.private;
    apy_snapshot as u128.private;

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

mapping supplied_total:
    key as boolean.public;
    value as u128.public;

mapping borrowed_total:
    key as boolean.public;
    value as u128.public;

function lend:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.public;
    input r2 as u32.public;
    input r3 as u128.public;
    input r4 as u128.public;
    assert.eq 5983142094692128773510225623816045070304444621008302359049788306211838130558field r0.token_id;
    call token_registry.aleo/transfer_private_to_public q3d7x2p5n8l4.aleo r1 r0 into r5 r6;
    is.eq r3 0u128 into r7;
    add r3 r1 into r8;
    mul r4 100u128 into r9;
    div r9 r8 into r10;
    ternary r7 1u128 r10 into r11;
    gte r11 95u128 into r12;
    gt r11 80u128 into r13;
    gt r11 50u128 into r14;
    gt r11 20u128 into r15;
    ternary r15 4u128 1u128 into r16;
    ternary r14 7u128 r16 into r17;
    ternary r13 10u128 r17 into r18;
    ternary r12 15u128 r18 into r19;
    mul 3u32 r2 into r20;
    add r20 10u32 into r21;
    cast self.signer r1 r21 r19 into r22 as avUSDG.record;
    async lend r2 r3 r8 r1 r6 into r23;
    output r5 as token_registry.aleo/Token.record;
    output r22 as avUSDG.record;
    output r23 as q3d7x2p5n8l4.aleo/lend.future;

finalize lend:
    input r0 as u32.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as token_registry.aleo/transfer_private_to_public.future;
    gte block.height r0 into r5;
    assert.eq r5 true;
    add r0 50u32 into r6;
    lt block.height r6 into r7;
    assert.eq r7 true;
    get supplied_total[true] into r8;
    assert.eq r8 r1;
    set r2 into supplied_total[true];
    await r4;

function withdraw:
    input r0 as Reward.record;
    input r1 as u128.public;
    call token_registry.aleo/transfer_public_to_private 5983142094692128773510225623816045070304444621008302359049788306211838130558field self.signer r1 false into r2 r3;
    commit.bhp256 self.signer r0.randomizer into r4 as field;
    async withdraw r4 r1 r3 into r5;
    output r2 as token_registry.aleo/Token.record;
    output r5 as q3d7x2p5n8l4.aleo/withdraw.future;

finalize withdraw:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as token_registry.aleo/transfer_public_to_private.future;
    get rewards[r0] into r3;
    assert.eq r1 r3;
    await r2;
