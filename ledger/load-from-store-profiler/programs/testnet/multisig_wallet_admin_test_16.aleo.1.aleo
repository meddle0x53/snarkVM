program multisig_wallet_admin_test_16.aleo;

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
    output r0 as multisig_wallet_admin_test_16.aleo/initialize.future;

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
    cast r6 5u8 r2 multisig_wallet_admin_test_16.aleo into r7 as admin_operation;
    hash.bhp256 r7 into r8 as field;
    output r8 as field.private;

function add_admin:
    input r0 as u8.public;
    input r1 as address.public;
    input r2 as [signature; 8u32].private;
    input r3 as [address; 8u32].private;
    input r4 as u64.private;
    cast r1 into r5 as field;
    cast r0 into r6 as field;
    cast r5 r6 into r7 as [field; 2u32];
    hash.bhp256 r7 into r8 as field;
    cast r8 5u8 r4 multisig_wallet_admin_test_16.aleo into r9 as admin_operation;
    hash.bhp256 r9 into r10 as field;
    sign.verify r2[0u32] r3[0u32] r10 into r11;
    cast r11 into r12 as u8;
    sign.verify r2[1u32] r3[1u32] r10 into r13;
    cast r13 into r14 as u8;
    add r12 r14 into r15;
    sign.verify r2[2u32] r3[2u32] r10 into r16;
    cast r16 into r17 as u8;
    add r15 r17 into r18;
    sign.verify r2[3u32] r3[3u32] r10 into r19;
    cast r19 into r20 as u8;
    add r18 r20 into r21;
    sign.verify r2[4u32] r3[4u32] r10 into r22;
    cast r22 into r23 as u8;
    add r21 r23 into r24;
    sign.verify r2[5u32] r3[5u32] r10 into r25;
    cast r25 into r26 as u8;
    add r24 r26 into r27;
    sign.verify r2[6u32] r3[6u32] r10 into r28;
    cast r28 into r29 as u8;
    add r27 r29 into r30;
    sign.verify r2[7u32] r3[7u32] r10 into r31;
    cast r31 into r32 as u8;
    add r30 r32 into r33;
    async add_admin r9 r0 r1 r33 r3 into r34;
    output r34 as multisig_wallet_admin_test_16.aleo/add_admin.future;

finalize add_admin:
    input r0 as admin_operation.public;
    input r1 as u8.public;
    input r2 as address.public;
    input r3 as u8.public;
    input r4 as [address; 8u32].public;
    get admins[r4[0u32]] into r5;
    cast r5 into r6 as u8;
    get admins[r4[1u32]] into r7;
    cast r7 into r8 as u8;
    add r6 r8 into r9;
    get admins[r4[2u32]] into r10;
    cast r10 into r11 as u8;
    add r9 r11 into r12;
    get admins[r4[3u32]] into r13;
    cast r13 into r14 as u8;
    add r12 r14 into r15;
    get admins[r4[4u32]] into r16;
    cast r16 into r17 as u8;
    add r15 r17 into r18;
    get admins[r4[5u32]] into r19;
    cast r19 into r20 as u8;
    add r18 r20 into r21;
    get admins[r4[6u32]] into r22;
    cast r22 into r23 as u8;
    add r21 r23 into r24;
    get admins[r4[7u32]] into r25;
    cast r25 into r26 as u8;
    add r24 r26 into r27;
    get.or_use threshold[0u8] 2u8 into r28;
    get.or_use nonce[0u8] 1u64 into r29;
    gte r27 r28 into r30;
    gte r3 r28 into r31;
    and r30 r31 into r32;
    assert.eq r32 true;
    contains admin_operations[r29] into r33;
    not r33 into r34;
    assert.eq r34 true;
    is.eq r29 r0.request_id into r35;
    assert.eq r35 true;
    add r29 1u64 into r36;
    set r36 into nonce[0u8];
    get.or_use admin_count[0u8] 2u8 into r37;
    add r37 1u8 into r38;
    get admins[r2] into r39;
    not r39 into r40;
    assert.eq r40 true;
    lt r37 8u8 into r41;
    assert.eq r41 true;
    gte r1 2u8 into r42;
    lte r1 8u8 into r43;
    and r42 r43 into r44;
    assert.eq r44 true;
    lte r1 r38 into r45;
    assert.eq r45 true;
    gte r38 2u8 into r46;
    assert.eq r46 true;
    set r2 into admin_list[r37];
    set true into admins[r2];
    set r38 into admin_count[0u8];
    set r1 into threshold[0u8];
    set r0 into admin_operations[r29];

