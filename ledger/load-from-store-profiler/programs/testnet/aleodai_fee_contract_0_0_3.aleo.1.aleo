import credits.aleo;

program aleodai_fee_contract_0_0_3.aleo;

struct FeeBalance:
    loan_fee as u64;
    saving_interest as u64;
    balance as u64;

mapping fee_balance:
    key as u8.public;
    value as FeeBalance.public;

function deposit:
    input r0 as u64.public;
    assert.eq self.caller aleodai_vault_contract_0_0_1.aleo;
    async deposit r0 into r1;
    output r1 as aleodai_fee_contract_0_0_3.aleo/deposit.future;

finalize deposit:
    input r0 as u64.public;
    cast 0u64 0u64 0u64 into r1 as FeeBalance;
    get.or_use fee_balance[1u8] r1 into r2;
    add r2.loan_fee r0 into r3;
    add r2.balance r0 into r4;
    cast r3 r2.saving_interest r4 into r5 as FeeBalance;
    set r5 into fee_balance[1u8];

function withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    is.eq self.caller aleodai_bank_contract_0_0_1.aleo into r3;
    is.eq self.caller aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    call credits.aleo/transfer_public r0 r1 into r6;
    async withdraw r6 r1 into r7;
    output r7 as aleodai_fee_contract_0_0_3.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as u64.public;
    await r0;
    get fee_balance[1u8] into r2;
    gt r2.saving_interest r1 into r3;
    gt r2.balance r1 into r4;
    and r3 r4 into r5;
    assert.eq r5 true;
    sub r2.saving_interest r1 into r6;
    sub r2.balance r1 into r7;
    cast r2.loan_fee r6 r7 into r8 as FeeBalance;
    set r8 into fee_balance[1u8];
