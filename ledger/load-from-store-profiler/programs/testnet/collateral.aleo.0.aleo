import credits.aleo;
import token_registry.aleo;

program collateral.aleo;

record Collateral:
    owner as address.private;
    collateral_id as field.private;
    token_id as field.private;
    number_of_shares as u128.private;
    maturity as u32.private;
    credit_rating as u8.private;
    stock_price as u128.private;

record OTC_Info:
    owner as address.private;
    collateral_id as field.private;
    haircut as u8.private;
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
    maturity as u32.private;
    amount as u128.private;
    token_id as field.private;

record RepoChain:
    owner as address.private;
    collateral_id as field.private;
    token_id as field.private;
    number_of_shares as u128.private;
    maturity as u32.private;
    credit_rating as u8.private;
    stock_price as u128.private;
    lender as address.private;
    hypothecation_level as u8.private;
    haircut as u8.private;
    rehypothecation_allowed as boolean.private;

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

mapping allocated_repo_collateral:
    key as field.public;
    value as u8.public;

function create_collateral:
    input r0 as u32.private;
    input r1 as u8.private;
    input r2 as address.private;
    input r3 as u128.private;
    input r4 as field.private;
    input r5 as u128.private;
    hash.bhp256 self.signer into r6 as field;
    add r6 r4 into r7;
    hash.bhp256 r3 into r8 as field;
    add r7 r8 into r9;
    hash.bhp256 r0 into r10 as field;
    add r9 r10 into r11;
    hash.bhp256 r11 into r12 as field;
    cast self.signer r12 r4 r3 r0 r1 r5 into r13 as Collateral.record;
    async create_collateral r12 into r14;
    output r13 as Collateral.record;
    output r14 as collateral.aleo/create_collateral.future;

finalize create_collateral:
    input r0 as field.public;
    set false into eligible_OTC_collateral[r0];

function validate_otc_eligibility:
    input r0 as Collateral.record;
    input r1 as u8.private;
    input r2 as u128.private;
    cast r0.owner r0.collateral_id r1 r2 into r3 as OTC_Info.record;
    lt r0.credit_rating 11u8 into r4;
    mul r0.number_of_shares r0.stock_price into r5;
    cast r1 into r6 as u128;
    sub 100u128 r6 into r7;
    mul r5 r7 into r8;
    div r8 100u128 into r9;
    gt r9 r2 into r10;
    and r4 r10 into r11;
    async validate_otc_eligibility r0.collateral_id r11 into r12;
    cast r0.owner r0.collateral_id r0.token_id r0.number_of_shares r0.maturity r0.credit_rating r0.stock_price into r13 as Collateral.record;
    output r13 as Collateral.record;
    output r3 as OTC_Info.record;
    output r12 as collateral.aleo/validate_otc_eligibility.future;

finalize validate_otc_eligibility:
    input r0 as field.public;
    input r1 as boolean.public;
    set r1 into eligible_OTC_collateral[r0];

function lock_otc_collateral:
    input r0 as Collateral.record;
    input r1 as address.private;
    mul r0.number_of_shares r0.stock_price into r2;
    cast self.signer r0.collateral_id r0.token_id r2 r1 into r3 as EngagedCollateral.record;
    async lock_otc_collateral r0.collateral_id into r4;
    cast r0.owner r0.collateral_id r0.token_id r0.number_of_shares r0.maturity r0.credit_rating r0.stock_price into r5 as Collateral.record;
    output r5 as Collateral.record;
    output r3 as EngagedCollateral.record;
    output r4 as collateral.aleo/lock_otc_collateral.future;

finalize lock_otc_collateral:
    input r0 as field.public;
    get.or_use eligible_OTC_collateral[r0] false into r1;
    assert.eq r1 true;
    get.or_use allocated_OTC_collateral[r0] false into r2;
    assert.eq r2 false;
    set true into allocated_OTC_collateral[r0];

function transfer_locked_tokens:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.public;
    assert.eq r0.owner self.signer;
    call token_registry.aleo/transfer_private_to_public collateral.aleo r1 r0 into r2 r3;
    async transfer_locked_tokens r3 into r4;
    output r2 as token_registry.aleo/Token.record;
    output r4 as collateral.aleo/transfer_locked_tokens.future;

finalize transfer_locked_tokens:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    await r0;

function mark_loan_repaid:
    input r0 as ReceiptCollateral.record;
    assert.eq r0.owner self.signer;
    async mark_loan_repaid r0.collateral_id into r1;
    output r1 as collateral.aleo/mark_loan_repaid.future;

finalize mark_loan_repaid:
    input r0 as field.public;
    get.or_use allocated_OTC_collateral[r0] false into r1;
    assert.eq r1 true;
    set true into loan_repaid[r0];

