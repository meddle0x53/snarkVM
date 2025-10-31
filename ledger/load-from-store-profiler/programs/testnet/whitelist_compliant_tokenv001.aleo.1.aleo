import credits.aleo;
import token_registry.aleo;

program whitelist_compliant_tokenv001.aleo;

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

mapping whitelist:
    key as address.public;
    value as boolean.public;

mapping whitelist_root:
    key as u32.public;
    value as field.public;

closure verify_merkle_proof:
    input r0 as field;
    input r1 as address;
    input r2 as [field; 15u32];
    input r3 as [field; 15u32];
    hash.psd2 r1 into r4 as field;
    sub r3[0u32] 1field into r5;
    mul r3[0u32] r5 into r6;
    assert.eq r6 0field;
    is.eq r3[0u32] 0field into r7;
    cast r4 r2[0u32] into r8 as [field; 2u32];
    hash.psd2 r8 into r9 as field;
    not r7 into r10;
    cast r2[0u32] r4 into r11 as [field; 2u32];
    hash.psd2 r11 into r12 as field;
    ternary r7 r9 r12 into r13;
    sub r3[1u32] 1field into r14;
    mul r3[1u32] r14 into r15;
    assert.eq r15 0field;
    is.eq r3[1u32] 0field into r16;
    cast r13 r2[1u32] into r17 as [field; 2u32];
    hash.psd2 r17 into r18 as field;
    not r16 into r19;
    cast r2[1u32] r13 into r20 as [field; 2u32];
    hash.psd2 r20 into r21 as field;
    ternary r16 r18 r21 into r22;
    sub r3[2u32] 1field into r23;
    mul r3[2u32] r23 into r24;
    assert.eq r24 0field;
    is.eq r3[2u32] 0field into r25;
    cast r22 r2[2u32] into r26 as [field; 2u32];
    hash.psd2 r26 into r27 as field;
    not r25 into r28;
    cast r2[2u32] r22 into r29 as [field; 2u32];
    hash.psd2 r29 into r30 as field;
    ternary r25 r27 r30 into r31;
    sub r3[3u32] 1field into r32;
    mul r3[3u32] r32 into r33;
    assert.eq r33 0field;
    is.eq r3[3u32] 0field into r34;
    cast r31 r2[3u32] into r35 as [field; 2u32];
    hash.psd2 r35 into r36 as field;
    not r34 into r37;
    cast r2[3u32] r31 into r38 as [field; 2u32];
    hash.psd2 r38 into r39 as field;
    ternary r34 r36 r39 into r40;
    sub r3[4u32] 1field into r41;
    mul r3[4u32] r41 into r42;
    assert.eq r42 0field;
    is.eq r3[4u32] 0field into r43;
    cast r40 r2[4u32] into r44 as [field; 2u32];
    hash.psd2 r44 into r45 as field;
    not r43 into r46;
    cast r2[4u32] r40 into r47 as [field; 2u32];
    hash.psd2 r47 into r48 as field;
    ternary r43 r45 r48 into r49;
    sub r3[5u32] 1field into r50;
    mul r3[5u32] r50 into r51;
    assert.eq r51 0field;
    is.eq r3[5u32] 0field into r52;
    cast r49 r2[5u32] into r53 as [field; 2u32];
    hash.psd2 r53 into r54 as field;
    not r52 into r55;
    cast r2[5u32] r49 into r56 as [field; 2u32];
    hash.psd2 r56 into r57 as field;
    ternary r52 r54 r57 into r58;
    sub r3[6u32] 1field into r59;
    mul r3[6u32] r59 into r60;
    assert.eq r60 0field;
    is.eq r3[6u32] 0field into r61;
    cast r58 r2[6u32] into r62 as [field; 2u32];
    hash.psd2 r62 into r63 as field;
    not r61 into r64;
    cast r2[6u32] r58 into r65 as [field; 2u32];
    hash.psd2 r65 into r66 as field;
    ternary r61 r63 r66 into r67;
    sub r3[7u32] 1field into r68;
    mul r3[7u32] r68 into r69;
    assert.eq r69 0field;
    is.eq r3[7u32] 0field into r70;
    cast r67 r2[7u32] into r71 as [field; 2u32];
    hash.psd2 r71 into r72 as field;
    not r70 into r73;
    cast r2[7u32] r67 into r74 as [field; 2u32];
    hash.psd2 r74 into r75 as field;
    ternary r70 r72 r75 into r76;
    sub r3[8u32] 1field into r77;
    mul r3[8u32] r77 into r78;
    assert.eq r78 0field;
    is.eq r3[8u32] 0field into r79;
    cast r76 r2[8u32] into r80 as [field; 2u32];
    hash.psd2 r80 into r81 as field;
    not r79 into r82;
    cast r2[8u32] r76 into r83 as [field; 2u32];
    hash.psd2 r83 into r84 as field;
    ternary r79 r81 r84 into r85;
    sub r3[9u32] 1field into r86;
    mul r3[9u32] r86 into r87;
    assert.eq r87 0field;
    is.eq r3[9u32] 0field into r88;
    cast r85 r2[9u32] into r89 as [field; 2u32];
    hash.psd2 r89 into r90 as field;
    not r88 into r91;
    cast r2[9u32] r85 into r92 as [field; 2u32];
    hash.psd2 r92 into r93 as field;
    ternary r88 r90 r93 into r94;
    sub r3[10u32] 1field into r95;
    mul r3[10u32] r95 into r96;
    assert.eq r96 0field;
    is.eq r3[10u32] 0field into r97;
    cast r94 r2[10u32] into r98 as [field; 2u32];
    hash.psd2 r98 into r99 as field;
    not r97 into r100;
    cast r2[10u32] r94 into r101 as [field; 2u32];
    hash.psd2 r101 into r102 as field;
    ternary r97 r99 r102 into r103;
    sub r3[11u32] 1field into r104;
    mul r3[11u32] r104 into r105;
    assert.eq r105 0field;
    is.eq r3[11u32] 0field into r106;
    cast r103 r2[11u32] into r107 as [field; 2u32];
    hash.psd2 r107 into r108 as field;
    not r106 into r109;
    cast r2[11u32] r103 into r110 as [field; 2u32];
    hash.psd2 r110 into r111 as field;
    ternary r106 r108 r111 into r112;
    sub r3[12u32] 1field into r113;
    mul r3[12u32] r113 into r114;
    assert.eq r114 0field;
    is.eq r3[12u32] 0field into r115;
    cast r112 r2[12u32] into r116 as [field; 2u32];
    hash.psd2 r116 into r117 as field;
    not r115 into r118;
    cast r2[12u32] r112 into r119 as [field; 2u32];
    hash.psd2 r119 into r120 as field;
    ternary r115 r117 r120 into r121;
    sub r3[13u32] 1field into r122;
    mul r3[13u32] r122 into r123;
    assert.eq r123 0field;
    is.eq r3[13u32] 0field into r124;
    cast r121 r2[13u32] into r125 as [field; 2u32];
    hash.psd2 r125 into r126 as field;
    not r124 into r127;
    cast r2[13u32] r121 into r128 as [field; 2u32];
    hash.psd2 r128 into r129 as field;
    ternary r124 r126 r129 into r130;
    sub r3[14u32] 1field into r131;
    mul r3[14u32] r131 into r132;
    assert.eq r132 0field;
    is.eq r3[14u32] 0field into r133;
    cast r130 r2[14u32] into r134 as [field; 2u32];
    hash.psd2 r134 into r135 as field;
    not r133 into r136;
    cast r2[14u32] r130 into r137 as [field; 2u32];
    hash.psd2 r137 into r138 as field;
    ternary r133 r135 r138 into r139;
    is.eq r139 r0 into r140;
    output r140 as boolean;

