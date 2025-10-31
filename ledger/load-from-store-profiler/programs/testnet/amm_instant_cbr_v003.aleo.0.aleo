import amm_reserve_state_v003.aleo;

program amm_instant_cbr_v003.aleo;

struct ReserveData:
    last_update_block_height as u32;
    liquidity_rate as u128;
    borrow_rate as u128;
    liquidity_cumulative_index as u128;
    borrow_cumulative_index as u128;

struct ReserveConfig:
    token_id as field;
    decimals as u8;
    borrow_fee_percentage as u128;
    base_LTV_as_collateral as u128;
    liquidation_threshold as u128;
    liquidation_bonus as u128;
    optimal_utilization_rate as u128;
    base_borrow_rate as u128;
    borrow_threshold as u128;
    is_freezed as boolean;
    is_active as boolean;

mapping allowed_programs:
    key as address.public;
    value as boolean.public;

mapping admin:
    key as boolean.public;
    value as address.public;

function initialize:
    async initialize self.caller into r0;
    output r0 as amm_instant_cbr_v003.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    contains admin[true] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into admin[true];

function instant_CBR:
    input r0 as [field; 10u32].private;
    call amm_reserve_state_v003.aleo/instant_CBR r0[0u32] into r1;
    call amm_reserve_state_v003.aleo/instant_CBR r0[1u32] into r2;
    call amm_reserve_state_v003.aleo/instant_CBR r0[2u32] into r3;
    call amm_reserve_state_v003.aleo/instant_CBR r0[3u32] into r4;
    call amm_reserve_state_v003.aleo/instant_CBR r0[4u32] into r5;
    call amm_reserve_state_v003.aleo/instant_CBR r0[5u32] into r6;
    call amm_reserve_state_v003.aleo/instant_CBR r0[6u32] into r7;
    call amm_reserve_state_v003.aleo/instant_CBR r0[7u32] into r8;
    call amm_reserve_state_v003.aleo/instant_CBR r0[8u32] into r9;
    call amm_reserve_state_v003.aleo/instant_CBR r0[9u32] into r10;
    async instant_CBR self.caller r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 into r11;
    output r11 as amm_instant_cbr_v003.aleo/instant_CBR.future;

finalize instant_CBR:
    input r0 as address.public;
    input r1 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r2 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r3 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r4 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r5 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r6 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r7 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r8 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r9 as amm_reserve_state_v003.aleo/instant_CBR.future;
    input r10 as amm_reserve_state_v003.aleo/instant_CBR.future;
    get allowed_programs[r0] into r11;
    assert.eq r11 true;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
    await r9;
    await r10;

function update_program_status:
    input r0 as address.private;
    input r1 as boolean.private;
    async update_program_status self.caller r0 r1 into r2;
    output r2 as amm_instant_cbr_v003.aleo/update_program_status.future;

finalize update_program_status:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get admin[true] into r3;
    assert.eq r0 r3;
    is.eq r2 true into r4;
    branch.eq r4 false to end_then_0_0;
    set true into allowed_programs[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    remove allowed_programs[r1];
    position end_otherwise_0_1;
