import credits.aleo;
import token_registry.aleo;

program multisig_wallet_test_00.aleo;

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

struct transfer_operation:
    recipient as address;
    amount as u64;

struct transfer_registry_operation:
    token_id as field;
    recipient as address;
    amount as u128;

struct bond_operation:
    validator as address;
    withdraw as address;
    amount as u64;

struct unbond_operation:
    staker as address;
    amount as u64;

struct claim_unbond_operation:
    staker as address;

struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;
    program_id as address;

mapping admin_operations:
    key as u64.public;
    value as admin_operation.public;

mapping admins:
    key as address.public;
    value as boolean.public;

mapping initialized:
    key as u8.public;
    value as boolean.public;

mapping nonce:
    key as u8.public;
    value as u64.public;

mapping threshold:
    key as u8.public;
    value as u8.public;

mapping admin_list:
    key as u8.public;
    value as address.public;

mapping admin_count:
    key as u8.public;
    value as u8.public;

function initialize:
    async initialize into r0;
    output r0 as multisig_wallet_test_00.aleo/initialize.future;

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
    set 0u64 into nonce[0u8];

function set_threshold:
    input r0 as u8.public;
    input r1 as signature.public;
    input r2 as address.public;
    input r3 as signature.public;
    input r4 as address.public;
    async set_threshold r0 r1 r2 r3 r4 into r5;
    output r5 as multisig_wallet_test_00.aleo/set_threshold.future;

finalize set_threshold:
    input r0 as u8.public;
    input r1 as signature.public;
    input r2 as address.public;
    input r3 as signature.public;
    input r4 as address.public;
    get.or_use nonce[0u8] 0u64 into r5;
    add r5 1u64 into r6;
    set r6 into nonce[0u8];
    hash.bhp256 r0 into r7 as field;
    cast r7 7u8 r5 multisig_wallet_test_00.aleo into r8 as admin_operation;
    hash.bhp256 r8 into r9 as field;
    sign.verify r1 r2 r9 into r10;
    assert.eq r10 true;
    sign.verify r3 r4 r9 into r11;
    assert.eq r11 true;
    assert.neq r2 r4;
    get admins[r2] into r12;
    get admins[r4] into r13;
    and r12 r13 into r14;
    assert.eq r14 true;
    contains admin_operations[r5] into r15;
    not r15 into r16;
    assert.eq r16 true;
    get.or_use admin_count[0u8] 0u8 into r17;
    gte r0 1u8 into r18;
    lte r0 r17 into r19;
    and r18 r19 into r20;
    assert.eq r20 true;
    set r0 into threshold[0u8];
    set r8 into admin_operations[r5];

function transfer:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    call credits.aleo/transfer_public r0 r1 into r6;
    async transfer r6 r0 r1 r2 r3 r4 r5 into r7;
    output r7 as multisig_wallet_test_00.aleo/transfer.future;

finalize transfer:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    get.or_use nonce[0u8] 0u64 into r7;
    add r7 1u64 into r8;
    set r8 into nonce[0u8];
    cast r1 r2 into r9 as transfer_operation;
    hash.bhp256 r9 into r10 as field;
    cast r10 0u8 r7 multisig_wallet_test_00.aleo into r11 as admin_operation;
    hash.bhp256 r11 into r12 as field;
    sign.verify r3 r4 r12 into r13;
    assert.eq r13 true;
    sign.verify r5 r6 r12 into r14;
    assert.eq r14 true;
    assert.neq r4 r6;
    get admins[r4] into r15;
    get admins[r6] into r16;
    and r15 r16 into r17;
    assert.eq r17 true;
    contains admin_operations[r7] into r18;
    not r18 into r19;
    assert.eq r19 true;
    await r0;
    set r11 into admin_operations[r7];

function transfer_registry:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    call token_registry.aleo/transfer_public r0 r1 r2 into r7;
    cast r0 r1 r2 into r8 as transfer_registry_operation;
    hash.bhp256 r8 into r9 as field;
    cast r9 0u8 0u64 multisig_wallet_test_00.aleo into r10 as admin_operation;
    async transfer_registry r7 r10 r3 r4 r5 r6 into r11;
    output r11 as multisig_wallet_test_00.aleo/transfer_registry.future;

