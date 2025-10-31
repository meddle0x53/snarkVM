import arcn_access_manager_v1.aleo;
import credits.aleo;
import multi_token_support_program.aleo;
import arcn_pool_v2_1_1.aleo;

program arcn_pub_v2_1_1.aleo;

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
    input r1 as field.private;
    input r2 as u128.private;
    input r3 as boolean.private;
    input r4 as field.private;
    input r5 as u128.private;
    input r6 as boolean.private;
    input r7 as u16.private;
    input r8 as field.private;
    input r9 as u8.private;
    input r10 as u16.private;
    call multi_token_support_program.aleo/transfer_from_public_to_private r1 self.signer self.signer r2 r3 into r11 r12;
    call multi_token_support_program.aleo/transfer_from_public_to_private r4 self.signer self.signer r5 r6 into r13 r14;
    call arcn_pool_v2_1_1.aleo/create_pool self.caller r11 r2 r13 r5 r7 r8 r9 r10 into r15 r16 r17 r18 r19;
    call arcn_pool_v2_1_1.aleo/transfer_pool_ownership r15 r0 into r20;
    call arcn_pool_v2_1_1.aleo/transfer_lp_receipt r18 r0 into r21 r22;
    async create_pool r12 r14 r19 r22 into r23;
    output r20 as arcn_pool_v2_1_1.aleo/PoolAdmin.record;
    output r21 as arcn_pool_v2_1_1.aleo/LpTokenReceipt.record;
    output r23 as arcn_pub_v2_1_1.aleo/create_pool.future;

finalize create_pool:
    input r0 as multi_token_support_program.aleo/transfer_from_public_to_private.future;
    input r1 as multi_token_support_program.aleo/transfer_from_public_to_private.future;
    input r2 as arcn_pool_v2_1_1.aleo/create_pool.future;
    input r3 as arcn_pool_v2_1_1.aleo/transfer_lp_receipt.future;
    await r0;
    await r1;
    await r2;
    await r3;

function swap_amm:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as boolean.private;
    input r4 as u128.private;
    input r5 as field.private;
    input r6 as boolean.private;
    input r7 as u128.private;
    input r8 as field.private;
    call multi_token_support_program.aleo/transfer_from_public_to_private r2 self.signer self.signer r4 r3 into r9 r10;
    call arcn_pool_v2_1_1.aleo/swap_amm r0 self.signer r9 r9.amount r5 r7 r8 r6 into r11 r12 r13 r14;
    call multi_token_support_program.aleo/transfer_private_to_public r1 r12.amount r12 into r15 r16;
    call arcn_pool_v2_1_1.aleo/transfer_voucher r13 r1 into r17;
    async swap_amm r10 r14 r16 into r18;
    output r17 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r18 as arcn_pub_v2_1_1.aleo/swap_amm.future;

finalize swap_amm:
    input r0 as multi_token_support_program.aleo/transfer_from_public_to_private.future;
    input r1 as arcn_pool_v2_1_1.aleo/swap_amm.future;
    input r2 as multi_token_support_program.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;

function redeem_voucher:
    input r0 as address.private;
    input r1 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    input r2 as u128.private;
    input r3 as boolean.private;
    call arcn_pool_v2_1_1.aleo/redeem_voucher r1 r2 r3 into r4 r5;
    call multi_token_support_program.aleo/transfer_private_to_public r0 r4.amount r4 into r6 r7;
    async redeem_voucher r5 r7 into r8;
    output r8 as arcn_pub_v2_1_1.aleo/redeem_voucher.future;

finalize redeem_voucher:
    input r0 as arcn_pool_v2_1_1.aleo/redeem_voucher.future;
    input r1 as multi_token_support_program.aleo/transfer_private_to_public.future;
    await r0;
    await r1;

function swap_stable:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u128.private;
    input r4 as boolean.private;
    input r5 as field.private;
    input r6 as u128.private;
    input r7 as boolean.private;
    input r8 as u16.private;
    input r9 as field.private;
    call multi_token_support_program.aleo/transfer_from_public_to_private r2 self.signer self.signer r3 r4 into r10 r11;
    call arcn_pool_v2_1_1.aleo/swap_stable self.signer r0 r10 r5 r10.amount r6 r9 r8 r7 into r12 r13 r14 r15;
    call multi_token_support_program.aleo/transfer_private_to_public r1 r13.amount r13 into r16 r17;
    call arcn_pool_v2_1_1.aleo/transfer_voucher r14 r1 into r18;
    async swap_stable r11 r15 r17 into r19;
    output r18 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r19 as arcn_pub_v2_1_1.aleo/swap_stable.future;

finalize swap_stable:
    input r0 as multi_token_support_program.aleo/transfer_from_public_to_private.future;
    input r1 as arcn_pool_v2_1_1.aleo/swap_stable.future;
    input r2 as multi_token_support_program.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;

function add_amm_liq:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u128.private;
    input r4 as boolean.private;
    input r5 as field.private;
    input r6 as u128.private;
    input r7 as boolean.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as field.private;
    call multi_token_support_program.aleo/transfer_from_public_to_private r2 self.signer self.signer r3 r4 into r11 r12;
    call multi_token_support_program.aleo/transfer_from_public_to_private r5 self.signer self.signer r6 r7 into r13 r14;
    call arcn_pool_v2_1_1.aleo/add_amm_liquidity r0 self.signer r11 r3 r13 r6 r8 r9 r10 into r15 r16 r17 r18 r19 r20;
    call arcn_pool_v2_1_1.aleo/transfer_lp_receipt r17 r1 into r21 r22;
    async add_amm_liq r12 r14 r20 r22 into r23;
    output r21 as arcn_pool_v2_1_1.aleo/LpTokenReceipt.record;
    output r18 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r19 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r23 as arcn_pub_v2_1_1.aleo/add_amm_liq.future;

finalize add_amm_liq:
    input r0 as multi_token_support_program.aleo/transfer_from_public_to_private.future;
    input r1 as multi_token_support_program.aleo/transfer_from_public_to_private.future;
    input r2 as arcn_pool_v2_1_1.aleo/add_amm_liquidity.future;
    input r3 as arcn_pool_v2_1_1.aleo/transfer_lp_receipt.future;
    await r0;
    await r1;
    await r2;
    await r3;

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
    call arcn_pool_v2_1_1.aleo/remove_amm_liquidity_part self.signer r1 r2 r3 r4 r5 r6 r7 r8 r9 true into r10 r11 r12 r13 r14;
    call multi_token_support_program.aleo/transfer_private_to_public r0 r10.amount r10 into r15 r16;
    call multi_token_support_program.aleo/transfer_private_to_public r0 r11.amount r11 into r17 r18;
    call arcn_pool_v2_1_1.aleo/transfer_voucher r12 r0 into r19;
    call arcn_pool_v2_1_1.aleo/transfer_voucher r13 r0 into r20;
    async remove_amm_liq_part r14 r16 r18 into r21;
    output r19 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r20 as arcn_pool_v2_1_1.aleo/ExtraAmountVoucher.record;
    output r21 as arcn_pub_v2_1_1.aleo/remove_amm_liq_part.future;

finalize remove_amm_liq_part:
    input r0 as arcn_pool_v2_1_1.aleo/remove_amm_liquidity_part.future;
    input r1 as multi_token_support_program.aleo/transfer_private_to_public.future;
    input r2 as multi_token_support_program.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;
