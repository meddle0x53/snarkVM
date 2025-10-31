import credits.aleo;

program aleodai_fee_contract_0_0_2.aleo;

struct FeeBalance:
    loan_fee as u64;
    saving_interest as u64;
    balance as u64;

mapping fee_balance:
    key as u8.public;
    value as FeeBalance.public;

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
    output r7 as aleodai_fee_contract_0_0_2.aleo/withdraw.future;

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