finalize transfer_registry:
    input r0 as token_registry.aleo/transfer_public.future;
    input r1 as admin_operation.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    get.or_use nonce[0u8] 0u64 into r6;
    add r6 1u64 into r7;
    set r7 into nonce[0u8];
    cast r1.arg r1.op_type r6 r1.program_id into r8 as admin_operation;
    hash.bhp256 r8 into r9 as field;
    sign.verify r2 r3 r9 into r10;
    assert.eq r10 true;
    sign.verify r4 r5 r9 into r11;
    assert.eq r11 true;
    assert.neq r3 r5;
    get admins[r3] into r12;
    get admins[r5] into r13;
    and r12 r13 into r14;
    assert.eq r14 true;
    contains admin_operations[r6] into r15;
    not r15 into r16;
    assert.eq r16 true;
    await r0;
    set r8 into admin_operations[r6];

function bond:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    call credits.aleo/bond_public r0 r1 r2 into r7;
    async bond r7 r0 r1 r2 r3 r4 r5 r6 into r8;
    output r8 as multisig_wallet_test_00.aleo/bond.future;

finalize bond:
    input r0 as credits.aleo/bond_public.future;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as u64.public;
    input r4 as signature.public;
    input r5 as address.public;
    input r6 as signature.public;
    input r7 as address.public;
    get.or_use nonce[0u8] 0u64 into r8;
    add r8 1u64 into r9;
    set r9 into nonce[0u8];
    cast r1 r2 r3 into r10 as bond_operation;
    hash.bhp256 r10 into r11 as field;
    cast r11 2u8 r8 multisig_wallet_test_00.aleo into r12 as admin_operation;
    hash.bhp256 r12 into r13 as field;
    sign.verify r4 r5 r13 into r14;
    assert.eq r14 true;
    sign.verify r6 r7 r13 into r15;
    assert.eq r15 true;
    assert.neq r5 r7;
    get admins[r5] into r16;
    get admins[r7] into r17;
    and r16 r17 into r18;
    assert.eq r18 true;
    contains admin_operations[r8] into r19;
    not r19 into r20;
    assert.eq r20 true;
    await r0;
    set r12 into admin_operations[r8];

function unbond:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    call credits.aleo/unbond_public r0 r1 into r6;
    async unbond r6 r0 r1 r2 r3 r4 r5 into r7;
    output r7 as multisig_wallet_test_00.aleo/unbond.future;

finalize unbond:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    get.or_use nonce[0u8] 0u64 into r7;
    add r7 1u64 into r8;
    set r8 into nonce[0u8];
    cast r1 r2 into r9 as unbond_operation;
    hash.bhp256 r9 into r10 as field;
    cast r10 3u8 r7 multisig_wallet_test_00.aleo into r11 as admin_operation;
    hash.bhp256 r11 into r12 as field;
    sign.verify r3 r4 r12 into r13;
    assert.eq r13 true;
    sign.verify r5 r6 r12 into r14;
    assert.eq r14 true;
    assert.neq r4 r6;
    get admins[r4] into r15;
    get admins[r6] into r16;
    and r15 r16 into r17;
    assert.eq r17 true;
    contains admin_operations[r7] into r18;
    not r18 into r19;
    assert.eq r19 true;
    await r0;
    set r11 into admin_operations[r7];

function claim_unbond:
    input r0 as address.public;
    input r1 as signature.public;
    input r2 as address.public;
    input r3 as signature.public;
    input r4 as address.public;
    call credits.aleo/claim_unbond_public r0 into r5;
    async claim_unbond r5 r0 r1 r2 r3 r4 into r6;
    output r6 as multisig_wallet_test_00.aleo/claim_unbond.future;

