program config_v1x5.aleo;

struct ProtocolFee:
    collector as address;
    base_portion as u128;

mapping governor:
    key as boolean.public;
    value as address.public;

mapping swap_fee:
    key as boolean.public;
    value as u128.public;

mapping protocol_fee:
    key as boolean.public;
    value as ProtocolFee.public;

mapping pri_ops_flag:
    key as u8.public;
    value as boolean.public;

function init:
    input r0 as address.public;
    input r1 as address.public;
    assert.eq self.caller aleo1tdszx3hcgnyp2jw3y3fzvw27vremxcs24u4pys6vptg9y2jfsvps8e8ffz;
    async init r0 r1 into r2;
    output r2 as config_v1x5.aleo/init.future;

finalize init:
    input r0 as address.public;
    input r1 as address.public;
    contains governor[true] into r2;
    assert.eq r2 false;
    set r0 into governor[true];
    set 30u128 into swap_fee[true];
    cast r1 5u128 into r3 as ProtocolFee;
    set r3 into protocol_fee[true];
    set true into pri_ops_flag[1u8];

function change_governor:
    input r0 as address.public;
    async change_governor self.caller r0 into r1;
    output r1 as config_v1x5.aleo/change_governor.future;

finalize change_governor:
    input r0 as address.public;
    input r1 as address.public;
    get governor[true] into r2;
    assert.eq r0 r2;
    set r1 into governor[true];

function set_fee:
    input r0 as u128.public;
    input r1 as address.public;
    input r2 as u128.public;
    lte r0 100u128 into r3;
    assert.eq r3 true;
    gt r2 0u128 into r4;
    lt r2 100u128 into r5;
    and r4 r5 into r6;
    assert.eq r6 true;
    async set_fee self.caller r0 r1 r2 into r7;
    output r7 as config_v1x5.aleo/set_fee.future;

finalize set_fee:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as u128.public;
    get governor[true] into r4;
    assert.eq r0 r4;
    set r1 into swap_fee[true];
    cast r2 r3 into r5 as ProtocolFee;
    set r5 into protocol_fee[true];

function set_pri_ops:
    input r0 as boolean.public;
    async set_pri_ops self.caller r0 into r1;
    output r1 as config_v1x5.aleo/set_pri_ops.future;

finalize set_pri_ops:
    input r0 as address.public;
    input r1 as boolean.public;
    get governor[true] into r2;
    assert.eq r0 r2;
    set r1 into pri_ops_flag[1u8];
