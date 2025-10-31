import arcn_access_manager_v1.aleo;
import credits.aleo;
import multi_token_support_program.aleo;
import arcn_pool_v2_1_1.aleo;

program arcn_credits_helper_v2_1_1.aleo;

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

struct ProtocolFeeConfig:
    rate as u16;
    foundation as address;

function create_pool:
    input r0 as address.private;
    input r1 as multi_token_support_program.aleo/Token.record;
    input r2 as u128.private;
    input r3 as boolean.private;
    input r4 as credits.aleo/credits.record;
    input r5 as u128.private;
    input r6 as u16.private;
    input r7 as field.private;
    input r8 as u8.private;
    input r9 as u16.private;
    cast r5 into r10 as u64;
    call multi_token_support_program.aleo/deposit_credits_private r4 r10 into r11 r12 r13;
    call arcn_pool_v2_1_1.aleo/create_pool r0 r1 r2 r12 r5 r6 r7 r8 r9 into r14 r15 r16 r17 r18;
    async create_pool r13 r18 into r19;
    output r15 as multi_token_support_program.aleo/Token.record;
    output r11 as credits.aleo/credits.record;
    output r14 as arcn_pool_v2_1_1.aleo/PoolAdmin.record;
    output r17 as arcn_pool_v2_1_1.aleo/LpTokenReceipt.record;
    output r19 as arcn_credits_helper_v2_1_1.aleo/create_pool.future;

finalize create_pool:
    input r0 as multi_token_support_program.aleo/deposit_credits_private.future;
    input r1 as arcn_pool_v2_1_1.aleo/create_pool.future;
    await r0;
    await r1;

function redeem_voucher:
    input r0 as address.private;
    input r1 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    input r2 as u128.private;
    call arcn_pool_v2_1_1.aleo/redeem_voucher r1 r2 false into r3 r4;
    cast r3.amount into r5 as u64;
    call multi_token_support_program.aleo/withdraw_credits_private r3 r5 into r6 r7 r8;
    call credits.aleo/transfer_private r7 r0 r7.microcredits into r9 r10;
    async redeem_voucher r4 r8 into r11;
    output r9 as credits.aleo/credits.record;
    output r11 as arcn_credits_helper_v2_1_1.aleo/redeem_voucher.future;

finalize redeem_voucher:
    input r0 as arcn_pool_v2_1_1.aleo/redeem_voucher.future;
    input r1 as multi_token_support_program.aleo/withdraw_credits_private.future;
    await r0;
    await r1;

function swap_amm_credits_in:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as credits.aleo/credits.record;
    input r3 as u128.private;
    input r4 as field.private;
    input r5 as boolean.private;
    input r6 as u128.private;
    input r7 as field.private;
    cast r3 into r8 as u64;
    call multi_token_support_program.aleo/deposit_credits_private r2 r8 into r9 r10 r11;
    call arcn_pool_v2_1_1.aleo/swap_amm r0 r1 r10 r10.amount r4 r6 r7 r5 into r12 r13 r14 r15;
    async swap_amm_credits_in r11 r15 into r16;
    output r9 as credits.aleo/credits.record;
    output r13 as multi_token_support_program.aleo/Token.record;
    output r14 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r16 as arcn_credits_helper_v2_1_1.aleo/swap_amm_credits_in.future;

finalize swap_amm_credits_in:
    input r0 as multi_token_support_program.aleo/deposit_credits_private.future;
    input r1 as arcn_pool_v2_1_1.aleo/swap_amm.future;
    await r0;
    await r1;

function swap_amm_credits_out:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as multi_token_support_program.aleo/Token.record;
    input r3 as u128.private;
    input r4 as u128.private;
    input r5 as field.private;
    call arcn_pool_v2_1_1.aleo/swap_amm r0 self.signer r2 r2.amount 3443843282313283355522573239085696902919850365217539366784739393210722344986field r4 r5 false into r6 r7 r8 r9;
    cast r7.amount into r10 as u64;
    call multi_token_support_program.aleo/withdraw_credits_private r7 r10 into r11 r12 r13;
    call credits.aleo/transfer_private r12 r1 r12.microcredits into r14 r15;
    call arcn_pool_v2_1_1.aleo/transfer_voucher r8 r1 into r16;
    async swap_amm_credits_out r9 r13 into r17;
    output r6 as multi_token_support_program.aleo/Token.record;
    output r15 as credits.aleo/credits.record;
    output r16 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r17 as arcn_credits_helper_v2_1_1.aleo/swap_amm_credits_out.future;

finalize swap_amm_credits_out:
    input r0 as arcn_pool_v2_1_1.aleo/swap_amm.future;
    input r1 as multi_token_support_program.aleo/withdraw_credits_private.future;
    await r0;
    await r1;

function add_amm_liq:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as multi_token_support_program.aleo/Token.record;
    input r3 as u128.private;
    input r4 as boolean.private;
    input r5 as credits.aleo/credits.record;
    input r6 as u128.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    cast r6 into r10 as u64;
    call multi_token_support_program.aleo/deposit_credits_private r5 r10 into r11 r12 r13;
    call arcn_pool_v2_1_1.aleo/add_amm_liquidity r0 self.signer r2 r3 r12 r6 r7 r8 r9 into r14 r15 r16 r17 r18 r19;
    call arcn_pool_v2_1_1.aleo/transfer_lp_receipt r16 r1 into r20 r21;
    async add_amm_liq r13 r19 r21 into r22;
    output r14 as multi_token_support_program.aleo/Token.record;
    output r11 as credits.aleo/credits.record;
    output r20 as arcn_pool_v2_1_1.aleo/LpTokenReceipt.record;
    output r17 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r18 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r22 as arcn_credits_helper_v2_1_1.aleo/add_amm_liq.future;

finalize add_amm_liq:
    input r0 as multi_token_support_program.aleo/deposit_credits_private.future;
    input r1 as arcn_pool_v2_1_1.aleo/add_amm_liquidity.future;
    input r2 as arcn_pool_v2_1_1.aleo/transfer_lp_receipt.future;
    await r0;
    await r1;
    await r2;

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
    call arcn_pool_v2_1_1.aleo/remove_amm_liquidity_part self.signer r1 r2 r3 r4 r5 r6 r7 r8 false true into r9 r10 r11 r12 r13;
    call multi_token_support_program.aleo/transfer_private r0 r9.amount r9 into r14 r15 r16;
    cast r10.amount into r17 as u64;
    call multi_token_support_program.aleo/withdraw_credits_private r10 r17 into r18 r19 r20;
    call credits.aleo/transfer_private r19 r0 r19.microcredits into r21 r22;
    call arcn_pool_v2_1_1.aleo/transfer_voucher r11 r0 into r23;
    call arcn_pool_v2_1_1.aleo/transfer_voucher r12 r0 into r24;
    async remove_amm_liq_part r13 r16 r20 into r25;
    output r15 as multi_token_support_program.aleo/Token.record;
    output r22 as credits.aleo/credits.record;
    output r23 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r24 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r25 as arcn_credits_helper_v2_1_1.aleo/remove_amm_liq_part.future;

finalize remove_amm_liq_part:
    input r0 as arcn_pool_v2_1_1.aleo/remove_amm_liquidity_part.future;
    input r1 as multi_token_support_program.aleo/transfer_private.future;
    input r2 as multi_token_support_program.aleo/withdraw_credits_private.future;
    await r0;
    await r1;
    await r2;
