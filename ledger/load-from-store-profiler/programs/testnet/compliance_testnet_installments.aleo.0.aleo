import credits.aleo;
import token_registry.aleo;

program compliance_testnet_installments.aleo;

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

record SpendLimit:
    owner as address.private;
    amount_spent as u128.private;
    epoch_spent as u32.private;

record Installment:
    owner as address.private;
    amount_to_pay as u128.private;
    months as u8.private;

mapping has_minted:
    key as u8.public;
    value as boolean.public;

mapping has_spend_limit:
    key as field.public;
    value as boolean.public;

function transfer_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as SpendLimit.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    lt r1.epoch_spent r4 into r5;
    add r2 r1.amount_spent into r6;
    ternary r5 r2 r6 into r7;
    lte r7 10000000000u128 into r8;
    assert.eq r8 true;
    cast r1.owner r7 r4 into r9 as SpendLimit.record;
    call token_registry.aleo/prehook_private r0 r2 4294967295u32 into r10 r11 r12;
    call token_registry.aleo/transfer_private r3 r2 r11 into r13 r14 r15;
    async transfer_private r12 r15 r4 into r16;
    output r9 as SpendLimit.record;
    output r10 as token_registry.aleo/Token.record;
    output r13 as token_registry.aleo/Token.record;
    output r14 as token_registry.aleo/Token.record;
    output r16 as compliance_testnet_installments.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as u32.public;
    await r0;
    await r1;
    rem block.height 28800u32 into r3;
    assert.eq r2 r3;

function initialize:
    assert.eq self.caller aleo1lyx5gt9mgn38tueqm03fgjx8tvzqcg4s6a4tfs4uw8xxlncrrg9swxl7rh;
    call token_registry.aleo/register_token 7161906355395312783612863field 7161906355395312783612863u128 7161906355395312783612863u128 6u8 10000000000000000u128 true compliance_testnet_installments.aleo into r0;
    async initialize r0 into r1;
    output r1 as compliance_testnet_installments.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo1lyx5gt9mgn38tueqm03fgjx8tvzqcg4s6a4tfs4uw8xxlncrrg9swxl7rh;
    call token_registry.aleo/mint_private 7161906355395312783612863field aleo1lyx5gt9mgn38tueqm03fgjx8tvzqcg4s6a4tfs4uw8xxlncrrg9swxl7rh 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as compliance_testnet_installments.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo1lyx5gt9mgn38tueqm03fgjx8tvzqcg4s6a4tfs4uw8xxlncrrg9swxl7rh;
    cast r0 0u128 0u32 into r1 as SpendLimit.record;
    output r1 as SpendLimit.record;

function init_installment:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as u8.private;
    cast r2 into r3 as u128;
    div r1 r3 into r4;
    cast r0 r4 r2 into r5 as Installment.record;
    output r5 as Installment.record;

function pay_installment:
    input r0 as token_registry.aleo/Token.record;
    input r1 as Installment.record;
    input r2 as address.private;
    input r3 as u32.public;
    sub r1.months 1u8 into r4;
    cast r1.owner r1.amount_to_pay r4 into r5 as Installment.record;
    call token_registry.aleo/prehook_private r0 r1.amount_to_pay 4294967295u32 into r6 r7 r8;
    call token_registry.aleo/transfer_private r2 r1.amount_to_pay r7 into r9 r10 r11;
    async pay_installment r8 r11 r3 into r12;
    output r5 as Installment.record;
    output r6 as token_registry.aleo/Token.record;
    output r9 as token_registry.aleo/Token.record;
    output r10 as token_registry.aleo/Token.record;
    output r12 as compliance_testnet_installments.aleo/pay_installment.future;

finalize pay_installment:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as u32.public;
    await r0;
    await r1;
    rem block.height 28800u32 into r3;
    assert.eq r2 r3;
