program config_perps_v0_4.aleo;

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

mapping super_admin:
    key as boolean.public;
    value as address.public;

mapping is_governor:
    key as address.public;
    value as boolean.public;

mapping is_liquidator:
    key as address.public;
    value as boolean.public;

mapping is_position_keeper:
    key as address.public;
    value as boolean.public;

mapping whitelist_token_ids:
    key as boolean.public;
    value as [field; 5u32].public;

mapping tokens_config:
    key as field.public;
    value as TokenConfig.public;

mapping total_token_weights:
    key as boolean.public;
    value as u128.public;

mapping buffer_amounts:
    key as field.public;
    value as u128.public;

mapping min_profit_basis_points:
    key as field.public;
    value as u32.public;

mapping max_global_short_sizes:
    key as field.public;
    value as u128.public;

mapping max_usda_amounts:
    key as field.public;
    value as u128.public;

mapping min_execution_fee:
    key as boolean.public;
    value as u128.public;

mapping shorts_tracker_config:
    key as boolean.public;
    value as ShortsTrackerConfig.public;

mapping setting:
    key as boolean.public;
    value as PerpSetting.public;

function init_super_admin:
    input r0 as address.public;
    assert.eq self.caller aleo1cnm2w8qlrhahlsmalph7t0jh3adny5pj4m38jgpcdzt2reqthurqaen3dp;
    async init_super_admin r0 into r1;
    output r1 as config_perps_v0_4.aleo/init_super_admin.future;

finalize init_super_admin:
    input r0 as address.public;
    contains super_admin[true] into r1;
    assert.eq r1 false;
    set r0 into super_admin[true];

function init_setting:
    input r0 as AumConfig.public;
    input r1 as FundingRateConfig.public;
    input r2 as LiquidityFeeBpsConfig.public;
    input r3 as PositionFeeBpsConfig.public;
    input r4 as LeverageSwapLiqModeConfig.public;
    input r5 as BlockDelayConfig.public;
    input r6 as u128.public;
    input r7 as ShortsTrackerConfig.public;
    lte r0.cooldown_duration 34560u32 into r8;
    assert.eq r8 true;
    lte r1.stable_funding_rate_factor 10000u128 into r9;
    lte r1.funding_rate_factor 10000u128 into r10;
    and r9 r10 into r11;
    gte r1.funding_interval_block 720u32 into r12;
    and r11 r12 into r13;
    assert.eq r13 true;
    lte r2.tax_basis_points 500u128 into r14;
    lte r2.stable_tax_basis_points 500u128 into r15;
    and r14 r15 into r16;
    lte r2.mint_burn_fee_basis_points 500u128 into r17;
    and r16 r17 into r18;
    lte r2.swap_fee_basis_points 500u128 into r19;
    and r18 r19 into r20;
    lte r2.stable_swap_fee_basis_points 500u128 into r21;
    and r20 r21 into r22;
    assert.eq r22 true;
    lte r3.margin_fee_basis_points 500u128 into r23;
    lte r3.liquidation_fee_usd 100000000u128 into r24;
    and r23 r24 into r25;
    assert.eq r22 true;
    gt r4.max_leverage 10000u128 into r26;
    lte r4.max_leverage 1000000u128 into r27;
    and r26 r27 into r28;
    assert.eq r28 true;
    async init_setting self.caller r0 r1 r2 r3 r4 r5 r6 r7 into r29;
    output r29 as config_perps_v0_4.aleo/init_setting.future;

finalize init_setting:
    input r0 as address.public;
    input r1 as AumConfig.public;
    input r2 as FundingRateConfig.public;
    input r3 as LiquidityFeeBpsConfig.public;
    input r4 as PositionFeeBpsConfig.public;
    input r5 as LeverageSwapLiqModeConfig.public;
    input r6 as BlockDelayConfig.public;
    input r7 as u128.public;
    input r8 as ShortsTrackerConfig.public;
    get is_governor[r0] into r9;
    assert.eq r9 true;
    cast r1 r2 r3 r4 r5 r6 into r10 as PerpSetting;
    set r10 into setting[true];
    set r7 into min_execution_fee[true];
    set r8 into shorts_tracker_config[true];

function init_setting_tokens:
    input r0 as [field; 5u32].public;
    input r1 as [TokenConfig; 5u32].public;
    async init_setting_tokens self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/init_setting_tokens.future;

finalize init_setting_tokens:
    input r0 as address.public;
    input r1 as [field; 5u32].public;
    input r2 as [TokenConfig; 5u32].public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r1 into whitelist_token_ids[true];
    set r2[0u32] into tokens_config[r1[0u32]];
    add 0u128 r2[0u32].weight into r4;
    set r2[1u32] into tokens_config[r1[1u32]];
    add r4 r2[1u32].weight into r5;
    set r2[2u32] into tokens_config[r1[2u32]];
    add r5 r2[2u32].weight into r6;
    set r2[3u32] into tokens_config[r1[3u32]];
    add r6 r2[3u32].weight into r7;
    set r2[4u32] into tokens_config[r1[4u32]];
    add r7 r2[4u32].weight into r8;
    set r8 into total_token_weights[true];

