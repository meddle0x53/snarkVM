import arcn_access_manager_v1.aleo;
import arcn_whitelist.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_2.aleo;
import wrapped_credits.aleo;

program arcn_puc_in_helper_swap_v2_2_5.aleo;

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
    output r4 as arcn_puc_in_helper_swap_v2_2_5.aleo/withdraw_protocol_fee.future;

finalize withdraw_protocol_fee:
    input r0 as arcn_access_manager_v1.aleo/check_access_public.future;
    input r1 as credits.aleo/transfer_public.future;
    await r0;
    await r1;

function swap_amm_credits_in:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as field.public;
    input r4 as boolean.public;
    input r5 as u128.public;
    input r6 as field.public;
    input r7 as u64.public;
    cast r2 into r8 as u64;
    add r8 r7 into r9;
    call credits.aleo/transfer_public_as_signer arcn_puc_in_helper_swap_v2_2_5.aleo r9 into r10;
    call credits.aleo/transfer_public_to_private self.signer r8 into r11 r12;
    call wrapped_credits.aleo/deposit_credits_private r11 r8 into r13 r14 r15;
    call arcn_pool_v2_2_2.aleo/swap_amm r0 self.signer r14 r14.amount r3 r5 r6 r4 into r16 r17 r18 r19;
    call token_registry.aleo/transfer_private_to_public r1 r17.amount r17 into r20 r21;
    call arcn_pool_v2_2_2.aleo/transfer_voucher r18 r1 into r22;
    async swap_amm_credits_in r10 r12 r15 r19 r21 into r23;
    output r22 as arcn_pool_v2_2_2.aleo/ExtraAmountVoucher.record;
    output r23 as arcn_puc_in_helper_swap_v2_2_5.aleo/swap_amm_credits_in.future;

finalize swap_amm_credits_in:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/transfer_public_to_private.future;
    input r2 as wrapped_credits.aleo/deposit_credits_private.future;
    input r3 as arcn_pool_v2_2_2.aleo/swap_amm.future;
    input r4 as token_registry.aleo/transfer_private_to_public.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
