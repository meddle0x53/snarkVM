import official_oracle_v2.aleo;

program perp_oracle_v0_3.aleo;

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
    output r6 as perp_oracle_v0_3.aleo/init.future;

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
    output r8 as perp_oracle_v0_3.aleo/register_token_info.future;

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
    output r1 as perp_oracle_v0_3.aleo/deregister_token_info.future;

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
    output r6 as perp_oracle_v0_3.aleo/set_settings.future;

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
    call official_oracle_v2.aleo/set_data_sgx r2 r3 r4 r5 into r10;
    call official_oracle_v2.aleo/set_data_sgx r6 r7 r8 r9 into r11;
    async aggregate_non_stable_coin_price r0 r1 self.caller r10 r11 into r12;
    output r12 as perp_oracle_v0_3.aleo/aggregate_non_stable_coin_price.future;

finalize aggregate_non_stable_coin_price:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as official_oracle_v2.aleo/set_data_sgx.future;
    input r4 as official_oracle_v2.aleo/set_data_sgx.future;
    await r3;
    await r4;
    get settings[true] into r5;
    get price_infos[r0] into r6;
    assert.eq false r6.is_stable;
    assert.eq r2 r5.feeder;
    get request_hashes[r0] into r7;
    assert.eq r3[0u32] r7.request_hash_1;
    assert.eq r4[0u32] r7.request_hash_2;
    get official_oracle_v2.aleo/sgx_attested_data[r3[0u32]] into r8;
    get official_oracle_v2.aleo/sgx_attested_data[r4[0u32]] into r9;
    add r8.data r9.data into r10;
    div r10 2u128 into r11;
    gt r11 r1 into r12;
    ternary r12 r11 r1 into r13;
    gt r11 r1 into r14;
    ternary r14 r1 r11 into r15;
    sub r13 r15 into r16;
    mul r16 10000u128 into r17;
    div r17 r11 into r18;
    lte r18 r5.max_deviation_basis_point into r19;
    ternary r19 r11 r13 into r20;
    ternary r19 r11 r15 into r21;
    ternary r5.secondary_price_enabled r20 r11 into r22;
    ternary r5.secondary_price_enabled r21 r11 into r23;
    add 10000u128 r6.spread_basis_point into r24;
    mul r24 r22 into r25;
    div r25 10000u128 into r26;
    sub 10000u128 r6.spread_basis_point into r27;
    mul r27 r23 into r28;
    div r28 10000u128 into r29;
    assert.neq r26 0u128;
    assert.neq r29 0u128;
    cast false r6.spread_basis_point r26 r29 block.height into r30 as PriceInfo;
    set r30 into price_infos[r0];

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
    call official_oracle_v2.aleo/set_data_sgx r2 r3 r4 r5 into r10;
    call official_oracle_v2.aleo/set_data_sgx r6 r7 r8 r9 into r11;
    async aggregate_stable_coin_price r0 r1 self.caller r10 r11 into r12;
    output r12 as perp_oracle_v0_3.aleo/aggregate_stable_coin_price.future;

finalize aggregate_stable_coin_price:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as official_oracle_v2.aleo/set_data_sgx.future;
    input r4 as official_oracle_v2.aleo/set_data_sgx.future;
    await r3;
    await r4;
    get settings[true] into r5;
    get price_infos[r0] into r6;
    assert.eq r6.is_stable true;
    assert.eq r2 r5.feeder;
    get request_hashes[r0] into r7;
    assert.eq r3[0u32] r7.request_hash_1;
    assert.eq r4[0u32] r7.request_hash_2;
    get official_oracle_v2.aleo/sgx_attested_data[r3[0u32]] into r8;
    get official_oracle_v2.aleo/sgx_attested_data[r4[0u32]] into r9;
    add r8.data r9.data into r10;
    div r10 2u128 into r11;
    gt r11 r1 into r12;
    ternary r12 r11 r1 into r13;
    gt r11 r1 into r14;
    ternary r14 r1 r11 into r15;
    sub r13 r15 into r16;
    mul r16 10000u128 into r17;
    div r17 r11 into r18;
    lte r18 r5.max_deviation_basis_point into r19;
    ternary r19 r11 r13 into r20;
    ternary r19 r11 r15 into r21;
    ternary r5.secondary_price_enabled r20 r11 into r22;
    ternary r5.secondary_price_enabled r21 r11 into r23;
    gt r22 1000000u128 into r24;
    sub.w r22 1000000u128 into r25;
    sub.w 1000000u128 r22 into r26;
    ternary r24 r25 r26 into r27;
    gt r27 r5.max_stable_price_deviation into r28;
    gt r22 1000000u128 into r29;
    and r28 r29 into r30;
    ternary r30 r22 1000000u128 into r31;
    gt r23 1000000u128 into r32;
    sub.w r23 1000000u128 into r33;
    sub.w 1000000u128 r23 into r34;
    ternary r32 r33 r34 into r35;
    gt r35 r5.max_stable_price_deviation into r36;
    lt r23 1000000u128 into r37;
    and r36 r37 into r38;
    ternary r38 r23 1000000u128 into r39;
    assert.neq r31 0u128;
    assert.neq r39 0u128;
    cast true r6.spread_basis_point r31 r39 block.height into r40 as PriceInfo;
    set r40 into price_infos[r0];
