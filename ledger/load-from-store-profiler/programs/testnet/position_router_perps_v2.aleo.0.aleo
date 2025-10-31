import official_oracle.aleo;
import perp_oracle_v0_1.aleo;
import config_perps_v2.aleo;
import pool_perps_v2.aleo;

program position_router_perps_v2.aleo;

struct DataChunk:
    f0 as u128;
    f1 as u128;
    f2 as u128;
    f3 as u128;
    f4 as u128;
    f5 as u128;
    f6 as u128;
    f7 as u128;
    f8 as u128;
    f9 as u128;
    f10 as u128;
    f11 as u128;
    f12 as u128;
    f13 as u128;
    f14 as u128;
    f15 as u128;
    f16 as u128;
    f17 as u128;
    f18 as u128;
    f19 as u128;
    f20 as u128;
    f21 as u128;
    f22 as u128;
    f23 as u128;
    f24 as u128;
    f25 as u128;
    f26 as u128;
    f27 as u128;
    f28 as u128;
    f29 as u128;
    f30 as u128;
    f31 as u128;

struct Report:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;
    c8 as DataChunk;
    c9 as DataChunk;

struct ReportData:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;

struct BlockDelayConfig:
    min_block_delay_keeper as u32;
    min_block_delay_user as u32;
    max_block_delay_user as u32;

struct LeverageSwapLiqModeConfig:
    leverage_enabled as boolean;
    max_leverage as u128;
    swap_enabled as boolean;
    in_private_liquidation_mode as boolean;

struct RequestKey:
    user as address;
    index as u128;

struct DecreasePositionRequest:
    user as address;
    collateral_token_id as field;
    index_token_id as field;
    collateral_delta as u128;
    size_delta as u128;
    is_long as boolean;
    receiver as address;
    acceptable_price as u128;
    execution_fee as u128;
    block_number as u32;

mapping decrease_positions_index:
    key as address.public;
    value as u128.public;

mapping decrease_position_requests:
    key as field.public;
    value as DecreasePositionRequest.public;

function create_decrease_position:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as boolean.public;
    input r5 as address.public;
    input r6 as u128.public;
    input r7 as u128.public;
    call pool_perps_v2.aleo/transfer_from 2332509741224889217762299597065758555844272253918577374930571880861666094922field self.caller position_router_perps_v2.aleo r7 into r8;
    async create_decrease_position self.caller r7 r0 r1 r2 r3 r4 r5 r6 r8 into r9;
    output r9 as position_router_perps_v2.aleo/create_decrease_position.future;

finalize create_decrease_position:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    input r5 as u128.public;
    input r6 as boolean.public;
    input r7 as address.public;
    input r8 as u128.public;
    input r9 as pool_perps_v2.aleo/transfer_from.future;
    get config_perps_v2.aleo/min_execution_fee[true] into r10;
    gte r1 r10 into r11;
    assert.eq r11 true;
    await r9;
    cast r0 r2 r3 r4 r5 r6 r7 r8 r1 block.height into r12 as DecreasePositionRequest;
    get.or_use decrease_positions_index[r0] 0u128 into r13;
    add r13 1u128 into r14;
    set r14 into decrease_positions_index[r0];
    cast r0 r14 into r15 as RequestKey;
    hash.bhp256 r15 into r16 as field;
    set r12 into decrease_position_requests[r16];

function cancel_decrease_position:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    call pool_perps_v2.aleo/transfer_public 2332509741224889217762299597065758555844272253918577374930571880861666094922field r2 r1 into r3;
    async cancel_decrease_position self.caller r0 r1 r3 into r4;
    output r4 as position_router_perps_v2.aleo/cancel_decrease_position.future;

