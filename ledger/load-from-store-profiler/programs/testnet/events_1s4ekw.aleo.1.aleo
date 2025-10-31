program events_1s4ekw.aleo;

struct Event:
    code as field;
    content as field;
    caller as address;

mapping events:
    key as field.public;
    value as Event.public;

function emit:
    input r0 as Event.public;
    assert.eq self.caller r0.caller;
    hash.bhp256 r0.code into r1 as field;
    async emit r1 r0 into r2;
    output r2 as events_1s4ekw.aleo/emit.future;

finalize emit:
    input r0 as field.public;
    input r1 as Event.public;
    set r1 into events[r0];

function get:
    input r0 as field.public;
    async get r0 into r1;
    output r1 as events_1s4ekw.aleo/get.future;

finalize get:
    input r0 as field.public;
    get events[r0] into r1;
