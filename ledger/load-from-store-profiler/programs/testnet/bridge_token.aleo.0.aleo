program bridge_token.aleo;

record Token:
    owner as address.private;
    amount as u64.private;
    bridge_id as field.private;

record WithdrawalRequest:
    owner as address.private;
    amount as u64.private;
    evm_recipient as field.private;
    withdrawal_id as field.private;

mapping evm_deposits:
    key as field.public;
    value as boolean.public;

mapping processed_withdrawals:
    key as field.public;
    value as boolean.public;

mapping total_supply:
    key as u8.public;
    value as u64.public;

function mint_from_evm:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as field.private;
    input r3 as u32.private;
    input r4 as field.public;
    hash.psd2 r2 into r5 as field;
    cast r0 r1 r5 into r6 as Token.record;
    async mint_from_evm r2 r1 into r7;
    output r6 as Token.record;
    output r7 as bridge_token.aleo/mint_from_evm.future;

finalize mint_from_evm:
    input r0 as field.public;
    input r1 as u64.public;
    get.or_use evm_deposits[r0] false into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into evm_deposits[r0];
    get.or_use total_supply[0u8] 0u64 into r4;
    add r4 r1 into r5;
    set r5 into total_supply[0u8];

function transfer:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    assert.eq r0.owner self.caller;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    sub r0.amount r2 into r4;
    cast r0.owner r4 r0.bridge_id into r5 as Token.record;
    cast r1 r2 r0.bridge_id into r6 as Token.record;
    output r5 as Token.record;
    output r6 as Token.record;

function request_withdrawal:
    input r0 as Token.record;
    input r1 as field.private;
    input r2 as u64.private;
    assert.eq r0.owner self.caller;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    sub r0.amount r2 into r4;
    hash.psd2 r1 into r5 as field;
    cast r0.owner r4 r0.bridge_id into r6 as Token.record;
    cast self.caller r2 r1 r5 into r7 as WithdrawalRequest.record;
    async request_withdrawal r5 r2 into r8;
    output r6 as Token.record;
    output r7 as WithdrawalRequest.record;
    output r8 as bridge_token.aleo/request_withdrawal.future;

finalize request_withdrawal:
    input r0 as field.public;
    input r1 as u64.public;
    get.or_use processed_withdrawals[r0] false into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into processed_withdrawals[r0];
    get.or_use total_supply[0u8] 0u64 into r4;
    sub r4 r1 into r5;
    set r5 into total_supply[0u8];

function finalize_withdrawal:
    input r0 as WithdrawalRequest.record;
    assert.eq r0.owner self.caller;
    output r0.withdrawal_id as field.private;
