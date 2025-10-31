program amm_oracle_v003.aleo;

mapping price:
    key as field.public;
    value as u128.public;

mapping admin:
    key as boolean.public;
    value as address.public;

function initialize:
    async initialize self.caller into r0;
    output r0 as amm_oracle_v003.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    contains admin[true] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into admin[true];

function set_price:
    input r0 as field.private;
    input r1 as u128.private;
    async set_price self.caller r0 r1 into r2;
    output r2 as amm_oracle_v003.aleo/set_price.future;

finalize set_price:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get admin[true] into r3;
    assert.eq r0 r3;
    set r2 into price[r1];
