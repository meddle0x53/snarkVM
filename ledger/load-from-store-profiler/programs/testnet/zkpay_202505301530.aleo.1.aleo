import credits.aleo;

program zkpay_202505301530.aleo;

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
    output r3 as group.private;
    output r4 as zkpay_202505301530.aleo/create_request.future;

finalize create_request:
    input r0 as group.public;
    input r1 as u64.public;
    contains requests[r0] into r2;
    not r2 into r3;
    assert.eq r3 true;
    cast false false r1 into r4 as Payment;
    set r4 into requests[r0];

closure compute_fee:
    input r0 as u64;
    gte r0 100u64 into r1;
    cast r0 into r2 as u64;
    mul r2 1000u64 into r3;
    div r3 10000u64 into r4;
    cast r4 into r5 as u64;
    lt r5 1u64 into r6;
    ternary r6 1u64 r5 into r7;
    ternary r1 1u64 r7 into r8;
    output r8 as u64;

function pay_request:
    input r0 as credits.aleo/credits.record;
    input r1 as u64.private;
    input r2 as group.private;
    call credits.aleo/transfer_private_to_public r0 zkpay_202505301530.aleo r1 into r3 r4;
    call compute_fee r1 into r5;
    call credits.aleo/transfer_private_to_public r3 aleo1cd9kse57z66vp73ez5c34qykur4hsvz8r48xk7s9hpa6ke4hj5pqle8srw r5 into r6 r7;
    async pay_request r2 r1 r4 r7 into r8;
    output r6 as credits.aleo/credits.record;
    output true as boolean.private;
    output r8 as zkpay_202505301530.aleo/pay_request.future;

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
    output r5 as zkpay_202505301530.aleo/withdraw_request.future;

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
