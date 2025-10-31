import zklegacy_v4.aleo;

program oracle_tls_v3.aleo;

struct Testament:
    id as field;
    testator_address as address;
    executor_address as address;
    oracle_address as address;
    ipfs_hash as field;
    creation_timestamp as u32;
    status as u8;

struct KeyRelease:
    testament_id as field;
    death_confirmed as boolean;
    death_timestamp as u32;
    oracle_signature as field;

struct DeathCertificate:
    national_id_hash as field;
    death_date as u32;
    issuing_authority as field;
    jurisdiction as u8;
    certificate_hash as field;
    validation_score as u8;

struct TLSProof:
    server_cert_hash as field;
    response_hash as field;
    timestamp as u32;
    signature_r as field;
    signature_s as field;
    chain_root_hash as field;
    nonce as scalar;

mapping person_death_status:
    key as field.public;
    value as boolean.public;

mapping person_last_activity:
    key as field.public;
    value as u32.public;

mapping trusted_oracles:
    key as address.public;
    value as boolean.public;

mapping validated_certificates:
    key as field.public;
    value as DeathCertificate.public;

mapping tls_proof_registry:
    key as field.public;
    value as TLSProof.public;

mapping inactivity_cache:
    key as field.public;
    value as u32.public;

function submit_heartbeat:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    async submit_heartbeat r0 self.caller r2 into r3;
    output r3 as oracle_tls_v3.aleo/submit_heartbeat.future;

finalize submit_heartbeat:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    set block.height into person_last_activity[r0];
    set false into person_death_status[r0];

function prove_death:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as DeathCertificate.public;
    input r3 as TLSProof.public;
    input r4 as [field; 5u32].public;
    input r5 as [field; 5u32].public;
    call zklegacy_v4.aleo/confirm_death r4[0u32] r2.death_date r5[0u32] into r6;
    call zklegacy_v4.aleo/confirm_death r4[1u32] r2.death_date r5[1u32] into r7;
    call zklegacy_v4.aleo/confirm_death r4[2u32] r2.death_date r5[2u32] into r8;
    call zklegacy_v4.aleo/confirm_death r4[3u32] r2.death_date r5[3u32] into r9;
    call zklegacy_v4.aleo/confirm_death r4[4u32] r2.death_date r5[4u32] into r10;
    async prove_death r0 r4 r5 r1 r2 r3 self.caller r6 r7 r8 r9 r10 into r11;
    output r11 as oracle_tls_v3.aleo/prove_death.future;

finalize prove_death:
    input r0 as field.public;
    input r1 as [field; 5u32].public;
    input r2 as [field; 5u32].public;
    input r3 as field.public;
    input r4 as DeathCertificate.public;
    input r5 as TLSProof.public;
    input r6 as address.public;
    input r7 as zklegacy_v4.aleo/confirm_death.future;
    input r8 as zklegacy_v4.aleo/confirm_death.future;
    input r9 as zklegacy_v4.aleo/confirm_death.future;
    input r10 as zklegacy_v4.aleo/confirm_death.future;
    input r11 as zklegacy_v4.aleo/confirm_death.future;
    await r7;
    await r8;
    await r9;
    await r10;
    await r11;
    get.or_use trusted_oracles[r6] false into r12;
    assert.eq r12 true;
    sub block.height r5.timestamp into r13;
    lte r13 86400u32 into r14;
    assert.eq r14 true;
    is.eq r5.server_cert_hash 123456789012345field into r15;
    is.eq r5.server_cert_hash 987654321098765field into r16;
    is.eq r5.server_cert_hash 456789012345678field into r17;
    or r15 r16 into r18;
    or r18 r17 into r19;
    assert.eq r19 true;
    is.neq r5.signature_r 0field into r20;
    is.neq r5.signature_s 0field into r21;
    is.neq r5.response_hash 0field into r22;
    is.neq r5.chain_root_hash 0field into r23;
    and r20 r21 into r24;
    and r24 r22 into r25;
    and r25 r23 into r26;
    add r5.response_hash r5.signature_r into r27;
    hash.bhp256 r27 into r28 as field;
    add r5.signature_s r5.chain_root_hash into r29;
    hash.bhp256 r29 into r30 as field;
    add r28 r30 into r31;
    hash.bhp256 r31 into r32 as field;
    is.neq r32 0field into r33;
    and r26 r33 into r34;
    assert.eq r34 true;
    get.or_use person_death_status[r0] false into r35;
    not r35 into r36;
    assert.eq r36 true;
    gte r4.validation_score 90u8 into r37;
    assert.eq r37 true;
    get.or_use person_last_activity[r0] 0u32 into r38;
    sub block.height r38 into r39;
    gte r39 15552000u32 into r40;
    assert.eq r40 true;
    set true into person_death_status[r0];
    hash.bhp256 r0 into r41 as field;
    set r4 into validated_certificates[r41];
    set r5 into tls_proof_registry[r41];

