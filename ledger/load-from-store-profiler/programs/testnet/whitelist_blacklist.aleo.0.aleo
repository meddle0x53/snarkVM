program whitelist_blacklist.aleo;

struct ComplianceReport:
    timestamp as u64;
    company_hash as field;
    data_verified as boolean;
    compliance_score as u8;
    category as u8;

struct AuditProof:
    report_hash as field;
    verifier_id as field;
    verification_timestamp as u32;

struct TimestampAndCompanyHash:
    timestamp as u64;
    company_hash as field;

struct ScoreAndCategory:
    compliance_score as u8;
    category as u8;

struct ReportHashInput:
    hash1 as field;
    hash2 as field;

struct AuditHashInput:
    hash1 as field;
    timestamp as u32;

mapping reports:
    key as field.public;
    value as field.public;

mapping audits:
    key as field.public;
    value as field.public;

function submit_report:
    input r0 as ComplianceReport.private;
    input r1 as scalar.private;
    hash.psd2 r1 into r2 as field;
    assert.eq r2 r0.company_hash;
    cast r0.timestamp r0.company_hash into r3 as TimestampAndCompanyHash;
    cast r0.compliance_score r0.category into r4 as ScoreAndCategory;
    hash.psd2 r3 into r5 as field;
    hash.psd2 r4 into r6 as field;
    cast r5 r6 into r7 as ReportHashInput;
    hash.psd2 r7 into r8 as field;
    output r8 as field.private;

function verify_report:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    cast r0 r2 0u32 into r3 as AuditProof;
    cast r0 0u32 into r4 as AuditHashInput;
    hash.psd2 r4 into r5 as field;
    output r3 as AuditProof.private;

function check_compliance:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u8.private;
    input r3 as u8.private;
    output true as boolean.private;

closure generate_report_hash:
    input r0 as u64;
    input r1 as field;
    input r2 as u8;
    input r3 as u8;
    cast r0 r1 into r4 as TimestampAndCompanyHash;
    cast r2 r3 into r5 as ScoreAndCategory;
    hash.psd2 r4 into r6 as field;
    hash.psd2 r5 into r7 as field;
    cast r6 r7 into r8 as ReportHashInput;
    hash.psd2 r8 into r9 as field;
    output r9 as field;

closure generate_audit_hash:
    input r0 as field;
    input r1 as field;
    input r2 as u32;
    cast r0 r2 into r3 as AuditHashInput;
    hash.psd2 r3 into r4 as field;
    output r4 as field;
