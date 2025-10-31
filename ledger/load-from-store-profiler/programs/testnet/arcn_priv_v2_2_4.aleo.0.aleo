import arcn_compliance_v1.aleo;
import arcn_access_manager_v1.aleo;
import arcn_whitelist_v2.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_3.aleo;

program arcn_priv_v2_2_4.aleo;

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

struct DepositValue:
    amount as u128;
    pool_id as field;

struct DepositOwner:
    from as address;
    salt as field;

struct ProtocolFeeConfig:
    rate as u16;
    foundation as address;

function create_pool:
    input r0 as address.private;
    input r1 as token_registry.aleo/Token.record;
    input r2 as u128.private;
    input r3 as token_registry.aleo/Token.record;
    input r4 as u128.private;
    input r5 as u16.private;
    input r6 as field.private;
    input r7 as u8.private;
    input r8 as u16.private;
    call arcn_pool_v2_2_3.aleo/create_pool self.signer r1 r2 r3 r4 r5 r6 0u8 0u16 into r9 r10 r11 r12 r13;
    call arcn_pool_v2_2_3.aleo/transfer_pool_ownership r9 r0 into r14;
    call arcn_pool_v2_2_3.aleo/transfer_lp_receipt_by_salt r12.deposit_salt r12.pool_id r12.token1_id r12.token2_id r0 r12.deposit_salt true into r15 r16;
    call arcn_compliance_v1.aleo/report self.signer r0 r1.token_id r3.token_id r2 r4;
    async create_pool r13 r16 into r17;
    output r10 as token_registry.aleo/Token.record;
    output r11 as token_registry.aleo/Token.record;
    output r14 as arcn_pool_v2_2_3.aleo/PoolAdmin.record;
    output r15 as arcn_pool_v2_2_3.aleo/LpTokenReceipt.record;
    output r17 as arcn_priv_v2_2_4.aleo/create_pool.future;

finalize create_pool:
    input r0 as arcn_pool_v2_2_3.aleo/create_pool.future;
    input r1 as arcn_pool_v2_2_3.aleo/transfer_lp_receipt_by_salt.future;
    await r0;
    await r1;

function swap_amm:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as token_registry.aleo/Token.record;
    input r3 as u128.private;
    input r4 as field.private;
    input r5 as u128.private;
    input r6 as field.private;
    input r7 as boolean.private;
    call arcn_pool_v2_2_3.aleo/swap_amm r0 self.signer r2 r3 r4 r5 r6 r7 into r8 r9 r10 r11;
    call token_registry.aleo/transfer_private r1 r9.amount r9 into r12 r13 r14;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r10 r1 into r15;
    call arcn_compliance_v1.aleo/report self.signer r1 r2.token_id r4 r3 r5;
    async swap_amm r11 r14 into r16;
    output r8 as token_registry.aleo/Token.record;
    output r13 as token_registry.aleo/Token.record;
    output r15 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r16 as arcn_priv_v2_2_4.aleo/swap_amm.future;

finalize swap_amm:
    input r0 as arcn_pool_v2_2_3.aleo/swap_amm.future;
    input r1 as token_registry.aleo/transfer_private.future;
    await r0;
    await r1;

function redeem_voucher:
    input r0 as address.private;
    input r1 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    input r2 as u128.private;
    input r3 as boolean.private;
    call arcn_pool_v2_2_3.aleo/redeem_voucher r1 r2 r3 into r4 r5;
    call token_registry.aleo/transfer_private r0 r4.amount r4 into r6 r7 r8;
    call arcn_compliance_v1.aleo/report_voucher r1.owner r0 r1.token_id r2;
    async redeem_voucher r5 r8 into r9;
    output r7 as token_registry.aleo/Token.record;
    output r9 as arcn_priv_v2_2_4.aleo/redeem_voucher.future;

finalize redeem_voucher:
    input r0 as arcn_pool_v2_2_3.aleo/redeem_voucher.future;
    input r1 as token_registry.aleo/transfer_private.future;
    await r0;
    await r1;

