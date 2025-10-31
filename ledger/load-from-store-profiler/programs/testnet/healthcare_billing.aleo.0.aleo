program healthcare_billing.aleo;

struct PatientRecord:
    patient_id as u64;
    insurance_id as u64;
    status as u8;

struct MedicalBill:
    bill_id as u64;
    patient_id as u64;
    amount as u64;
    service_code as u64;
    status as u8;

struct Payment:
    payment_id as u64;
    bill_id as u64;
    amount as u64;
    timestamp as u64;

function register_patient:
    input r0 as u64.private;
    input r1 as u64.private;
    cast r0 r1 1u8 into r2 as PatientRecord;
    output r2 as PatientRecord.private;

function create_bill:
    input r0 as u64.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as u64.private;
    cast r0 r1 r2 r3 0u8 into r4 as MedicalBill;
    output r4 as MedicalBill.private;

function process_payment:
    input r0 as u64.private;
    input r1 as u64.private;
    input r2 as MedicalBill.private;
    input r3 as u64.private;
    input r4 as u64.private;
    cast r0 r1 r3 r4 into r5 as Payment;
    gte r3 r2.amount into r6;
    not r6 into r7;
    ternary r6 2u8 1u8 into r8;
    cast r2.bill_id r2.patient_id r2.amount r2.service_code r8 into r9 as MedicalBill;
    output r5 as Payment.private;
    output r9 as MedicalBill.private;

function dispute_bill:
    input r0 as MedicalBill.private;
    input r1 as u64.private;
    cast r0.bill_id r0.patient_id r0.amount r0.service_code 3u8 into r2 as MedicalBill;
    output r2 as MedicalBill.private;

function resolve_dispute:
    input r0 as MedicalBill.private;
    input r1 as u64.private;
    cast r0.bill_id r0.patient_id r1 r0.service_code 0u8 into r2 as MedicalBill;
    output r2 as MedicalBill.private;
