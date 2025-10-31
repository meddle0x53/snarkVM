import credits.aleo;
import dai_stablecoin_0_0_1.aleo;
import dai_fee_contract_0_0_1.aleo;
import dai_oracle_contract_0_0_1.aleo;

program dai_bank_contract_0_0_1.aleo;

struct PriceFeed:
    price as u64;
    max_price as u64;
    min_price as u64;
    block_height as u64;

struct BankConfig:
    saving_interes_rate as u64;

struct Saving:
    owner_address as address;
    amount as u64;
    deposit_block_height as u64;
    withdraw_block_height as u64;
    closed as boolean;

mapping bank_config:
    key as u8.public;
    value as BankConfig.public;

mapping saving_id:
    key as u8.public;
    value as u128.public;

mapping savings:
    key as u128.public;
    value as Saving.public;

function deposit:
    input r0 as u64.public;
    call dai_stablecoin_0_0_1.aleo/transfer_public_as_signer dai_bank_contract_0_0_1.aleo r0 into r1;
    async deposit r1 self.signer r0 into r2;
    output r2 as dai_bank_contract_0_0_1.aleo/deposit.future;

finalize deposit:
    input r0 as dai_stablecoin_0_0_1.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get.or_use saving_id[1u8] 0u128 into r3;
    add r3 1u128 into r4;
    set r4 into saving_id[1u8];
    cast block.height into r5 as u64;
    cast r1 r2 r5 0u64 false into r6 as Saving;
    set r6 into savings[r4];

function withdraw:
    input r0 as u128.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    input r5 as u64.public;
    call dai_stablecoin_0_0_1.aleo/transfer_public self.caller r1 into r6;
    div.w r1 r5 into r7;
    sub r4 r3 into r8;
    div.w r8 43200u64 into r9;
    mul r7 r9 into r10;
    mul r10 r2 into r11;
    div.w r11 10000u64 into r12;
    call dai_fee_contract_0_0_1.aleo/withdraw self.caller r12 into r13;
    async withdraw r0 self.caller r6 r1 r13 r2 r3 r4 r5 into r14;
    output r14 as dai_bank_contract_0_0_1.aleo/withdraw.future;

finalize withdraw:
    input r0 as u128.public;
    input r1 as address.public;
    input r2 as dai_stablecoin_0_0_1.aleo/transfer_public.future;
    input r3 as u64.public;
    input r4 as dai_fee_contract_0_0_1.aleo/withdraw.future;
    input r5 as u64.public;
    input r6 as u64.public;
    input r7 as u64.public;
    input r8 as u64.public;
    get dai_oracle_contract_0_0_1.aleo/price_feed_latest[1u8] into r9;
    gte r8 r9.min_price into r10;
    lte r8 r9.max_price into r11;
    and r10 r11 into r12;
    assert.eq r12 true;
    await r2;
    await r4;
    get.or_use saving_id[1u8] 0u128 into r13;
    lte r0 r13 into r14;
    gt r0 0u128 into r15;
    and r14 r15 into r16;
    assert.eq r16 true;
    get savings[r0] into r17;
    assert.eq r17.closed false;
    assert.eq r17.owner_address r1;
    assert.eq r17.amount r3;
    assert.eq r17.deposit_block_height r6;
    add r7 100u64 into r18;
    cast block.height into r19 as u64;
    gt r18 r19 into r20;
    assert.eq r20 true;
    get bank_config[1u8] into r21;
    assert.eq r5 r21.saving_interes_rate;
    cast r1 r3 r6 r7 true into r22 as Saving;
    set r22 into savings[r0];

function update_saving_interes_rate:
    input r0 as u64.public;
    assert.eq self.caller aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q;
    async update_saving_interes_rate r0 into r1;
    output r1 as dai_bank_contract_0_0_1.aleo/update_saving_interes_rate.future;

finalize update_saving_interes_rate:
    input r0 as u64.public;
    cast 5u64 into r1 as BankConfig;
    get.or_use bank_config[1u8] r1 into r2;
    cast r0 into r3 as BankConfig;
    set r3 into bank_config[1u8];
