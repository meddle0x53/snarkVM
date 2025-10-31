import arcn_compliance_v1.aleo;
import arcn_access_manager_v1.aleo;
import arcn_whitelist.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_2.aleo;
import wrapped_credits.aleo;
import arcn_puc_out_helper_v2_2_3.aleo;
import token_registry_airdrop_32b.aleo;

program zsociety_staking_v2.aleo;

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

struct DepositOwner:
    from as address;
    salt as field;

struct ProtocolFeeConfig:
    rate as u16;
    foundation as address;

struct DepositData:
    from as address;
    beg as u32;
    zsct_amount as u128;
    withdrawn as boolean;

record StakingReceipt:
    owner as address.private;
    deposit_id as field.private;

mapping deposits:
    key as field.public;
    value as DepositData.public;

mapping state:
    key as boolean.public;
    value as u8.public;

mapping end_block:
    key as boolean.public;
    value as u32.public;

mapping points:
    key as address.public;
    value as u128.public;

function initialize:
    assert.eq self.caller aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t;
    async initialize into r0;
    output r0 as zsociety_staking_v2.aleo/initialize.future;

finalize initialize:
    contains state[true] into r0;
    not r0 into r1;
    assert.eq r1 true;
    set 1u8 into state[true];

function pause:
    assert.eq self.caller aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t;
    async pause into r0;
    output r0 as zsociety_staking_v2.aleo/pause.future;

finalize pause:
    get state[true] into r0;
    assert.eq r0 1u8;
    set 2u8 into state[true];

function resume:
    assert.eq self.caller aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t;
    async resume into r0;
    output r0 as zsociety_staking_v2.aleo/resume.future;

finalize resume:
    get state[true] into r0;
    assert.eq r0 2u8;
    set 1u8 into state[true];

function end:
    assert.eq self.caller aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t;
    async end into r0;
    output r0 as zsociety_staking_v2.aleo/end.future;

finalize end:
    get state[true] into r0;
    is.eq r0 1u8 into r1;
    is.eq r0 2u8 into r2;
    or r1 r2 into r3;
    assert.eq r3 true;
    set 3u8 into state[true];
    set block.height into end_block[true];

function stake_zsct:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as field.private;
    input r3 as field.public;
    input r4 as field.public;
    call arcn_puc_out_helper_v2_2_3.aleo/add_amm_liq_credits_is_token2 663462887040197364783577261038929681987128751933994308964551716937037886418field self.signer 123field r0 false r1 r2 r3 r4 into r5 r6 r7 r8;
    cast self.signer r2 into r9 as StakingReceipt.record;
    cast self.signer r2 into r10 as DepositOwner;
    hash.bhp256 r10 into r11 as field;
    async stake_zsct r11 self.signer r0 r8 into r12;
    output r9 as StakingReceipt.record;
    output r12 as zsociety_staking_v2.aleo/stake_zsct.future;

finalize stake_zsct:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as arcn_puc_out_helper_v2_2_3.aleo/add_amm_liq_credits_is_token2.future;
    cast r1 block.height r2 false into r4 as DepositData;
    contains deposits[r0] into r5;
    not r5 into r6;
    assert.eq r6 true;
    set r4 into deposits[r0];
    await r3;
    get state[true] into r7;
    assert.eq r7 1u8;

function claim_and_stake_zsct:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as field.private;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    input r6 as field.public;
    input r7 as scalar.private;
    input r8 as u32.private;
    input r9 as [field; 32u32].private;
    call token_registry_airdrop_32b.aleo/claim_airdrop r5 123field r6 r7 r0 r8 r9 into r10 r11;
    call token_registry.aleo/transfer_private_to_public self.signer r0 r10 into r12 r13;
    call arcn_puc_out_helper_v2_2_3.aleo/add_amm_liq_credits_is_token2 663462887040197364783577261038929681987128751933994308964551716937037886418field self.signer 123field r0 false r1 r2 r3 r4 into r14 r15 r16 r17;
    cast self.signer r2 into r18 as StakingReceipt.record;
    cast self.signer r2 into r19 as DepositOwner;
    hash.bhp256 r19 into r20 as field;
    async claim_and_stake_zsct r20 self.signer r0 r11 r13 r17 into r21;
    output r18 as StakingReceipt.record;
    output r21 as zsociety_staking_v2.aleo/claim_and_stake_zsct.future;

finalize claim_and_stake_zsct:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as token_registry_airdrop_32b.aleo/claim_airdrop.future;
    input r4 as token_registry.aleo/transfer_private_to_public.future;
    input r5 as arcn_puc_out_helper_v2_2_3.aleo/add_amm_liq_credits_is_token2.future;
    cast r1 block.height r2 false into r6 as DepositData;
    contains deposits[r0] into r7;
    not r7 into r8;
    assert.eq r8 true;
    set r6 into deposits[r0];
    await r3;
    await r4;
    await r5;
    get state[true] into r9;
    assert.eq r9 1u8;

function unstake_zsct:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as field.private;
    input r3 as field.public;
    input r4 as field.public;
    call arcn_puc_out_helper_v2_2_3.aleo/remove_liq_credits_is_token2 self.signer r2 123field r0 r1 r3 r4 false into r5 r6 r7;
    cast self.signer r2 into r8 as DepositOwner;
    hash.bhp256 r8 into r9 as field;
    async unstake_zsct r9 r7 into r10;
    output r10 as zsociety_staking_v2.aleo/unstake_zsct.future;

finalize unstake_zsct:
    input r0 as field.public;
    input r1 as arcn_puc_out_helper_v2_2_3.aleo/remove_liq_credits_is_token2.future;
    await r1;
    get deposits[r0] into r2;
    not r2.withdrawn into r3;
    assert.eq r3 true;
    cast r2.from r2.beg r2.zsct_amount true into r4 as DepositData;
    set r4 into deposits[r0];
    get state[true] into r5;
    gte r5 1u8 into r6;
    assert.eq r6 true;
    is.eq r5 3u8 into r7;
    get end_block[true] into r8;
    ternary r7 r8 block.height into r9;
    sub r9 r2.beg into r10;
    cast r10 into r11 as u128;
    mul r11 r2.zsct_amount into r12;
    get.or_use points[r2.from] 0u128 into r13;
    add r13 r12 into r14;
    set r14 into points[r2.from];