function remove_admin:
    input r0 as u8.public;
    input r1 as address.public;
    input r2 as [signature; 8u32].private;
    input r3 as [address; 8u32].private;
    input r4 as u64.private;
    cast r1 into r5 as field;
    cast r0 into r6 as field;
    cast r5 r6 into r7 as [field; 2u32];
    hash.bhp256 r7 into r8 as field;
    cast r8 6u8 r4 multisig_wallet_admin_test_16.aleo into r9 as admin_operation;
    hash.bhp256 r9 into r10 as field;
    sign.verify r2[0u32] r3[0u32] r10 into r11;
    cast r11 into r12 as u8;
    sign.verify r2[1u32] r3[1u32] r10 into r13;
    cast r13 into r14 as u8;
    add r12 r14 into r15;
    sign.verify r2[2u32] r3[2u32] r10 into r16;
    cast r16 into r17 as u8;
    add r15 r17 into r18;
    sign.verify r2[3u32] r3[3u32] r10 into r19;
    cast r19 into r20 as u8;
    add r18 r20 into r21;
    sign.verify r2[4u32] r3[4u32] r10 into r22;
    cast r22 into r23 as u8;
    add r21 r23 into r24;
    sign.verify r2[5u32] r3[5u32] r10 into r25;
    cast r25 into r26 as u8;
    add r24 r26 into r27;
    sign.verify r2[6u32] r3[6u32] r10 into r28;
    cast r28 into r29 as u8;
    add r27 r29 into r30;
    sign.verify r2[7u32] r3[7u32] r10 into r31;
    cast r31 into r32 as u8;
    add r30 r32 into r33;
    async remove_admin r9 r0 r1 r33 r3 into r34;
    output r34 as multisig_wallet_admin_test_16.aleo/remove_admin.future;

finalize remove_admin:
    input r0 as admin_operation.public;
    input r1 as u8.public;
    input r2 as address.public;
    input r3 as u8.public;
    input r4 as [address; 8u32].public;
    get admins[r4[0u32]] into r5;
    cast r5 into r6 as u8;
    get admins[r4[1u32]] into r7;
    cast r7 into r8 as u8;
    add r6 r8 into r9;
    get admins[r4[2u32]] into r10;
    cast r10 into r11 as u8;
    add r9 r11 into r12;
    get admins[r4[3u32]] into r13;
    cast r13 into r14 as u8;
    add r12 r14 into r15;
    get admins[r4[4u32]] into r16;
    cast r16 into r17 as u8;
    add r15 r17 into r18;
    get admins[r4[5u32]] into r19;
    cast r19 into r20 as u8;
    add r18 r20 into r21;
    get admins[r4[6u32]] into r22;
    cast r22 into r23 as u8;
    add r21 r23 into r24;
    get admins[r4[7u32]] into r25;
    cast r25 into r26 as u8;
    add r24 r26 into r27;
    get.or_use threshold[0u8] 2u8 into r28;
    get.or_use nonce[0u8] 0u64 into r29;
    gte r27 r28 into r30;
    assert.eq r30 true;
    gte r3 r28 into r31;
    assert.eq r31 true;
    is.eq r29 r0.request_id into r32;
    assert.eq r32 true;
    add r29 1u64 into r33;
    set r33 into nonce[0u8];
    get.or_use admin_count[0u8] 2u8 into r34;
    sub r34 1u8 into r35;
    get admins[r2] into r36;
    assert.eq r36 true;
    gte r1 2u8 into r37;
    lte r1 8u8 into r38;
    and r37 r38 into r39;
    assert.eq r39 true;
    lte r1 r35 into r40;
    assert.eq r40 true;
    gte r35 2u8 into r41;
    lte r35 8u8 into r42;
    and r41 r42 into r43;
    assert.eq r43 true;
    sub r34 1u8 into r44;
    get admin_list[r44] into r45;
    get admin_list[0u8] into r46;
    is.eq r46 r2 into r47;
    cast r47 into r48 as u8;
    mul r48 0u8 into r49;
    get admin_list[1u8] into r50;
    is.eq r50 r2 into r51;
    cast r51 into r52 as u8;
    mul r52 1u8 into r53;
    add r49 r53 into r54;
    get admin_list[2u8] into r55;
    is.eq r55 r2 into r56;
    cast r56 into r57 as u8;
    mul r57 2u8 into r58;
    add r54 r58 into r59;
    get admin_list[3u8] into r60;
    is.eq r60 r2 into r61;
    cast r61 into r62 as u8;
    mul r62 3u8 into r63;
    add r59 r63 into r64;
    get admin_list[4u8] into r65;
    is.eq r65 r2 into r66;
    cast r66 into r67 as u8;
    mul r67 4u8 into r68;
    add r64 r68 into r69;
    get admin_list[5u8] into r70;
    is.eq r70 r2 into r71;
    cast r71 into r72 as u8;
    mul r72 5u8 into r73;
    add r69 r73 into r74;
    get admin_list[6u8] into r75;
    is.eq r75 r2 into r76;
    cast r76 into r77 as u8;
    mul r77 6u8 into r78;
    add r74 r78 into r79;
    get admin_list[7u8] into r80;
    is.eq r80 r2 into r81;
    cast r81 into r82 as u8;
    mul r82 7u8 into r83;
    add r79 r83 into r84;
    get admin_list[r84] into r85;
    is.eq r85 r2 into r86;
    assert.eq r86 true;
    set r45 into admin_list[r84];
    remove admin_list[r44];
    remove admins[r2];
    set r35 into admin_count[0u8];
    set r1 into threshold[0u8];
    set r0 into admin_operations[r29];
