program multisig_wallet_admin_test_19.aleo;

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
    output r0 as multisig_wallet_admin_test_19.aleo/initialize.future;

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
    cast r6 5u8 r2 multisig_wallet_admin_test_19.aleo into r7 as admin_operation;
    hash.bhp256 r7 into r8 as field;
    output r8 as field.private;

function remove_admin_hash:
    input r0 as u8.public;
    input r1 as address.public;
    input r2 as u64.public;
    cast r1 into r3 as field;
    cast r0 into r4 as field;
    cast r3 r4 into r5 as [field; 2u32];
    hash.bhp256 r5 into r6 as field;
    cast r6 6u8 r2 multisig_wallet_admin_test_19.aleo into r7 as admin_operation;
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
    cast r8 5u8 r4 multisig_wallet_admin_test_19.aleo into r9 as admin_operation;
    hash.bhp256 r9 into r10 as field;
    sign.verify r2[0u32] r3[0u32] r10 into r11;
    sign.verify r2[1u32] r3[1u32] r10 into r12;
    sign.verify r2[2u32] r3[2u32] r10 into r13;
    sign.verify r2[3u32] r3[3u32] r10 into r14;
    sign.verify r2[4u32] r3[4u32] r10 into r15;
    sign.verify r2[5u32] r3[5u32] r10 into r16;
    sign.verify r2[6u32] r3[6u32] r10 into r17;
    sign.verify r2[7u32] r3[7u32] r10 into r18;
    cast r11 r12 r13 r14 r15 r16 r17 r18 into r19 as [boolean; 8u32];
    async add_admin r9 r0 r1 r19 r3 into r20;
    output r20 as multisig_wallet_admin_test_19.aleo/add_admin.future;

finalize add_admin:
    input r0 as admin_operation.public;
    input r1 as u8.public;
    input r2 as address.public;
    input r3 as [boolean; 8u32].public;
    input r4 as [address; 8u32].public;
    get.or_use admins[r4[0u32]] false into r5;
    and r3[0u32] r5 into r6;
    cast r6 into r7 as u8;
    get.or_use admins[r4[1u32]] false into r8;
    and r3[1u32] r8 into r9;
    cast r9 into r10 as u8;
    add r7 r10 into r11;
    get.or_use admins[r4[2u32]] false into r12;
    and r3[2u32] r12 into r13;
    cast r13 into r14 as u8;
    add r11 r14 into r15;
    get.or_use admins[r4[3u32]] false into r16;
    and r3[3u32] r16 into r17;
    cast r17 into r18 as u8;
    add r15 r18 into r19;
    get.or_use admins[r4[4u32]] false into r20;
    and r3[4u32] r20 into r21;
    cast r21 into r22 as u8;
    add r19 r22 into r23;
    get.or_use admins[r4[5u32]] false into r24;
    and r3[5u32] r24 into r25;
    cast r25 into r26 as u8;
    add r23 r26 into r27;
    get.or_use admins[r4[6u32]] false into r28;
    and r3[6u32] r28 into r29;
    cast r29 into r30 as u8;
    add r27 r30 into r31;
    get.or_use admins[r4[7u32]] false into r32;
    and r3[7u32] r32 into r33;
    cast r33 into r34 as u8;
    add r31 r34 into r35;
    get.or_use threshold[0u8] 2u8 into r36;
    get.or_use nonce[0u8] 1u64 into r37;
    gte r35 r36 into r38;
    assert.eq r38 true;
    contains admin_operations[r37] into r39;
    not r39 into r40;
    assert.eq r40 true;
    is.eq r37 r0.request_id into r41;
    assert.eq r41 true;
    add r37 1u64 into r42;
    set r42 into nonce[0u8];
    get.or_use admin_count[0u8] 2u8 into r43;
    add r43 1u8 into r44;
    get.or_use admins[r2] false into r45;
    not r45 into r46;
    assert.eq r46 true;
    lt r43 8u8 into r47;
    assert.eq r47 true;
    gte r1 2u8 into r48;
    lte r1 8u8 into r49;
    and r48 r49 into r50;
    assert.eq r50 true;
    lte r1 r44 into r51;
    assert.eq r51 true;
    gte r44 2u8 into r52;
    assert.eq r52 true;
    set r2 into admin_list[r43];
    set true into admins[r2];
    set r44 into admin_count[0u8];
    set r1 into threshold[0u8];
    set r0 into admin_operations[r37];

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
    cast r8 6u8 r4 multisig_wallet_admin_test_19.aleo into r9 as admin_operation;
    hash.bhp256 r9 into r10 as field;
    sign.verify r2[0u32] r3[0u32] r10 into r11;
    sign.verify r2[1u32] r3[1u32] r10 into r12;
    sign.verify r2[2u32] r3[2u32] r10 into r13;
    sign.verify r2[3u32] r3[3u32] r10 into r14;
    sign.verify r2[4u32] r3[4u32] r10 into r15;
    sign.verify r2[5u32] r3[5u32] r10 into r16;
    sign.verify r2[6u32] r3[6u32] r10 into r17;
    sign.verify r2[7u32] r3[7u32] r10 into r18;
    cast r11 r12 r13 r14 r15 r16 r17 r18 into r19 as [boolean; 8u32];
    async remove_admin r9 r0 r1 r19 r3 into r20;
    output r20 as multisig_wallet_admin_test_19.aleo/remove_admin.future;

