import official_oracle.aleo;

program perp_oracle_v0_2.aleo;

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

struct PriceInfo:
    is_stable as boolean;
    spread_basis_point as u128;
    max_price as u128;
    min_price as u128;
    latest_updated_height as u32;

struct Setting:
    amm_price_enabled as boolean;
    secondary_price_enabled as boolean;
    max_deviation_basis_point as u128;
    max_stable_price_deviation as u128;
    feeder as address;
    admin as address;

struct RequestHashes:
    request_hash_1 as u128;
    request_hash_2 as u128;

mapping price_infos:
    key as field.public;
    value as PriceInfo.public;

mapping settings:
    key as boolean.public;
    value as Setting.public;

mapping request_hashes:
    key as field.public;
    value as RequestHashes.public;

function init:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    input r3 as boolean.public;
    input r4 as u128.public;
    input r5 as u128.public;
    assert.eq self.caller aleo1qdtufktf3xj78qdxh9s9jerelrmjukt7rn5l04nx8nhr7k8spcpsyf9eye;
    async init r0 r1 r2 r3 r4 r5 into r6;
    output r6 as perp_oracle_v0_2.aleo/init.future;

finalize init:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    input r3 as boolean.public;
    input r4 as u128.public;
    input r5 as u128.public;
    contains settings[true] into r6;
    assert.eq r6 false;
    cast r2 r3 r4 r5 r0 r1 into r7 as Setting;
    set r7 into settings[true];

function register_token_info:
    input r0 as field.public;
    input r1 as boolean.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as u128.public;
    not r1 into r5;
    is.eq r2 0u128 into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    async register_token_info r0 r1 r2 r3 r4 self.caller into r8;
    output r8 as perp_oracle_v0_2.aleo/register_token_info.future;

finalize register_token_info:
    input r0 as field.public;
    input r1 as boolean.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as u128.public;
    input r5 as address.public;
    get settings[true] into r6;
    assert.eq r5 r6.admin;
    contains price_infos[r0] into r7;
    assert.eq r7 false;
    cast r1 r2 0u128 0u128 0u32 into r8 as PriceInfo;
    set r8 into price_infos[r0];
    cast r3 r4 into r9 as RequestHashes;
    set r9 into request_hashes[r0];

function deregister_token_info:
    input r0 as field.public;
    async deregister_token_info r0 self.caller into r1;
    output r1 as perp_oracle_v0_2.aleo/deregister_token_info.future;

finalize deregister_token_info:
    input r0 as field.public;
    input r1 as address.public;
    get settings[true] into r2;
    assert.eq r1 r2.admin;
    contains price_infos[r0] into r3;
    assert.eq r3 true;
    remove price_infos[r0];
    remove request_hashes[r0];

function set_settings:
    input r0 as boolean.public;
    input r1 as boolean.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as address.public;
    input r5 as address.public;
    async set_settings r0 r1 r2 r3 r4 r5 self.caller into r6;
    output r6 as perp_oracle_v0_2.aleo/set_settings.future;

finalize set_settings:
    input r0 as boolean.public;
    input r1 as boolean.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    get settings[true] into r7;
    assert.eq r6 r7.admin;
    cast r0 r1 r2 r3 r4 r5 into r8 as Setting;
    set r8 into settings[true];

function aggregate_non_stable_coin_price:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as ReportData.public;
    input r3 as Report.public;
    input r4 as signature.public;
    input r5 as address.public;
    input r6 as ReportData.public;
    input r7 as Report.public;
    input r8 as signature.public;
    input r9 as address.public;
    call official_oracle.aleo/set_data r2 r3 r4 r5 into r10;
    call official_oracle.aleo/set_data r6 r7 r8 r9 into r11;
    async aggregate_non_stable_coin_price r0 r1 self.caller r10 r11 into r12;
    output r12 as perp_oracle_v0_2.aleo/aggregate_non_stable_coin_price.future;

