import credits.aleo;

program bond_multi_sign.aleo;

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

function initialize:
    async initialize into r0;
    output r0 as bond_multi_sign.aleo/initialize.future;

finalize initialize:
    contains initialized[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    set true into initialized[0u8];
    set true into admins[aleo1csgkqstenz9hgf7r6pxaglfgg2uh0nqzpfahly8m982thwwvkcxs0mr646];
    set true into admins[aleo1ys7c3pl70g7zn57k6m6zzd8mz87yass4ssrrmjdgeyjmlfjfkvqsdjvc3r];
    set true into admins[aleo1tgctqylml97ljhxcvfc0frkfza3kmqhr4hhewkkg20mtzesq3yyqyd68w3];

function transfer:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    input r6 as u64.public;
    call credits.aleo/transfer_public r0 r1 into r7;
    cast r0 r1 into r8 as transfer_operation;
    hash.bhp256 r8 into r9 as field;
    cast r9 0u8 r6 bond_multi_sign.aleo into r10 as admin_operation;
    hash.bhp256 r10 into r11 as field;
    sign.verify r2 r3 r11 into r12;
    sign.verify r4 r5 r11 into r13;
    and r12 r13 into r14;
    assert.eq r14 true;
    assert.neq r3 r5;
    async transfer r7 r3 r5 r10 into r15;
    output r15 as bond_multi_sign.aleo/transfer.future;

finalize transfer:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as admin_operation.public;
    await r0;
    get admins[r1] into r4;
    get admins[r2] into r5;
    and r4 r5 into r6;
    assert.eq r6 true;
    contains admin_operations[r3.request_id] into r7;
    assert.eq r7 false;
    set r3 into admin_operations[r3.request_id];

function update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    input r6 as u64.public;
    cast r0 r1 into r7 as [address; 2u32];
    hash.bhp256 r7 into r8 as field;
    cast r8 1u8 r6 bond_multi_sign.aleo into r9 as admin_operation;
    hash.bhp256 r9 into r10 as field;
    sign.verify r2 r3 r10 into r11;
    sign.verify r4 r5 r10 into r12;
    and r11 r12 into r13;
    assert.eq r13 true;
    assert.neq r3 r5;
    async update_admin r0 r1 r3 r5 r9 into r14;
    output r14 as bond_multi_sign.aleo/update_admin.future;

finalize update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as admin_operation.public;
    get admins[r2] into r5;
    get admins[r3] into r6;
    and r5 r6 into r7;
    assert.eq r7 true;
    contains admin_operations[r4.request_id] into r8;
    assert.eq r8 false;
    set r4 into admin_operations[r4.request_id];
    contains admins[r0] into r9;
    assert.eq r9 true;
    contains admins[r1] into r10;
    not r10 into r11;
    assert.eq r11 true;
    remove admins[r0];
    set true into admins[r1];