finalize remove_admin:
    input r0 as admin_operation.public;
    input r1 as u8.public;
    input r2 as address.public;
    input r3 as [boolean; 8u32].public;
    input r4 as [address; 8u32].public;
    get.or_use admins[r4[0u32]] false into r5;
    and r3[0u32] r5 into r6;
    cast r6 into r7 as u8;
    get.or_use admins[r4[1u32]] false into r8;
    and r3[1u32] r8 into r9;
    cast r9 into r10 as u8;
    add r7 r10 into r11;
    get.or_use admins[r4[2u32]] false into r12;
    and r3[2u32] r12 into r13;
    cast r13 into r14 as u8;
    add r11 r14 into r15;
    get.or_use admins[r4[3u32]] false into r16;
    and r3[3u32] r16 into r17;
    cast r17 into r18 as u8;
    add r15 r18 into r19;
    get.or_use admins[r4[4u32]] false into r20;
    and r3[4u32] r20 into r21;
    cast r21 into r22 as u8;
    add r19 r22 into r23;
    get.or_use admins[r4[5u32]] false into r24;
    and r3[5u32] r24 into r25;
    cast r25 into r26 as u8;
    add r23 r26 into r27;
    get.or_use admins[r4[6u32]] false into r28;
    and r3[6u32] r28 into r29;
    cast r29 into r30 as u8;
    add r27 r30 into r31;
    get.or_use admins[r4[7u32]] false into r32;
    and r3[7u32] r32 into r33;
    cast r33 into r34 as u8;
    add r31 r34 into r35;
    get.or_use threshold[0u8] 2u8 into r36;
    get.or_use nonce[0u8] 0u64 into r37;
    gte r35 r36 into r38;
    assert.eq r38 true;
    is.eq r37 r0.request_id into r39;
    assert.eq r39 true;
    add r37 1u64 into r40;
    set r40 into nonce[0u8];
    get.or_use admin_count[0u8] 2u8 into r41;
    sub r41 1u8 into r42;
    get.or_use admins[r2] false into r43;
    assert.eq r43 true;
    gte r1 2u8 into r44;
    lte r1 8u8 into r45;
    and r44 r45 into r46;
    assert.eq r46 true;
    lte r1 r42 into r47;
    assert.eq r47 true;
    gte r42 2u8 into r48;
    lte r42 8u8 into r49;
    and r48 r49 into r50;
    assert.eq r50 true;
    sub r41 1u8 into r51;
    get admin_list[r51] into r52;
    get.or_use admin_list[0u8] aleo1svjqjtdvmc2wukkfaha6a5ad460hgxtx7ju8rvy7wysltjqsn5pqha3syl into r53;
    is.eq r53 r2 into r54;
    cast r54 into r55 as u8;
    mul r55 0u8 into r56;
    get.or_use admin_list[1u8] aleo1svjqjtdvmc2wukkfaha6a5ad460hgxtx7ju8rvy7wysltjqsn5pqha3syl into r57;
    is.eq r57 r2 into r58;
    cast r58 into r59 as u8;
    mul r59 1u8 into r60;
    add r56 r60 into r61;
    get.or_use admin_list[2u8] aleo1svjqjtdvmc2wukkfaha6a5ad460hgxtx7ju8rvy7wysltjqsn5pqha3syl into r62;
    is.eq r62 r2 into r63;
    cast r63 into r64 as u8;
    mul r64 2u8 into r65;
    add r61 r65 into r66;
    get.or_use admin_list[3u8] aleo1svjqjtdvmc2wukkfaha6a5ad460hgxtx7ju8rvy7wysltjqsn5pqha3syl into r67;
    is.eq r67 r2 into r68;
    cast r68 into r69 as u8;
    mul r69 3u8 into r70;
    add r66 r70 into r71;
    get.or_use admin_list[4u8] aleo1svjqjtdvmc2wukkfaha6a5ad460hgxtx7ju8rvy7wysltjqsn5pqha3syl into r72;
    is.eq r72 r2 into r73;
    cast r73 into r74 as u8;
    mul r74 4u8 into r75;
    add r71 r75 into r76;
    get.or_use admin_list[5u8] aleo1svjqjtdvmc2wukkfaha6a5ad460hgxtx7ju8rvy7wysltjqsn5pqha3syl into r77;
    is.eq r77 r2 into r78;
    cast r78 into r79 as u8;
    mul r79 5u8 into r80;
    add r76 r80 into r81;
    get.or_use admin_list[6u8] aleo1svjqjtdvmc2wukkfaha6a5ad460hgxtx7ju8rvy7wysltjqsn5pqha3syl into r82;
    is.eq r82 r2 into r83;
    cast r83 into r84 as u8;
    mul r84 6u8 into r85;
    add r81 r85 into r86;
    get.or_use admin_list[7u8] aleo1svjqjtdvmc2wukkfaha6a5ad460hgxtx7ju8rvy7wysltjqsn5pqha3syl into r87;
    is.eq r87 r2 into r88;
    cast r88 into r89 as u8;
    mul r89 7u8 into r90;
    add r86 r90 into r91;
    get admin_list[r91] into r92;
    is.eq r92 r2 into r93;
    assert.eq r93 true;
    set r52 into admin_list[r91];
    remove admin_list[r51];
    remove admins[r2];
    set r42 into admin_count[0u8];
    set r1 into threshold[0u8];
    set r0 into admin_operations[r37];
