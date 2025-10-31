program dixa_care_system.aleo;

record ZPass:
    owner as address.private;
    issuer as address.private;
    credential_hash as field.private;
    expiry as u32.private;
    version as u8.private;

record Patient:
    owner as address.private;
    credential_hash as field.private;
    medical_root as field.private;
    last_updated as u32.private;

struct AccessConsent:
    patient as address;
    provider as address;
    file_cid as field;
    proof as field;
    expiry as u64;

struct Appointment:
    patient as address;
    doctor as address;
    time as u32;
    encrypted_notes as field;
    status as field;

mapping authorized_issuers:
    key as address.public;
    value as boolean.public;

mapping revoked_zpasses:
    key as field.public;
    value as boolean.public;

mapping patient_registry:
    key as address.public;
    value as field.public;

mapping access_grants:
    key as field.public;
    value as boolean.public;

mapping appointments:
    key as field.public;
    value as Appointment.public;

mapping issuer:
    key as field.public;
    value as address.public;

function init:
    input r0 as address.public;
    async init r0 into r1;
    output r1 as dixa_care_system.aleo/init.future;

finalize init:
    input r0 as address.public;
    is.eq r0 aleo1vyp43fc4ynjf9sr4xaqprqdwf53gutry8eq0cxfyuyxax3cs9y9q8v5pm5 into r1;
    assert.eq r1 true;
    set true into authorized_issuers[r0];

function issue_zpass:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as u32.public;
    input r4 as address.public;
    add r0 r1 into r5;
    add r5 r2 into r6;
    hash.bhp256 r6 into r7 as field;
    cast r4 self.caller r7 r3 1u8 into r8 as ZPass.record;
    async issue_zpass self.caller r4 r7 into r9;
    output r8 as ZPass.record;
    output r9 as dixa_care_system.aleo/issue_zpass.future;

finalize issue_zpass:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as field.public;
    get.or_use authorized_issuers[r0] false into r3;
    get.or_use authorized_issuers[r0] false into r4;
    assert.eq r4 true;
    set r1 into issuer[r2];

function register_patient:
    input r0 as ZPass.record;
    input r1 as field.private;
    is.eq r0.owner self.caller into r2;
    assert.eq r2 true;
    cast self.caller r0.credential_hash r1 r0.expiry into r3 as Patient.record;
    async register_patient self.caller r0.credential_hash r0.expiry into r4;
    output r3 as Patient.record;
    output r4 as dixa_care_system.aleo/register_patient.future;

finalize register_patient:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u32.public;
    gt r2 block.height into r3;
    assert.eq r3 true;
    set r1 into patient_registry[r0];

function grant_access:
    input r0 as Patient.record;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as u64.public;
    is.eq r0.owner self.caller into r4;
    assert.eq r4 true;
    hash.bhp256 r1 into r5 as field;
    hash.bhp256 r2 into r6 as field;
    hash.bhp256 r3 into r7 as field;
    add r0.credential_hash r5 into r8;
    add r8 r6 into r9;
    add r9 r7 into r10;
    hash.bhp256 r10 into r11 as field;
    cast r0.owner r1 r2 r11 r3 into r12 as AccessConsent;
    async grant_access r0.owner r7 r11 into r13;
    output r12 as AccessConsent.private;
    output r13 as dixa_care_system.aleo/grant_access.future;

finalize grant_access:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    set true into access_grants[r2];

function book_appointment:
    input r0 as Patient.record;
    input r1 as address.public;
    input r2 as u32.public;
    input r3 as field.private;
    input r4 as field.public;
    is.eq r0.owner self.caller into r5;
    assert.eq r5 true;
    cast r0.owner r1 r2 r3 r4 into r6 as Appointment;
    async book_appointment r0.owner r1 r2 r4 into r7;
    output r6 as Appointment.private;
    output r7 as dixa_care_system.aleo/book_appointment.future;

finalize book_appointment:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u32.public;
    input r3 as field.public;
    gt r2 block.height into r4;
    assert.eq r4 true;
    get.or_use patient_registry[r0] r3 into r5;
    cast r0 r1 r2 0field r3 into r6 as Appointment;
    set r6 into appointments[r5];

function remove_zpass:
    input r0 as address.public;
    input r1 as field.public;
    is.eq self.caller r0 into r2;
    assert.eq r2 true;
    async remove_zpass r1 r0 into r3;
    output r3 as dixa_care_system.aleo/remove_zpass.future;

finalize remove_zpass:
    input r0 as field.public;
    input r1 as address.public;
    remove issuer[r0];

function emergency_access:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as u32.public;
    is.eq self.caller aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h into r4;
    assert.eq r4 true;
    async emergency_access self.caller r3 into r5;
    output r5 as dixa_care_system.aleo/emergency_access.future;

finalize emergency_access:
    input r0 as address.public;
    input r1 as u32.public;
    get.or_use authorized_issuers[r0] false into r2;
    get.or_use authorized_issuers[r0] false into r3;
    assert.eq r3 true;
    add block.height r1 into r4;