function transfer_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as SpendLimit.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    input r5 as [field; 15u32].private;
    input r6 as [field; 15u32].private;
    input r7 as field.private;
    input r8 as field.private;
    call verify_merkle_proof r7 r3 r5 r6 into r9;
    assert.eq r9 true;
    lt r1.epoch_spent r4 into r10;
    add r2 r1.amount_spent into r11;
    ternary r10 r2 r11 into r12;
    lte r12 10000u128 into r13;
    assert.eq r13 true;
    cast r1.owner r12 r4 into r14 as SpendLimit.record;
    call token_registry.aleo/prehook_private r0 r2 4294967295u32 into r15 r16 r17;
    call token_registry.aleo/transfer_private r3 r2 r16 into r18 r19 r20;
    async transfer_private r17 r20 r4 into r21;
    output r14 as SpendLimit.record;
    output r15 as token_registry.aleo/Token.record;
    output r18 as token_registry.aleo/Token.record;
    output r19 as token_registry.aleo/Token.record;
    output r21 as whitelist_compliant_tokenv001.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as u32.public;
    await r0;
    await r1;
    rem block.height 28800u32 into r3;
    assert.eq r2 r3;

function initialize:
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    call token_registry.aleo/register_token 71619063553950105623552field 71619063553950105623552u128 71619063553950105623552u128 6u8 10000000000000000u128 true whitelist_compliant_tokenv001.aleo into r0;
    async initialize r0 into r1;
    output r1 as whitelist_compliant_tokenv001.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    call token_registry.aleo/mint_private 71619063553950105623552field aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as whitelist_compliant_tokenv001.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    cast r0 0u128 0u32 into r1 as SpendLimit.record;
    output r1 as SpendLimit.record;

function add_to_whitelist:
    input r0 as address.private;
    input r1 as [field; 15u32].private;
    input r2 as [field; 15u32].private;
    input r3 as field.private;
    input r4 as field.private;
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    call verify_merkle_proof r3 r0 r1 r2 into r5;
    assert.eq r5 true;
    async add_to_whitelist r4 r3 into r6;
    output r6 as whitelist_compliant_tokenv001.aleo/add_to_whitelist.future;

finalize add_to_whitelist:
    input r0 as field.public;
    input r1 as field.public;
    get whitelist_root[42u32] into r2;
    is.eq r2 r0 into r3;
    assert.eq r3 true;
    set r1 into whitelist_root[42u32];

function remove_from_whitelist:
    input r0 as address.private;
    input r1 as [field; 15u32].private;
    input r2 as [field; 15u32].private;
    input r3 as field.private;
    input r4 as field.private;
    assert.eq self.caller aleo10047h9c9efxz3d0u69xn7alclvsvt96ysuhts80p7h2eh57kh5zsjwsp8f;
    call verify_merkle_proof r3 r0 r1 r2 into r5;
    assert.eq r5 true;
    async remove_from_whitelist r4 r3 into r6;
    output r6 as whitelist_compliant_tokenv001.aleo/remove_from_whitelist.future;

finalize remove_from_whitelist:
    input r0 as field.public;
    input r1 as field.public;
    get whitelist_root[42u32] into r2;
    is.eq r2 r0 into r3;
    assert.eq r3 true;
    set r1 into whitelist_root[42u32];
