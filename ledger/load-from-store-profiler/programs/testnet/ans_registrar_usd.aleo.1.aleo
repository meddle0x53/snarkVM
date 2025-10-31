import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;
import ans_coupon_card_v3.aleo;
import credits.aleo;
import multi_token_support_programv1.aleo;
import mtsp_creditsv1.aleo;
import pondo_oraclev1.aleo;
import pondo_staked_aleo_tokenv1.aleo;
import pondo_tokenv1.aleo;
import pondo_delegator1v1.aleo;
import pondo_delegator2v1.aleo;
import pondo_delegator3v1.aleo;
import pondo_delegator4v1.aleo;
import pondo_delegator5v1.aleo;
import pondo_core_protocolv1.aleo;
import official_oracle_v2.aleo;

program ans_registrar_usd.aleo;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as field;

struct data:
    metadata as [field; 4u32];

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;

struct validator_state:
    validator as address;
    commission as u8;

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

struct TimestampedHash:
    request_hash as u128;
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

mapping general_settings:
    key as u8.public;
    value as u128.public;

function transfer_public:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.private;
    call aleo_name_service_registry_v4.aleo/transfer_public r0 r1 r2 into r3 r4;
    hash.bhp256 self.caller into r5 as u128;
    async transfer_public r5 r4 into r6;
    output r6 as ans_registrar_usd.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as u128.public;
    input r1 as aleo_name_service_registry_v4.aleo/transfer_public.future;
    await r1;
    get general_settings[0u8] into r2;
    assert.eq r0 r2;

function initialize_registrar:
    hash.bhp256 aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v into r0 as u128;
    async initialize_registrar r0 into r1;
    output r1 as ans_registrar_usd.aleo/initialize_registrar.future;

finalize initialize_registrar:
    input r0 as u128.public;
    get.or_use general_settings[0u8] 0u128 into r1;
    assert.eq r1 0u128;
    set r0 into general_settings[0u8];
    set 1u128 into general_settings[2u8];
    set 1u128 into general_settings[3u8];
    set 1000000u128 into general_settings[4u8];
    set 10000000u128 into general_settings[5u8];
    set 14400u128 into general_settings[6u8];

function update_setting:
    input r0 as u8.private;
    input r1 as u128.private;
    hash.bhp256 self.caller into r2 as u128;
    async update_setting r2 r0 r1 into r3;
    output r3 as ans_registrar_usd.aleo/update_setting.future;

finalize update_setting:
    input r0 as u128.public;
    input r1 as u8.public;
    input r2 as u128.public;
    get general_settings[0u8] into r3;
    assert.eq r0 r3;
    set r2 into general_settings[r1];

function change_admin:
    input r0 as address.private;
    hash.bhp256 self.caller into r1 as u128;
    hash.bhp256 r0 into r2 as u128;
    async change_admin r1 r2 into r3;
    output r3 as ans_registrar_usd.aleo/change_admin.future;

finalize change_admin:
    input r0 as u128.public;
    input r1 as u128.public;
    get general_settings[0u8] into r2;
    assert.eq r0 r2;
    set r1 into general_settings[0u8];

closure get_name_length:
    input r0 as [u128; 4u32];
    gt r0[0u32] 4294967295u128 into r1;
    gt r0[0u32] 16777215u128 into r2;
    gt r0[0u32] 65535u128 into r3;
    gt r0[0u32] 255u128 into r4;
    ternary r4 2u8 1u8 into r5;
    ternary r3 3u8 r5 into r6;
    ternary r2 4u8 r6 into r7;
    ternary r1 5u8 r7 into r8;
    output r8 as u8;

function register_free:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v3.aleo/CouponCard.record;
    assert.eq r3.discount_percent 0u8;
    is.eq r3.tld r1 into r4;
    is.eq r3.tld 0field into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    call get_name_length r0 into r7;
    gte r7 r3.limit_name_length into r8;
    assert.eq r8 true;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r9 r10;
    call ans_coupon_card_v3.aleo/use r3 into r11;
    async register_free r10 into r12;
    output r12 as ans_registrar_usd.aleo/register_free.future;

