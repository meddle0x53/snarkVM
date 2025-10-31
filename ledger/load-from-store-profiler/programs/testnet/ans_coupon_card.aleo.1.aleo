program ans_coupon_card.aleo;

record CouponCard:
    owner as address.private;
    discount_percent as u8.private;
    limit_name_length as u8.private;
    tld as field.private;

struct CardOwner:
    account as address;
    discount_percent as u8;
    limit_name_length as u8;
    tld as field;

mapping admins:
    key as u8.public;
    value as address.public;

mapping cards:
    key as field.public;
    value as u64.public;

function initialize:
    async initialize self.caller into r0;
    output r0 as ans_coupon_card.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    set r0 into admins[0u8];

function set_admin:
    input r0 as address.private;
    async set_admin self.caller r0 into r1;
    output r1 as ans_coupon_card.aleo/set_admin.future;

finalize set_admin:
    input r0 as address.public;
    input r1 as address.public;
    get admins[0u8] into r2;
    assert.eq r2 r0;
    set r1 into admins[0u8];

function transfer_private:
    input r0 as CouponCard.record;
    input r1 as address.private;
    cast r1 r0.discount_percent r0.limit_name_length r0.tld into r2 as CouponCard.record;
    output r2 as CouponCard.record;

function transfer_private_to_public:
    input r0 as CouponCard.record;
    input r1 as address.public;
    cast r1 r0.discount_percent r0.limit_name_length r0.tld into r2 as CardOwner;
    hash.bhp256 r2 into r3 as field;
    async transfer_private_to_public r3 into r4;
    output r4 as ans_coupon_card.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as field.public;
    get.or_use cards[r0] 0u64 into r1;
    add r1 1u64 into r2;
    set r2 into cards[r0];

function transfer_public_to_private:
    input r0 as address.private;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as field.private;
    cast self.caller r1 r2 r3 into r4 as CardOwner;
    hash.bhp256 r4 into r5 as field;
    cast r0 r1 r2 r3 into r6 as CouponCard.record;
    async transfer_public_to_private r5 into r7;
    output r6 as CouponCard.record;
    output r7 as ans_coupon_card.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as field.public;
    get cards[r0] into r1;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    sub r1 1u64 into r3;
    set r3 into cards[r0];

function transfer_public:
    input r0 as address.private;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as field.private;
    input r4 as u64.private;
    cast self.caller r1 r2 r3 into r5 as CardOwner;
    hash.bhp256 r5 into r6 as field;
    cast r0 r1 r2 r3 into r7 as CardOwner;
    hash.bhp256 r7 into r8 as field;
    async transfer_public r6 r8 r4 into r9;
    output r9 as ans_coupon_card.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    get cards[r0] into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    sub r3 r2 into r5;
    set r5 into cards[r0];
    get.or_use cards[r1] 0u64 into r6;
    add r6 r2 into r7;
    set r7 into cards[r1];

function issue_coupon_card:
    input r0 as address.private;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as field.private;
    lt r1 100u8 into r4;
    assert.eq r4 true;
    cast r0 r1 r2 r3 into r5 as CouponCard.record;
    async issue_coupon_card self.caller into r6;
    output r5 as CouponCard.record;
    output r6 as ans_coupon_card.aleo/issue_coupon_card.future;

finalize issue_coupon_card:
    input r0 as address.public;
    get admins[0u8] into r1;
    assert.eq r1 r0;

function issue_coupon_card_public:
    input r0 as address.private;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as field.private;
    input r4 as u64.private;
    lt r1 100u8 into r5;
    assert.eq r5 true;
    cast r0 r1 r2 r3 into r6 as CardOwner;
    hash.bhp256 r6 into r7 as field;
    async issue_coupon_card_public self.caller r7 r4 into r8;
    output r8 as ans_coupon_card.aleo/issue_coupon_card_public.future;

finalize issue_coupon_card_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u64.public;
    get admins[0u8] into r3;
    assert.eq r3 r0;
    get.or_use cards[r1] 0u64 into r4;
    add r4 r2 into r5;
    set r5 into cards[r1];

function use:
    input r0 as CouponCard.record;
