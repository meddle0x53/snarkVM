program zpass_demo_v2_rr.aleo;

mapping whitelisted:
    key as field.public;
    value as boolean.public;

function add_address:
    input r0 as address.private;
    hash.bhp256 r0 into r1 as field;
    async add_address self.caller r1 into r2;
    output r2 as zpass_demo_v2_rr.aleo/add_address.future;

finalize add_address:
    input r0 as address.public;
    input r1 as field.public;
    assert.eq r0 aleo1kypwp5m7qtk9mwazgcpg0tq8aal23mnrvwfvug65qgcg9xvsrqgspyjm6n;
    set true into whitelisted[r1];

function remove_address:
    input r0 as address.private;
    hash.bhp256 r0 into r1 as field;
    async remove_address self.caller r1 into r2;
    output r2 as zpass_demo_v2_rr.aleo/remove_address.future;

finalize remove_address:
    input r0 as address.public;
    input r1 as field.public;
    assert.eq r0 aleo1kypwp5m7qtk9mwazgcpg0tq8aal23mnrvwfvug65qgcg9xvsrqgspyjm6n;
    remove whitelisted[r1];

function check_address:
    async check_address self.signer into r0;
    output r0 as zpass_demo_v2_rr.aleo/check_address.future;

finalize check_address:
    input r0 as address.public;
    hash.bhp256 r0 into r1 as field;
    get.or_use whitelisted[r1] false into r2;
    assert.eq r2 true;