finalize claim_unbond:
    input r0 as credits.aleo/claim_unbond_public.future;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    get.or_use nonce[0u8] 0u64 into r6;
    add r6 1u64 into r7;
    set r7 into nonce[0u8];
    cast r1 into r8 as claim_unbond_operation;
    hash.bhp256 r8 into r9 as field;
    cast r9 4u8 r6 multisig_wallet_test_00.aleo into r10 as admin_operation;
    hash.bhp256 r10 into r11 as field;
    sign.verify r2 r3 r11 into r12;
    assert.eq r12 true;
    sign.verify r4 r5 r11 into r13;
    assert.eq r13 true;
    assert.neq r3 r5;
    get admins[r3] into r14;
    get admins[r5] into r15;
    and r14 r15 into r16;
    assert.eq r16 true;
    contains admin_operations[r6] into r17;
    not r17 into r18;
    assert.eq r18 true;
    await r0;
    set r10 into admin_operations[r6];

function update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    async update_admin r0 r1 r2 r3 r4 r5 into r6;
    output r6 as multisig_wallet_test_00.aleo/update_admin.future;

finalize update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    get.or_use nonce[0u8] 0u64 into r6;
    add r6 1u64 into r7;
    set r7 into nonce[0u8];
    cast r0 r1 into r8 as [address; 2u32];
    hash.bhp256 r8 into r9 as field;
    cast r9 1u8 r6 multisig_wallet_test_00.aleo into r10 as admin_operation;
    hash.bhp256 r10 into r11 as field;
    sign.verify r2 r3 r11 into r12;
    assert.eq r12 true;
    sign.verify r4 r5 r11 into r13;
    assert.eq r13 true;
    assert.neq r3 r5;
    get admins[r3] into r14;
    get admins[r5] into r15;
    and r14 r15 into r16;
    assert.eq r16 true;
    contains admin_operations[r6] into r17;
    not r17 into r18;
    assert.eq r18 true;
    set r10 into admin_operations[r6];
    get.or_use admin_count[0u8] 0u8 into r19;
    get admin_list[0u8] into r20;
    is.eq r20 r0 into r21;
    branch.eq r21 false to end_then_0_0;
    set r1 into admin_list[0u8];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    get admin_list[1u8] into r22;
    is.eq r22 r0 into r23;
    branch.eq r23 false to end_then_1_2;
    set r1 into admin_list[1u8];
    branch.eq true true to end_otherwise_1_3;
    position end_then_1_2;
    get admin_list[2u8] into r24;
    is.eq r24 r0 into r25;
    branch.eq r25 false to end_then_2_4;
    set r1 into admin_list[2u8];
    branch.eq true true to end_otherwise_2_5;
    position end_then_2_4;
    get admin_list[3u8] into r26;
    is.eq r26 r0 into r27;
    branch.eq r27 false to end_then_3_6;
    set r1 into admin_list[3u8];
    branch.eq true true to end_otherwise_3_7;
    position end_then_3_6;
    get admin_list[4u8] into r28;
    is.eq r28 r0 into r29;
    branch.eq r29 false to end_then_4_8;
    set r1 into admin_list[4u8];
    branch.eq true true to end_otherwise_4_9;
    position end_then_4_8;
    get admin_list[5u8] into r30;
    is.eq r30 r0 into r31;
    branch.eq r31 false to end_then_5_10;
    set r1 into admin_list[5u8];
    branch.eq true true to end_otherwise_5_11;
    position end_then_5_10;
    get admin_list[6u8] into r32;
    is.eq r32 r0 into r33;
    branch.eq r33 false to end_then_6_12;
    set r1 into admin_list[6u8];
    branch.eq true true to end_otherwise_6_13;
    position end_then_6_12;
    get admin_list[7u8] into r34;
    is.eq r34 r0 into r35;
    branch.eq r35 false to end_then_7_14;
    set r1 into admin_list[7u8];
    branch.eq true true to end_otherwise_7_15;
    position end_then_7_14;
    position end_otherwise_7_15;
    position end_otherwise_6_13;
    position end_otherwise_5_11;
    position end_otherwise_4_9;
    position end_otherwise_3_7;
    position end_otherwise_2_5;
    position end_otherwise_1_3;
    position end_otherwise_0_1;
    get admins[r0] into r36;
    get admins[r1] into r37;
    not r37 into r38;
    and r36 r38 into r39;
    assert.eq r39 true;
    remove admins[r0];
    set true into admins[r1];

