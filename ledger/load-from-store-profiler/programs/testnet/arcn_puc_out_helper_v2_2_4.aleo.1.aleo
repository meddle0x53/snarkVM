import arcn_compliance_v1.aleo;
import arcn_access_manager_v1.aleo;
import arcn_whitelist_v2.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_3.aleo;
import wrapped_credits.aleo;

program arcn_puc_out_helper_v2_2_4.aleo;

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
    call credits.aleo/transfer_private_to_public r7 r0 r7.microcredits into r9 r10;
    call arcn_compliance_v1.aleo/report_voucher r1.owner r0 r1.token_id r2;
    async redeem_voucher r4 r8 r10 into r11;
    output r11 as arcn_puc_out_helper_v2_2_4.aleo/redeem_voucher.future;

finalize redeem_voucher:
    input r0 as arcn_pool_v2_2_3.aleo/redeem_voucher.future;
    input r1 as wrapped_credits.aleo/withdraw_credits_private.future;
    input r2 as credits.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;

function create_pool_credits_is_token2:
    input r0 as address.public;
    input r1 as field.private;
    input r2 as u128.public;
    input r3 as boolean.public;
    input r4 as u128.public;
    input r5 as u16.public;
    input r6 as field.public;
    input r7 as u8.public;
    input r8 as u16.public;
    call token_registry.aleo/transfer_from_public_to_private r1 self.signer self.signer r2 r3 into r9 r10;
    cast r4 into r11 as u64;
    call wrapped_credits.aleo/deposit_credits_public_signer r11 into r12;
    call token_registry.aleo/transfer_from_public_to_private 3443843282313283355522573239085696902919850365217539366784739393210722344986field self.signer self.signer r4 false into r13 r14;
    call arcn_pool_v2_2_3.aleo/create_pool r0 r9 r2 r13 r4 r5 r6 0u8 0u16 into r15 r16 r17 r18 r19;
    call arcn_compliance_v1.aleo/report self.signer r0 r9.token_id r13.token_id r2 r4;
    async create_pool_credits_is_token2 r10 r12 r14 r19 into r20;
    output r15 as arcn_pool_v2_2_3.aleo/PoolAdmin.record;
    output r18 as arcn_pool_v2_2_3.aleo/LpTokenReceipt.record;
    output r20 as arcn_puc_out_helper_v2_2_4.aleo/create_pool_credits_is_token2.future;

finalize create_pool_credits_is_token2:
    input r0 as token_registry.aleo/transfer_from_public_to_private.future;
    input r1 as wrapped_credits.aleo/deposit_credits_public_signer.future;
    input r2 as token_registry.aleo/transfer_from_public_to_private.future;
    input r3 as arcn_pool_v2_2_3.aleo/create_pool.future;
    await r0;
    await r1;
    await r2;
    await r3;

function swap_amm_credits_out:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.private;
    input r3 as boolean.public;
    input r4 as u128.public;
    input r5 as u128.public;
    input r6 as field.public;
    call token_registry.aleo/transfer_from_public_to_private r2 self.signer self.signer r4 r3 into r7 r8;
    call arcn_pool_v2_2_3.aleo/swap_amm r0 self.signer r7 r4 3443843282313283355522573239085696902919850365217539366784739393210722344986field r5 r6 false into r9 r10 r11 r12;
    cast r10.amount into r13 as u64;
    call wrapped_credits.aleo/withdraw_credits_private r10 r13 into r14 r15 r16;
    call credits.aleo/transfer_private_to_public r15 r1 r15.microcredits into r17 r18;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r11 r1 into r19;
    call arcn_compliance_v1.aleo/report self.signer r1 r7.token_id 3443843282313283355522573239085696902919850365217539366784739393210722344986field r4 r5;
    async swap_amm_credits_out r8 r12 r16 r18 into r20;
    output r19 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r20 as arcn_puc_out_helper_v2_2_4.aleo/swap_amm_credits_out.future;

