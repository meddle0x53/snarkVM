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
import ans_registrar_v6.aleo;

program ans_registrar_quest.aleo;

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

function register_free:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r4 as [field; 8u32].private;
    call ans_registrar_v6.aleo/register_free r0 r1 r2 r3 into r5;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r4 into r6;
    async register_free r5 into r7;
    output r7 as ans_registrar_quest.aleo/register_free.future;

finalize register_free:
    input r0 as ans_registrar_v6.aleo/register_free.future;
    await r0;

function register_fld:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as [field; 8u32].private;
    call ans_registrar_v6.aleo/register_fld r0 r1 r2 r3 into r5;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r4 into r6;
    async register_fld r5 into r7;
    output r7 as ans_registrar_quest.aleo/register_fld.future;

finalize register_fld:
    input r0 as ans_registrar_v6.aleo/register_fld.future;
    await r0;

function register_fld_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as [field; 8u32].private;
    call ans_registrar_v6.aleo/register_fld_public r0 r1 r2 into r4;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r3 into r5;
    async register_fld_public r4 into r6;
    output r6 as ans_registrar_quest.aleo/register_fld_public.future;

finalize register_fld_public:
    input r0 as ans_registrar_v6.aleo/register_fld_public.future;
    await r0;

function register_fld_with_coupon:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as credits.aleo/credits.record;
    input r4 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r5 as [field; 8u32].private;
    call ans_registrar_v6.aleo/register_fld_with_coupon r0 r1 r2 r3 r4 into r6;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r5 into r7;
    async register_fld_with_coupon r6 into r8;
    output r8 as ans_registrar_quest.aleo/register_fld_with_coupon.future;

finalize register_fld_with_coupon:
    input r0 as ans_registrar_v6.aleo/register_fld_with_coupon.future;
    await r0;

function register_fld_with_coupon_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as ans_coupon_card_v3.aleo/CouponCard.record;
    input r4 as [field; 8u32].private;
    call ans_registrar_v6.aleo/register_fld_with_coupon_public r0 r1 r2 r3 into r5;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r4 into r6;
    async register_fld_with_coupon_public r5 into r7;
    output r7 as ans_registrar_quest.aleo/register_fld_with_coupon_public.future;

finalize register_fld_with_coupon_public:
    input r0 as ans_registrar_v6.aleo/register_fld_with_coupon_public.future;
    await r0;