function check_death_status:
    input r0 as field.public;
    async check_death_status r0 into r1;
    output r1 as oracle_tls_v3.aleo/check_death_status.future;

finalize check_death_status:
    input r0 as field.public;
    get.or_use person_death_status[r0] false into r1;

function check_last_activity:
    input r0 as field.public;
    async check_last_activity r0 into r1;
    output r1 as oracle_tls_v3.aleo/check_last_activity.future;

finalize check_last_activity:
    input r0 as field.public;
    get.or_use person_last_activity[r0] 0u32 into r1;

function get_inactivity_status:
    input r0 as field.public;
    async get_inactivity_status r0 into r1;
    output r1 as oracle_tls_v3.aleo/get_inactivity_status.future;

finalize get_inactivity_status:
    input r0 as field.public;
    get.or_use person_last_activity[r0] 0u32 into r1;
    sub block.height r1 into r2;
    set r2 into inactivity_cache[r0];

function add_trusted_oracle:
    input r0 as address.public;
    assert.eq self.caller aleo1m06yuk9mwfhfgqea2hzkr6ntrsha3dvwllu5jphrgs6w2suc9q8qv65ya2;
    async add_trusted_oracle r0 into r1;
    output r1 as oracle_tls_v3.aleo/add_trusted_oracle.future;

finalize add_trusted_oracle:
    input r0 as address.public;
    set true into trusted_oracles[r0];

function revoke_oracle:
    input r0 as address.public;
    assert.eq self.caller aleo1m06yuk9mwfhfgqea2hzkr6ntrsha3dvwllu5jphrgs6w2suc9q8qv65ya2;
    async revoke_oracle r0 into r1;
    output r1 as oracle_tls_v3.aleo/revoke_oracle.future;

finalize revoke_oracle:
    input r0 as address.public;
    set false into trusted_oracles[r0];

function create_certificate_hash:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as field.public;
    input r3 as u8.public;
    cast r1 into r4 as field;
    cast r3 into r5 as field;
    add r0 r4 into r6;
    hash.bhp256 r6 into r7 as field;
    add r2 r5 into r8;
    hash.bhp256 r8 into r9 as field;
    add r7 r9 into r10;
    hash.bhp256 r10 into r11 as field;
    output r11 as field.private;

function test_hash_functions:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as field.public;
    cast r1 into r3 as field;
    cast 0u8 into r4 as field;
    add r0 r3 into r5;
    hash.bhp256 r5 into r6 as field;
    add r2 r4 into r7;
    hash.bhp256 r7 into r8 as field;
    add r6 r8 into r9;
    hash.bhp256 r9 into r10 as field;
    output r10 as field.private;

function validate_tls_proof_simple:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    is.neq r1 0field into r4;
    is.neq r2 0field into r5;
    is.neq r0 0field into r6;
    is.neq r3 0field into r7;
    and r4 r5 into r8;
    and r8 r6 into r9;
    and r9 r7 into r10;
    add r0 r1 into r11;
    hash.bhp256 r11 into r12 as field;
    add r2 r3 into r13;
    hash.bhp256 r13 into r14 as field;
    add r12 r14 into r15;
    hash.bhp256 r15 into r16 as field;
    is.neq r16 0field into r17;
    ternary r10 r17 false into r18;
    output r18 as boolean.private;

closure hash_national_id:
    input r0 as field;
    input r1 as u8;
    input r2 as scalar;
    cast r1 into r3 as field;
    add r0 r3 into r4;
    hash.bhp256 r4 into r5 as field;
    commit.bhp256 r5 r2 into r6 as field;
    output r6 as field;
