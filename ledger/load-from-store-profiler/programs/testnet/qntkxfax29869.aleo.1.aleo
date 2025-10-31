program qntkxfax29869.aleo;

mapping state:
    key as address.public;
    value as u64.public;

function change_state:
    input r0 as address.private;
    async change_state r0 into r1;
    output r1 as qntkxfax29869.aleo/change_state.future;

finalize change_state:
    input r0 as address.public;
    get.or_use state[r0] 0u64 into r1;
    add r1 1u64 into r2;
    set r2 into state[r0];
