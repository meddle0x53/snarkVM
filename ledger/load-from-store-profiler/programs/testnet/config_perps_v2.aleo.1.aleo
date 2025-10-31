program config_perps_v2.aleo;

struct BlockDelayConfig:
    min_block_delay_keeper as u32;
    min_block_delay_user as u32;
    max_block_delay_user as u32;

struct AumConfig:
    addition as u128;
    deduction as u128;
    cooldown_duration as u32;

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

struct FundingRateConfig:
    stable_funding_rate_factor as u128;
    funding_rate_factor as u128;
    funding_interval_block as u32;

struct LeverageSwapLiqModeConfig:
    leverage_enabled as boolean;
    max_leverage as u128;
    swap_enabled as boolean;
    in_private_liquidation_mode as boolean;

mapping super_admin:
    key as boolean.public;
    value as address.public;

mapping is_governor:
    key as address.public;
    value as boolean.public;

mapping whitelist_token_ids:
    key as boolean.public;
    value as [field; 5u32].public;

mapping is_whitelist_token:
    key as field.public;
    value as boolean.public;

mapping aum_config:
    key as boolean.public;
    value as AumConfig.public;

mapping funding_rate_config:
    key as boolean.public;
    value as FundingRateConfig.public;

mapping liquidity_fee_bps_config:
    key as boolean.public;
    value as LiquidityFeeBpsConfig.public;

mapping position_fee_bps_config:
    key as boolean.public;
    value as PositionFeeBpsConfig.public;

mapping leverage_swap_liq_mode_config:
    key as boolean.public;
    value as LeverageSwapLiqModeConfig.public;

mapping block_delay_config:
    key as boolean.public;
    value as BlockDelayConfig.public;

mapping stable_tokens:
    key as field.public;
    value as boolean.public;

mapping token_weights:
    key as field.public;
    value as u128.public;

mapping total_token_weights:
    key as boolean.public;
    value as u128.public;

mapping max_usda_amounts:
    key as field.public;
    value as u128.public;

mapping min_profit_basis_points:
    key as field.public;
    value as u32.public;

mapping is_liquidator:
    key as address.public;
    value as boolean.public;

mapping is_position_keeper:
    key as address.public;
    value as boolean.public;

mapping min_execution_fee:
    key as boolean.public;
    value as u128.public;

mapping max_global_short_sizes:
    key as field.public;
    value as u128.public;

mapping max_global_long_sizes:
    key as field.public;
    value as u128.public;

mapping buffer_amounts:
    key as field.public;
    value as u128.public;

function init_super_admin:
    input r0 as address.public;
    assert.eq self.caller aleo1cnm2w8qlrhahlsmalph7t0jh3adny5pj4m38jgpcdzt2reqthurqaen3dp;
    async init_super_admin r0 into r1;
    output r1 as config_perps_v2.aleo/init_super_admin.future;

finalize init_super_admin:
    input r0 as address.public;
    contains super_admin[true] into r1;
    assert.eq r1 false;
    set r0 into super_admin[true];

function change_admin:
    input r0 as address.public;
    async change_admin self.caller r0 into r1;
    output r1 as config_perps_v2.aleo/change_admin.future;

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
    output r2 as config_perps_v2.aleo/set_governor.future;

finalize set_governor:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get super_admin[true] into r3;
    assert.eq r0 r3;
    set r2 into is_governor[r1];

function init_tokens:
    input r0 as [field; 5u32].public;
    input r1 as [boolean; 5u32].public;
    input r2 as [boolean; 5u32].public;
    async init_tokens self.caller r0 r1 r2 into r3;
    output r3 as config_perps_v2.aleo/init_tokens.future;

finalize init_tokens:
    input r0 as address.public;
    input r1 as [field; 5u32].public;
    input r2 as [boolean; 5u32].public;
    input r3 as [boolean; 5u32].public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    set r1 into whitelist_token_ids[true];
    set r2[0u32] into is_whitelist_token[r1[0u32]];
    set r3[0u32] into stable_tokens[r1[0u32]];
    set r2[1u32] into is_whitelist_token[r1[1u32]];
    set r3[1u32] into stable_tokens[r1[1u32]];
    set r2[2u32] into is_whitelist_token[r1[2u32]];
    set r3[2u32] into stable_tokens[r1[2u32]];
    set r2[3u32] into is_whitelist_token[r1[3u32]];
    set r3[3u32] into stable_tokens[r1[3u32]];
    set r2[4u32] into is_whitelist_token[r1[4u32]];
    set r3[4u32] into stable_tokens[r1[4u32]];