finalize cancel_decrease_position:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as pool_perps_v2.aleo/transfer_public.future;
    get decrease_position_requests[r1] into r4;
    is.eq r4.execution_fee r2 into r5;
    assert.eq r5 true;
    get config_perps_v2.aleo/block_delay_config[true] into r6;
    get config_perps_v2.aleo/leverage_swap_liq_mode_config[true] into r7;
    get.or_use config_perps_v2.aleo/is_position_keeper[r0] false into r8;
    or r7.leverage_enabled r8 into r9;
    assert.eq r9 true;
    get.or_use config_perps_v2.aleo/is_position_keeper[r0] false into r10;
    is.eq r0 r4.user into r11;
    or r10 r11 into r12;
    assert.eq r12 true;
    not r10 into r13;
    is.eq r0 r4.user into r14;
    and r13 r14 into r15;
    add r4.block_number r6.min_block_delay_user into r16;
    lte r16 block.height into r17;
    ternary r15 r17 true into r18;
    assert.eq r18 true;
    add r4.block_number r6.min_block_delay_keeper into r19;
    lte r19 block.height into r20;
    ternary r10 r20 true into r21;
    assert.eq r21 true;
    remove decrease_position_requests[r1];
    await r3;

function execute_decrease_position:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as DecreasePositionRequest.public;
    call pool_perps_v2.aleo/decrease_position r2.user r2.collateral_token_id r2.index_token_id r2.collateral_delta r2.size_delta r2.is_long r2.receiver r2.acceptable_price into r3;
    call pool_perps_v2.aleo/transfer_public 2332509741224889217762299597065758555844272253918577374930571880861666094922field r1 r2.execution_fee into r4;
    async execute_decrease_position self.caller r0 r1 r2 r3 r4 into r5;
    output r5 as position_router_perps_v2.aleo/execute_decrease_position.future;

finalize execute_decrease_position:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as DecreasePositionRequest.public;
    input r4 as pool_perps_v2.aleo/decrease_position.future;
    input r5 as pool_perps_v2.aleo/transfer_public.future;
    get decrease_position_requests[r1] into r6;
    is.eq r6.user r3.user into r7;
    is.eq r6.collateral_token_id r3.collateral_token_id into r8;
    and r7 r8 into r9;
    is.eq r6.index_token_id r3.index_token_id into r10;
    and r9 r10 into r11;
    is.eq r6.collateral_delta r3.collateral_delta into r12;
    and r11 r12 into r13;
    is.eq r6.size_delta r3.size_delta into r14;
    and r13 r14 into r15;
    is.eq r6.is_long r3.is_long into r16;
    and r15 r16 into r17;
    is.eq r6.receiver r3.receiver into r18;
    and r17 r18 into r19;
    is.eq r6.acceptable_price r3.acceptable_price into r20;
    and r19 r20 into r21;
    is.eq r6.execution_fee r3.execution_fee into r22;
    and r21 r22 into r23;
    is.eq r6.block_number r3.block_number into r24;
    and r23 r24 into r25;
    assert.eq r25 true;
    get config_perps_v2.aleo/block_delay_config[true] into r26;
    add r6.block_number r26.max_block_delay_user into r27;
    gt r27 block.height into r28;
    assert.eq r28 true;
    get config_perps_v2.aleo/leverage_swap_liq_mode_config[true] into r29;
    get.or_use config_perps_v2.aleo/is_position_keeper[r0] false into r30;
    or r29.leverage_enabled r30 into r31;
    assert.eq r31 true;
    get.or_use config_perps_v2.aleo/is_position_keeper[r0] false into r32;
    is.eq r0 r6.user into r33;
    or r32 r33 into r34;
    assert.eq r34 true;
    not r32 into r35;
    is.eq r0 r6.user into r36;
    and r35 r36 into r37;
    add r6.block_number r26.min_block_delay_user into r38;
    lte r38 block.height into r39;
    ternary r37 r39 true into r40;
    assert.eq r40 true;
    add r6.block_number r26.min_block_delay_keeper into r41;
    lte r41 block.height into r42;
    ternary r32 r42 true into r43;
    assert.eq r43 true;
    remove decrease_position_requests[r1];
    await r4;
    await r5;
