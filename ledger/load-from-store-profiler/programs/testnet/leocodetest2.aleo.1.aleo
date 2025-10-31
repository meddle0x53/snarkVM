program leocodetest2.aleo;

struct ComplianceReport:
    user as address;
    status as boolean;

function submit_report:
    input r0 as address.private;
    input r1 as boolean.private;
    cast r0 r1 into r2 as ComplianceReport;
    output r2 as ComplianceReport.private;

function verify_compliance:
    input r0 as ComplianceReport.private;
    input r1 as address.private;
    input r2 as address.private;
    assert.eq r1 r2;
    output r0.status as boolean.private;
