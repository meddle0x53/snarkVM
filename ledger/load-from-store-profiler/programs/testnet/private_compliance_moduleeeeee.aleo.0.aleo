program private_compliance_moduleeeeee.aleo;

record user_data:
    owner as address.private;
    age as u8.private;
    country_code as u16.private;
    credit_score as u16.private;

record claim:
    owner as address.private;
    issuer as address.private;
    topic as u8.private;
    claim_data as u64.private;
    expiration as u32.private;

record verification_result:
    owner as address.private;
    is_eligible as boolean.private;

mapping verified_users:
    key as address.public;
    value as boolean.public;

mapping trusted_issuers:
    key as address.public;
    value as boolean.public;

mapping admins:
    key as address.public;
    value as boolean.public;

function create_user_data:
    input r0 as u8.private;
    input r1 as u16.private;
    input r2 as u16.private;
    cast self.caller r0 r1 r2 into r3 as user_data.record;
    output r3 as user_data.record;

function check_eligibility_private:
    input r0 as user_data.record;
    gte r0.age 18u8 into r1;
    lt r0.country_code 900u16 into r2;
    and r1 r2 into r3;
    gte r0.credit_score 650u16 into r4;
    and r3 r4 into r5;
    output r0 as user_data.record;
    output r5 as boolean.private;

function verify_eligibility_public:
    input r0 as u8.public;
    input r1 as u16.public;
    input r2 as u16.public;
    gte r0 18u8 into r3;
    lt r1 900u16 into r4;
    and r3 r4 into r5;
    gte r2 650u16 into r6;
    and r5 r6 into r7;
    async verify_eligibility_public self.caller r7 into r8;
    output r8 as private_compliance_moduleeeeee.aleo/verify_eligibility_public.future;

finalize verify_eligibility_public:
    input r0 as address.public;
    input r1 as boolean.public;
    set r1 into verified_users[r0];

function get_verification_status:
    cast self.caller false into r0 as verification_result.record;
    async get_verification_status self.caller into r1;
    output r0 as verification_result.record;
    output r1 as private_compliance_moduleeeeee.aleo/get_verification_status.future;

finalize get_verification_status:
    input r0 as address.public;
    get.or_use verified_users[r0] false into r1;

function register_and_verify:
    input r0 as user_data.record;
    gte r0.age 18u8 into r1;
    lt r0.country_code 900u16 into r2;
    and r1 r2 into r3;
    gte r0.credit_score 650u16 into r4;
    and r3 r4 into r5;
    async register_and_verify self.caller r5 into r6;
    output r0 as user_data.record;
    output r6 as private_compliance_moduleeeeee.aleo/register_and_verify.future;

finalize register_and_verify:
    input r0 as address.public;
    input r1 as boolean.public;
    set r1 into verified_users[r0];

function create_verification_result:
    input r0 as boolean.private;
    cast self.caller r0 into r1 as verification_result.record;
    output r1 as verification_result.record;

function retrieve_verification_result:
    cast self.caller false into r0 as verification_result.record;
    async retrieve_verification_result self.caller into r1;
    output r0 as verification_result.record;
    output r1 as private_compliance_moduleeeeee.aleo/retrieve_verification_result.future;

finalize retrieve_verification_result:
    input r0 as address.public;
    get.or_use verified_users[r0] false into r1;

function initialize_program:
    async initialize_program self.caller into r0;
    output r0 as private_compliance_moduleeeeee.aleo/initialize_program.future;

finalize initialize_program:
    input r0 as address.public;
    set true into admins[r0];

function add_admin:
    input r0 as address.public;
    async add_admin self.caller r0 into r1;
    output r1 as private_compliance_moduleeeeee.aleo/add_admin.future;

finalize add_admin:
    input r0 as address.public;
    input r1 as address.public;
    get.or_use admins[r0] false into r2;
    assert.eq r2 true;
    set true into admins[r1];

function register_trusted_issuer:
    input r0 as address.public;
    async register_trusted_issuer self.caller r0 into r1;
    output r1 as private_compliance_moduleeeeee.aleo/register_trusted_issuer.future;

finalize register_trusted_issuer:
    input r0 as address.public;
    input r1 as address.public;
    get.or_use admins[r0] false into r2;
    assert.eq r2 true;
    set true into trusted_issuers[r1];

function revoke_trusted_issuer:
    input r0 as address.public;
    async revoke_trusted_issuer self.caller r0 into r1;
    output r1 as private_compliance_moduleeeeee.aleo/revoke_trusted_issuer.future;

finalize revoke_trusted_issuer:
    input r0 as address.public;
    input r1 as address.public;
    get.or_use admins[r0] false into r2;
    assert.eq r2 true;
    set false into trusted_issuers[r1];

function issue_claim:
    input r0 as address.public;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as u32.public;
    cast r0 self.caller r1 r2 r3 into r4 as claim.record;
    async issue_claim self.caller into r5;
    output r4 as claim.record;
    output r5 as private_compliance_moduleeeeee.aleo/issue_claim.future;

finalize issue_claim:
    input r0 as address.public;
    get.or_use trusted_issuers[r0] false into r1;
    assert.eq r1 true;

function verify_claim:
    input r0 as claim.record;
    input r1 as u32.private;
    gt r0.expiration r1 into r2;
    output r2 as boolean.private;

function verify_claim_and_update_status:
    input r0 as claim.record;
    input r1 as u32.public;
    gt r0.expiration r1 into r2;
    async verify_claim_and_update_status self.caller r2 r0.topic into r3;
    output r0 as claim.record;
    output r3 as private_compliance_moduleeeeee.aleo/verify_claim_and_update_status.future;

finalize verify_claim_and_update_status:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as u8.public;
    branch.eq r1 false to end_then_0_0;
    set r1 into verified_users[r0];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function transfer_claim:
    input r0 as claim.record;
    input r1 as address.private;
    input r2 as u64.private;
    shl 1u64 r0.topic into r3;
    and r2 r3 into r4;
    is.neq r4 0u64 into r5;
    assert.eq r5 true;
    cast r1 r0.issuer r0.topic r0.claim_data r0.expiration into r6 as claim.record;
    output r6 as claim.record;

function check_issuer_trusted:
    input r0 as address.public;
    async check_issuer_trusted r0 into r1;
    output r1 as private_compliance_moduleeeeee.aleo/check_issuer_trusted.future;

finalize check_issuer_trusted:
    input r0 as address.public;
    get.or_use trusted_issuers[r0] false into r1;
    assert.eq r1 true;
