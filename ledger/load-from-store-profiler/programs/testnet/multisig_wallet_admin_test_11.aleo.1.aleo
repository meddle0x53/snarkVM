program multisig_wallet_admin_test_11.aleo;

struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;
    program_id as address;

mapping nonce:
    key as u8.public;
    value as u64.public;

mapping threshold:
    key as u8.public;
    value as u8.public;

mapping admin_list:
    key as u8.public;
    value as address.public;

mapping admins:
    key as address.public;
    value as boolean.public;

mapping admin_count:
    key as u8.public;
    value as u8.public;

mapping admin_operations:
    key as u64.public;
    value as admin_operation.public;

mapping initialized:
    key as u8.public;
    value as boolean.public;

function initialize:
    async initialize into r0;
    output r0 as multisig_wallet_admin_test_11.aleo/initialize.future;

finalize initialize:
    contains initialized[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    set true into initialized[0u8];
    set true into admins[aleo1csgkqstenz9hgf7r6pxaglfgg2uh0nqzpfahly8m982thwwvkcxs0mr646];
    set true into admins[aleo1ys7c3pl70g7zn57k6m6zzd8mz87yass4ssrrmjdgeyjmlfjfkvqsdjvc3r];
    set true into admins[aleo1tgctqylml97ljhxcvfc0frkfza3kmqhr4hhewkkg20mtzesq3yyqyd68w3];
    set 2u8 into threshold[0u8];
    set aleo1csgkqstenz9hgf7r6pxaglfgg2uh0nqzpfahly8m982thwwvkcxs0mr646 into admin_list[0u8];
    set aleo1ys7c3pl70g7zn57k6m6zzd8mz87yass4ssrrmjdgeyjmlfjfkvqsdjvc3r into admin_list[1u8];
    set aleo1tgctqylml97ljhxcvfc0frkfza3kmqhr4hhewkkg20mtzesq3yyqyd68w3 into admin_list[2u8];
    set 3u8 into admin_count[0u8];
    set 1u64 into nonce[0u8];

function add_admin_hash:
    input r0 as u8.public;
    input r1 as address.public;
    input r2 as u64.public;
    cast r1 into r3 as field;
    cast r0 into r4 as field;
    cast r3 r4 into r5 as [field; 2u32];
    hash.bhp256 r5 into r6 as field;
    cast r6 5u8 r2 multisig_wallet_admin_test_11.aleo into r7 as admin_operation;
    hash.bhp256 r7 into r8 as field;
    output r8 as field.private;

function add_admin:
    input r0 as u8.public;
    input r1 as address.public;
    input r2 as [signature; 8u32].private;
    input r3 as [address; 8u32].private;
    cast r1 into r4 as field;
    cast r0 into r5 as field;
    cast r4 r5 into r6 as [field; 2u32];
    hash.bhp256 r6 into r7 as field;
    cast r7 5u8 1u64 multisig_wallet_admin_test_11.aleo into r8 as admin_operation;
    async add_admin r8 r0 r1 r2 r3 into r9;
    output r9 as multisig_wallet_admin_test_11.aleo/add_admin.future;

finalize add_admin:
    input r0 as admin_operation.public;
    input r1 as u8.public;
    input r2 as address.public;
    input r3 as [signature; 8u32].public;
    input r4 as [address; 8u32].public;
    get.or_use nonce[0u8] 1u64 into r5;
    add r5 1u64 into r6;
    set r6 into nonce[0u8];
    cast r0.arg r0.op_type r5 r0.program_id into r7 as admin_operation;
    hash.bhp256 r7 into r8 as field;
    get.or_use threshold[0u8] 2u8 into r9;
    sign.verify r3[0u32] r4[0u32] r8 into r10;
    get admins[r4[0u32]] into r11;
    and r10 r11 into r12;
    cast r12 into r13 as u8;
    sign.verify r3[1u32] r4[1u32] r8 into r14;
    get admins[r4[1u32]] into r15;
    and r14 r15 into r16;
    cast r16 into r17 as u8;
    add r13 r17 into r18;
    sign.verify r3[2u32] r4[2u32] r8 into r19;
    get admins[r4[2u32]] into r20;
    and r19 r20 into r21;
    cast r21 into r22 as u8;
    add r18 r22 into r23;
    sign.verify r3[3u32] r4[3u32] r8 into r24;
    get admins[r4[3u32]] into r25;
    and r24 r25 into r26;
    cast r26 into r27 as u8;
    add r23 r27 into r28;
    sign.verify r3[4u32] r4[4u32] r8 into r29;
    get admins[r4[4u32]] into r30;
    and r29 r30 into r31;
    cast r31 into r32 as u8;
    add r28 r32 into r33;
    sign.verify r3[5u32] r4[5u32] r8 into r34;
    get admins[r4[5u32]] into r35;
    and r34 r35 into r36;
    cast r36 into r37 as u8;
    add r33 r37 into r38;
    sign.verify r3[6u32] r4[6u32] r8 into r39;
    get admins[r4[6u32]] into r40;
    and r39 r40 into r41;
    cast r41 into r42 as u8;
    add r38 r42 into r43;
    sign.verify r3[7u32] r4[7u32] r8 into r44;
    get admins[r4[7u32]] into r45;
    and r44 r45 into r46;
    cast r46 into r47 as u8;
    add r43 r47 into r48;
    gte r48 r9 into r49;
    contains admin_operations[r5] into r50;
    not r50 into r51;
    and r49 r51 into r52;
    assert.eq r52 true;
    get.or_use admin_count[0u8] 2u8 into r53;
    add r53 1u8 into r54;
    set r2 into admin_list[r53];
    set true into admins[r2];
    set r54 into admin_count[0u8];
    set r1 into threshold[0u8];
    set r7 into admin_operations[r5];

function remove_admin:
    input r0 as u8.public;
    input r1 as address.public;
    input r2 as [signature; 8u32].private;
    input r3 as [address; 8u32].private;
    cast r1 into r4 as field;
    cast r0 into r5 as field;
    cast r4 r5 into r6 as [field; 2u32];
    hash.bhp256 r6 into r7 as field;
    cast r7 6u8 0u64 multisig_wallet_admin_test_11.aleo into r8 as admin_operation;
    async remove_admin r8 r0 r1 r2 r3 into r9;
    output r9 as multisig_wallet_admin_test_11.aleo/remove_admin.future;

finalize remove_admin:
    input r0 as admin_operation.public;
    input r1 as u8.public;
    input r2 as address.public;
    input r3 as [signature; 8u32].public;
    input r4 as [address; 8u32].public;
    get.or_use nonce[0u8] 0u64 into r5;
    add r5 1u64 into r6;
    set r6 into nonce[0u8];
    cast r0.arg r0.op_type r5 r0.program_id into r7 as admin_operation;
    hash.bhp256 r7 into r8 as field;
    get.or_use threshold[0u8] 2u8 into r9;
    set r1 into threshold[0u8];
    sign.verify r3[0u32] r4[0u32] r8 into r10;
    get admins[r4[0u32]] into r11;
    and r10 r11 into r12;
    cast r12 into r13 as u8;
    sign.verify r3[1u32] r4[1u32] r8 into r14;
    get admins[r4[1u32]] into r15;
    and r14 r15 into r16;
    cast r16 into r17 as u8;
    add r13 r17 into r18;
    sign.verify r3[2u32] r4[2u32] r8 into r19;
    get admins[r4[2u32]] into r20;
    and r19 r20 into r21;
    cast r21 into r22 as u8;
    add r18 r22 into r23;
    sign.verify r3[3u32] r4[3u32] r8 into r24;
    get admins[r4[3u32]] into r25;
    and r24 r25 into r26;
    cast r26 into r27 as u8;
    add r23 r27 into r28;
    sign.verify r3[4u32] r4[4u32] r8 into r29;
    get admins[r4[4u32]] into r30;
    and r29 r30 into r31;
    cast r31 into r32 as u8;
    add r28 r32 into r33;
    sign.verify r3[5u32] r4[5u32] r8 into r34;
    get admins[r4[5u32]] into r35;
    and r34 r35 into r36;
    cast r36 into r37 as u8;
    add r33 r37 into r38;
    sign.verify r3[6u32] r4[6u32] r8 into r39;
    get admins[r4[6u32]] into r40;
    and r39 r40 into r41;
    cast r41 into r42 as u8;
    add r38 r42 into r43;
    sign.verify r3[7u32] r4[7u32] r8 into r44;
    get admins[r4[7u32]] into r45;
    and r44 r45 into r46;
    cast r46 into r47 as u8;
    add r43 r47 into r48;
    gte r48 r9 into r49;
    contains admin_operations[r5] into r50;
    not r50 into r51;
    and r49 r51 into r52;
    assert.eq r52 true;
    get.or_use admin_count[0u8] 2u8 into r53;
    sub r53 1u8 into r54;
    get admins[r2] into r55;
    assert.eq r55 true;
    gte r1 2u8 into r56;
    lte r1 8u8 into r57;
    and r56 r57 into r58;
    assert.eq r58 true;
    lte r1 r54 into r59;
    assert.eq r59 true;
    gte r54 2u8 into r60;
    lte r54 8u8 into r61;
    and r60 r61 into r62;
    assert.eq r62 true;
    sub r53 1u8 into r63;
    get admin_list[r63] into r64;
    get admin_list[0u8] into r65;
    is.eq r65 r2 into r66;
    cast r66 into r67 as u8;
    mul r67 0u8 into r68;
    get admin_list[1u8] into r69;
    is.eq r69 r2 into r70;
    cast r70 into r71 as u8;
    mul r71 1u8 into r72;
    add r68 r72 into r73;
    get admin_list[2u8] into r74;
    is.eq r74 r2 into r75;
    cast r75 into r76 as u8;
    mul r76 2u8 into r77;
    add r73 r77 into r78;
    get admin_list[3u8] into r79;
    is.eq r79 r2 into r80;
    cast r80 into r81 as u8;
    mul r81 3u8 into r82;
    add r78 r82 into r83;
    get admin_list[4u8] into r84;
    is.eq r84 r2 into r85;
    cast r85 into r86 as u8;
    mul r86 4u8 into r87;
    add r83 r87 into r88;
    get admin_list[5u8] into r89;
    is.eq r89 r2 into r90;
    cast r90 into r91 as u8;
    mul r91 5u8 into r92;
    add r88 r92 into r93;
    get admin_list[6u8] into r94;
    is.eq r94 r2 into r95;
    cast r95 into r96 as u8;
    mul r96 6u8 into r97;
    add r93 r97 into r98;
    get admin_list[7u8] into r99;
    is.eq r99 r2 into r100;
    cast r100 into r101 as u8;
    mul r101 7u8 into r102;
    add r98 r102 into r103;
    get admin_list[r103] into r104;
    is.eq r104 r2 into r105;
    assert.eq r105 true;
    set r64 into admin_list[r103];
    remove admin_list[r63];
    remove admins[r2];
    set r54 into admin_count[0u8];
    set r1 into threshold[0u8];
    set r7 into admin_operations[r5];