function init_token_weights:
    input r0 as [field; 5u32].public;
    input r1 as [u128; 5u32].public;
    async init_token_weights self.caller r0 r1 into r2;
    output r2 as config_perps_v2.aleo/init_token_weights.future;

finalize init_token_weights:
    input r0 as address.public;
    input r1 as [field; 5u32].public;
    input r2 as [u128; 5u32].public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2[0u32] into token_weights[r1[0u32]];
    add 0u128 r2[0u32] into r4;
    set r2[1u32] into token_weights[r1[1u32]];
    add r4 r2[1u32] into r5;
    set r2[2u32] into token_weights[r1[2u32]];
    add r5 r2[2u32] into r6;
    set r2[3u32] into token_weights[r1[3u32]];
    add r6 r2[3u32] into r7;
    set r2[4u32] into token_weights[r1[4u32]];
    add r7 r2[4u32] into r8;
    set r8 into total_token_weights[true];

function set_leverage_swap_liq_config:
    input r0 as boolean.public;
    input r1 as u128.public;
    input r2 as boolean.public;
    input r3 as boolean.public;
    async set_leverage_swap_liq_config self.caller r0 r1 r2 r3 into r4;
    output r4 as config_perps_v2.aleo/set_leverage_swap_liq_config.future;

finalize set_leverage_swap_liq_config:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as u128.public;
    input r3 as boolean.public;
    input r4 as boolean.public;
    get is_governor[r0] into r5;
    assert.eq r5 true;
    gt r2 10000u128 into r6;
    lte r2 1000000u128 into r7;
    and r6 r7 into r8;
    assert.eq r8 true;
    cast r1 r2 r3 r4 into r9 as LeverageSwapLiqModeConfig;
    set r9 into leverage_swap_liq_mode_config[true];

function set_liquidity_fee_bps_config:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as boolean.public;
    input r4 as u128.public;
    input r5 as u128.public;
    lte r0 500u128 into r6;
    assert.eq r6 true;
    lte r1 500u128 into r7;
    assert.eq r7 true;
    lte r2 500u128 into r8;
    assert.eq r8 true;
    lte r4 500u128 into r9;
    assert.eq r9 true;
    lte r5 500u128 into r10;
    assert.eq r10 true;
    async set_liquidity_fee_bps_config self.caller r0 r1 r2 r3 r4 r5 into r11;
    output r11 as config_perps_v2.aleo/set_liquidity_fee_bps_config.future;

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
    set r8 into liquidity_fee_bps_config[true];

function set_position_fee_bps_config:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u32.public;
    lte r0 500u128 into r3;
    assert.eq r3 true;
    lte r1 100000000u128 into r4;
    assert.eq r4 true;
    async set_position_fee_bps_config self.caller r0 r1 r2 into r5;
    output r5 as config_perps_v2.aleo/set_position_fee_bps_config.future;

finalize set_position_fee_bps_config:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u32.public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    cast r1 r2 r3 into r5 as PositionFeeBpsConfig;
    set r5 into position_fee_bps_config[true];

function set_aum_config:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u32.public;
    async set_aum_config self.caller r0 r1 r2 into r3;
    output r3 as config_perps_v2.aleo/set_aum_config.future;

finalize set_aum_config:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u32.public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    lte r3 34560u32 into r5;
    assert.eq r5 true;
    cast r1 r2 r3 into r6 as AumConfig;
    set r6 into aum_config[true];

function set_funding_rate_config:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u32.public;
    lte r0 10000u128 into r3;
    lt r1 10000u128 into r4;
    and r3 r4 into r5;
    assert.eq r5 true;
    gte r2 720u32 into r6;
    assert.eq r6 true;
    async set_funding_rate_config self.caller r0 r1 r2 into r7;
    output r7 as config_perps_v2.aleo/set_funding_rate_config.future;

finalize set_funding_rate_config:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u32.public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    cast r1 r2 r3 into r5 as FundingRateConfig;
    set r5 into funding_rate_config[true];

function set_min_execution_fee:
    input r0 as u128.public;
    async set_min_execution_fee self.caller r0 into r1;
    output r1 as config_perps_v2.aleo/set_min_execution_fee.future;

finalize set_min_execution_fee:
    input r0 as address.public;
    input r1 as u128.public;
    get is_governor[r0] into r2;
    assert.eq r2 true;
    set r1 into min_execution_fee[true];

function set_block_delay_config:
    input r0 as u32.public;
    input r1 as u32.public;
    input r2 as u32.public;
    async set_block_delay_config self.caller r0 r1 r2 into r3;
    output r3 as config_perps_v2.aleo/set_block_delay_config.future;

