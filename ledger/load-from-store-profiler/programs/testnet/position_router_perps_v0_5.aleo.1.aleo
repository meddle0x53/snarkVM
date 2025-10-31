import official_oracle_v2.aleo;
import perp_oracle_v0_3.aleo;
import config_perps_v0_5.aleo;
import pool_perps_v0_5.aleo;

program position_router_perps_v0_5.aleo;

struct UniqueID:
    chunk_1 as u128;
    chunk_2 as u128;

struct PcrValues:
    pcr_0_chunk_1 as u128;
    pcr_0_chunk_2 as u128;
    pcr_0_chunk_3 as u128;
    pcr_1_chunk_1 as u128;
    pcr_1_chunk_2 as u128;
    pcr_1_chunk_3 as u128;
    pcr_2_chunk_1 as u128;
    pcr_2_chunk_2 as u128;
    pcr_2_chunk_3 as u128;

struct AttestedData:
    data as u128;
    attestation_timestamp as u128;

struct PositionData:
    block_index as u8;
    shift_a as u8;
    shift_b as u8;
    mask_a as u128;
    mask_b as u128;

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

struct TokenConfig:
    is_whitelist as boolean;
    is_stable as boolean;
    weight as u128;

struct AumConfig:
    addition as u128;
    deduction as u128;
    cooldown_duration as u32;

struct FundingRateConfig:
    stable_funding_rate_factor as u128;
    funding_rate_factor as u128;
    funding_interval_block as u32;

struct LiquidityFeeBpsConfig:
    tax_basis_points as u128;
    stable_tax_basis_points as u128;
    mint_burn_fee_basis_points as u128;
    has_dynamic_fees as boolean;
    swap_fee_basis_points as u128;
    stable_swap_fee_basis_points as u128;

struct PositionFeeBpsConfig:
    margin_fee_basis_points as u128;
    liquidation_fee_usd as u128;
    min_profit_block as u32;

struct LeverageSwapLiqModeConfig:
    leverage_enabled as boolean;
    max_leverage as u128;
    swap_enabled as boolean;
    in_private_liquidation_mode as boolean;

struct BlockDelayConfig:
    min_block_delay_keeper as u32;
    min_block_delay_user as u32;
    max_block_delay_user as u32;

struct PerpSetting:
    aum as AumConfig;
    funding_rate as FundingRateConfig;
    liquidity_fee_bps as LiquidityFeeBpsConfig;
    position_fee_bps as PositionFeeBpsConfig;
    leverage_swap_liq_mode as LeverageSwapLiqModeConfig;
    block_delay as BlockDelayConfig;

struct ShortsTrackerConfig:
    is_global_short_data_ready as boolean;
    average_price_weight as u128;

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
    slippage as u128;
    execution_fee as u128;
    block_number as u32;

mapping decrease_position_indexs:
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
    input r8 as u128.public;
    call pool_perps_v0_5.aleo/transfer_from 2813478088177688924050396837210505436110696643421413171056690758889678767651field self.caller position_router_perps_v0_5.aleo r8 into r9;
    async create_decrease_position self.caller r8 r0 r1 r2 r3 r4 r5 r6 r7 r9 into r10;
    output r10 as position_router_perps_v0_5.aleo/create_decrease_position.future;

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
    input r9 as u128.public;
    input r10 as pool_perps_v0_5.aleo/transfer_from.future;
    get config_perps_v0_5.aleo/min_execution_fee[true] into r11;
    gte r1 r11 into r12;
    assert.eq r12 true;
    await r10;
    cast r0 r2 r3 r4 r5 r6 r7 r8 r9 r1 block.height into r13 as DecreasePositionRequest;
    get.or_use decrease_position_indexs[r0] 0u128 into r14;
    add r14 1u128 into r15;
    set r15 into decrease_position_indexs[r0];
    cast r0 r15 into r16 as RequestKey;
    hash.bhp256 r16 into r17 as field;
    set r13 into decrease_position_requests[r17];

function cancel_decrease_position:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    call pool_perps_v0_5.aleo/transfer_public 2813478088177688924050396837210505436110696643421413171056690758889678767651field r2 r1 into r3;
    async cancel_decrease_position self.caller r0 r1 r3 into r4;
    output r4 as position_router_perps_v0_5.aleo/cancel_decrease_position.future;

finalize cancel_decrease_position:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as pool_perps_v0_5.aleo/transfer_public.future;
    get decrease_position_requests[r1] into r4;
    is.eq r4.execution_fee r2 into r5;
    assert.eq r5 true;
    get config_perps_v0_5.aleo/setting[true] into r6;
    get.or_use config_perps_v0_5.aleo/is_position_keeper[r0] false into r7;
    is.eq r7 true into r8;
    not r8 into r9;
    and r9 r6.leverage_swap_liq_mode.leverage_enabled into r10;
    is.eq r0 r4.user into r11;
    and r10 r11 into r12;
    add r4.block_number r6.block_delay.min_block_delay_keeper into r13;
    lte r13 block.height into r14;
    add r4.block_number r6.block_delay.min_block_delay_user into r15;
    lte r15 block.height into r16;
    ternary r12 r16 false into r17;
    ternary r8 r14 r17 into r18;
    assert.eq r18 true;
    remove decrease_position_requests[r1];
    await r3;

function execute_decrease_position:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as DecreasePositionRequest.public;
    call pool_perps_v0_5.aleo/decrease_position r2.user r2.collateral_token_id r2.index_token_id r2.collateral_delta r2.size_delta r2.is_long r2.receiver r2.acceptable_price r2.slippage into r3;
    call pool_perps_v0_5.aleo/transfer_public 2813478088177688924050396837210505436110696643421413171056690758889678767651field r1 r2.execution_fee into r4;
    async execute_decrease_position self.caller r0 r1 r2 r3 r4 into r5;
    output r5 as position_router_perps_v0_5.aleo/execute_decrease_position.future;

finalize execute_decrease_position:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as DecreasePositionRequest.public;
    input r4 as pool_perps_v0_5.aleo/decrease_position.future;
    input r5 as pool_perps_v0_5.aleo/transfer_public.future;
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
    is.eq r6.slippage r3.slippage into r22;
    and r21 r22 into r23;
    is.eq r6.execution_fee r3.execution_fee into r24;
    and r23 r24 into r25;
    is.eq r6.block_number r3.block_number into r26;
    and r25 r26 into r27;
    assert.eq r27 true;
    get config_perps_v0_5.aleo/setting[true] into r28;
    add r6.block_number r28.block_delay.max_block_delay_user into r29;
    gt r29 block.height into r30;
    assert.eq r30 true;
    get.or_use config_perps_v0_5.aleo/is_position_keeper[r0] false into r31;
    is.eq r31 true into r32;
    not r32 into r33;
    and r33 r28.leverage_swap_liq_mode.leverage_enabled into r34;
    is.eq r0 r6.user into r35;
    and r34 r35 into r36;
    add r6.block_number r28.block_delay.min_block_delay_keeper into r37;
    lte r37 block.height into r38;
    add r6.block_number r28.block_delay.min_block_delay_user into r39;
    lte r39 block.height into r40;
    ternary r36 r40 false into r41;
    ternary r32 r38 r41 into r42;
    assert.eq r42 true;
    remove decrease_position_requests[r1];
    await r4;
    await r5;