function add_admin:
    input r0 as address.public;
    input r1 as signature.public;
    input r2 as address.public;
    input r3 as signature.public;
    input r4 as address.public;
    hash.bhp256 r0 into r5 as field;
    cast r5 5u8 0u64 multisig_wallet_test_00.aleo into r6 as admin_operation;
    async add_admin r6 r0 r1 r2 r3 r4 into r7;
    output r7 as multisig_wallet_test_00.aleo/add_admin.future;

finalize add_admin:
    input r0 as admin_operation.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    get.or_use nonce[0u8] 0u64 into r6;
    add r6 1u64 into r7;
    set r7 into nonce[0u8];
    cast r0.arg r0.op_type r6 r0.program_id into r8 as admin_operation;
    hash.bhp256 r8 into r9 as field;
    sign.verify r2 r3 r9 into r10;
    assert.eq r10 true;
    sign.verify r4 r5 r9 into r11;
    assert.eq r11 true;
    assert.neq r3 r5;
    get admins[r3] into r12;
    get admins[r5] into r13;
    and r12 r13 into r14;
    assert.eq r14 true;
    contains admin_operations[r6] into r15;
    not r15 into r16;
    assert.eq r16 true;
    get.or_use admin_count[0u8] 0u8 into r17;
    is.eq r0.op_type 5u8 into r18;
    branch.eq r18 false to end_then_0_16;
    get admins[r1] into r19;
    not r19 into r20;
    assert.eq r20 true;
    lt r17 8u8 into r21;
    assert.eq r21 true;
    set r1 into admin_list[r17];
    set true into admins[r1];
    add r17 1u8 into r22;
    set r22 into admin_count[0u8];
    branch.eq true true to end_otherwise_0_17;
    position end_then_0_16;
    get admins[r1] into r23;
    assert.eq r23 true;
    gt r17 0u8 into r24;
    assert.eq r24 true;
    sub r17 1u8 into r25;
    get admin_list[r25] into r26;
    get admin_list[0u8] into r27;
    is.eq r27 r1 into r28;
    branch.eq r28 false to end_then_1_18;
    set r26 into admin_list[0u8];
    branch.eq true true to end_otherwise_1_19;
    position end_then_1_18;
    get admin_list[1u8] into r29;
    is.eq r29 r1 into r30;
    branch.eq r30 false to end_then_2_20;
    set r26 into admin_list[1u8];
    branch.eq true true to end_otherwise_2_21;
    position end_then_2_20;
    get admin_list[2u8] into r31;
    is.eq r31 r1 into r32;
    branch.eq r32 false to end_then_3_22;
    set r26 into admin_list[2u8];
    branch.eq true true to end_otherwise_3_23;
    position end_then_3_22;
    get admin_list[3u8] into r33;
    is.eq r33 r1 into r34;
    branch.eq r34 false to end_then_4_24;
    set r26 into admin_list[3u8];
    branch.eq true true to end_otherwise_4_25;
    position end_then_4_24;
    get admin_list[4u8] into r35;
    is.eq r35 r1 into r36;
    branch.eq r36 false to end_then_5_26;
    set r26 into admin_list[4u8];
    branch.eq true true to end_otherwise_5_27;
    position end_then_5_26;
    get admin_list[5u8] into r37;
    is.eq r37 r1 into r38;
    branch.eq r38 false to end_then_6_28;
    set r26 into admin_list[5u8];
    branch.eq true true to end_otherwise_6_29;
    position end_then_6_28;
    get admin_list[6u8] into r39;
    is.eq r39 r1 into r40;
    branch.eq r40 false to end_then_7_30;
    set r26 into admin_list[6u8];
    branch.eq true true to end_otherwise_7_31;
    position end_then_7_30;
    get admin_list[7u8] into r41;
    is.eq r41 r1 into r42;
    branch.eq r42 false to end_then_8_32;
    set r26 into admin_list[7u8];
    branch.eq true true to end_otherwise_8_33;
    position end_then_8_32;
    position end_otherwise_8_33;
    position end_otherwise_7_31;
    position end_otherwise_6_29;
    position end_otherwise_5_27;
    position end_otherwise_4_25;
    position end_otherwise_3_23;
    position end_otherwise_2_21;
    position end_otherwise_1_19;
    remove admin_list[r25];
    remove admins[r1];
    set r25 into admin_count[0u8];
    position end_otherwise_0_17;
    set r8 into admin_operations[r6];

