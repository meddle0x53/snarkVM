program employer_registry.aleo;

struct Employer:
    employer_hash as field;
    nonce as scalar;

mapping employer_records:
    key as address.public;
    value as Employer.public;

mapping employer_registry:
    key as address.public;
    value as boolean.public;

mapping employer_tax_compliance:
    key as address.public;
    value as boolean.public;

function register_employer:
    input r0 as address.private;
    input r1 as field.private;
    async register_employer r0 r1 into r2;
    output r2 as employer_registry.aleo/register_employer.future;

finalize register_employer:
    input r0 as address.public;
    input r1 as field.public;
    rand.chacha into r2 as scalar;
    cast r1 r2 into r3 as Employer;
    set r3 into employer_records[r0];
    set true into employer_registry[r0];
    set false into employer_tax_compliance[r0];

function verify_employer_tax:
    input r0 as address.private;
    async verify_employer_tax r0 into r1;
    output r1 as employer_registry.aleo/verify_employer_tax.future;

finalize verify_employer_tax:
    input r0 as address.public;
    get.or_use employer_registry[r0] false into r1;
    assert.eq r1 true;
    set true into employer_tax_compliance[r0];
