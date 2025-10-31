program tax_compliance_task.aleo;

record Transaction:
    owner as address.private;
    amount as u64.private;
    tax_rate as u64.private;
    tax_applied as boolean.private;

function create_transaction:
    input r0 as u64.private;
    input r1 as u64.private;
    cast self.caller r0 r1 false into r2 as Transaction.record;
    output r2 as Transaction.record;

function apply_tax:
    input r0 as Transaction.record;
    input r1 as address.private;
    not r0.tax_applied into r2;
    assert.eq r2 true;
    mul r0.amount r0.tax_rate into r3;
    div r3 10000u64 into r4;
    sub r0.amount r4 into r5;
    cast r0.owner r5 0u64 true into r6 as Transaction.record;
    cast r1 r4 0u64 true into r7 as Transaction.record;
    output r6 as Transaction.record;
    output r7 as Transaction.record;
