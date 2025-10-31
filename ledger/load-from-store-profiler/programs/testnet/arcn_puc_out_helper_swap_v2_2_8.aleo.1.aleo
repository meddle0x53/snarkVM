import arcn_access_manager_v1.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_4.aleo;
import wrapped_credits.aleo;

program arcn_puc_out_helper_swap_v2_2_8.aleo;

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

function withdraw_protocol_fee:
    input r0 as address.private;
    input r1 as u64.private;
    call arcn_access_manager_v1.aleo/check_access_public self.caller into r2;
    call credits.aleo/transfer_public r0 r1 into r3;
    async withdraw_protocol_fee r2 r3 into r4;
    output r4 as arcn_puc_out_helper_swap_v2_2_8.aleo/withdraw_protocol_fee.future;

finalize withdraw_protocol_fee:
    input r0 as arcn_access_manager_v1.aleo/check_access_public.future;
    input r1 as credits.aleo/transfer_public.future;
    await r0;
    await r1;

function swap_amm_credits_out:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.private;
    input r3 as boolean.public;
    input r4 as u128.public;
    input r5 as u128.public;
    input r6 as field.public;
    input r7 as u64.public;
    call token_registry.aleo/transfer_from_public_to_private r2 self.signer self.signer r4 r3 into r8 r9;
    call arcn_pool_v2_2_4.aleo/swap_amm r0 self.signer r8 r4 3443843282313283355522573239085696902919850365217539366784739393210722344986field r5 r6 false into r10 r11 r12 r13;
    cast r11.amount into r14 as u64;
    call wrapped_credits.aleo/withdraw_credits_private r11 r14 into r15 r16 r17;
    call credits.aleo/transfer_private_to_public r16 r1 r16.microcredits into r18 r19;
    call arcn_pool_v2_2_4.aleo/transfer_voucher r12 r1 into r20;
    call credits.aleo/transfer_public_as_signer arcn_puc_out_helper_swap_v2_2_8.aleo r7 into r21;
    async swap_amm_credits_out r9 r13 r17 r19 r21 into r22;
    output r20 as arcn_pool_v2_2_4.aleo/ExtraAmountVoucher.record;
    output r22 as arcn_puc_out_helper_swap_v2_2_8.aleo/swap_amm_credits_out.future;

finalize swap_amm_credits_out:
    input r0 as token_registry.aleo/transfer_from_public_to_private.future;
    input r1 as arcn_pool_v2_2_4.aleo/swap_amm.future;
    input r2 as wrapped_credits.aleo/withdraw_credits_private.future;
    input r3 as credits.aleo/transfer_private_to_public.future;
    input r4 as credits.aleo/transfer_public_as_signer.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
