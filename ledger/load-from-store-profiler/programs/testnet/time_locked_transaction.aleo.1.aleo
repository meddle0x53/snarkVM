program time_locked_transaction.aleo;

record LockedTransaction:
    owner as address.private;
    receiver as address.private;
    amount as u64.private;
    unlock_block as u64.private;
    is_receiver_whitelisted as boolean.private;

function create_locked_transaction:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    is.eq r0 aleo173r6atplj8l2wlthtuyckmepkrkl2j456ymh7v7mmhv82sle3qzsry6lj8 into r3;
    is.eq r0 aleo1npexhp28ssqnuqu2pjgaulk7crz3c7qd7gm26ymnrl5jn79g5ypqzzlrv8 into r4;
    or r3 r4 into r5;
    is.eq r0 aleo16qj6fdv9q2reh4l9ugy3hsrat8uvx9u77fz98hmhffv5pt9assgsvqe68m into r6;
    or r5 r6 into r7;
    cast self.caller r0 r1 r2 r7 into r8 as LockedTransaction.record;
    output r8 as LockedTransaction.record;

function execute_transaction:
    input r0 as LockedTransaction.record;
    input r1 as u64.private;
    assert.eq self.caller r0.receiver;
    assert.eq r0.is_receiver_whitelisted true;
    gte r1 r0.unlock_block into r2;
    assert.eq r2 true;
    output true as boolean.private;
