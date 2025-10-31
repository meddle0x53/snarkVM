program dai_oracle_contract_0_0_1.aleo;

struct OracleConfig:
    price_offset as u64;

struct PriceFeed:
    price as u64;
    max_price as u64;
    min_price as u64;
    block_height as u64;

mapping oracle_config:
    key as u8.public;
    value as OracleConfig.public;

mapping price_feed_id:
    key as u8.public;
    value as u128.public;

mapping price_feed:
    key as u128.public;
    value as PriceFeed.public;

mapping price_feed_latest:
    key as u8.public;
    value as PriceFeed.public;

function add_price_feed:
    input r0 as u64.public;
    gt r0 0u64 into r1;
    assert.eq r1 true;
    assert.eq self.caller aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q;
    async add_price_feed r0 into r2;
    output r2 as dai_oracle_contract_0_0_1.aleo/add_price_feed.future;

finalize add_price_feed:
    input r0 as u64.public;
    get.or_use price_feed_id[1u8] 0u128 into r1;
    add r1 1u128 into r2;
    set r2 into price_feed_id[1u8];
    get oracle_config[1u8] into r3;
    mul r0 r3.price_offset into r4;
    div.w r4 100u64 into r5;
    add r0 r5 into r6;
    sub r0 r5 into r7;
    cast block.height into r8 as u64;
    cast r0 r6 r7 r8 into r9 as PriceFeed;
    set r9 into price_feed[r2];
    set r9 into price_feed_latest[1u8];

function update_saving_interes_rate:
    input r0 as u64.public;
    assert.eq self.caller aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q;
    gt r0 0u64 into r1;
    assert.eq r1 true;
    async update_saving_interes_rate r0 into r2;
    output r2 as dai_oracle_contract_0_0_1.aleo/update_saving_interes_rate.future;

finalize update_saving_interes_rate:
    input r0 as u64.public;
    cast 5u64 into r1 as OracleConfig;
    get.or_use oracle_config[1u8] r1 into r2;
    cast r0 into r3 as OracleConfig;
    set r3 into oracle_config[1u8];