function change_admin:
    input r0 as address.public;
    async change_admin self.caller r0 into r1;
    output r1 as config_perps_v0_4.aleo/change_admin.future;

finalize change_admin:
    input r0 as address.public;
    input r1 as address.public;
    get super_admin[true] into r2;
    assert.eq r0 r2;
    set r1 into super_admin[true];

function set_governor:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_governor self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_governor.future;

finalize set_governor:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get super_admin[true] into r3;
    assert.eq r0 r3;
    set r2 into is_governor[r1];

function set_whitelist_token_ids:
    input r0 as [field; 5u32].public;
    async set_whitelist_token_ids self.caller r0 into r1;
    output r1 as config_perps_v0_4.aleo/set_whitelist_token_ids.future;

finalize set_whitelist_token_ids:
    input r0 as address.public;
    input r1 as [field; 5u32].public;
    get is_governor[r0] into r2;
    assert.eq r2 true;
    set r1 into whitelist_token_ids[true];

function set_token_config:
    input r0 as field.public;
    input r1 as TokenConfig.public;
    async set_token_config self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_token_config.future;

finalize set_token_config:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as TokenConfig.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    get.or_use total_token_weights[true] 0u128 into r4;
    cast false false 0u128 into r5 as TokenConfig;
    get.or_use tokens_config[r1] r5 into r6;
    add r4 r2.weight into r7;
    sub r7 r6.weight into r8;
    set r8 into total_token_weights[true];
    set r2 into tokens_config[r1];

function set_min_execution_fee:
    input r0 as u128.public;
    async set_min_execution_fee self.caller r0 into r1;
    output r1 as config_perps_v0_4.aleo/set_min_execution_fee.future;

finalize set_min_execution_fee:
    input r0 as address.public;
    input r1 as u128.public;
    get is_governor[r0] into r2;
    assert.eq r2 true;
    set r1 into min_execution_fee[true];

function set_shorts_tracker_config:
    input r0 as boolean.public;
    input r1 as u128.public;
    async set_shorts_tracker_config self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_shorts_tracker_config.future;

finalize set_shorts_tracker_config:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as u128.public;
    get.or_use is_governor[r0] false into r3;
    is.eq r0 pool_perps_v0_4.aleo into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    cast r1 r2 into r6 as ShortsTrackerConfig;
    set r6 into shorts_tracker_config[true];

function set_aum_config:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u32.public;
    lte r2 34560u32 into r3;
    assert.eq r3 true;
    async set_aum_config self.caller r0 r1 r2 into r4;
    output r4 as config_perps_v0_4.aleo/set_aum_config.future;

finalize set_aum_config:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u32.public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    cast r1 r2 r3 into r5 as AumConfig;
    get setting[true] into r6;
    cast r5 r6.funding_rate r6.liquidity_fee_bps r6.position_fee_bps r6.leverage_swap_liq_mode r6.block_delay into r7 as PerpSetting;
    set r7 into setting[true];

function set_funding_rate_config:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u32.public;
    lte r0 10000u128 into r3;
    lte r1 10000u128 into r4;
    and r3 r4 into r5;
    gte r2 720u32 into r6;
    and r5 r6 into r7;
    assert.eq r7 true;
    async set_funding_rate_config self.caller r0 r1 r2 into r8;
    output r8 as config_perps_v0_4.aleo/set_funding_rate_config.future;

finalize set_funding_rate_config:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u32.public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    cast r1 r2 r3 into r5 as FundingRateConfig;
    get setting[true] into r6;
    cast r6.aum r5 r6.liquidity_fee_bps r6.position_fee_bps r6.leverage_swap_liq_mode r6.block_delay into r7 as PerpSetting;
    set r7 into setting[true];

function set_liquidity_fee_bps_config:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as boolean.public;
    input r4 as u128.public;
    input r5 as u128.public;
    lte r0 500u128 into r6;
    lte r1 500u128 into r7;
    and r6 r7 into r8;
    lte r2 500u128 into r9;
    and r8 r9 into r10;
    lte r4 500u128 into r11;
    and r10 r11 into r12;
    lte r5 500u128 into r13;
    and r12 r13 into r14;
    assert.eq r14 true;
    async set_liquidity_fee_bps_config self.caller r0 r1 r2 r3 r4 r5 into r15;
    output r15 as config_perps_v0_4.aleo/set_liquidity_fee_bps_config.future;

