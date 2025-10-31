program vesting_token_01.aleo;

mapping vesting_owner:
    key as address.public;
    value as address.public;

mapping vesting_start_epoch:
    key as address.public;
    value as u32.public;

mapping vesting_cliff_duration:
    key as address.public;
    value as u32.public;

mapping vesting_duration:
    key as address.public;
    value as u32.public;

mapping vesting_amount:
    key as address.public;
    value as u128.public;

mapping vesting_released:
    key as address.public;
    value as u128.public;

function create_vesting_schedule:
    input r0 as address.private;
    input r1 as u32.private;
    input r2 as u32.private;
    input r3 as u32.private;
    input r4 as u128.private;
    assert.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h;
    async create_vesting_schedule r0 r1 r2 r3 r4 into r5;
    output r5 as vesting_token_01.aleo/create_vesting_schedule.future;

finalize create_vesting_schedule:
    input r0 as address.public;
    input r1 as u32.public;
    input r2 as u32.public;
    input r3 as u32.public;
    input r4 as u128.public;
    contains vesting_owner[r0] into r5;
    not r5 into r6;
    assert.eq r6 true;
    set r0 into vesting_owner[r0];
    set r1 into vesting_start_epoch[r0];
    set r2 into vesting_cliff_duration[r0];
    set r3 into vesting_duration[r0];
    set r4 into vesting_amount[r0];
    set 0u128 into vesting_released[r0];

function release_vested_tokens:
    input r0 as address.private;
    input r1 as u32.private;
    assert.eq self.caller r0;
    async release_vested_tokens r0 r1 into r2;
    output r2 as vesting_token_01.aleo/release_vested_tokens.future;

finalize release_vested_tokens:
    input r0 as address.public;
    input r1 as u32.public;
    get vesting_start_epoch[r0] into r2;
    get vesting_cliff_duration[r0] into r3;
    get vesting_duration[r0] into r4;
    get vesting_amount[r0] into r5;
    get vesting_released[r0] into r6;
    add r2 r3 into r7;
    gte r1 r7 into r8;
    assert.eq r8 true;
    sub r1 r2 into r9;
    gte r9 r4 into r10;
    cast r9 into r11 as u128;
    mul r5 r11 into r12;
    cast r4 into r13 as u128;
    div r12 r13 into r14;
    ternary r10 r5 r14 into r15;
    sub r15 r6 into r16;
    gt r16 0u128 into r17;
    assert.eq r17 true;
    set r15 into vesting_released[r0];
