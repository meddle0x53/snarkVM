import credits.aleo;

program multi_sign_test_1.aleo;

struct transfer_operation:
    recipient as address;
    amount as u64;

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

function initialize:
    async initialize into r0;
    output r0 as multi_sign_test_1.aleo/initialize.future;

finalize initialize:
    contains initialized[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    set true into initialized[0u8];
    set true into admins[aleo1csgkqstenz9hgf7r6pxaglfgg2uh0nqzpfahly8m982thwwvkcxs0mr646];
    set true into admins[aleo1ys7c3pl70g7zn57k6m6zzd8mz87yass4ssrrmjdgeyjmlfjfkvqsdjvc3r];
    set true into admins[aleo1tgctqylml97ljhxcvfc0frkfza3kmqhr4hhewkkg20mtzesq3yyqyd68w3];
    set 0u64 into nonce[0u8];

function transfer:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    call credits.aleo/transfer_public r0 r1 into r6;
    async transfer r6 r0 r1 r2 r3 r4 r5 into r7;
    output r7 as multi_sign_test_1.aleo/transfer.future;

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
    cast r10 0u8 r7 multi_sign_test_1.aleo into r11 as admin_operation;
    hash.bhp256 r11 into r12 as field;
    sign.verify r3 r4 r12 into r13;
    assert.eq r13 true;
    sign.verify r5 r6 r12 into r14;
    assert.eq r14 true;
    assert.neq r4 r6;
    await r0;
    get admins[r4] into r15;
    get admins[r6] into r16;
    and r15 r16 into r17;
    assert.eq r17 true;
    contains admin_operations[r11.request_id] into r18;
    not r18 into r19;
    assert.eq r19 true;
    set r11 into admin_operations[r11.request_id];

function update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    async update_admin r0 r1 r2 r3 r4 r5 into r6;
    output r6 as multi_sign_test_1.aleo/update_admin.future;

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
    cast r9 1u8 r6 multi_sign_test_1.aleo into r10 as admin_operation;
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
    contains admin_operations[r10.request_id] into r17;
    not r17 into r18;
    assert.eq r18 true;
    set r10 into admin_operations[r10.request_id];
    contains admins[r0] into r19;
    assert.eq r19 true;
    contains admins[r1] into r20;
    not r20 into r21;
    assert.eq r21 true;
    remove admins[r0];
    set true into admins[r1];

function build_hash:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    cast r0 r1 into r3 as transfer_operation;
    hash.bhp256 r3 into r4 as field;
    cast r4 0u8 r2 multi_sign_test_1.aleo into r5 as admin_operation;
    hash.bhp256 r5 into r6 as field;
    output r6 as field.private;
