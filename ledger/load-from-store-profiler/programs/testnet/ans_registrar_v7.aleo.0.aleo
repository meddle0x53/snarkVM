import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;
import ans_coupon_card_v3.aleo;
import messenger.aleo;
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

program ans_registrar_v7.aleo;

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
    output r6 as ans_registrar_v7.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as u128.public;
    input r1 as aleo_name_service_registry_v4.aleo/transfer_public.future;
    await r1;
    get general_settings[0u8] into r2;
    assert.eq r0 r2;

function initialize_registrar:
    hash.bhp256 aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v into r0 as u128;
    async initialize_registrar r0 into r1;
    output r1 as ans_registrar_v7.aleo/initialize_registrar.future;

finalize initialize_registrar:
    input r0 as u128.public;
    get.or_use general_settings[0u8] 0u128 into r1;
    assert.eq r1 0u128;
    set r0 into general_settings[0u8];
    set 0u128 into general_settings[2u8];
    set 1u128 into general_settings[3u8];
    set 1000000u128 into general_settings[4u8];
    set 10000000u128 into general_settings[5u8];

function update_setting:
    input r0 as u8.private;
    input r1 as u128.private;
    hash.bhp256 self.caller into r2 as u128;
    async update_setting r2 r0 r1 into r3;
    output r3 as ans_registrar_v7.aleo/update_setting.future;

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
    output r3 as ans_registrar_v7.aleo/change_admin.future;

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
    input r4 as [field; 8u32].private;
    assert.eq r3.discount_percent 0u8;
    is.eq r3.tld r1 into r5;
    is.eq r3.tld 0field into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    call get_name_length r0 into r8;
    gte r8 r3.limit_name_length into r9;
    assert.eq r9 true;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r10 r11;
    call ans_coupon_card_v3.aleo/use r3 into r12;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r4 into r13;
    async register_free r11 into r14;
    output r14 as ans_registrar_v7.aleo/register_free.future;

finalize register_free:
    input r0 as aleo_name_service_registry_v4.aleo/register.future;
    await r0;
    get general_settings[3u8] into r1;
    assert.eq r1 1u128;

closure calc_price:
    input r0 as u8;
    is.eq r0 5u8 into r1;
    is.eq r0 4u8 into r2;
    is.eq r0 3u8 into r3;
    is.eq r0 2u8 into r4;
    ternary r4 250000000u64 9999000000u64 into r5;
    ternary r3 50000000u64 r5 into r6;
    ternary r2 10000000u64 r6 into r7;
    ternary r1 2000000u64 r7 into r8;
    output r8 as u64;

function register_fld:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as [field; 8u32].private;
    call get_name_length r0 into r5;
    call calc_price r5 into r6;
    call credits.aleo/transfer_private_to_public r3 ans_registrar_v6.aleo r6 into r7 r8;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r9 r10;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r4 into r11;
    async register_fld r8 r10 into r12;
    output r12 as ans_registrar_v7.aleo/register_fld.future;

finalize register_fld:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    await r0;
    await r1;
    get general_settings[2u8] into r2;
    assert.eq r2 1u128;

function register_fld_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as [field; 8u32].private;
    call get_name_length r0 into r4;
    call calc_price r4 into r5;
    call credits.aleo/transfer_public_as_signer ans_registrar_v6.aleo r5 into r6;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r7 r8;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r3 into r9;
    async register_fld_public r6 r8 into r10;
    output r10 as ans_registrar_v7.aleo/register_fld_public.future;

finalize register_fld_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    await r0;
    await r1;
    get general_settings[2u8] into r2;
    assert.eq r2 1u128;

function register_fld_with_coupon:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r5 as [field; 8u32].private;
    is.eq r4.tld r1 into r6;
    is.eq r4.tld 0field into r7;
    or r6 r7 into r8;
    assert.eq r8 true;
    call get_name_length r0 into r9;
    gte r9 r4.limit_name_length into r10;
    assert.eq r10 true;
    call calc_price r9 into r11;
    cast r4.discount_percent into r12 as u64;
    mul r11 r12 into r13;
    div r13 100u64 into r14;
    call credits.aleo/transfer_private_to_public r3 ans_registrar_v6.aleo r14 into r15 r16;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r17 r18;
    call ans_coupon_card_v3.aleo/use r4 into r19;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r5 into r20;
    async register_fld_with_coupon r16 r18 into r21;
    output r21 as ans_registrar_v7.aleo/register_fld_with_coupon.future;

finalize register_fld_with_coupon:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    await r0;
    await r1;
    get general_settings[3u8] into r2;
    assert.eq r2 1u128;

function register_fld_with_coupon_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r4 as [field; 8u32].private;
    is.eq r3.tld r1 into r5;
    is.eq r3.tld 0field into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    call get_name_length r0 into r8;
    gte r8 r3.limit_name_length into r9;
    assert.eq r9 true;
    call calc_price r8 into r10;
    cast r3.discount_percent into r11 as u64;
    mul r10 r11 into r12;
    div r12 100u64 into r13;
    call credits.aleo/transfer_public_as_signer ans_registrar_v6.aleo r13 into r14;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r15 r16;
    call ans_coupon_card_v3.aleo/use r3 into r17;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r4 into r18;
    async register_fld_with_coupon_public r14 r16 into r19;
    output r19 as ans_registrar_v7.aleo/register_fld_with_coupon_public.future;

finalize register_fld_with_coupon_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    await r0;
    await r1;
    get general_settings[3u8] into r2;
    assert.eq r2 1u128;