finalize register_free:
    input r0 as aleo_name_service_registry_v4.aleo/register.future;
    await r0;
    get general_settings[3u8] into r1;
    assert.eq r1 1u128;

closure calc_price:
    input r0 as u8;
    input r1 as u64;
    is.eq r0 5u8 into r2;
    div 4000000000000u64 r1 into r3;
    is.eq r0 4u8 into r4;
    div 40000000000000u64 r1 into r5;
    is.eq r0 3u8 into r6;
    div 160000000000000u64 r1 into r7;
    is.eq r0 2u8 into r8;
    div 640000000000000u64 r1 into r9;
    div 9999000000000000u64 r1 into r10;
    ternary r8 r9 r10 into r11;
    ternary r6 r7 r11 into r12;
    ternary r4 r5 r12 into r13;
    ternary r2 r3 r13 into r14;
    output r14 as u64;

function register_fld:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as boolean.private;
    input r5 as u128.private;
    input r6 as u64.private;
    call get_name_length r0 into r7;
    call calc_price r7 r6 into r8;
    call credits.aleo/transfer_private_to_public r3 ans_registrar_usd.aleo r8 into r9 r10;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r11 r12;
    cast 325436984254736568690754472542545613141u128 r5 into r13 as TimestampedHash;
    hash.psd8 r13 into r14 as u128;
    cast r6 into r15 as u128;
    async register_fld r10 r12 r4 r14 r15 into r16;
    output r16 as ans_registrar_usd.aleo/register_fld.future;

finalize register_fld:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    input r2 as boolean.public;
    input r3 as u128.public;
    input r4 as u128.public;
    await r0;
    await r1;
    get general_settings[2u8] into r5;
    assert.eq r5 1u128;
    get official_oracle_v2.aleo/sgx_attested_data[325436984254736568690754472542545613141u128] into r6;
    get official_oracle_v2.aleo/nitro_attested_data[325436984254736568690754472542545613141u128] into r7;
    gte r6.attestation_timestamp r7.attestation_timestamp into r8;
    ternary r8 r6.data r7.data into r9;
    ternary r8 r6.attestation_timestamp r7.attestation_timestamp into r10;
    cast r9 r10 into r11 as AttestedData;
    get.or_use official_oracle_v2.aleo/sgx_attested_data[r3] r11 into r12;
    get.or_use official_oracle_v2.aleo/nitro_attested_data[r3] r11 into r13;
    ternary r2 r12.data r13.data into r14;
    ternary r2 r12.attestation_timestamp r13.attestation_timestamp into r15;
    cast r14 r15 into r16 as AttestedData;
    assert.eq r16.data r4;
    sub r11.attestation_timestamp r16.attestation_timestamp into r17;
    get general_settings[6u8] into r18;
    lte r17 r18 into r19;
    assert.eq r19 true;

function register_fld_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as boolean.private;
    input r4 as u128.private;
    input r5 as u64.private;
    call get_name_length r0 into r6;
    call calc_price r6 r5 into r7;
    call credits.aleo/transfer_public_as_signer ans_registrar_usd.aleo r7 into r8;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r9 r10;
    cast 325436984254736568690754472542545613141u128 r4 into r11 as TimestampedHash;
    hash.psd8 r11 into r12 as u128;
    cast r5 into r13 as u128;
    async register_fld_public r8 r10 r3 r12 r13 into r14;
    output r14 as ans_registrar_usd.aleo/register_fld_public.future;

