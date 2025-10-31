import credits.aleo;
import token_registry.aleo;

program otc_derivate.aleo;

record OTCDerivativeCollateral:
    owner as address.private;
    collateral_id as field.private;
    token_id as field.private;
    number_of_shares as u128.private;
    maturity as u32.private;
    credit_rating as u8.private;
    haircut as u64.private;
    stock_price as u128.private;
    siim_margin as u64.private;

record OTCDerivativeReceipt:
    owner as address.private;
    collateral_id as field.private;
    token_id as field.private;
    amount as u128.private;
    recipient as address.private;

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

function create_otc_derivative:
    input r0 as u32.private;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as address.private;
    input r4 as u128.private;
    input r5 as field.private;
    input r6 as u128.private;
    input r7 as u64.private;
    hash.bhp256 self.signer into r8 as field;
    add r8 r5 into r9;
    hash.bhp256 r4 into r10 as field;
    add r9 r10 into r11;
    hash.bhp256 r0 into r12 as field;
    add r11 r12 into r13;
    hash.bhp256 r13 into r14 as field;
    cast r3 r14 r5 r4 r0 r1 r2 r6 r7 into r15 as OTCDerivativeCollateral.record;
    async create_otc_derivative r14 into r16;
    output r15 as OTCDerivativeCollateral.record;
    output r16 as otc_derivate.aleo/create_otc_derivative.future;

finalize create_otc_derivative:
    input r0 as field.public;
    set false into eligible_OTC_collateral[r0];

function validate_otc_eligibility:
    input r0 as OTCDerivativeCollateral.record;
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
    cast r0.owner r0.collateral_id r0.token_id r0.number_of_shares r0.maturity r0.credit_rating r0.haircut r0.stock_price r0.siim_margin into r11 as OTCDerivativeCollateral.record;
    output r11 as OTCDerivativeCollateral.record;
    output r10 as otc_derivate.aleo/validate_otc_eligibility.future;

finalize validate_otc_eligibility:
    input r0 as field.public;
    input r1 as boolean.public;
    set r1 into eligible_OTC_collateral[r0];

function lock:
    input r0 as token_registry.aleo/Token.record;
    input r1 as OTCDerivativeCollateral.record;
    input r2 as u128.public;
    input r3 as address.private;
    assert.eq r0.owner r1.owner;
    assert.eq r0.token_id r1.token_id;
    assert.eq r2 r1.number_of_shares;
    call token_registry.aleo/transfer_private_to_public otc_derivate.aleo r2 r0 into r4 r5;
    cast self.signer r1.collateral_id r1.token_id r1.number_of_shares r3 into r6 as OTCDerivativeReceipt.record;
    async lock r5 r1.collateral_id into r7;
    cast r1.owner r1.collateral_id r1.token_id r1.number_of_shares r1.maturity r1.credit_rating r1.haircut r1.stock_price r1.siim_margin into r8 as OTCDerivativeCollateral.record;
    output r4 as token_registry.aleo/Token.record;
    output r8 as OTCDerivativeCollateral.record;
    output r6 as OTCDerivativeReceipt.record;
    output r7 as otc_derivate.aleo/lock.future;

finalize lock:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    await r0;
    get.or_use allocated_OTC_collateral[r1] false into r2;
    assert.eq r2 false;
    set true into allocated_OTC_collateral[r1];

function withdraw:
    input r0 as OTCDerivativeReceipt.record;
    assert.eq r0.owner self.signer;
    call token_registry.aleo/transfer_public_to_private r0.token_id self.signer r0.amount false into r1 r2;
    async withdraw r2 r0.collateral_id into r3;
    output r1 as token_registry.aleo/Token.record;
    output r3 as otc_derivate.aleo/withdraw.future;

finalize withdraw:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    await r0;
    get.or_use allocated_OTC_collateral[r1] false into r2;
    assert.eq r2 true;
    set false into allocated_OTC_collateral[r1];
