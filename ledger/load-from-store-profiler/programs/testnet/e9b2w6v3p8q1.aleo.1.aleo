import credits.aleo;
import token_registry.aleo;

program e9b2w6v3p8q1.aleo;

record avUSDG:
    owner as address.private;
    amount as u128.private;
    timestamp as u32.private;
    apy_snapshot as u128.private;

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
    call token_registry.aleo/transfer_private_to_public e9b2w6v3p8q1.aleo r1 r0 into r5 r6;
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
    output r23 as e9b2w6v3p8q1.aleo/lend.future;

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
    get.or_use supplied_total[true] 0u128 into r8;
    assert.eq r8 r1;
    set r2 into supplied_total[true];
    await r4;

function redeem:
    input r0 as avUSDG.record;
    input r1 as u32.public;
    input r2 as u128.public;
    assert.eq r0.owner self.signer;
    mul 3u32 r1 into r3;
    add r3 10u32 into r4;
    sub r4 r0.timestamp into r5;
    cast r5 into r6 as u128;
    mul r0.apy_snapshot r6 into r7;
    div r7 3153600000u128 into r8;
    add r0.amount r8 into r9;
    call token_registry.aleo/transfer_public_to_private 5983142094692128773510225623816045070304444621008302359049788306211838130558field self.signer r9 false into r10 r11;
    sub r2 r0.amount into r12;
    async redeem r1 r2 r12 r11 into r13;
    output r10 as token_registry.aleo/Token.record;
    output r13 as e9b2w6v3p8q1.aleo/redeem.future;

finalize redeem:
    input r0 as u32.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    gte block.height r0 into r4;
    assert.eq r4 true;
    add r0 50u32 into r5;
    lt block.height r5 into r6;
    assert.eq r6 true;
    get.or_use supplied_total[true] 0u128 into r7;
    assert.eq r7 r1;
    set r2 into supplied_total[true];
    await r3;
