program multisig_v1.aleo;

struct Operation:
    program_id as address;
    op_type as u8;
    params as field;
    op_salt as u64;
    delay as u32;

struct Request:
    operation as Operation;
    multisig as address;

struct ReqState:
    state as u8;
    active_block as u32;

mapping admins:
    key as address.public;
    value as boolean.public;

mapping initialized:
    key as u8.public;
    value as boolean.public;

mapping requests:
    key as field.public;
    value as ReqState.public;

function init:
    input r0 as [address; 5u32].public;
    assert.neq r0[0u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    assert.neq r0[1u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    assert.neq r0[2u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    assert.neq r0[3u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    assert.neq r0[4u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    assert.neq r0[0u32] r0[1u32];
    assert.neq r0[0u32] r0[2u32];
    assert.neq r0[0u32] r0[3u32];
    assert.neq r0[0u32] r0[4u32];
    assert.neq r0[1u32] r0[2u32];
    assert.neq r0[1u32] r0[3u32];
    assert.neq r0[1u32] r0[4u32];
    assert.neq r0[2u32] r0[3u32];
    assert.neq r0[2u32] r0[4u32];
    assert.neq r0[3u32] r0[4u32];
    async init r0 into r1;
    output r1 as multisig_v1.aleo/init.future;

finalize init:
    input r0 as [address; 5u32].public;
    contains initialized[1u8] into r1;
    assert.eq r1 false;
    set true into initialized[1u8];
    set true into admins[r0[0u32]];
    set true into admins[r0[1u32]];
    set true into admins[r0[2u32]];
    set true into admins[r0[3u32]];
    set true into admins[r0[4u32]];

closure verify_signatures:
    input r0 as Request;
    input r1 as [address; 3u32];
    input r2 as [signature; 3u32];
    assert.neq r1[0u32] r1[1u32];
    assert.neq r1[0u32] r1[2u32];
    assert.neq r1[1u32] r1[2u32];
    hash.bhp256 r0 into r3 as field;
    sign.verify r2[0u32] r1[0u32] r3 into r4;
    assert.eq r4 true;
    sign.verify r2[1u32] r1[1u32] r3 into r5;
    assert.eq r5 true;
    sign.verify r2[2u32] r1[2u32] r3 into r6;
    assert.eq r6 true;
    output r3 as field;

function change_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.private;
    input r3 as [address; 3u32].public;
    input r4 as [signature; 3u32].private;
    assert.neq r0 r1;
    assert.neq r1 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    cast r0 r1 into r5 as [address; 2u32];
    hash.bhp256 r5 into r6 as field;
    cast multisig_v1.aleo 1u8 r6 r2 0u32 into r7 as Operation;
    cast r7 multisig_v1.aleo into r8 as Request;
    call verify_signatures r8 r3 r4 into r9;
    async change_admin r0 r1 r9 r3 into r10;
    output r10 as multisig_v1.aleo/change_admin.future;

finalize change_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as [address; 3u32].public;
    get admins[r3[0u32]] into r4;
    assert.eq r4 true;
    get admins[r3[1u32]] into r5;
    assert.eq r5 true;
    get admins[r3[2u32]] into r6;
    assert.eq r6 true;
    contains requests[r2] into r7;
    assert.eq r7 false;
    cast 1u8 block.height into r8 as ReqState;
    set r8 into requests[r2];
    get admins[r0] into r9;
    assert.eq r9 true;
    get.or_use admins[r1] false into r10;
    assert.eq r10 false;
    remove admins[r0];
    set true into admins[r1];

function new_request:
    input r0 as Operation.public;
    input r1 as boolean.public;
    input r2 as [address; 3u32].public;
    input r3 as [signature; 3u32].private;
    cast r0 multisig_v1.aleo into r4 as Request;
    call verify_signatures r4 r2 r3 into r5;
    not r1 into r6;
    is.eq r0.program_id self.caller into r7;
    or r6 r7 into r8;
    assert.eq r8 true;
    not r1 into r9;
    is.eq r0.delay 0u32 into r10;
    or r9 r10 into r11;
    assert.eq r11 true;
    async new_request r1 r0.delay r5 r2 into r12;
    output r12 as multisig_v1.aleo/new_request.future;

finalize new_request:
    input r0 as boolean.public;
    input r1 as u32.public;
    input r2 as field.public;
    input r3 as [address; 3u32].public;
    get admins[r3[0u32]] into r4;
    assert.eq r4 true;
    get admins[r3[1u32]] into r5;
    assert.eq r5 true;
    get admins[r3[2u32]] into r6;
    assert.eq r6 true;
    contains requests[r2] into r7;
    assert.eq r7 false;
    ternary r0 1u8 0u8 into r8;
    add block.height r1 into r9;
    cast r8 r9 into r10 as ReqState;
    set r10 into requests[r2];

function cancel_request:
    input r0 as field.public;
    input r1 as [address; 3u32].public;
    input r2 as [signature; 3u32].private;
    cast multisig_v1.aleo 2u8 r0 0u64 0u32 into r3 as Operation;
    cast r3 multisig_v1.aleo into r4 as Request;
    call verify_signatures r4 r1 r2 into r5;
    async cancel_request r0 r1 into r6;
    output r6 as multisig_v1.aleo/cancel_request.future;

finalize cancel_request:
    input r0 as field.public;
    input r1 as [address; 3u32].public;
    get admins[r1[0u32]] into r2;
    assert.eq r2 true;
    get admins[r1[1u32]] into r3;
    assert.eq r3 true;
    get admins[r1[2u32]] into r4;
    assert.eq r4 true;
    get requests[r0] into r5;
    assert.eq r5.state 0u8;
    cast 2u8 r5.active_block into r6 as ReqState;
    set r6 into requests[r0];

function execute:
    input r0 as Operation.public;
    assert.eq r0.program_id self.caller;
    cast r0 multisig_v1.aleo into r1 as Request;
    hash.bhp256 r1 into r2 as field;
    async execute r2 into r3;
    output r3 as multisig_v1.aleo/execute.future;

finalize execute:
    input r0 as field.public;
    get requests[r0] into r1;
    assert.eq r1.state 0u8;
    lte r1.active_block block.height into r2;
    assert.eq r2 true;
    cast 1u8 r1.active_block into r3 as ReqState;
    set r3 into requests[r0];
