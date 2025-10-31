import ans_utils.aleo;
import aleo_name_service_registry_v1.aleo;
import ans_coupon_card_v1.aleo;
import credits.aleo;

program ans_registrar_v1.aleo;

struct Name:
    name as [u128; 4u32];
    parent as field;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as u128;

struct data:
    metadata as [field; 4u32];
    content as Name;

mapping general_settings:
    key as u8.public;
    value as u128.public;

function initialize_registrar:
    hash.bhp256 self.caller into r0 as u128;
    async initialize_registrar r0 into r1;
    output r1 as ans_registrar_v1.aleo/initialize_registrar.future;

finalize initialize_registrar:
    input r0 as u128.public;
    set r0 into general_settings[0u8];

function set_minting_flag:
    input r0 as u128.private;
    input r1 as u128.private;
    hash.bhp256 self.caller into r2 as u128;
    async set_minting_flag r2 r0 r1 into r3;
    output r3 as ans_registrar_v1.aleo/set_minting_flag.future;

finalize set_minting_flag:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u128.public;
    get general_settings[0u8] into r3;
    assert.eq r0 r3;
    set r1 into general_settings[1u8];
    set r2 into general_settings[2u8];

function change_admin:
    input r0 as address.private;
    hash.bhp256 self.caller into r1 as u128;
    hash.bhp256 r0 into r2 as u128;
    async change_admin r1 r2 into r3;
    output r3 as ans_registrar_v1.aleo/change_admin.future;

finalize change_admin:
    input r0 as u128.public;
    input r1 as u128.public;
    get general_settings[0u8] into r2;
    assert.eq r0 r2;
    set r1 into general_settings[7u8];

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
    input r3 as ans_coupon_card_v1.aleo/CouponCard.record;
    assert.eq r3.discount_percent 0u8;
    is.eq r3.tld r1 into r4;
    is.eq r3.tld 0field into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    call get_name_length r0 into r7;
    gte r7 r3.limit_name_length into r8;
    assert.eq r8 true;
    call aleo_name_service_registry_v1.aleo/register r0 r1 r2 0u128 into r9 r10;
    call ans_coupon_card_v1.aleo/use r3;
    async register_free r10 into r11;
    output r11 as ans_registrar_v1.aleo/register_free.future;

finalize register_free:
    input r0 as aleo_name_service_registry_v1.aleo/register.future;
    await r0;
    get general_settings[2u8] into r1;
    assert.eq r1 1u128;

closure calc_price:
    input r0 as u8;
    is.eq r0 5u8 into r1;
    is.eq r0 4u8 into r2;
    is.eq r0 3u8 into r3;
    is.eq r0 2u8 into r4;
    ternary r4 250000000u64 1250000000u64 into r5;
    ternary r3 50000000u64 r5 into r6;
    ternary r2 10000000u64 r6 into r7;
    ternary r1 2000000u64 r7 into r8;
    output r8 as u64;

function register_fld:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    call get_name_length r0 into r4;
    call calc_price r4 into r5;
    call credits.aleo/transfer_private_to_public r3 ans_registrar_v1.aleo r5 into r6 r7;
    call aleo_name_service_registry_v1.aleo/register r0 r1 r2 0u128 into r8 r9;
    async register_fld r7 r9 into r10;
    output r10 as ans_registrar_v1.aleo/register_fld.future;

finalize register_fld:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as aleo_name_service_registry_v1.aleo/register.future;
    await r0;
    await r1;
    get general_settings[1u8] into r2;
    assert.eq r2 1u128;

function register_fld_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    call get_name_length r0 into r3;
    call calc_price r3 into r4;
    call credits.aleo/transfer_public_as_signer ans_registrar_v1.aleo r4 into r5;
    call aleo_name_service_registry_v1.aleo/register r0 r1 r2 0u128 into r6 r7;
    async register_fld_public r5 r7 into r8;
    output r8 as ans_registrar_v1.aleo/register_fld_public.future;

finalize register_fld_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as aleo_name_service_registry_v1.aleo/register.future;
    await r0;
    await r1;
    get general_settings[1u8] into r2;
    assert.eq r2 1u128;

function register_fld_with_coupon:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as ans_coupon_card_v1.aleo/CouponCard.record;
    is.eq r4.tld r1 into r5;
    is.eq r4.tld 0field into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    call get_name_length r0 into r8;
    gte r8 r4.limit_name_length into r9;
    assert.eq r9 true;
    call calc_price r8 into r10;
    cast r4.discount_percent into r11 as u64;
    mul r10 r11 into r12;
    div r12 100u64 into r13;
    call credits.aleo/transfer_private_to_public r3 ans_registrar_v1.aleo r13 into r14 r15;
    call aleo_name_service_registry_v1.aleo/register r0 r1 r2 0u128 into r16 r17;
    call ans_coupon_card_v1.aleo/use r4;
    async register_fld_with_coupon r15 r17 into r18;
    output r18 as ans_registrar_v1.aleo/register_fld_with_coupon.future;

finalize register_fld_with_coupon:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as aleo_name_service_registry_v1.aleo/register.future;
    await r0;
    await r1;
    get general_settings[2u8] into r2;
    assert.eq r2 1u128;

function register_fld_with_coupon_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v1.aleo/CouponCard.record;
    is.eq r3.tld r1 into r4;
    is.eq r3.tld 0field into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    call get_name_length r0 into r7;
    gte r7 r3.limit_name_length into r8;
    assert.eq r8 true;
    call calc_price r7 into r9;
    cast r3.discount_percent into r10 as u64;
    mul r9 r10 into r11;
    div r11 100u64 into r12;
    call credits.aleo/transfer_public_as_signer ans_registrar_v1.aleo r12 into r13;
    call aleo_name_service_registry_v1.aleo/register r0 r1 r2 0u128 into r14 r15;
    call ans_coupon_card_v1.aleo/use r3;
    async register_fld_with_coupon_public r13 r15 into r16;
    output r16 as ans_registrar_v1.aleo/register_fld_with_coupon_public.future;

finalize register_fld_with_coupon_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as aleo_name_service_registry_v1.aleo/register.future;
    await r0;
    await r1;
    get general_settings[2u8] into r2;
    assert.eq r2 1u128;

function stake:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as u64.private;
    hash.bhp256 self.caller into r3 as u128;
    call credits.aleo/bond_public r0 r1 r2 into r4;
    async stake r4 r3 into r5;
    output r5 as ans_registrar_v1.aleo/stake.future;

finalize stake:
    input r0 as credits.aleo/bond_public.future;
    input r1 as u128.public;
    await r0;
    get general_settings[0u8] into r2;
    assert.eq r1 r2;