finalize swap_amm_credits_out:
    input r0 as token_registry.aleo/transfer_from_public_to_private.future;
    input r1 as arcn_pool_v2_2_3.aleo/swap_amm.future;
    input r2 as wrapped_credits.aleo/withdraw_credits_private.future;
    input r3 as credits.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;
    await r3;

function add_amm_liq_credits_is_token2:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.private;
    input r3 as u128.public;
    input r4 as boolean.public;
    input r5 as u128.public;
    input r6 as field.public;
    input r7 as field.public;
    input r8 as field.public;
    call token_registry.aleo/transfer_from_public_to_private r2 self.signer self.signer r3 r4 into r9 r10;
    cast r5 into r11 as u64;
    call wrapped_credits.aleo/deposit_credits_public_signer r11 into r12;
    call token_registry.aleo/transfer_from_public_to_private 3443843282313283355522573239085696902919850365217539366784739393210722344986field self.signer self.signer r5 false into r13 r14;
    call arcn_pool_v2_2_3.aleo/add_amm_liquidity r0 self.signer r9 r3 r13 r5 r6 r7 r8 into r15 r16 r17 r18 r19 r20;
    call arcn_pool_v2_2_3.aleo/transfer_lp_receipt_by_salt r17.deposit_salt r17.pool_id r17.token1_id r17.token2_id r1 r17.deposit_salt true into r21 r22;
    call arcn_compliance_v1.aleo/report self.signer r1 r9.token_id 3443843282313283355522573239085696902919850365217539366784739393210722344986field r3 r5;
    async add_amm_liq_credits_is_token2 r10 r12 r14 r20 r22 into r23;
    output r21 as arcn_pool_v2_2_3.aleo/LpTokenReceipt.record;
    output r18 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r19 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r23 as arcn_puc_out_helper_v2_2_4.aleo/add_amm_liq_credits_is_token2.future;

finalize add_amm_liq_credits_is_token2:
    input r0 as token_registry.aleo/transfer_from_public_to_private.future;
    input r1 as wrapped_credits.aleo/deposit_credits_public_signer.future;
    input r2 as token_registry.aleo/transfer_from_public_to_private.future;
    input r3 as arcn_pool_v2_2_3.aleo/add_amm_liquidity.future;
    input r4 as arcn_pool_v2_2_3.aleo/transfer_lp_receipt_by_salt.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;

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
    call token_registry.aleo/transfer_private_to_public r0 r8.amount r8 into r13 r14;
    cast r9.amount into r15 as u64;
    call wrapped_credits.aleo/withdraw_credits_private r9 r15 into r16 r17 r18;
    call credits.aleo/transfer_private_to_public r17 r0 r17.microcredits into r19 r20;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r10 r0 into r21;
    call arcn_pool_v2_2_3.aleo/transfer_voucher r11 r0 into r22;
    call arcn_compliance_v1.aleo/report self.signer r0 r2 3443843282313283355522573239085696902919850365217539366784739393210722344986field r3 r4;
    cast self.signer r1 into r23 as DepositOwner;
    hash.bhp256 r23 into r24 as field;
    async remove_liq_credits_is_token2 r12 r24 r14 r18 r20 into r25;
    output r21 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r22 as arcn_pool_v2_2_3.aleo/ExtraAmountVoucher.record;
    output r25 as arcn_puc_out_helper_v2_2_4.aleo/remove_liq_credits_is_token2.future;

finalize remove_liq_credits_is_token2:
    input r0 as arcn_pool_v2_2_3.aleo/remove_amm_liquidity_part.future;
    input r1 as field.public;
    input r2 as token_registry.aleo/transfer_private_to_public.future;
    input r3 as wrapped_credits.aleo/withdraw_credits_private.future;
    input r4 as credits.aleo/transfer_private_to_public.future;
    await r0;
    get arcn_pool_v2_2_3.aleo/amm_deposits[r1] into r5;
    assert.eq r5.amount 0u128;
    await r2;
    await r3;
    await r4;
