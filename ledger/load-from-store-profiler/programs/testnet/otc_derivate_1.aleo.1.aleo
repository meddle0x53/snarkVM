import credits.aleo;
import token_registry.aleo;

program otc_derivate_1.aleo;

record Collateral:
    owner as address.private;
    collateral_id as field.private;
    token_id as field.private;
    number_of_shares as u128.private;
    maturity as u16.private;
    credit_rating as u8.private;
    haircut as u8.private;
    stock_price as u128.private;
    siim_margin as u128.private;

record EngagedCollateral:
    owner as address.private;
    collateral_id as field.private;
    token_id as field.private;
    amount as u128.private;
    recipient as address.private;

record ReceiptCollateral:
    owner as address.private;
    collateral_id as field.private;
    lender as address.private;
    maturity as u16.private;
    amount as u128.private;
    token_id as field.private;

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

mapping eligible_OTC_collateral:
    key as field.public;
    value as boolean.public;

mapping allocated_OTC_collateral:
    key as field.public;
    value as boolean.public;

mapping loan_repaid:
    key as field.public;
    value as boolean.public;

mapping dispute_lock:
    key as field.public;
    value as boolean.public;

function create_collateral:
    input r0 as u16.private;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as address.private;
    input r4 as u128.private;
    input r5 as field.private;
    input r6 as u128.private;
    input r7 as u128.private;
    hash.bhp256 self.signer into r8 as field;
    add r8 r5 into r9;
    hash.bhp256 r4 into r10 as field;
    add r9 r10 into r11;
    hash.bhp256 r0 into r12 as field;
    add r11 r12 into r13;
    hash.bhp256 r13 into r14 as field;
    cast self.signer r14 r5 r4 r0 r1 r2 r6 r7 into r15 as Collateral.record;
    async create_collateral r14 into r16;
    output r15 as Collateral.record;
    output r16 as otc_derivate_1.aleo/create_collateral.future;

finalize create_collateral:
    input r0 as field.public;
    set false into eligible_OTC_collateral[r0];

function validate_otc_eligibility:
    input r0 as Collateral.record;
    gt r0.credit_rating 11u8 into r1;
    mul r0.number_of_shares r0.stock_price into r2;
    cast r0.haircut into r3 as u128;
    sub 100u128 r3 into r4;
    mul r2 r4 into r5;
    div r5 100u128 into r6;
    cast r0.siim_margin into r7 as u128;
    gt r6 r7 into r8;
    and r1 r8 into r9;
    async validate_otc_eligibility r0.collateral_id r9 into r10;
    cast r0.owner r0.collateral_id r0.token_id r0.number_of_shares r0.maturity r0.credit_rating r0.haircut r0.stock_price r0.siim_margin into r11 as Collateral.record;
    output r11 as Collateral.record;
    output r10 as otc_derivate_1.aleo/validate_otc_eligibility.future;

finalize validate_otc_eligibility:
    input r0 as field.public;
    input r1 as boolean.public;
    set r1 into eligible_OTC_collateral[r0];

function lock_otc:
    input r0 as token_registry.aleo/Token.record;
    input r1 as Collateral.record;
    input r2 as u128.public;
    input r3 as address.private;
    mul r1.number_of_shares r1.stock_price into r4;
    assert.eq r0.owner r1.owner;
    assert.eq r0.token_id r1.token_id;
    assert.eq r4 r1.number_of_shares;
    call token_registry.aleo/transfer_private_to_public otc_derivate_1.aleo r4 r0 into r5 r6;
    cast self.signer r1.collateral_id r1.token_id r4 r3 into r7 as EngagedCollateral.record;
    cast r3 r1.collateral_id self.signer r1.maturity r4 r1.token_id into r8 as ReceiptCollateral.record;
    async lock_otc r6 r1.collateral_id into r9;
    cast r1.owner r1.collateral_id r1.token_id r1.number_of_shares r1.maturity r1.credit_rating r1.haircut r1.stock_price r1.siim_margin into r10 as Collateral.record;
    output r5 as token_registry.aleo/Token.record;
    output r10 as Collateral.record;
    output r7 as EngagedCollateral.record;
    output r8 as ReceiptCollateral.record;
    output r9 as otc_derivate_1.aleo/lock_otc.future;

finalize lock_otc:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    get.or_use eligible_OTC_collateral[r1] false into r2;
    assert.eq r2 true;
    get.or_use allocated_OTC_collateral[r1] false into r3;
    assert.eq r3 false;
    set true into allocated_OTC_collateral[r1];
    await r0;

function mark_loan_repaid:
    input r0 as ReceiptCollateral.record;
    assert.eq r0.owner self.signer;
    async mark_loan_repaid r0.collateral_id into r1;
    output r1 as otc_derivate_1.aleo/mark_loan_repaid.future;

finalize mark_loan_repaid:
    input r0 as field.public;
    get.or_use allocated_OTC_collateral[r0] false into r1;
    assert.eq r1 true;
    set true into loan_repaid[r0];

function withdraw_otc:
    input r0 as EngagedCollateral.record;
    assert.eq r0.owner self.signer;
    call token_registry.aleo/transfer_public_to_private r0.token_id self.signer r0.amount false into r1 r2;
    async withdraw_otc r2 r0.collateral_id into r3;
    output r1 as token_registry.aleo/Token.record;
    output r3 as otc_derivate_1.aleo/withdraw_otc.future;

finalize withdraw_otc:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    get.or_use allocated_OTC_collateral[r1] false into r2;
    assert.eq r2 true;
    get.or_use dispute_lock[r1] false into r3;
    assert.eq r3 false;
    get.or_use loan_repaid[r1] false into r4;
    assert.eq r4 true;
    set false into allocated_OTC_collateral[r1];
    set false into loan_repaid[r1];
    await r0;

function liquidate_collateral:
    input r0 as ReceiptCollateral.record;
    input r1 as u16.public;
    assert.eq r0.owner self.signer;
    add r0.maturity 3u16 into r2;
    lt r1 r2 into r3;
    assert.eq r3 true;
    call token_registry.aleo/transfer_public_to_private r0.token_id self.signer r0.amount false into r4 r5;
    async liquidate_collateral r5 r0.collateral_id into r6;
    output r4 as token_registry.aleo/Token.record;
    output r6 as otc_derivate_1.aleo/liquidate_collateral.future;

finalize liquidate_collateral:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    get.or_use allocated_OTC_collateral[r1] false into r2;
    assert.eq r2 true;
    get.or_use dispute_lock[r1] false into r3;
    assert.eq r3 false;
    get.or_use loan_repaid[r1] false into r4;
    assert.eq r4 false;
    set false into allocated_OTC_collateral[r1];
    set true into loan_repaid[r1];
    await r0;

function trigger_dispute:
    input r0 as address.private;
    input r1 as ReceiptCollateral.record;
    assert.eq r0 r1.owner;
    assert.eq self.signer r0;
    async trigger_dispute r1.collateral_id into r2;
    cast r1.owner r1.collateral_id r1.lender r1.maturity r1.amount r1.token_id into r3 as ReceiptCollateral.record;
    output r3 as ReceiptCollateral.record;
    output r2 as otc_derivate_1.aleo/trigger_dispute.future;

finalize trigger_dispute:
    input r0 as field.public;
    get.or_use allocated_OTC_collateral[r0] false into r1;
    assert.eq r1 true;
    set true into dispute_lock[r0];
