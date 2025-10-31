import messenger.aleo;
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
import ans_registrar_usd_v2.aleo;

program ans_registrar_quest_1.aleo;

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

function register_free:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r4 as [field; 8u32].private;
    call ans_registrar_usd_v2.aleo/register_free r0 r1 r2 r3 into r5;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r4 into r6;
    async register_free r5 into r7;
    output r7 as ans_registrar_quest_1.aleo/register_free.future;

finalize register_free:
    input r0 as ans_registrar_usd_v2.aleo/register_free.future;
    await r0;

function register_fld:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as boolean.private;
    input r5 as u128.private;
    input r6 as u64.private;
    input r7 as [field; 8u32].private;
    call ans_registrar_usd_v2.aleo/register_fld r0 r1 r2 r3 r4 r5 r6 into r8;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r7 into r9;
    async register_fld r8 into r10;
    output r10 as ans_registrar_quest_1.aleo/register_fld.future;

finalize register_fld:
    input r0 as ans_registrar_usd_v2.aleo/register_fld.future;
    await r0;

function register_fld_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as boolean.private;
    input r4 as u128.private;
    input r5 as u64.private;
    input r6 as [field; 8u32].private;
    call ans_registrar_usd_v2.aleo/register_fld_public r0 r1 r2 r3 r4 r5 into r7;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r6 into r8;
    async register_fld_public r7 into r9;
    output r9 as ans_registrar_quest_1.aleo/register_fld_public.future;

finalize register_fld_public:
    input r0 as ans_registrar_usd_v2.aleo/register_fld_public.future;
    await r0;

function register_fld_with_coupon:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r5 as boolean.private;
    input r6 as u128.private;
    input r7 as u64.private;
    input r8 as [field; 8u32].private;
    call ans_registrar_usd_v2.aleo/register_fld_with_coupon r0 r1 r2 r3 r4 r5 r6 r7 into r9;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r8 into r10;
    async register_fld_with_coupon r9 into r11;
    output r11 as ans_registrar_quest_1.aleo/register_fld_with_coupon.future;

finalize register_fld_with_coupon:
    input r0 as ans_registrar_usd_v2.aleo/register_fld_with_coupon.future;
    await r0;

function register_fld_with_coupon_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r4 as boolean.private;
    input r5 as u128.private;
    input r6 as u64.private;
    input r7 as [field; 8u32].private;
    call ans_registrar_usd_v2.aleo/register_fld_with_coupon_public r0 r1 r2 r3 r4 r5 r6 into r8;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r7 into r9;
    async register_fld_with_coupon_public r8 into r10;
    output r10 as ans_registrar_quest_1.aleo/register_fld_with_coupon_public.future;

finalize register_fld_with_coupon_public:
    input r0 as ans_registrar_usd_v2.aleo/register_fld_with_coupon_public.future;
    await r0;