function remove_admin:
    input r0 as address.public;
    input r1 as signature.public;
    input r2 as address.public;
    input r3 as signature.public;
    input r4 as address.public;
    hash.bhp256 r0 into r5 as field;
    cast r5 6u8 0u64 multisig_wallet_test_00.aleo into r6 as admin_operation;
    async remove_admin r6 r0 r1 r2 r3 r4 into r7;
    output r7 as multisig_wallet_test_00.aleo/remove_admin.future;

finalize remove_admin:
    input r0 as admin_operation.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    get.or_use nonce[0u8] 0u64 into r6;
    add r6 1u64 into r7;
    set r7 into nonce[0u8];
    cast r0.arg r0.op_type r6 r0.program_id into r8 as admin_operation;
    hash.bhp256 r8 into r9 as field;
    sign.verify r2 r3 r9 into r10;
    assert.eq r10 true;
    sign.verify r4 r5 r9 into r11;
    assert.eq r11 true;
    assert.neq r3 r5;
    get admins[r3] into r12;
    get admins[r5] into r13;
    and r12 r13 into r14;
    assert.eq r14 true;
    contains admin_operations[r6] into r15;
    not r15 into r16;
    assert.eq r16 true;
    get.or_use admin_count[0u8] 0u8 into r17;
    is.eq r0.op_type 5u8 into r18;
    branch.eq r18 false to end_then_0_34;
    get admins[r1] into r19;
    not r19 into r20;
    assert.eq r20 true;
    lt r17 8u8 into r21;
    assert.eq r21 true;
    set r1 into admin_list[r17];
    set true into admins[r1];
    add r17 1u8 into r22;
    set r22 into admin_count[0u8];
    branch.eq true true to end_otherwise_0_35;
    position end_then_0_34;
    get admins[r1] into r23;
    assert.eq r23 true;
    gt r17 0u8 into r24;
    assert.eq r24 true;
    sub r17 1u8 into r25;
    get admin_list[r25] into r26;
    get admin_list[0u8] into r27;
    is.eq r27 r1 into r28;
    branch.eq r28 false to end_then_1_36;
    set r26 into admin_list[0u8];
    branch.eq true true to end_otherwise_1_37;
    position end_then_1_36;
    get admin_list[1u8] into r29;
    is.eq r29 r1 into r30;
    branch.eq r30 false to end_then_2_38;
    set r26 into admin_list[1u8];
    branch.eq true true to end_otherwise_2_39;
    position end_then_2_38;
    get admin_list[2u8] into r31;
    is.eq r31 r1 into r32;
    branch.eq r32 false to end_then_3_40;
    set r26 into admin_list[2u8];
    branch.eq true true to end_otherwise_3_41;
    position end_then_3_40;
    get admin_list[3u8] into r33;
    is.eq r33 r1 into r34;
    branch.eq r34 false to end_then_4_42;
    set r26 into admin_list[3u8];
    branch.eq true true to end_otherwise_4_43;
    position end_then_4_42;
    get admin_list[4u8] into r35;
    is.eq r35 r1 into r36;
    branch.eq r36 false to end_then_5_44;
    set r26 into admin_list[4u8];
    branch.eq true true to end_otherwise_5_45;
    position end_then_5_44;
    get admin_list[5u8] into r37;
    is.eq r37 r1 into r38;
    branch.eq r38 false to end_then_6_46;
    set r26 into admin_list[5u8];
    branch.eq true true to end_otherwise_6_47;
    position end_then_6_46;
    get admin_list[6u8] into r39;
    is.eq r39 r1 into r40;
    branch.eq r40 false to end_then_7_48;
    set r26 into admin_list[6u8];
    branch.eq true true to end_otherwise_7_49;
    position end_then_7_48;
    get admin_list[7u8] into r41;
    is.eq r41 r1 into r42;
    branch.eq r42 false to end_then_8_50;
    set r26 into admin_list[7u8];
    branch.eq true true to end_otherwise_8_51;
    position end_then_8_50;
    position end_otherwise_8_51;
    position end_otherwise_7_49;
    position end_otherwise_6_47;
    position end_otherwise_5_45;
    position end_otherwise_4_43;
    position end_otherwise_3_41;
    position end_otherwise_2_39;
    position end_otherwise_1_37;
    remove admin_list[r25];
    remove admins[r1];
    set r25 into admin_count[0u8];
    position end_otherwise_0_35;
    set r8 into admin_operations[r6];

