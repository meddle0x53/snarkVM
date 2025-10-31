import credits.aleo;

program aleodai_fee_contract_0_0_6.aleo;

struct FeeConfig:
    vault_addr as address;
    bank_addr as address;

struct FeeBalance:
    loan_fee as u64;
    balance as u64;

mapping fee_config:
    key as u8.public;
    value as FeeConfig.public;

mapping fee_balance:
    key as u8.public;
    value as FeeBalance.public;

function deposit:
    input r0 as u64.public;
    async deposit self.caller r0 into r1;
    output r1 as aleodai_fee_contract_0_0_6.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as u64.public;
    get fee_config[1u8] into r2;
    assert.eq r0 r2.vault_addr;
    cast 0u64 0u64 into r3 as FeeBalance;
    get.or_use fee_balance[1u8] r3 into r4;
    add r4.loan_fee r1 into r5;
    add r4.balance r1 into r6;
    cast r5 r6 into r7 as FeeBalance;
    set r7 into fee_balance[1u8];

function withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public r0 r1 into r2;
    async withdraw r2 self.caller r1 into r3;
    output r3 as aleodai_fee_contract_0_0_6.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get fee_config[1u8] into r3;
    is.eq r1 r3.bank_addr into r4;
    is.eq r1 aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    get fee_balance[1u8] into r7;
    gte r7.balance r2 into r8;
    assert.eq r8 true;
    sub r7.balance r2 into r9;
    cast r7.loan_fee r9 into r10 as FeeBalance;
    set r10 into fee_balance[1u8];

function update_vault_addr:
    input r0 as address.public;
    assert.eq self.caller aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q;
    async update_vault_addr r0 into r1;
    output r1 as aleodai_fee_contract_0_0_6.aleo/update_vault_addr.future;

finalize update_vault_addr:
    input r0 as address.public;
    cast aleodai_vault_contract_0_0_1.aleo aleodai_bank_contract_0_0_1.aleo into r1 as FeeConfig;
    get.or_use fee_config[1u8] r1 into r2;
    cast r0 r2.bank_addr into r3 as FeeConfig;
    set r3 into fee_config[1u8];

function update_bank_addr:
    input r0 as address.public;
    assert.eq self.caller aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q;
    async update_bank_addr r0 into r1;
    output r1 as aleodai_fee_contract_0_0_6.aleo/update_bank_addr.future;

finalize update_bank_addr:
    input r0 as address.public;
    cast aleodai_vault_contract_0_0_1.aleo aleodai_bank_contract_0_0_1.aleo into r1 as FeeConfig;
    get.or_use fee_config[1u8] r1 into r2;
    assert.neq r0 r2.bank_addr;
    cast r2.vault_addr r0 into r3 as FeeConfig;
    set r3 into fee_config[1u8];
