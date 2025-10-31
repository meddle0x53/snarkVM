program zk_dca_arcane_finance.aleo;

record DCAPosition:
    owner as address.private;
    position_id as field.private;
    input_token_id as u64.private;
    input_amount as u64.private;
    output_token_id as u64.private;
    interval as u32.private;
    next_execution as u32.private;
    executions_remaining as u32.private;
    min_output_amount as u64.private;

record Execution:
    owner as address.private;
    position_id as field.private;
    execution_block as u32.private;
    input_amount as u64.private;
    output_amount as u64.private;
    input_token_id as u64.private;
    output_token_id as u64.private;

record TokenRecord:
    owner as address.private;
    token_id as u64.private;
    amount as u64.private;

mapping pending_executions:
    key as u32.public;
    value as field.public;

mapping user_position_count:
    key as field.public;
    value as u32.public;

function create_position:
    input r0 as u64.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as u32.private;
    input r4 as u32.private;
    input r5 as u64.private;
    input r6 as u32.private;
    hash.bhp256 self.caller into r7 as field;
    add r6 r3 into r8;
    cast self.caller r7 r0 r1 r2 r3 r8 r4 r5 into r9 as DCAPosition.record;
    hash.bhp256 self.caller into r10 as field;
    async create_position r8 r7 r10 into r11;
    output r9 as DCAPosition.record;
    output r11 as zk_dca_arcane_finance.aleo/create_position.future;

finalize create_position:
    input r0 as u32.public;
    input r1 as field.public;
    input r2 as field.public;
    set r1 into pending_executions[r0];
    get.or_use user_position_count[r2] 0u32 into r3;
    add r3 1u32 into r4;
    set r4 into user_position_count[r2];

function execute_dca:
    input r0 as DCAPosition.record;
    input r1 as TokenRecord.record;
    input r2 as u32.private;
    gte r2 r0.next_execution into r3;
    assert.eq r3 true;
    gte r1.amount r0.input_amount into r4;
    assert.eq r4 true;
    is.eq r1.token_id r0.input_token_id into r5;
    assert.eq r5 true;
    add r2 r0.interval into r6;
    gt r0.executions_remaining 0u32 into r7;
    sub r0.executions_remaining 1u32 into r8;
    ternary r7 r8 r0.executions_remaining into r9;
    cast r0.owner r0.position_id r0.input_token_id r0.input_amount r0.output_token_id r0.interval r6 r9 r0.min_output_amount into r10 as DCAPosition.record;
    cast r0.owner r0.position_id r2 r0.input_amount r0.input_amount r0.input_token_id r0.output_token_id into r11 as Execution.record;
    cast r0.owner r0.output_token_id r0.input_amount into r12 as TokenRecord.record;
    async execute_dca r0.next_execution r6 r0.position_id into r13;
    output r10 as DCAPosition.record;
    output r11 as Execution.record;
    output r12 as TokenRecord.record;
    output r13 as zk_dca_arcane_finance.aleo/execute_dca.future;

finalize execute_dca:
    input r0 as u32.public;
    input r1 as u32.public;
    input r2 as field.public;
    remove pending_executions[r0];
    set r2 into pending_executions[r1];

function cancel_position:
    input r0 as DCAPosition.record;
    assert.eq self.caller r0.owner;
    async cancel_position r0.next_execution r0.position_id into r1;
    output r1 as zk_dca_arcane_finance.aleo/cancel_position.future;

finalize cancel_position:
    input r0 as u32.public;
    input r1 as field.public;
    remove pending_executions[r0];

closure get_executable_positions:
    input r0 as u32;
    assert.eq true true;
    output 0field as field;
