import official_oracle_v2.aleo;
import perp_oracle_v0_3.aleo;
import config_perps_v0_4.aleo;
import pool_perps_v0_4.aleo;
import btc_perps_v0_4.aleo;

program btc_wrapper_perps_v0_4.aleo;

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

struct ShortsTrackerConfig:
    is_global_short_data_ready as boolean;
    average_price_weight as u128;

struct TokenId:
    base as address;
    creator as address;
    salt as u128;

function init_wrapper:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    call pool_perps_v0_4.aleo/create_token r0 r1 r2 0u128 btc_wrapper_perps_v0_4.aleo 1u128 into r3;
    async init_wrapper r3 into r4;
    output r4 as btc_wrapper_perps_v0_4.aleo/init_wrapper.future;

finalize init_wrapper:
    input r0 as pool_perps_v0_4.aleo/create_token.future;
    await r0;

function wrap_public:
    input r0 as u128.public;
    input r1 as address.public;
    call btc_perps_v0_4.aleo/transfer_from_public self.caller btc_wrapper_perps_v0_4.aleo r0 into r2;
    cast pool_perps_v0_4.aleo btc_wrapper_perps_v0_4.aleo 1u128 into r3 as TokenId;
    hash.bhp256 r3 into r4 as field;
    call pool_perps_v0_4.aleo/mint r4 r1 r0 into r5;
    async wrap_public r2 r5 into r6;
    output r6 as btc_wrapper_perps_v0_4.aleo/wrap_public.future;

finalize wrap_public:
    input r0 as btc_perps_v0_4.aleo/transfer_from_public.future;
    input r1 as pool_perps_v0_4.aleo/mint.future;
    await r0;
    await r1;

function unwrap_public:
    input r0 as u128.public;
    input r1 as address.public;
    cast pool_perps_v0_4.aleo btc_wrapper_perps_v0_4.aleo 1u128 into r2 as TokenId;
    hash.bhp256 r2 into r3 as field;
    call pool_perps_v0_4.aleo/burn_from r3 self.caller r0 into r4;
    call btc_perps_v0_4.aleo/transfer_public r1 r0 into r5;
    async unwrap_public r4 r5 into r6;
    output r6 as btc_wrapper_perps_v0_4.aleo/unwrap_public.future;

finalize unwrap_public:
    input r0 as pool_perps_v0_4.aleo/burn_from.future;
    input r1 as btc_perps_v0_4.aleo/transfer_public.future;
    await r0;
    await r1;
