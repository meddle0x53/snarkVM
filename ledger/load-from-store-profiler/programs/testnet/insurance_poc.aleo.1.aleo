import credits.aleo;

program insurance_poc.aleo;

struct PolicyDetails:
    payment_amount_in_microcredits as u64;
    expiration_unix_secs as u64;

mapping policies:
    key as field.public;
    value as PolicyDetails.public;

function register:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as u64.private;
    assert.eq self.caller aleo1fygr89ue39wk2rlyjtjzatsaeyt53myptc2l29460564400vs5gswn9sz5;
    cast r1 r2 into r3 as PolicyDetails;
    async register r0 r3 into r4;
    output r4 as insurance_poc.aleo/register.future;

finalize register:
    input r0 as field.public;
    input r1 as PolicyDetails.public;
    set r1 into policies[r0];

function check_policy_exists:
    input r0 as field.private;
    async check_policy_exists r0 into r1;
    output r1 as insurance_poc.aleo/check_policy_exists.future;

finalize check_policy_exists:
    input r0 as field.public;
    contains policies[r0] into r1;
    assert.eq r1 true;

function pay_policy:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as u64.private;
    call credits.aleo/transfer_public aleo1fygr89ue39wk2rlyjtjzatsaeyt53myptc2l29460564400vs5gswn9sz5 r1 into r3;
    async pay_policy r0 r1 r2 r3 into r4;
    output r4 as insurance_poc.aleo/pay_policy.future;

finalize pay_policy:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as credits.aleo/transfer_public.future;
    await r3;
    get policies[r0] into r4;
    cast r4.payment_amount_in_microcredits r2 into r5 as PolicyDetails;
    set r5 into policies[r0];

function cancel:
    input r0 as field.private;
    assert.eq self.caller aleo1fygr89ue39wk2rlyjtjzatsaeyt53myptc2l29460564400vs5gswn9sz5;
    async cancel r0 into r1;
    output r1 as insurance_poc.aleo/cancel.future;

finalize cancel:
    input r0 as field.public;
    remove policies[r0];
