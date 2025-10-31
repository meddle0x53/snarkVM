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

program ans_registrar_usd2.aleo;

struct data:
    metadata as [field; 4u32];

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as field;

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

struct UnitPriceData:
    price as u64;
    timestamp as u64;

mapping general_settings:
    key as u8.public;
    value as u128.public;

mapping price_data:
    key as u64.public;
    value as UnitPriceData.public;

function transfer_public:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.private;
    call aleo_name_service_registry_v4.aleo/transfer_public r0 r1 r2 into r3 r4;
    hash.bhp256 self.caller into r5 as u128;
    async transfer_public r5 r4 into r6;
    output r6 as ans_registrar_usd2.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as u128.public;
    input r1 as aleo_name_service_registry_v4.aleo/transfer_public.future;
    await r1;
    get general_settings[0u8] into r2;
    assert.eq r0 r2;

function initialize_registrar:
    async initialize_registrar 129967232274961287173788227149222870785u128 into r0;
    output r0 as ans_registrar_usd2.aleo/initialize_registrar.future;

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
    output r3 as ans_registrar_usd2.aleo/update_setting.future;

finalize update_setting:
    input r0 as u128.public;
    input r1 as u8.public;
    input r2 as u128.public;
    get general_settings[0u8] into r3;
    assert.eq r0 r3;
    set r2 into general_settings[r1];

function set_unit_price:
    input r0 as u64.public;
    input r1 as u64.public;
    hash.bhp256 self.caller into r2 as u128;
    cast r0 r1 into r3 as UnitPriceData;
    async set_unit_price r2 r3 into r4;
    output r4 as ans_registrar_usd2.aleo/set_unit_price.future;

finalize set_unit_price:
    input r0 as u128.public;
    input r1 as UnitPriceData.public;
    get general_settings[0u8] into r2;
    assert.eq r0 r2;
    set r1 into price_data[0u64];
    set r1 into price_data[r1.timestamp];

function change_admin:
    input r0 as address.private;
    hash.bhp256 self.caller into r1 as u128;
    hash.bhp256 r0 into r2 as u128;
    async change_admin r1 r2 into r3;
    output r3 as ans_registrar_usd2.aleo/change_admin.future;

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
    output r12 as ans_registrar_usd2.aleo/register_free.future;

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
    input r4 as u64.private;
    input r5 as u64.private;
    call get_name_length r0 into r6;
    call calc_price r6 r5 into r7;
    call credits.aleo/transfer_private_to_public r3 ans_registrar_usd2.aleo r7 into r8 r9;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r10 r11;
    async register_fld r9 r11 r4 r5 into r12;
    output r12 as ans_registrar_usd2.aleo/register_fld.future;

finalize register_fld:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    input r2 as u64.public;
    input r3 as u64.public;
    await r0;
    await r1;
    get general_settings[2u8] into r4;
    assert.eq r4 1u128;
    get price_data[0u64] into r5;
    get.or_use price_data[r2] r5 into r6;
    assert.eq r6.price r3;
    sub r5.timestamp r6.timestamp into r7;
    get general_settings[6u8] into r8;
    cast r8 into r9 as u64;
    lte r7 r9 into r10;
    assert.eq r10 true;

function register_fld_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as u64.private;
    input r4 as u64.private;
    call get_name_length r0 into r5;
    call calc_price r5 r4 into r6;
    call credits.aleo/transfer_public_as_signer ans_registrar_usd2.aleo r6 into r7;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r8 r9;
    async register_fld_public r7 r9 r3 r4 into r10;
    output r10 as ans_registrar_usd2.aleo/register_fld_public.future;

finalize register_fld_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    input r2 as u64.public;
    input r3 as u64.public;
    await r0;
    await r1;
    get general_settings[2u8] into r4;
    assert.eq r4 1u128;
    get price_data[0u64] into r5;
    get.or_use price_data[r2] r5 into r6;
    assert.eq r6.price r3;
    sub r5.timestamp r6.timestamp into r7;
    get general_settings[6u8] into r8;
    cast r8 into r9 as u64;
    lte r7 r9 into r10;
    assert.eq r10 true;