function swap_stable:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as token_registry.aleo/Token.record;
    input r3 as field.private;
    input r4 as u128.private;
    input r5 as u128.private;
    input r6 as field.private;
    input r7 as u16.private;
    input r8 as boolean.private;
    call arcn_pool_v2_2_3.aleo/swap_stable self.signer r1 r2 r3 r4 r5 r6 r7 r8 into r9 r10 r11 r12;
    call token_registry.aleo/transfer_private r0 r10.amount r10 into r13 r14 r15;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r11 r0 into r16;
    call arcn_compliance_v1.aleo/report self.signer r0 r2.token_id r3 r4 r5;
    async swap_stable r12 r15 into r17;
    output r9 as token_registry.aleo/Token.record;
    output r14 as token_registry.aleo/Token.record;
    output r16 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r17 as arcn_priv_v2_2_4.aleo/swap_stable.future;

finalize swap_stable:
    input r0 as arcn_pool_v2_2_3.aleo/swap_stable.future;
    input r1 as token_registry.aleo/transfer_private.future;
    await r0;
    await r1;

function add_amm_liq:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as token_registry.aleo/Token.record;
    input r3 as u128.private;
    input r4 as token_registry.aleo/Token.record;
    input r5 as u128.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    call arcn_pool_v2_2_3.aleo/add_amm_liquidity r0 self.signer r2 r3 r4 r5 r6 r7 r8 into r9 r10 r11 r12 r13 r14;
    call arcn_pool_v2_2_3.aleo/transfer_lp_receipt_by_salt r11.deposit_salt r11.pool_id r11.token1_id r11.token2_id r1 r11.deposit_salt true into r15 r16;
    call arcn_compliance_v1.aleo/report self.signer r1 r2.token_id r4.token_id r3 r5;
    async add_amm_liq r14 r16 into r17;
    output r9 as token_registry.aleo/Token.record;
    output r10 as token_registry.aleo/Token.record;
    output r15 as arcn_pool_v2_2_3.aleo/LpTokenReceipt.record;
    output r12 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r13 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r17 as arcn_priv_v2_2_4.aleo/add_amm_liq.future;

finalize add_amm_liq:
    input r0 as arcn_pool_v2_2_3.aleo/add_amm_liquidity.future;
    input r1 as arcn_pool_v2_2_3.aleo/transfer_lp_receipt_by_salt.future;
    await r0;
    await r1;

function remove_amm_liq_part:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as u128.private;
    input r5 as u128.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as boolean.public;
    input r9 as boolean.public;
    call arcn_pool_v2_2_3.aleo/remove_amm_liquidity_part self.signer r1 r2 r3 r4 r5 r6 r7 r8 r9 true into r10 r11 r12 r13 r14;
    call token_registry.aleo/transfer_private r0 r10.amount r10 into r15 r16 r17;
    call token_registry.aleo/transfer_private r0 r11.amount r11 into r18 r19 r20;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r12 r0 into r21;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r13 r0 into r22;
    call arcn_compliance_v1.aleo/report self.signer r0 r2 r3 r4 r5;
    cast self.signer r1 into r23 as DepositOwner;
    hash.bhp256 r23 into r24 as field;
    async remove_amm_liq_part r14 r24 r17 r20 into r25;
    output r16 as token_registry.aleo/Token.record;
    output r19 as token_registry.aleo/Token.record;
    output r21 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r22 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r25 as arcn_priv_v2_2_4.aleo/remove_amm_liq_part.future;

finalize remove_amm_liq_part:
    input r0 as arcn_pool_v2_2_3.aleo/remove_amm_liquidity_part.future;
    input r1 as field.public;
    input r2 as token_registry.aleo/transfer_private.future;
    input r3 as token_registry.aleo/transfer_private.future;
    await r0;
    get arcn_pool_v2_2_3.aleo/amm_deposits[r1] into r4;
    assert.eq r4.amount 0u128;
    await r2;
    await r3;
