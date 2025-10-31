import arcn_compliance_v1.aleo;
import arcn_access_manager_v1.aleo;
import arcn_whitelist_v2.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_3.aleo;
import wrapped_credits.aleo;

program arcn_credits_out_helper_v2_2_4.aleo;

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

function redeem_voucher:
    input r0 as address.public;
    input r1 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    input r2 as u128.public;
    call arcn_pool_v2_2_3.aleo/redeem_voucher r1 r2 false into r3 r4;
    cast r3.amount into r5 as u64;
    call wrapped_credits.aleo/withdraw_credits_private r3 r5 into r6 r7 r8;
    call credits.aleo/transfer_private r7 r0 r7.microcredits into r9 r10;
    call arcn_compliance_v1.aleo/report_voucher r1.owner r0 r1.token_id r2;
    async redeem_voucher r4 r8 into r11;
    output r9 as credits.aleo/credits.record;
    output r11 as arcn_credits_out_helper_v2_2_4.aleo/redeem_voucher.future;

finalize redeem_voucher:
    input r0 as arcn_pool_v2_2_3.aleo/redeem_voucher.future;
    input r1 as wrapped_credits.aleo/withdraw_credits_private.future;
    await r0;
    await r1;

function create_pool_credits_is_token2:
    input r0 as address.public;
    input r1 as token_registry.aleo/Token.record;
    input r2 as u128.public;
    input r3 as boolean.public;
    input r4 as credits.aleo/credits.record;
    input r5 as u128.public;
    input r6 as u16.public;
    input r7 as field.public;
    input r8 as u8.public;
    input r9 as u16.public;
    cast r5 into r10 as u64;
    call wrapped_credits.aleo/deposit_credits_private r4 r10 into r11 r12 r13;
    call arcn_pool_v2_2_3.aleo/create_pool r0 r1 r2 r12 r5 r6 r7 0u8 0u16 into r14 r15 r16 r17 r18;
    call arcn_compliance_v1.aleo/report r4.owner r0 r1.token_id r12.token_id r2 r5;
    async create_pool_credits_is_token2 r13 r18 into r19;
    output r15 as token_registry.aleo/Token.record;
    output r11 as credits.aleo/credits.record;
    output r14 as arcn_pool_v2_2_3.aleo/PoolAdmin.record;
    output r17 as arcn_pool_v2_2_3.aleo/LpTokenReceipt.record;
    output r19 as arcn_credits_out_helper_v2_2_4.aleo/create_pool_credits_is_token2.future;

finalize create_pool_credits_is_token2:
    input r0 as wrapped_credits.aleo/deposit_credits_private.future;
    input r1 as arcn_pool_v2_2_3.aleo/create_pool.future;
    await r0;
    await r1;

function swap_amm_credits_out:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as token_registry.aleo/Token.record;
    input r3 as u128.public;
    input r4 as u128.public;
    input r5 as field.public;
    call arcn_pool_v2_2_3.aleo/swap_amm r0 self.signer r2 r3 3443843282313283355522573239085696902919850365217539366784739393210722344986field r4 r5 false into r6 r7 r8 r9;
    cast r7.amount into r10 as u64;
    call wrapped_credits.aleo/withdraw_credits_private r7 r10 into r11 r12 r13;
    call credits.aleo/transfer_private r12 r1 r12.microcredits into r14 r15;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r8 r1 into r16;
    call arcn_compliance_v1.aleo/report r2.owner r1 r2.token_id 3443843282313283355522573239085696902919850365217539366784739393210722344986field r3 r4;
    async swap_amm_credits_out r9 r13 into r17;
    output r6 as token_registry.aleo/Token.record;
    output r14 as credits.aleo/credits.record;
    output r16 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r17 as arcn_credits_out_helper_v2_2_4.aleo/swap_amm_credits_out.future;

