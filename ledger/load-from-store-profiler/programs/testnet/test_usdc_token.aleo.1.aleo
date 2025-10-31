program test_usdc_token.aleo;

record PrivateToken:
    owner as address.private;
    amount as u128.private;

struct Metadata:
    name as field;
    symbol as field;
    decimals as u8;
    total_supply as u128;

struct ApprovalKeyData:
    approver as address;
    spender as address;

mapping account:
    key as address.public;
    value as u128.public;

mapping approvals:
    key as field.public;
    value as u128.public;

mapping metadata:
    key as boolean.public;
    value as Metadata.public;

function init:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    input r3 as u128.public;
    input r4 as address.public;
    assert.eq self.caller aleo1tdszx3hcgnyp2jw3y3fzvw27vremxcs24u4pys6vptg9y2jfsvps8e8ffz;
    async init r0 r1 r2 r3 r4 into r5;
    output r5 as test_usdc_token.aleo/init.future;

finalize init:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    input r3 as u128.public;
    input r4 as address.public;
    contains metadata[true] into r5;
    not r5 into r6;
    assert.eq r6 true;
    cast r0 r1 r2 r3 into r7 as Metadata;
    set r7 into metadata[true];
    set r3 into account[r4];

function transfer_public:
    input r0 as address.public;
    input r1 as u128.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as test_usdc_token.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u128.public;
    get account[r0] into r3;
    sub r3 r2 into r4;
    set r4 into account[r0];
    get.or_use account[r1] 0u128 into r5;
    add r5 r2 into r6;
    set r6 into account[r1];

function transfer_private:
    input r0 as PrivateToken.record;
    input r1 as address.private;
    input r2 as u128.private;
    cast r1 r2 into r3 as PrivateToken.record;
    sub r0.amount r2 into r4;
    cast r0.owner r4 into r5 as PrivateToken.record;
    output r3 as PrivateToken.record;
    output r5 as PrivateToken.record;

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u128.public;
    cast r0 r1 into r2 as PrivateToken.record;
    async transfer_public_to_private self.caller r1 into r3;
    output r2 as PrivateToken.record;
    output r3 as test_usdc_token.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u128.public;
    get account[r0] into r2;
    sub r2 r1 into r3;
    set r3 into account[r0];

function transfer_private_to_public:
    input r0 as PrivateToken.record;
    input r1 as address.public;
    input r2 as u128.public;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as PrivateToken.record;
    async transfer_private_to_public r1 r2 into r5;
    output r4 as PrivateToken.record;
    output r5 as test_usdc_token.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u128.public;
    get.or_use account[r0] 0u128 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];

function approve_public:
    input r0 as address.public;
    input r1 as u128.public;
    cast self.caller r0 into r2 as ApprovalKeyData;
    hash.bhp256 r2 into r3 as field;
    async approve_public r3 r1 into r4;
    output r4 as test_usdc_token.aleo/approve_public.future;

finalize approve_public:
    input r0 as field.public;
    input r1 as u128.public;
    get.or_use approvals[r0] 0u128 into r2;
    sub 340282366920938463463374607431768211455u128 r2 into r3;
    lt r1 r3 into r4;
    add.w r2 r1 into r5;
    ternary r4 r5 340282366920938463463374607431768211455u128 into r6;
    set r6 into approvals[r0];

function unapprove_public:
    input r0 as address.public;
    input r1 as u128.public;
    cast self.caller r0 into r2 as ApprovalKeyData;
    hash.bhp256 r2 into r3 as field;
    async unapprove_public r3 r1 into r4;
    output r4 as test_usdc_token.aleo/unapprove_public.future;

finalize unapprove_public:
    input r0 as field.public;
    input r1 as u128.public;
    get approvals[r0] into r2;
    gt r2 r1 into r3;
    sub.w r2 r1 into r4;
    ternary r3 r4 0u128 into r5;
    set r5 into approvals[r0];

function transfer_from_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u128.public;
    cast r0 self.caller into r3 as ApprovalKeyData;
    hash.bhp256 r3 into r4 as field;
    async transfer_from_public r4 r0 r1 r2 into r5;
    output r5 as test_usdc_token.aleo/transfer_from_public.future;

finalize transfer_from_public:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as u128.public;
    get approvals[r0] into r4;
    sub r4 r3 into r5;
    set r5 into approvals[r0];
    get account[r1] into r6;
    sub r6 r3 into r7;
    set r7 into account[r1];
    get.or_use account[r2] 0u128 into r8;
    add r8 r3 into r9;
    set r9 into account[r2];

function join:
    input r0 as PrivateToken.record;
    input r1 as PrivateToken.record;
    add r0.amount r1.amount into r2;
    cast r0.owner r2 into r3 as PrivateToken.record;
    output r3 as PrivateToken.record;
