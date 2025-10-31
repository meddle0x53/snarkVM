import arcn_access_manager_v1.aleo;
import arcn_whitelist.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_2.aleo;
import arcn_pool_v2_2_4.aleo;
import arcn_compliance_v1.aleo;
import arcn_priv_v2_2_3.aleo;
import arcn_priv_v2_2_6.aleo;

program arcn_liq_helper_v1_0_1.aleo;

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

function transfer_amm_liq:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as field.private;
    input r5 as u128.private;
    input r6 as u128.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as field.private;
    input r11 as boolean.public;
    input r12 as boolean.public;
    call arcn_priv_v2_2_3.aleo/remove_amm_liq_part self.signer r1 r3 r4 r5 r6 r7 r8 r11 r12 into r13 r14 r15 r16 r17;
    call arcn_priv_v2_2_6.aleo/add_amm_liq r0 self.signer r13 r5 r14 r6 r2 r9 r10 into r18 r19 r20 r21 r22 r23;
    async transfer_amm_liq r17 r23 into r24;
    output r18 as token_registry.aleo/Token.record;
    output r19 as token_registry.aleo/Token.record;
    output r15 as arcn_pool_v2_2_2.aleo/ExtraAmountVoucher.record;
    output r16 as arcn_pool_v2_2_2.aleo/ExtraAmountVoucher.record;
    output r20 as arcn_pool_v2_2_4.aleo/LpTokenReceipt.record;
    output r21 as arcn_pool_v2_2_4.aleo/ExtraAmountVoucher.record;
    output r22 as arcn_pool_v2_2_4.aleo/ExtraAmountVoucher.record;
    output r24 as arcn_liq_helper_v1_0_1.aleo/transfer_amm_liq.future;

finalize transfer_amm_liq:
    input r0 as arcn_priv_v2_2_3.aleo/remove_amm_liq_part.future;
    input r1 as arcn_priv_v2_2_6.aleo/add_amm_liq.future;
    await r0;
    await r1;
