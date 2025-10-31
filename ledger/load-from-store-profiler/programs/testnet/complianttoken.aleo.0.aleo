program complianttoken.aleo;

record SanctionsCompliance:
    owner as address.private;
    user_address as address.private;
    is_sanctioned as boolean.private;
    expiry_block as u32.private;

function issue_screening:
    input r0 as address.private;
    input r1 as boolean.private;
    input r2 as u32.private;
    assert.eq self.caller aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg;
    cast self.caller r0 r1 r2 into r3 as SanctionsCompliance.record;
    output r3 as SanctionsCompliance.record;

function verify_transfer_eligibility:
    input r0 as SanctionsCompliance.record;
    input r1 as u32.private;
    assert.eq self.caller r0.user_address;
    lte r1 r0.expiry_block into r2;
    assert.eq r2 true;
    not r0.is_sanctioned into r3;
    output r3 as boolean.private;
