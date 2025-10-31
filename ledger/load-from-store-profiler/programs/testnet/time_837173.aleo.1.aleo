program time_837173.aleo;

mapping last_called:
    key as address.public;
    value as u32.public;

mapping value_store:
    key as address.public;
    value as u32.public;

function time_throttled_set:
    input r0 as u32.public;
    async time_throttled_set self.caller r0 into r1;
    output r1 as time_837173.aleo/time_throttled_set.future;

finalize time_throttled_set:
    input r0 as address.public;
    input r1 as u32.public;
    get.or_use last_called[r0] 0u32 into r2;
    sub block.height r2 into r3;
    gt r3 100u32 into r4;
    assert.eq r4 true;
    set r1 into value_store[r0];
    set block.height into last_called[r0];
