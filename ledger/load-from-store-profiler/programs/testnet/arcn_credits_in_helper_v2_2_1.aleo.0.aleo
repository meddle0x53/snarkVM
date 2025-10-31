import arcn_compliance_v1.aleo;
import arcn_access_manager_v1.aleo;
import arcn_whitelist.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_1.aleo;
import wrapped_credits.aleo;

program arcn_credits_in_helper_v2_2_1.aleo;

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

function create_pool_credits_is_token1:
    input r0 as address.public;
    input r1 as credits.aleo/credits.record;
    input r2 as u128.public;
    input r3 as token_registry.aleo/Token.record;
    input r4 as u128.public;
    input r5 as boolean.public;
    input r6 as u16.public;
    input r7 as field.public;
    input r8 as u8.public;
    input r9 as u16.public;
    cast r2 into r10 as u64;
    call wrapped_credits.aleo/deposit_credits_private r1 r10 into r11 r12 r13;
    call arcn_pool_v2_2_1.aleo/create_pool r0 r12 r2 r3 r4 r6 r7 r8 r9 into r14 r15 r16 r17 r18;
    call arcn_compliance_v1.aleo/report r1.owner r0 3443843282313283355522573239085696902919850365217539366784739393210722344986field r3.token_id r2 r4;
    async create_pool_credits_is_token1 r13 r18 into r19;
    output r11 as credits.aleo/credits.record;
    output r16 as token_registry.aleo/Token.record;
    output r14 as arcn_pool_v2_2_1.aleo/PoolAdmin.record;
    output r17 as arcn_pool_v2_2_1.aleo/LpTokenReceipt.record;
    output r19 as arcn_credits_in_helper_v2_2_1.aleo/create_pool_credits_is_token1.future;

finalize create_pool_credits_is_token1:
    input r0 as wrapped_credits.aleo/deposit_credits_private.future;
    input r1 as arcn_pool_v2_2_1.aleo/create_pool.future;
    await r0;
    await r1;

function swap_amm_credits_in:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as credits.aleo/credits.record;
    input r3 as u128.public;
    input r4 as field.public;
    input r5 as boolean.public;
    input r6 as u128.public;
    input r7 as field.public;
    cast r3 into r8 as u64;
    call wrapped_credits.aleo/deposit_credits_private r2 r8 into r9 r10 r11;
    call arcn_pool_v2_2_1.aleo/swap_amm r0 r1 r10 r10.amount r4 r6 r7 r5 into r12 r13 r14 r15;
    call arcn_compliance_v1.aleo/report r2.owner r1 r10.token_id r4 r10.amount r6;
    async swap_amm_credits_in r11 r15 into r16;
    output r9 as credits.aleo/credits.record;
    output r12 as token_registry.aleo/Token.record;
    output r14 as arcn_pool_v2_2_1.aleo/ExtraAmountVoucher.record;
    output r16 as arcn_credits_in_helper_v2_2_1.aleo/swap_amm_credits_in.future;

finalize swap_amm_credits_in:
    input r0 as wrapped_credits.aleo/deposit_credits_private.future;
    input r1 as arcn_pool_v2_2_1.aleo/swap_amm.future;
    await r0;
    await r1;

function add_amm_liq_credits_is_token1:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as credits.aleo/credits.record;
    input r3 as u128.public;
    input r4 as token_registry.aleo/Token.record;
    input r5 as u128.public;
    input r6 as boolean.public;
    input r7 as field.public;
    input r8 as field.public;
    input r9 as field.public;
    cast r3 into r10 as u64;
    call wrapped_credits.aleo/deposit_credits_private r2 r10 into r11 r12 r13;
    call arcn_pool_v2_2_1.aleo/add_amm_liquidity r0 self.signer r12 r3 r4 r5 r7 r8 r9 into r14 r15 r16 r17 r18 r19;
    call arcn_pool_v2_2_1.aleo/transfer_lp_receipt_by_salt r16.deposit_salt r16.pool_id r16.token1_id r16.token2_id r1 r16.deposit_salt true into r20 r21;
    call arcn_compliance_v1.aleo/report r2.owner r1 3443843282313283355522573239085696902919850365217539366784739393210722344986field r4.token_id r3 r5;
    async add_amm_liq_credits_is_token1 r13 r19 r21 into r22;
    output r11 as credits.aleo/credits.record;
    output r15 as token_registry.aleo/Token.record;
    output r20 as arcn_pool_v2_2_1.aleo/LpTokenReceipt.record;
    output r17 as arcn_pool_v2_2_1.aleo/ExtraAmountVoucher.record;
    output r18 as arcn_pool_v2_2_1.aleo/ExtraAmountVoucher.record;
    output r22 as arcn_credits_in_helper_v2_2_1.aleo/add_amm_liq_credits_is_token1.future;

finalize add_amm_liq_credits_is_token1:
    input r0 as wrapped_credits.aleo/deposit_credits_private.future;
    input r1 as arcn_pool_v2_2_1.aleo/add_amm_liquidity.future;
    input r2 as arcn_pool_v2_2_1.aleo/transfer_lp_receipt_by_salt.future;
    await r0;
    await r1;
    await r2;

function remove_liq_credits_is_token1:
    input r0 as address.public;
    input r1 as field.private;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u128.public;
    input r5 as field.public;
    input r6 as field.public;
    input r7 as boolean.public;
    call arcn_pool_v2_2_1.aleo/remove_amm_liquidity_part self.signer r1 3443843282313283355522573239085696902919850365217539366784739393210722344986field r2 r3 r4 r5 r6 false r7 true into r8 r9 r10 r11 r12;
    cast r8.amount into r13 as u64;
    call wrapped_credits.aleo/withdraw_credits_private r8 r13 into r14 r15 r16;
    call credits.aleo/transfer_private r15 r0 r15.microcredits into r17 r18;
    call token_registry.aleo/transfer_private r0 r9.amount r9 into r19 r20 r21;
    call arcn_pool_v2_2_1.aleo/transfer_voucher r10 r0 into r22;
    call arcn_pool_v2_2_1.aleo/transfer_voucher r11 r0 into r23;
    call arcn_compliance_v1.aleo/report self.signer r0 3443843282313283355522573239085696902919850365217539366784739393210722344986field r2 r3 r4;
    async remove_liq_credits_is_token1 r12 r16 r21 into r24;
    output r17 as credits.aleo/credits.record;
    output r20 as token_registry.aleo/Token.record;
    output r22 as arcn_pool_v2_2_1.aleo/ExtraAmountVoucher.record;
    output r23 as arcn_pool_v2_2_1.aleo/ExtraAmountVoucher.record;
    output r24 as arcn_credits_in_helper_v2_2_1.aleo/remove_liq_credits_is_token1.future;

finalize remove_liq_credits_is_token1:
    input r0 as arcn_pool_v2_2_1.aleo/remove_amm_liquidity_part.future;
    input r1 as wrapped_credits.aleo/withdraw_credits_private.future;
    input r2 as token_registry.aleo/transfer_private.future;
    await r0;
    await r1;
    await r2;