finalize swap_amm_credits_out:
    input r0 as arcn_pool_v2_2_3.aleo/swap_amm.future;
    input r1 as wrapped_credits.aleo/withdraw_credits_private.future;
    await r0;
    await r1;

function add_amm_liq_credits_is_token2:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as token_registry.aleo/Token.record;
    input r3 as u128.public;
    input r4 as boolean.public;
    input r5 as credits.aleo/credits.record;
    input r6 as u128.public;
    input r7 as field.public;
    input r8 as field.public;
    input r9 as field.public;
    cast r6 into r10 as u64;
    call wrapped_credits.aleo/deposit_credits_private r5 r10 into r11 r12 r13;
    call arcn_pool_v2_2_3.aleo/add_amm_liquidity r0 self.signer r2 r3 r12 r6 r7 r8 r9 into r14 r15 r16 r17 r18 r19;
    call arcn_pool_v2_2_3.aleo/transfer_lp_receipt_by_salt r16.deposit_salt r16.pool_id r16.token1_id r16.token2_id r1 r16.deposit_salt true into r20 r21;
    call arcn_compliance_v1.aleo/report r5.owner r1 r2.token_id 3443843282313283355522573239085696902919850365217539366784739393210722344986field r3 r6;
    async add_amm_liq_credits_is_token2 r13 r19 r21 into r22;
    output r14 as token_registry.aleo/Token.record;
    output r11 as credits.aleo/credits.record;
    output r20 as arcn_pool_v2_2_3.aleo/LpTokenReceipt.record;
    output r17 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r18 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r22 as arcn_credits_out_helper_v2_2_4.aleo/add_amm_liq_credits_is_token2.future;

finalize add_amm_liq_credits_is_token2:
    input r0 as wrapped_credits.aleo/deposit_credits_private.future;
    input r1 as arcn_pool_v2_2_3.aleo/add_amm_liquidity.future;
    input r2 as arcn_pool_v2_2_3.aleo/transfer_lp_receipt_by_salt.future;
    await r0;
    await r1;
    await r2;

function remove_liq_credits_is_token2:
    input r0 as address.public;
    input r1 as field.private;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u128.public;
    input r5 as field.public;
    input r6 as field.public;
    input r7 as boolean.public;
    call arcn_pool_v2_2_3.aleo/remove_amm_liquidity_part self.signer r1 r2 3443843282313283355522573239085696902919850365217539366784739393210722344986field r3 r4 r5 r6 r7 false true into r8 r9 r10 r11 r12;
    call token_registry.aleo/transfer_private r0 r8.amount r8 into r13 r14 r15;
    cast r9.amount into r16 as u64;
    call wrapped_credits.aleo/withdraw_credits_private r9 r16 into r17 r18 r19;
    call credits.aleo/transfer_private r18 r0 r18.microcredits into r20 r21;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r10 r0 into r22;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r11 r0 into r23;
    call arcn_compliance_v1.aleo/report self.signer r0 r2 3443843282313283355522573239085696902919850365217539366784739393210722344986field r3 r4;
    cast self.signer r1 into r24 as DepositOwner;
    hash.bhp256 r24 into r25 as field;
    async remove_liq_credits_is_token2 r12 r25 r15 r19 into r26;
    output r14 as token_registry.aleo/Token.record;
    output r20 as credits.aleo/credits.record;
    output r22 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r23 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r26 as arcn_credits_out_helper_v2_2_4.aleo/remove_liq_credits_is_token2.future;

finalize remove_liq_credits_is_token2:
    input r0 as arcn_pool_v2_2_3.aleo/remove_amm_liquidity_part.future;
    input r1 as field.public;
    input r2 as token_registry.aleo/transfer_private.future;
    input r3 as wrapped_credits.aleo/withdraw_credits_private.future;
    await r0;
    get arcn_pool_v2_2_3.aleo/amm_deposits[r1] into r4;
    assert.eq r4.amount 0u128;
    await r2;
    await r3;
