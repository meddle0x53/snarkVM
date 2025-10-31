import credits.aleo;

program zkpay_core.aleo;

record PaymentRequest:
    owner as address.private;
    request_key as scalar.private;

struct Payment:
    paid as boolean;
    withdrawn as boolean;
    amount as u64;

mapping requests:
    key as group.public;
    value as Payment.public;

function create_request:
    input r0 as u64.public;
    input r1 as scalar.private;
    cast self.signer r1 into r2 as PaymentRequest.record;
    mul r1 1540945439182663264862696551825005342995406165131907382295858612069623286213group into r3;
    async create_request r3 r0 into r4;
    output r2 as PaymentRequest.record;
    output r4 as zkpay_core.aleo/create_request.future;

finalize create_request:
    input r0 as group.public;
    input r1 as u64.public;
    contains requests[r0] into r2;
    not r2 into r3;
    assert.eq r3 true;
    cast false false r1 into r4 as Payment;
    set r4 into requests[r0];

function pay_request:
    input r0 as credits.aleo/credits.record;
    input r1 as u64.private;
    input r2 as group.private;
    call credits.aleo/transfer_private_to_public r0 zkpay_core.aleo r1 into r3 r4;
    gte r1 100u64 into r5;
    cast r1 into r6 as u64;
    mul r6 1000u64 into r7;
    div r7 10000u64 into r8;
    cast r8 into r9 as u64;
    lt r9 1u64 into r10;
    ternary r10 1u64 r9 into r11;
    ternary r5 1u64 r11 into r12;
    call credits.aleo/transfer_private_to_public r3 aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw r12 into r13 r14;
    async pay_request r2 r1 r4 r14 into r15;
    output r13 as credits.aleo/credits.record;
    output true as boolean.private;
    output r15 as zkpay_core.aleo/pay_request.future;

finalize pay_request:
    input r0 as group.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_private_to_public.future;
    input r3 as credits.aleo/transfer_private_to_public.future;
    get requests[r0] into r4;
    not r4.paid into r5;
    assert.eq r5 true;
    not r4.withdrawn into r6;
    assert.eq r6 true;
    assert.eq r1 r4.amount;
    cast true false r4.amount into r7 as Payment;
    set r7 into requests[r0];
    await r2;
    await r3;

function withdraw_request:
    input r0 as PaymentRequest.record;
    input r1 as u64.public;
    call credits.aleo/transfer_public_to_private self.signer r1 into r2 r3;
    mul r0.request_key 1540945439182663264862696551825005342995406165131907382295858612069623286213group into r4;
    async withdraw_request r4 r1 r3 into r5;
    output r2 as credits.aleo/credits.record;
    output r5 as zkpay_core.aleo/withdraw_request.future;

finalize withdraw_request:
    input r0 as group.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_to_private.future;
    get requests[r0] into r3;
    assert.eq r3.paid true;
    not r3.withdrawn into r4;
    assert.eq r4 true;
    assert.eq r1 r3.amount;
    cast true true r3.amount into r5 as Payment;
    set r5 into requests[r0];
    await r2;