finalize aggregate_non_stable_coin_price:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as official_oracle.aleo/set_data.future;
    input r4 as official_oracle.aleo/set_data.future;
    await r3;
    await r4;
    get settings[true] into r5;
    get price_infos[r0] into r6;
    assert.eq false r6.is_stable;
    assert.eq r2 r5.feeder;
    get request_hashes[r0] into r7;
    assert.eq r3[0u32] r7.request_hash_1;
    assert.eq r4[0u32] r7.request_hash_2;
    add r3[1u32] r4[1u32] into r8;
    div r8 2u128 into r9;
    gt r9 r1 into r10;
    ternary r10 r9 r1 into r11;
    gt r9 r1 into r12;
    ternary r12 r1 r9 into r13;
    sub r11 r13 into r14;
    mul r14 10000u128 into r15;
    div r15 r9 into r16;
    lte r16 r5.max_deviation_basis_point into r17;
    ternary r17 r9 r11 into r18;
    ternary r17 r9 r13 into r19;
    ternary r5.secondary_price_enabled r18 r9 into r20;
    ternary r5.secondary_price_enabled r19 r9 into r21;
    add 10000u128 r6.spread_basis_point into r22;
    mul r22 r20 into r23;
    div r23 10000u128 into r24;
    sub 10000u128 r6.spread_basis_point into r25;
    mul r25 r21 into r26;
    div r26 10000u128 into r27;
    assert.neq r24 0u128;
    assert.neq r27 0u128;
    cast false r6.spread_basis_point r24 r27 block.height into r28 as PriceInfo;
    set r28 into price_infos[r0];

function aggregate_stable_coin_price:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as ReportData.public;
    input r3 as Report.public;
    input r4 as signature.public;
    input r5 as address.public;
    input r6 as ReportData.public;
    input r7 as Report.public;
    input r8 as signature.public;
    input r9 as address.public;
    call official_oracle.aleo/set_data r2 r3 r4 r5 into r10;
    call official_oracle.aleo/set_data r6 r7 r8 r9 into r11;
    async aggregate_stable_coin_price r0 r1 self.caller r10 r11 into r12;
    output r12 as perp_oracle_v0_2.aleo/aggregate_stable_coin_price.future;

finalize aggregate_stable_coin_price:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as official_oracle.aleo/set_data.future;
    input r4 as official_oracle.aleo/set_data.future;
    await r3;
    await r4;
    get settings[true] into r5;
    get price_infos[r0] into r6;
    assert.eq r6.is_stable true;
    assert.eq r2 r5.feeder;
    get request_hashes[r0] into r7;
    assert.eq r3[0u32] r7.request_hash_1;
    assert.eq r4[0u32] r7.request_hash_2;
    add r3[1u32] r4[1u32] into r8;
    div r8 2u128 into r9;
    gt r9 r1 into r10;
    ternary r10 r9 r1 into r11;
    gt r9 r1 into r12;
    ternary r12 r1 r9 into r13;
    sub r11 r13 into r14;
    mul r14 10000u128 into r15;
    div r15 r9 into r16;
    lte r16 r5.max_deviation_basis_point into r17;
    ternary r17 r9 r11 into r18;
    ternary r17 r9 r13 into r19;
    ternary r5.secondary_price_enabled r18 r9 into r20;
    ternary r5.secondary_price_enabled r19 r9 into r21;
    gt r20 1000000u128 into r22;
    sub.w r20 1000000u128 into r23;
    sub.w 1000000u128 r20 into r24;
    ternary r22 r23 r24 into r25;
    gt r25 r5.max_stable_price_deviation into r26;
    gt r20 1000000u128 into r27;
    and r26 r27 into r28;
    ternary r28 r20 1000000u128 into r29;
    gt r21 1000000u128 into r30;
    sub.w r21 1000000u128 into r31;
    sub.w 1000000u128 r21 into r32;
    ternary r30 r31 r32 into r33;
    gt r33 r5.max_stable_price_deviation into r34;
    lt r21 1000000u128 into r35;
    and r34 r35 into r36;
    ternary r36 r21 1000000u128 into r37;
    assert.neq r29 0u128;
    assert.neq r37 0u128;
    cast true r6.spread_basis_point r29 r37 block.height into r38 as PriceInfo;
    set r38 into price_infos[r0];