finalize set_liquidity_fee_bps_config:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as boolean.public;
    input r5 as u128.public;
    input r6 as u128.public;
    get is_governor[r0] into r7;
    assert.eq r7 true;
    cast r1 r2 r3 r4 r5 r6 into r8 as LiquidityFeeBpsConfig;
    get setting[true] into r9;
    cast r9.aum r9.funding_rate r8 r9.position_fee_bps r9.leverage_swap_liq_mode r9.block_delay into r10 as PerpSetting;
    set r10 into setting[true];

function set_position_fee_bps_config:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u32.public;
    lte r0 500u128 into r3;
    lte r1 100000000u128 into r4;
    and r3 r4 into r5;
    assert.eq r5 true;
    async set_position_fee_bps_config self.caller r0 r1 r2 into r6;
    output r6 as config_perps_v0_4.aleo/set_position_fee_bps_config.future;

finalize set_position_fee_bps_config:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u32.public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    cast r1 r2 r3 into r5 as PositionFeeBpsConfig;
    get setting[true] into r6;
    cast r6.aum r6.funding_rate r6.liquidity_fee_bps r5 r6.leverage_swap_liq_mode r6.block_delay into r7 as PerpSetting;
    set r7 into setting[true];

function set_leverage_swap_liq_config:
    input r0 as boolean.public;
    input r1 as u128.public;
    input r2 as boolean.public;
    input r3 as boolean.public;
    gt r1 10000u128 into r4;
    lte r1 1000000u128 into r5;
    and r4 r5 into r6;
    assert.eq r6 true;
    async set_leverage_swap_liq_config self.caller r0 r1 r2 r3 into r7;
    output r7 as config_perps_v0_4.aleo/set_leverage_swap_liq_config.future;

finalize set_leverage_swap_liq_config:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as u128.public;
    input r3 as boolean.public;
    input r4 as boolean.public;
    get is_governor[r0] into r5;
    assert.eq r5 true;
    cast r1 r2 r3 r4 into r6 as LeverageSwapLiqModeConfig;
    get setting[true] into r7;
    cast r7.aum r7.funding_rate r7.liquidity_fee_bps r7.position_fee_bps r6 r7.block_delay into r8 as PerpSetting;
    set r8 into setting[true];

function set_block_delay_config:
    input r0 as u32.public;
    input r1 as u32.public;
    input r2 as u32.public;
    async set_block_delay_config self.caller r0 r1 r2 into r3;
    output r3 as config_perps_v0_4.aleo/set_block_delay_config.future;

finalize set_block_delay_config:
    input r0 as address.public;
    input r1 as u32.public;
    input r2 as u32.public;
    input r3 as u32.public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    cast r1 r2 r3 into r5 as BlockDelayConfig;
    get setting[true] into r6;
    cast r6.aum r6.funding_rate r6.liquidity_fee_bps r6.position_fee_bps r6.leverage_swap_liq_mode r5 into r7 as PerpSetting;
    set r7 into setting[true];

function set_liquidator:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_liquidator self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_liquidator.future;

finalize set_liquidator:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into is_liquidator[r1];

function set_position_keeper:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_position_keeper self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_position_keeper.future;

finalize set_position_keeper:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into is_position_keeper[r1];

function set_min_profit_bps:
    input r0 as field.public;
    input r1 as u32.public;
    async set_min_profit_bps self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_min_profit_bps.future;

finalize set_min_profit_bps:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u32.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into min_profit_basis_points[r1];

function set_max_usda_amount:
    input r0 as field.public;
    input r1 as u128.public;
    async set_max_usda_amount self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_max_usda_amount.future;

finalize set_max_usda_amount:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into max_usda_amounts[r1];

function set_max_global_short_size:
    input r0 as field.public;
    input r1 as u128.public;
    async set_max_global_short_size self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_max_global_short_size.future;

finalize set_max_global_short_size:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into max_global_short_sizes[r1];

function set_max_global_sizes:
    input r0 as [field; 5u32].public;
    input r1 as [u128; 5u32].public;
    async set_max_global_sizes self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_max_global_sizes.future;

finalize set_max_global_sizes:
    input r0 as address.public;
    input r1 as [field; 5u32].public;
    input r2 as [u128; 5u32].public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2[0u32] into max_global_short_sizes[r1[0u32]];
    set r2[1u32] into max_global_short_sizes[r1[1u32]];
    set r2[2u32] into max_global_short_sizes[r1[2u32]];
    set r2[3u32] into max_global_short_sizes[r1[3u32]];
    set r2[4u32] into max_global_short_sizes[r1[4u32]];

function set_buffer_amounts:
    input r0 as field.public;
    input r1 as u128.public;
    async set_buffer_amounts self.caller r0 r1 into r2;
    output r2 as config_perps_v0_4.aleo/set_buffer_amounts.future;

finalize set_buffer_amounts:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into buffer_amounts[r1];