finalize register_fld_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    input r2 as boolean.public;
    input r3 as u128.public;
    input r4 as u128.public;
    await r0;
    await r1;
    get general_settings[2u8] into r5;
    assert.eq r5 1u128;
    get official_oracle_v2.aleo/sgx_attested_data[325436984254736568690754472542545613141u128] into r6;
    get official_oracle_v2.aleo/nitro_attested_data[325436984254736568690754472542545613141u128] into r7;
    gte r6.attestation_timestamp r7.attestation_timestamp into r8;
    ternary r8 r6.data r7.data into r9;
    ternary r8 r6.attestation_timestamp r7.attestation_timestamp into r10;
    cast r9 r10 into r11 as AttestedData;
    get.or_use official_oracle_v2.aleo/sgx_attested_data[r3] r11 into r12;
    get.or_use official_oracle_v2.aleo/nitro_attested_data[r3] r11 into r13;
    ternary r2 r12.data r13.data into r14;
    ternary r2 r12.attestation_timestamp r13.attestation_timestamp into r15;
    cast r14 r15 into r16 as AttestedData;
    assert.eq r16.data r4;
    sub r11.attestation_timestamp r16.attestation_timestamp into r17;
    get general_settings[6u8] into r18;
    lte r17 r18 into r19;
    assert.eq r19 true;

function register_fld_with_coupon:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r5 as boolean.private;
    input r6 as u128.private;
    input r7 as u64.private;
    is.eq r4.tld r1 into r8;
    is.eq r4.tld 0field into r9;
    or r8 r9 into r10;
    assert.eq r10 true;
    call get_name_length r0 into r11;
    gte r11 r4.limit_name_length into r12;
    assert.eq r12 true;
    call calc_price r11 r7 into r13;
    cast r4.discount_percent into r14 as u64;
    mul r13 r14 into r15;
    div r15 100u64 into r16;
    call credits.aleo/transfer_private_to_public r3 ans_registrar_usd.aleo r16 into r17 r18;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r19 r20;
    call ans_coupon_card_v3.aleo/use r4 into r21;
    cast 325436984254736568690754472542545613141u128 r6 into r22 as TimestampedHash;
    hash.psd8 r22 into r23 as u128;
    cast r7 into r24 as u128;
    async register_fld_with_coupon r18 r20 r5 r23 r24 into r25;
    output r25 as ans_registrar_usd.aleo/register_fld_with_coupon.future;

finalize register_fld_with_coupon:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    input r2 as boolean.public;
    input r3 as u128.public;
    input r4 as u128.public;
    await r0;
    await r1;
    get general_settings[3u8] into r5;
    assert.eq r5 1u128;
    get official_oracle_v2.aleo/sgx_attested_data[325436984254736568690754472542545613141u128] into r6;
    get official_oracle_v2.aleo/nitro_attested_data[325436984254736568690754472542545613141u128] into r7;
    gte r6.attestation_timestamp r7.attestation_timestamp into r8;
    ternary r8 r6.data r7.data into r9;
    ternary r8 r6.attestation_timestamp r7.attestation_timestamp into r10;
    cast r9 r10 into r11 as AttestedData;
    get.or_use official_oracle_v2.aleo/sgx_attested_data[r3] r11 into r12;
    get.or_use official_oracle_v2.aleo/nitro_attested_data[r3] r11 into r13;
    ternary r2 r12.data r13.data into r14;
    ternary r2 r12.attestation_timestamp r13.attestation_timestamp into r15;
    cast r14 r15 into r16 as AttestedData;
    assert.eq r16.data r4;
    sub r11.attestation_timestamp r16.attestation_timestamp into r17;
    get general_settings[6u8] into r18;
    lte r17 r18 into r19;
    assert.eq r19 true;

function register_fld_with_coupon_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r4 as boolean.private;
    input r5 as u128.private;
    input r6 as u64.private;
    is.eq r3.tld r1 into r7;
    is.eq r3.tld 0field into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    call get_name_length r0 into r10;
    gte r10 r3.limit_name_length into r11;
    assert.eq r11 true;
    call calc_price r10 r6 into r12;
    cast r3.discount_percent into r13 as u64;
    mul r12 r13 into r14;
    div r14 100u64 into r15;
    call credits.aleo/transfer_public_as_signer ans_registrar_usd.aleo r15 into r16;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r17 r18;
    call ans_coupon_card_v3.aleo/use r3 into r19;
    cast 325436984254736568690754472542545613141u128 r5 into r20 as TimestampedHash;
    hash.psd8 r20 into r21 as u128;
    cast r6 into r22 as u128;
    async register_fld_with_coupon_public r16 r18 r4 r21 r22 into r23;
    output r23 as ans_registrar_usd.aleo/register_fld_with_coupon_public.future;

