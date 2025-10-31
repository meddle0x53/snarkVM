program process_tax_compliance.aleo;

struct EmployerTaxRecord:
    employer_address as address;
    total_tax_paid as u64;
    last_payment_block as u32;
    is_compliant as boolean;

mapping employer_tax:
    key as address.public;
    value as EmployerTaxRecord.public;

function process_tax_compliance:
    input r0 as address.private;
    input r1 as u8.private;
    input r2 as u32.private;
    async process_tax_compliance r0 r1 r2 into r3;
    output r3 as process_tax_compliance.aleo/process_tax_compliance.future;

finalize process_tax_compliance:
    input r0 as address.public;
    input r1 as u8.public;
    input r2 as u32.public;
    is.eq r1 0u8 into r3;
    not r3 into r4;
    is.eq r1 1u8 into r5;
    and r4 r5 into r6;
    ternary r6 500u64 0u64 into r7;
    ternary r3 1000u64 r7 into r8;
    cast r0 0u64 0u32 false into r9 as EmployerTaxRecord;
    get.or_use employer_tax[r0] r9 into r10;
    add r10.total_tax_paid r8 into r11;
    gte r11 r8 into r12;
    cast r0 r11 r2 r12 into r13 as EmployerTaxRecord;
    set r13 into employer_tax[r0];

function verify_tax_record:
    input r0 as address.private;
    async verify_tax_record r0 into r1;
    output r1 as process_tax_compliance.aleo/verify_tax_record.future;

finalize verify_tax_record:
    input r0 as address.public;
    contains employer_tax[r0] into r1;
    assert.eq r1 true;
