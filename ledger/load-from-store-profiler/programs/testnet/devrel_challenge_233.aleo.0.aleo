program devrel_challenge_233.aleo;

record Record:
    owner as address.private;
    data as u128.private;

struct State:
    data as u128;
    data2 as field;

mapping state:
    key as u128.public;
    value as State.public;

function create_private_record:
    input r0 as u128.private;
    cast self.caller r0 into r1 as Record.record;
    output r1 as Record.record;

function update_private_record:
    input r0 as Record.record;
    input r1 as u128.private;
    cast r0.owner r1 into r2 as Record.record;
    output r2 as Record.record;

function set_public_state:
    input r0 as u128.private;
    input r1 as State.private;
    async set_public_state r0 r1 into r2;
    output r2 as devrel_challenge_233.aleo/set_public_state.future;

finalize set_public_state:
    input r0 as u128.public;
    input r1 as State.public;
    cast r1.data r1.data2 into r2 as State;
    set r2 into state[r0];

function update_public_state:
    input r0 as u128.private;
    input r1 as State.private;
    async update_public_state r0 r1 into r2;
    output r2 as devrel_challenge_233.aleo/update_public_state.future;

finalize update_public_state:
    input r0 as u128.public;
    input r1 as State.public;
    cast r1.data r1.data2 into r2 as State;
    set r2 into state[r0];