function build_hash:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    cast r0 r1 into r3 as transfer_operation;
    hash.bhp256 r3 into r4 as field;
    cast r4 0u8 r2 multisig_wallet_test_00.aleo into r5 as admin_operation;
    hash.bhp256 r5 into r6 as field;
    output r6 as field.private;

function build_hash_set_threshold:
    input r0 as u8.public;
    input r1 as u64.public;
    hash.bhp256 r0 into r2 as field;
    cast r2 7u8 r1 multisig_wallet_test_00.aleo into r3 as admin_operation;
    hash.bhp256 r3 into r4 as field;
    output r4 as field.private;

function build_hash_add_admin:
    input r0 as address.public;
    input r1 as u64.public;
    hash.bhp256 r0 into r2 as field;
    cast r2 5u8 r1 multisig_wallet_test_00.aleo into r3 as admin_operation;
    hash.bhp256 r3 into r4 as field;
    output r4 as field.private;

function build_hash_remove_admin:
    input r0 as address.public;
    input r1 as u64.public;
    hash.bhp256 r0 into r2 as field;
    cast r2 6u8 r1 multisig_wallet_test_00.aleo into r3 as admin_operation;
    hash.bhp256 r3 into r4 as field;
    output r4 as field.private;

function build_hash_registry:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as u64.public;
    cast r0 r1 r2 into r4 as transfer_registry_operation;
    hash.bhp256 r4 into r5 as field;
    cast r5 0u8 r3 multisig_wallet_test_00.aleo into r6 as admin_operation;
    hash.bhp256 r6 into r7 as field;
    output r7 as field.private;

function build_bond:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    cast r0 r1 r2 into r4 as bond_operation;
    hash.bhp256 r4 into r5 as field;
    cast r5 2u8 r3 multisig_wallet_test_00.aleo into r6 as admin_operation;
    hash.bhp256 r6 into r7 as field;
    output r7 as field.private;

function build_unbond:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    cast r0 r1 into r3 as unbond_operation;
    hash.bhp256 r3 into r4 as field;
    cast r4 3u8 r2 multisig_wallet_test_00.aleo into r5 as admin_operation;
    hash.bhp256 r5 into r6 as field;
    output r6 as field.private;

function build_claim_unbond:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 into r2 as claim_unbond_operation;
    hash.bhp256 r2 into r3 as field;
    cast r3 4u8 r1 multisig_wallet_test_00.aleo into r4 as admin_operation;
    hash.bhp256 r4 into r5 as field;
    output r5 as field.private;

function build_admin_hash:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    cast r0 r1 into r3 as [address; 2u32];
    hash.bhp256 r3 into r4 as field;
    cast r4 1u8 r2 multisig_wallet_test_00.aleo into r5 as admin_operation;
    hash.bhp256 r5 into r6 as field;
    output r6 as field.private;
