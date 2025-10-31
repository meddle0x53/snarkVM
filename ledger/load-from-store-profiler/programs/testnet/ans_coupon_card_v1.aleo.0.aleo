program ans_coupon_card_v1.aleo;

record CouponCard:
    owner as address.private;
    discount_percent as u8.private;
    limit_name_length as u8.private;
    tld as field.private;

mapping general_settings:
    key as u8.public;
    value as u128.public;

mapping cb_uuids:
    key as u128.public;
    value as boolean.public;

mapping cb_address:
    key as u128.public;
    value as boolean.public;

function initialize:
    hash.bhp256 self.caller into r0 as u128;
    async initialize r0 into r1;
    output r1 as ans_coupon_card_v1.aleo/initialize.future;

finalize initialize:
    input r0 as u128.public;
    set r0 into general_settings[0u8];

function update_toggle_settings:
    input r0 as u8.private;
    input r1 as u128.private;
    hash.bhp256 self.caller into r2 as u128;
    async update_toggle_settings r2 r0 r1 into r3;
    output r3 as ans_coupon_card_v1.aleo/update_toggle_settings.future;

finalize update_toggle_settings:
    input r0 as u128.public;
    input r1 as u8.public;
    input r2 as u128.public;
    get general_settings[0u8] into r3;
    assert.eq r0 r3;
    set r2 into general_settings[r1];

function issue_coupon_card:
    input r0 as address.private;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as field.private;
    lte r1 100u8 into r4;
    assert.eq r4 true;
    cast r0 r1 r2 r3 into r5 as CouponCard.record;
    hash.bhp256 self.caller into r6 as u128;
    async issue_coupon_card r6 into r7;
    output r5 as CouponCard.record;
    output r7 as ans_coupon_card_v1.aleo/issue_coupon_card.future;

finalize issue_coupon_card:
    input r0 as u128.public;
    get general_settings[0u8] into r1;
    assert.eq r0 r1;

function issue_coupon_card_cb:
    input r0 as address.private;
    input r1 as [u128; 4u32].private;
    cast r0 25u8 5u8 3429962289057708737616101644642461578953781498069508461288569895276398934019field into r2 as CouponCard.record;
    hash.bhp256 r0 into r3 as u128;
    hash.bhp256 r1 into r4 as u128;
    hash.bhp256 self.caller into r5 as u128;
    async issue_coupon_card_cb r5 r3 r4 into r6;
    output r2 as CouponCard.record;
    output r6 as ans_coupon_card_v1.aleo/issue_coupon_card_cb.future;

finalize issue_coupon_card_cb:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u128.public;
    get general_settings[1u8] into r3;
    assert.eq r0 r3;
    contains cb_uuids[r2] into r4;
    assert.eq r4 false;
    contains cb_address[r1] into r5;
    assert.eq r5 false;
    get general_settings[3u8] into r6;
    get general_settings[2u8] into r7;
    gt r7 r6 into r8;
    assert.eq r8 true;
    set true into cb_uuids[r2];
    set true into cb_address[r1];
    add r6 1u128 into r9;
    set r9 into general_settings[3u8];

function use:
    input r0 as CouponCard.record;
