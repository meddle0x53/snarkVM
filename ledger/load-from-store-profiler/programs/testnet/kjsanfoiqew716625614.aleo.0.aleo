import credits.aleo;
import token_registry.aleo;

program kjsanfoiqew716625614.aleo;

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
    token_id as field;
    recipient as address;
    amount as u128;

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
    output r0 as kjsanfoiqew716625614.aleo/initialize.future;

finalize initialize:
    contains initialized[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    set true into initialized[0u8];
    set true into admins[aleo13xhun5t87lv4kxv7zwte3dlxrelvgpclux9cu52xup9dx5ljjy9swpxd9d];
    set true into admins[aleo10785qm46jy5a9rhdmr4ukj9a55m2gd976yeeytn77utvkn0c6srsy7u5qp];
    set true into admins[aleo1xngpgxvrj6ttxugn9k3dfucw07hxfh5pfkvs8jd5500f0fxr8cqsr3nk6d];

function transfer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    input r7 as u64.public;
    call token_registry.aleo/transfer_public r0 r1 r2 into r8;
    cast r0 r1 r2 into r9 as transfer_operation;
    hash.bhp256 r9 into r10 as field;
    cast r10 0u8 r7 kjsanfoiqew716625614.aleo into r11 as admin_operation;
    hash.bhp256 r11 into r12 as field;
    sign.verify r3 r4 r12 into r13;
    sign.verify r5 r6 r12 into r14;
    and r13 r14 into r15;
    assert.eq r15 true;
    assert.neq r4 r6;
    async transfer r8 r4 r6 r11 into r16;
    output r16 as kjsanfoiqew716625614.aleo/transfer.future;

finalize transfer:
    input r0 as token_registry.aleo/transfer_public.future;
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
    cast r8 1u8 r6 kjsanfoiqew716625614.aleo into r9 as admin_operation;
    hash.bhp256 r9 into r10 as field;
    sign.verify r2 r3 r10 into r11;
    sign.verify r4 r5 r10 into r12;
    and r11 r12 into r13;
    assert.eq r13 true;
    assert.neq r3 r5;
    async update_admin r0 r1 r3 r5 r9 into r14;
    output r14 as kjsanfoiqew716625614.aleo/update_admin.future;

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
    remove admins[r0];
    contains admins[r1] into r10;
    not r10 into r11;
    assert.eq r11 true;
    set true into admins[r1];