function validate_withdraw_otc:
    input r0 as EngagedCollateral.record;
    assert.eq r0.owner self.signer;
    async validate_withdraw_otc r0.collateral_id into r1;
    cast r0.owner r0.collateral_id r0.token_id r0.amount r0.recipient into r2 as EngagedCollateral.record;
    output r2 as EngagedCollateral.record;
    output r1 as collateral.aleo/validate_withdraw_otc.future;

finalize validate_withdraw_otc:
    input r0 as field.public;
    get.or_use allocated_OTC_collateral[r0] false into r1;
    assert.eq r1 true;
    get.or_use dispute_lock[r0] false into r2;
    assert.eq r2 false;
    get.or_use loan_repaid[r0] false into r3;
    assert.eq r3 true;
    set false into allocated_OTC_collateral[r0];
    set false into loan_repaid[r0];

function withdraw_tokens_otc:
    input r0 as field.public;
    input r1 as u128.public;
    call token_registry.aleo/transfer_public_to_private r0 self.signer r1 false into r2 r3;
    async withdraw_tokens_otc r3 into r4;
    output r2 as token_registry.aleo/Token.record;
    output r4 as collateral.aleo/withdraw_tokens_otc.future;

finalize withdraw_tokens_otc:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    await r0;

function liquidate_otc:
    input r0 as ReceiptCollateral.record;
    input r1 as u32.public;
    assert.eq r0.owner self.signer;
    add r0.maturity 3u32 into r2;
    lt r1 r2 into r3;
    assert.eq r3 true;
    call token_registry.aleo/transfer_public_to_private r0.token_id self.signer r0.amount false into r4 r5;
    async liquidate_otc r5 r0.collateral_id into r6;
    output r4 as token_registry.aleo/Token.record;
    output r6 as collateral.aleo/liquidate_otc.future;

finalize liquidate_otc:
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
    output r2 as collateral.aleo/trigger_dispute.future;

finalize trigger_dispute:
    input r0 as field.public;
    get.or_use allocated_OTC_collateral[r0] false into r1;
    assert.eq r1 true;
    set true into dispute_lock[r0];

function lock_repo:
    input r0 as token_registry.aleo/Token.record;
    input r1 as Collateral.record;
    input r2 as u8.private;
    input r3 as boolean.private;
    input r4 as address.private;
    mul r1.number_of_shares r1.stock_price into r5;
    assert.eq r0.owner r1.owner;
    assert.eq r0.token_id r1.token_id;
    cast r4 r1.collateral_id r1.token_id r1.number_of_shares r1.maturity r1.credit_rating r1.stock_price self.signer 1u8 r2 r3 into r6 as RepoChain.record;
    cast self.signer r1.collateral_id r1.token_id r5 r4 into r7 as EngagedCollateral.record;
    async lock_repo r1.collateral_id into r8;
    cast r1.owner r1.collateral_id r1.token_id r1.number_of_shares r1.maturity r1.credit_rating r1.stock_price into r9 as Collateral.record;
    output r0 as token_registry.aleo/Token.record;
    output r9 as Collateral.record;
    output r6 as RepoChain.record;
    output r7 as EngagedCollateral.record;
    output r8 as collateral.aleo/lock_repo.future;

finalize lock_repo:
    input r0 as field.public;
    get.or_use allocated_repo_collateral[r0] 0u8 into r1;
    assert.eq r1 0u8;
    set 1u8 into allocated_repo_collateral[r0];

function rehypothecate:
    input r0 as RepoChain.record;
    input r1 as address.private;
    assert.eq r0.owner self.signer;
    assert.eq r0.rehypothecation_allowed true;
    gte r0.hypothecation_level 1u8 into r2;
    assert.eq r2 true;
    mul r0.number_of_shares r0.stock_price into r3;
    add r0.hypothecation_level 1u8 into r4;
    cast r1 r0.collateral_id r0.token_id r0.number_of_shares r0.maturity r0.credit_rating r0.stock_price self.signer r4 r0.haircut r0.rehypothecation_allowed into r5 as RepoChain.record;
    cast self.signer r0.collateral_id r0.token_id r3 r1 into r6 as EngagedCollateral.record;
    add r0.hypothecation_level 1u8 into r7;
    async rehypothecate r0.collateral_id r7 into r8;
    output r5 as RepoChain.record;
    output r6 as EngagedCollateral.record;
    output r8 as collateral.aleo/rehypothecate.future;

finalize rehypothecate:
    input r0 as field.public;
    input r1 as u8.public;
    set r1 into allocated_repo_collateral[r0];
