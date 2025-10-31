import credits.aleo;
import token_registry.aleo;

program d7w2z6m9t1q4.aleo;

record avUSDG:
    owner as address.private;
    amount as u128.private;
    timestamp as u32.private;
    apy_snapshot as u128.private;

record LoanPrivate:
    owner as address.private;
    id_public as u32.private;

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

struct LoanPublic:
    id_public as u32;
    collateral_amount as u128;
    collateral_token_id as field;
    borrowed_amount as u128;
    timestamp as u32;
    apr_snapshot as u128;
    active as boolean;

mapping supplied_total:
    key as boolean.public;
    value as u128.public;

mapping borrowed_total:
    key as boolean.public;
    value as u128.public;

mapping loans_public:
    key as u32.public;
    value as LoanPublic.public;

mapping next_loan_id:
    key as boolean.public;
    value as u32.public;

function lend:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.public;
    input r2 as u32.public;
    input r3 as u128.public;
    input r4 as u128.public;
    assert.eq 5983142094692128773510225623816045070304444621008302359049788306211838130558field r0.token_id;
    call token_registry.aleo/transfer_private_to_public d7w2z6m9t1q4.aleo r1 r0 into r5 r6;
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
    output r23 as d7w2z6m9t1q4.aleo/lend.future;

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
    output r13 as d7w2z6m9t1q4.aleo/redeem.future;

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

function borrow:
    input r0 as u32.public;
    input r1 as token_registry.aleo/Token.record;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as u32.public;
    input r5 as u128.public;
    input r6 as u128.public;
    is.eq r1.token_id 7282192565387792361809088173158053178461960397100960262024562261205950610485field into r7;
    is.eq r1.token_id 8260953594890310383870507716927422646335575786500909254294703665587287172223field into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    call token_registry.aleo/transfer_private_to_public d7w2z6m9t1q4.aleo r2 r1 into r10 r11;
    is.eq r1.token_id 7282192565387792361809088173158053178461960397100960262024562261205950610485field into r12;
    is.eq r1.token_id 8260953594890310383870507716927422646335575786500909254294703665587287172223field into r13;
    ternary r13 1u128 1u128 into r14;
    ternary r13 6u8 6u8 into r15;
    ternary r12 2500u128 r14 into r16;
    ternary r12 18u8 r15 into r17;
    sub 18u8 r17 into r18;
    cast r18 into r19 as u32;
    pow 10u128 r19 into r20;
    mul r2 r20 into r21;
    mul r21 r16 into r22;
    div r22 1000000u128 into r23;
    mul r3 120u128 into r24;
    add r24 99u128 into r25;
    div r25 100u128 into r26;
    gte r23 r26 into r27;
    assert.eq r27 true;
    is.eq r6 0u128 into r28;
    add r6 r3 into r29;
    mul r29 100u128 into r30;
    div r30 r5 into r31;
    ternary r28 1u128 r31 into r32;
    gte r32 95u128 into r33;
    gt r32 80u128 into r34;
    gt r32 50u128 into r35;
    gt r32 20u128 into r36;
    ternary r36 6u128 2u128 into r37;
    ternary r35 10u128 r37 into r38;
    ternary r34 15u128 r38 into r39;
    ternary r33 20u128 r39 into r40;
    mul 3u32 r4 into r41;
    add r41 10u32 into r42;
    cast r0 r2 r1.token_id r3 r42 r40 true into r43 as LoanPublic;
    cast self.signer r0 into r44 as LoanPrivate.record;
    call token_registry.aleo/transfer_public_to_private 5983142094692128773510225623816045070304444621008302359049788306211838130558field self.signer r3 false into r45 r46;
    async borrow r4 r6 r29 r11 r46 r43 into r47;
    output r45 as token_registry.aleo/Token.record;
    output r44 as LoanPrivate.record;
    output r47 as d7w2z6m9t1q4.aleo/borrow.future;

finalize borrow:
    input r0 as u32.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as token_registry.aleo/transfer_private_to_public.future;
    input r4 as token_registry.aleo/transfer_public_to_private.future;
    input r5 as LoanPublic.public;
    gte block.height r0 into r6;
    assert.eq r6 true;
    add r0 50u32 into r7;
    lt block.height r7 into r8;
    assert.eq r8 true;
    cast r5.id_public 0u128 0field 0u128 0u32 0u128 false into r9 as LoanPublic;
    get.or_use loans_public[r5.id_public] r9 into r10;
    is.eq r10.timestamp 0u32 into r11;
    assert.eq r11 true;
    get.or_use borrowed_total[true] 0u128 into r12;
    assert.eq r12 r1;
    set r2 into borrowed_total[true];
    set r5 into loans_public[r5.id_public];
    await r3;
    await r4;

function redeem_borrow:
    input r0 as token_registry.aleo/Token.record;
    input r1 as LoanPrivate.record;
    input r2 as LoanPublic.private;
    input r3 as u32.public;
    input r4 as u128.public;
    assert.eq r1.owner self.signer;
    assert.eq r1.id_public r2.id_public;
    is.eq r2.active true into r5;
    assert.eq r5 true;
    mul 3u32 r3 into r6;
    add r6 10u32 into r7;
    sub r7 r2.timestamp into r8;
    cast r8 into r9 as u128;
    mul r2.apr_snapshot r9 into r10;
    div r10 3153600000u128 into r11;
    add r2.borrowed_amount r11 into r12;
    call token_registry.aleo/transfer_private_to_public d7w2z6m9t1q4.aleo r12 r0 into r13 r14;
    call token_registry.aleo/transfer_public_to_private r2.collateral_token_id self.signer r2.collateral_amount false into r15 r16;
    sub r4 r2.borrowed_amount into r17;
    async redeem_borrow r3 r4 r17 r2.id_public r14 r16 into r18;
    output r13 as token_registry.aleo/Token.record;
    output r15 as token_registry.aleo/Token.record;
    output r18 as d7w2z6m9t1q4.aleo/redeem_borrow.future;

finalize redeem_borrow:
    input r0 as u32.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u32.public;
    input r4 as token_registry.aleo/transfer_private_to_public.future;
    input r5 as token_registry.aleo/transfer_public_to_private.future;
    gte block.height r0 into r6;
    assert.eq r6 true;
    add r0 50u32 into r7;
    lt block.height r7 into r8;
    assert.eq r8 true;
    get.or_use borrowed_total[true] 0u128 into r9;
    assert.eq r9 r1;
    set r2 into borrowed_total[true];
    cast r3 0u128 0field 0u128 0u32 0u128 true into r10 as LoanPublic;
    get.or_use loans_public[r3] r10 into r11;
    cast r11.id_public r11.collateral_amount r11.collateral_token_id r11.borrowed_amount r11.timestamp r11.apr_snapshot false into r12 as LoanPublic;
    set r12 into loans_public[r3];
    await r4;
    await r5;