function register_fld_with_coupon:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r5 as u64.private;
    input r6 as u64.private;
    is.eq r4.tld r1 into r7;
    is.eq r4.tld 0field into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    call get_name_length r0 into r10;
    gte r10 r4.limit_name_length into r11;
    assert.eq r11 true;
    call calc_price r10 r6 into r12;
    cast r4.discount_percent into r13 as u64;
    mul r12 r13 into r14;
    div r14 100u64 into r15;
    call credits.aleo/transfer_private_to_public r3 ans_registrar_usd2.aleo r15 into r16 r17;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r18 r19;
    call ans_coupon_card_v3.aleo/use r4 into r20;
    async register_fld_with_coupon r17 r19 r5 r6 into r21;
    output r21 as ans_registrar_usd2.aleo/register_fld_with_coupon.future;

finalize register_fld_with_coupon:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    input r2 as u64.public;
    input r3 as u64.public;
    await r0;
    await r1;
    get general_settings[3u8] into r4;
    assert.eq r4 1u128;
    get price_data[0u64] into r5;
    get.or_use price_data[r2] r5 into r6;
    assert.eq r6.price r3;
    sub r5.timestamp r6.timestamp into r7;
    get general_settings[6u8] into r8;
    cast r8 into r9 as u64;
    lte r7 r9 into r10;
    assert.eq r10 true;

function register_fld_with_coupon_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r4 as u64.private;
    input r5 as u64.private;
    is.eq r3.tld r1 into r6;
    is.eq r3.tld 0field into r7;
    or r6 r7 into r8;
    assert.eq r8 true;
    call get_name_length r0 into r9;
    gte r9 r3.limit_name_length into r10;
    assert.eq r10 true;
    call calc_price r9 r5 into r11;
    cast r3.discount_percent into r12 as u64;
    mul r11 r12 into r13;
    div r13 100u64 into r14;
    call credits.aleo/transfer_public_as_signer ans_registrar_usd2.aleo r14 into r15;
    call aleo_name_service_registry_v4.aleo/register r0 r1 r2 0field into r16 r17;
    call ans_coupon_card_v3.aleo/use r3 into r18;
    async register_fld_with_coupon_public r15 r17 r4 r5 into r19;
    output r19 as ans_registrar_usd2.aleo/register_fld_with_coupon_public.future;

finalize register_fld_with_coupon_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as aleo_name_service_registry_v4.aleo/register.future;
    input r2 as u64.public;
    input r3 as u64.public;
    await r0;
    await r1;
    get general_settings[3u8] into r4;
    assert.eq r4 1u128;
    get price_data[0u64] into r5;
    get.or_use price_data[r2] r5 into r6;
    assert.eq r6.price r3;
    sub r5.timestamp r6.timestamp into r7;
    get general_settings[6u8] into r8;
    cast r8 into r9 as u64;
    lte r7 r9 into r10;
    assert.eq r10 true;

function stake:
    input r0 as u64.private;
    input r1 as u64.private;
    call credits.aleo/transfer_public self.signer r0 into r2;
    call pondo_core_protocolv1.aleo/deposit_public_as_signer r0 r1 ans_registrar_usd2.aleo into r3;
    cast r1 into r4 as u128;
    call multi_token_support_programv1.aleo/transfer_public_as_signer 1751493913335802797273486270793650302076377624243810059080883537084141842600field ans_registrar_usd2.aleo r4 into r5;
    async stake r2 r3 r5 r0 r1 into r6;
    output r6 as ans_registrar_usd2.aleo/stake.future;

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
    output r5 as ans_registrar_usd2.aleo/withdraw.future;

finalize withdraw:
    input r0 as multi_token_support_programv1.aleo/transfer_public.future;
    input r1 as u128.public;
    await r0;
    get general_settings[0u8] into r2;
    assert.eq r1 r2;
