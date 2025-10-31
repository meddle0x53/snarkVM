program agent_registry_v2.aleo;

record AgentRecord:
    owner as address.private;
    agent_id as field.private;
    stake_amount as u64.private;
    performance_score as u32.private;
    registration_height as u32.private;

struct AgentMetrics:
    accuracy_rate as u32;
    success_rate as u32;
    avg_latency_ms as u32;
    total_executions as u32;

struct PerformanceResult:
    agent_id as field;
    score as u32;
    verified as boolean;
    timestamp as u32;

closure calc_performance_score:
    input r0 as AgentMetrics;
    mul r0.accuracy_rate 4u32 into r1;
    div r1 10u32 into r2;
    mul r0.success_rate 2u32 into r3;
    div r3 10u32 into r4;
    lt r0.avg_latency_ms 100u32 into r5;
    lt r0.avg_latency_ms 500u32 into r6;
    lt r0.avg_latency_ms 1000u32 into r7;
    lt r0.avg_latency_ms 5000u32 into r8;
    ternary r8 4000u32 2000u32 into r9;
    ternary r7 6000u32 r9 into r10;
    ternary r6 8000u32 r10 into r11;
    ternary r5 10000u32 r11 into r12;
    mul r12 2u32 into r13;
    div r13 10u32 into r14;
    gte r0.total_executions 10000u32 into r15;
    gte r0.total_executions 1000u32 into r16;
    gte r0.total_executions 100u32 into r17;
    gte r0.total_executions 10u32 into r18;
    ternary r18 4000u32 2000u32 into r19;
    ternary r17 6000u32 r19 into r20;
    ternary r16 8000u32 r20 into r21;
    ternary r15 10000u32 r21 into r22;
    mul r22 2u32 into r23;
    div r23 10u32 into r24;
    add r2 r4 into r25;
    add r25 r14 into r26;
    add r26 r24 into r27;
    gt r27 10000u32 into r28;
    ternary r28 10000u32 r27 into r29;
    output r29 as u32;

function register_agent:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as AgentMetrics.private;
    input r3 as u32.private;
    gte r1 1000u64 into r4;
    assert.eq r4 true;
    lte r1 1000000000u64 into r5;
    assert.eq r5 true;
    lte r2.accuracy_rate 10000u32 into r6;
    assert.eq r6 true;
    lte r2.success_rate 10000u32 into r7;
    assert.eq r7 true;
    lte r2.avg_latency_ms 10000u32 into r8;
    assert.eq r8 true;
    call calc_performance_score r2 into r9;
    cast self.caller r0 r1 r9 r3 into r10 as AgentRecord.record;
    output r10 as AgentRecord.record;

function verify_agent:
    input r0 as AgentRecord.record;
    input r1 as AgentMetrics.private;
    input r2 as u32.private;
    assert.eq r0.owner self.caller;
    lte r1.accuracy_rate 10000u32 into r3;
    assert.eq r3 true;
    lte r1.success_rate 10000u32 into r4;
    assert.eq r4 true;
    lte r1.avg_latency_ms 10000u32 into r5;
    assert.eq r5 true;
    gt r1.total_executions 0u32 into r6;
    assert.eq r6 true;
    call calc_performance_score r1 into r7;
    cast r0.owner r0.agent_id r0.stake_amount r7 r0.registration_height into r8 as AgentRecord.record;
    cast r0.agent_id r7 true r2 into r9 as PerformanceResult;
    output r8 as AgentRecord.record;
    output r9 as PerformanceResult.private;

function update_stake:
    input r0 as AgentRecord.record;
    input r1 as u64.private;
    assert.eq r0.owner self.caller;
    gte r1 1000u64 into r2;
    assert.eq r2 true;
    lte r1 1000000000u64 into r3;
    assert.eq r3 true;
    cast r0.owner r0.agent_id r1 r0.performance_score r0.registration_height into r4 as AgentRecord.record;
    output r4 as AgentRecord.record;

function transfer_agent:
    input r0 as AgentRecord.record;
    input r1 as address.private;
    assert.eq r0.owner self.caller;
    cast r1 r0.agent_id r0.stake_amount r0.performance_score r0.registration_height into r2 as AgentRecord.record;
    output r2 as AgentRecord.record;
