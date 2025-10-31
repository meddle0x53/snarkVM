program employer_agreement.aleo;

struct EmploymentAgreement:
    worker as address;
    employer as address;
    agreed_wage as u64;
    work_hours_per_week as u8;
    pay_period_days as u8;
    raise_schedule_days as u16;
    contract_start_block as u32;
    contract_end_block as u32;
    drug_and_alcohol_policy_signed as boolean;
    retirement_option_chosen as u8;
    health_insurance_option_chosen as u8;
    is_active as boolean;
    nonce as scalar;

mapping agreements:
    key as address.public;
    value as EmploymentAgreement.public;

function create_agreement:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as u64.private;
    input r3 as u8.private;
    input r4 as u8.private;
    input r5 as u16.private;
    input r6 as u32.private;
    input r7 as u32.private;
    input r8 as boolean.private;
    input r9 as u8.private;
    input r10 as u8.private;
    async create_agreement r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 into r11;
    output r11 as employer_agreement.aleo/create_agreement.future;

finalize create_agreement:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u8.public;
    input r4 as u8.public;
    input r5 as u16.public;
    input r6 as u32.public;
    input r7 as u32.public;
    input r8 as boolean.public;
    input r9 as u8.public;
    input r10 as u8.public;
    rand.chacha into r11 as scalar;
    cast r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 true r11 into r12 as EmploymentAgreement;
    set r12 into agreements[r0];

function terminate_agreement:
    input r0 as address.private;
    async terminate_agreement r0 into r1;
    output r1 as employer_agreement.aleo/terminate_agreement.future;

finalize terminate_agreement:
    input r0 as address.public;
    get agreements[r0] into r1;
    cast r1.worker r1.employer r1.agreed_wage r1.work_hours_per_week r1.pay_period_days r1.raise_schedule_days r1.contract_start_block r1.contract_end_block r1.drug_and_alcohol_policy_signed r1.retirement_option_chosen r1.health_insurance_option_chosen false r1.nonce into r2 as EmploymentAgreement;
    set r2 into agreements[r0];

function verify_agreement:
    input r0 as address.private;
    async verify_agreement r0 into r1;
    output r1 as employer_agreement.aleo/verify_agreement.future;

finalize verify_agreement:
    input r0 as address.public;
    contains agreements[r0] into r1;
    assert.eq r1 true;
