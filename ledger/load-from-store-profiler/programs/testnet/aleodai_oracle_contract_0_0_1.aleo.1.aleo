program aleodai_oracle_contract_0_0_1.aleo;

struct OracleConfig:
    price_offset as u32;

struct PriceFeed:
    price as u32;
    max_price as u32;
    min_price as u32;
    block_height as u32;

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
    input r0 as u32.public;
    gt r0 0u32 into r1;
    assert.eq r1 true;
    assert.eq self.caller aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q;
    async add_price_feed r0 into r2;
    output r2 as aleodai_oracle_contract_0_0_1.aleo/add_price_feed.future;

finalize add_price_feed:
    input r0 as u32.public;
    get price_feed_id[1u8] into r1;
    add r1 1u128 into r2;
    set r2 into price_feed_id[1u8];
    get oracle_config[1u8] into r3;
    gt r3.price_offset 0u32 into r4;
    ternary r4 r3.price_offset 5u32 into r5;
    mul r0 r5 into r6;
    div r6 100u32 into r7;
    add r0 r7 into r8;
    sub r0 r7 into r9;
    cast r0 r8 r9 block.height into r10 as PriceFeed;
    set r10 into price_feed[r2];
    set r10 into price_feed_latest[1u8];

function update_saving_interes_rate:
    input r0 as u32.public;
    assert.eq self.caller aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q;
    gt r0 0u32 into r1;
    assert.eq r1 true;
    async update_saving_interes_rate r0 into r2;
    output r2 as aleodai_oracle_contract_0_0_1.aleo/update_saving_interes_rate.future;

finalize update_saving_interes_rate:
    input r0 as u32.public;
    get oracle_config[1u8] into r1;
    assert.neq r0 r1.price_offset;
    cast r0 into r2 as OracleConfig;
    set r2 into oracle_config[1u8];