finalize register_fld_with_coupon_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    input r2 as boolean.public;
    input r3 as u128.public;
    input r4 as u128.public;
    await r0;
    await r1;
    get general_settings[3u8] into r5;
    assert.eq r5 1u128;
    get official_oracle_v2.aleo/sgx_attested_data[325436984254736568690754472542545613141u128] into r6;
    get official_oracle_v2.aleo/nitro_attested_data[325436984254736568690754472542545613141u128] into r7;
    gte r6.attestation_timestamp r7.attestation_timestamp into r8;
    ternary r8 r6.data r7.data into r9;
    ternary r8 r6.attestation_timestamp r7.attestation_timestamp into r10;
    cast r9 r10 into r11 as AttestedData;
    get.or_use official_oracle_v2.aleo/sgx_attested_data[r3] r11 into r12;
    get.or_use official_oracle_v2.aleo/nitro_attested_data[r3] r11 into r13;
    ternary r2 r12.data r13.data into r14;
    ternary r2 r12.attestation_timestamp r13.attestation_timestamp into r15;
    cast r14 r15 into r16 as AttestedData;
    assert.eq r16.data r4;
    sub r11.attestation_timestamp r16.attestation_timestamp into r17;
    get general_settings[6u8] into r18;
    lte r17 r18 into r19;
    assert.eq r19 true;

function stake:
    input r0 as u64.private;
    input r1 as u64.private;
    call credits.aleo/transfer_public self.signer r0 into r2;
    call pondo_core_protocolv1.aleo/deposit_public_as_signer r0 r1 ans_registrar_usd.aleo into r3;
    cast r1 into r4 as u128;
    call multi_token_support_programv1.aleo/transfer_public_as_signer 1751493913335802797273486270793650302076377624243810059080883537084141842600field ans_registrar_usd.aleo r4 into r5;
    async stake r2 r3 r5 r0 r1 into r6;
    output r6 as ans_registrar_usd.aleo/stake.future;

finalize stake:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as pondo_core_protocolv1.aleo/deposit_public_as_signer.future;
    input r2 as multi_token_support_programv1.aleo/transfer_public_as_signer.future;
    input r3 as u64.public;
    input r4 as u64.public;
    await r0;
    await r1;
    await r2;
    get general_settings[5u8] into r5;
    cast r4 into r6 as u128;
    gte r6 r5 into r7;
    assert.eq r7 true;
    get.or_use credits.aleo/account[pondo_core_protocolv1.aleo] 0u64 into r8;
    get pondo_core_protocolv1.aleo/balances[2u8] into r9;
    sub r8 r3 into r10;
    sub r10 r9 into r11;
    get pondo_core_protocolv1.aleo/balances[0u8] into r12;
    get pondo_core_protocolv1.aleo/owed_commission[0u8] into r13;
    get multi_token_support_programv1.aleo/registered_tokens[1751493913335802797273486270793650302076377624243810059080883537084141842600field] into r14;
    cast r14.supply into r15 as u64;
    add r15 r13 into r16;
    sub r16 r4 into r17;
    add r12 r11 into r18;
    cast r17 into r19 as u128;
    cast r3 into r20 as u128;
    mul r19 r20 into r21;
    cast r18 into r22 as u128;
    div r21 r22 into r23;
    get general_settings[4u8] into r24;
    sub r23 r6 into r25;
    lt r25 r24 into r26;
    assert.eq r26 true;

function withdraw:
    input r0 as address.private;
    input r1 as u64.private;
    hash.bhp256 self.caller into r2 as u128;
    cast r1 into r3 as u128;
    call multi_token_support_programv1.aleo/transfer_public 1751493913335802797273486270793650302076377624243810059080883537084141842600field r0 r3 into r4;
    async withdraw r4 r2 into r5;
    output r5 as ans_registrar_usd.aleo/withdraw.future;

finalize withdraw:
    input r0 as multi_token_support_programv1.aleo/transfer_public.future;
    input r1 as u128.public;
    await r0;
    get general_settings[0u8] into r2;
    assert.eq r1 r2;