finalize set_block_delay_config:
    input r0 as address.public;
    input r1 as u32.public;
    input r2 as u32.public;
    input r3 as u32.public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    cast r1 r2 r3 into r5 as BlockDelayConfig;
    set r5 into block_delay_config[true];

function set_buffer_amounts:
    input r0 as field.public;
    input r1 as u128.public;
    async set_buffer_amounts self.caller r0 r1 into r2;
    output r2 as config_perps_v2.aleo/set_buffer_amounts.future;

finalize set_buffer_amounts:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into buffer_amounts[r1];

function set_liquidator:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_liquidator self.caller r0 r1 into r2;
    output r2 as config_perps_v2.aleo/set_liquidator.future;

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
    output r2 as config_perps_v2.aleo/set_position_keeper.future;

finalize set_position_keeper:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into is_position_keeper[r1];

function set_whitelist_token_ids:
    input r0 as [field; 5u32].public;
    async set_whitelist_token_ids self.caller r0 into r1;
    output r1 as config_perps_v2.aleo/set_whitelist_token_ids.future;

finalize set_whitelist_token_ids:
    input r0 as address.public;
    input r1 as [field; 5u32].public;
    get is_governor[r0] into r2;
    assert.eq r2 true;
    set r1 into whitelist_token_ids[true];

function set_is_whitelist_token:
    input r0 as field.public;
    input r1 as boolean.public;
    async set_is_whitelist_token self.caller r0 r1 into r2;
    output r2 as config_perps_v2.aleo/set_is_whitelist_token.future;

finalize set_is_whitelist_token:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as boolean.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into is_whitelist_token[r1];

function set_token_weight:
    input r0 as field.public;
    input r1 as u128.public;
    async set_token_weight self.caller r0 r1 into r2;
    output r2 as config_perps_v2.aleo/set_token_weight.future;

finalize set_token_weight:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    get is_whitelist_token[r1] into r4;
    assert.eq r4 true;
    get.or_use total_token_weights[true] 0u128 into r5;
    add r5 r2 into r6;
    get.or_use token_weights[r1] 0u128 into r7;
    sub r6 r7 into r8;
    set r8 into total_token_weights[true];
    set r2 into token_weights[r1];

function set_stable_token:
    input r0 as field.public;
    input r1 as boolean.public;
    async set_stable_token self.caller r0 r1 into r2;
    output r2 as config_perps_v2.aleo/set_stable_token.future;

finalize set_stable_token:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as boolean.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into stable_tokens[r1];

function set_min_profit_bps:
    input r0 as field.public;
    input r1 as u32.public;
    async set_min_profit_bps self.caller r0 r1 into r2;
    output r2 as config_perps_v2.aleo/set_min_profit_bps.future;

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
    output r2 as config_perps_v2.aleo/set_max_usda_amount.future;

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
    output r2 as config_perps_v2.aleo/set_max_global_short_size.future;

finalize set_max_global_short_size:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into max_global_short_sizes[r1];

function set_max_global_long_size:
    input r0 as field.public;
    input r1 as u128.public;
    async set_max_global_long_size self.caller r0 r1 into r2;
    output r2 as config_perps_v2.aleo/set_max_global_long_size.future;

finalize set_max_global_long_size:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get is_governor[r0] into r3;
    assert.eq r3 true;
    set r2 into max_global_long_sizes[r1];

function set_max_global_sizes:
    input r0 as [field; 5u32].public;
    input r1 as [u128; 5u32].public;
    input r2 as [u128; 5u32].public;
    async set_max_global_sizes self.caller r0 r1 r2 into r3;
    output r3 as config_perps_v2.aleo/set_max_global_sizes.future;

finalize set_max_global_sizes:
    input r0 as address.public;
    input r1 as [field; 5u32].public;
    input r2 as [u128; 5u32].public;
    input r3 as [u128; 5u32].public;
    get is_governor[r0] into r4;
    assert.eq r4 true;
    set r2[0u32] into max_global_long_sizes[r1[0u32]];
    set r3[0u32] into max_global_short_sizes[r1[0u32]];
    set r2[1u32] into max_global_long_sizes[r1[1u32]];
    set r3[1u32] into max_global_short_sizes[r1[1u32]];
    set r2[2u32] into max_global_long_sizes[r1[2u32]];
    set r3[2u32] into max_global_short_sizes[r1[2u32]];
    set r2[3u32] into max_global_long_sizes[r1[3u32]];
    set r3[3u32] into max_global_short_sizes[r1[3u32]];
    set r2[4u32] into max_global_long_sizes[r1[4u32]];
    set r3[4u32] into max_global_short_sizes[r1[4u32]];
