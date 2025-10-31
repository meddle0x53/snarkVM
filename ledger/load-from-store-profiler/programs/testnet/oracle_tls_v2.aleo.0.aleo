program oracle_tls_v2.aleo;

record OracleAttestation:
    owner as address.private;
    master_vault_id as field.private;
    oracle_type as u8.private;
    data_hash as field.private;
    proof_hash as field.private;
    validation_timestamp as u32.private;
    expiry_block as u32.private;
    confidence_level as u8.private;
    nonce as group.private;

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
    output r3 as oracle_tls_v2.aleo/submit_heartbeat.future;

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
    input r4 as address.public;
    cast r2.death_date into r5 as field;
    cast r2.jurisdiction into r6 as field;
    add r2.national_id_hash r5 into r7;
    hash.bhp256 r7 into r8 as field;
    add r2.issuing_authority r6 into r9;
    hash.bhp256 r9 into r10 as field;
    add r8 r10 into r11;
    hash.bhp256 r11 into r12 as field;
    hash.bhp256 r3.server_cert_hash into r13 as field;
    cast r4 r0 0u8 r12 r13 0u32 0u32 95u8 1540945439182663264862696551825005342995406165131907382295858612069623286213group into r14 as OracleAttestation.record;
    async prove_death r0 r1 r2 r3 self.caller into r15;
    output r14 as OracleAttestation.record;
    output r15 as oracle_tls_v2.aleo/prove_death.future;

finalize prove_death:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as DeathCertificate.public;
    input r3 as TLSProof.public;
    input r4 as address.public;
    get.or_use trusted_oracles[r4] false into r5;
    assert.eq r5 true;
    sub block.height r3.timestamp into r6;
    lte r6 86400u32 into r7;
    assert.eq r7 true;
    is.eq r3.server_cert_hash 123456789012345field into r8;
    is.eq r3.server_cert_hash 987654321098765field into r9;
    is.eq r3.server_cert_hash 456789012345678field into r10;
    or r8 r9 into r11;
    or r11 r10 into r12;
    assert.eq r12 true;
    is.neq r3.signature_r 0field into r13;
    is.neq r3.signature_s 0field into r14;
    is.neq r3.response_hash 0field into r15;
    is.neq r3.chain_root_hash 0field into r16;
    and r13 r14 into r17;
    and r17 r15 into r18;
    and r18 r16 into r19;
    add r3.response_hash r3.signature_r into r20;
    hash.bhp256 r20 into r21 as field;
    add r3.signature_s r3.chain_root_hash into r22;
    hash.bhp256 r22 into r23 as field;
    add r21 r23 into r24;
    hash.bhp256 r24 into r25 as field;
    is.neq r25 0field into r26;
    and r19 r26 into r27;
    assert.eq r27 true;
    get.or_use person_death_status[r0] false into r28;
    not r28 into r29;
    assert.eq r29 true;
    gte r2.validation_score 90u8 into r30;
    assert.eq r30 true;
    get.or_use person_last_activity[r0] 0u32 into r31;
    sub block.height r31 into r32;
    gte r32 15552000u32 into r33;
    assert.eq r33 true;
    set true into person_death_status[r0];
    hash.bhp256 r0 into r34 as field;
    set r2 into validated_certificates[r34];
    set r3 into tls_proof_registry[r34];

function check_death_status:
    input r0 as field.public;
    async check_death_status r0 into r1;
    output r1 as oracle_tls_v2.aleo/check_death_status.future;

finalize check_death_status:
    input r0 as field.public;
    get.or_use person_death_status[r0] false into r1;

function check_last_activity:
    input r0 as field.public;
    async check_last_activity r0 into r1;
    output r1 as oracle_tls_v2.aleo/check_last_activity.future;

finalize check_last_activity:
    input r0 as field.public;
    get.or_use person_last_activity[r0] 0u32 into r1;

function get_inactivity_status:
    input r0 as field.public;
    async get_inactivity_status r0 into r1;
    output r1 as oracle_tls_v2.aleo/get_inactivity_status.future;

finalize get_inactivity_status:
    input r0 as field.public;
    get.or_use person_last_activity[r0] 0u32 into r1;
    sub block.height r1 into r2;
    set r2 into inactivity_cache[r0];

function add_trusted_oracle:
    input r0 as address.public;
    assert.eq self.caller aleo1m06yuk9mwfhfgqea2hzkr6ntrsha3dvwllu5jphrgs6w2suc9q8qv65ya2;
    async add_trusted_oracle r0 into r1;
    output r1 as oracle_tls_v2.aleo/add_trusted_oracle.future;

finalize add_trusted_oracle:
    input r0 as address.public;
    set true into trusted_oracles[r0];

function revoke_oracle:
    input r0 as address.public;
    assert.eq self.caller aleo1m06yuk9mwfhfgqea2hzkr6ntrsha3dvwllu5jphrgs6w2suc9q8qv65ya2;
    async revoke_oracle r0 into r1;
    output r1 as oracle_tls_v2.aleo/revoke_oracle.future;

finalize revoke_oracle:
    input r0 as address.public;
    set false into trusted_oracles[r0];

function reveal_certificate_details:
    input r0 as OracleAttestation.record;
    input r1 as field.public;
    assert.eq r0.master_vault_id r1;
    assert.eq r0.owner self.caller;
    hash.bhp256 r1 into r2 as field;
    cast r2 r0.validation_timestamp 123456789012345field 0u8 r0.data_hash r0.confidence_level into r3 as DeathCertificate;
    output r3 as DeathCertificate.private;

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
