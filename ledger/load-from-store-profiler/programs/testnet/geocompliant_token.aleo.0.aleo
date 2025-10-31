program geocompliant_token.aleo;

record Token:
    owner as address.private;
    amount as u64.private;
    jurisdiction as u8.private;

record JurisdictionAuthorization:
    owner as address.private;
    jurisdiction as u8.private;
    authorized as boolean.private;

record JurisdictionAllowlistEntry:
    owner as address.private;
    from_jurisdiction as u8.private;
    to_jurisdiction as u8.private;
    allowed as boolean.private;

function create_allowlist_entry:
    input r0 as u8.private;
    input r1 as u8.private;
    input r2 as boolean.private;
    assert.eq self.caller aleo10sly4fsk7y5nqw8wlevtspsztlllpsntelm5xnwhu2wkgj6d9spq0mddvr;
    cast aleo10sly4fsk7y5nqw8wlevtspsztlllpsntelm5xnwhu2wkgj6d9spq0mddvr r0 r1 r2 into r3 as JurisdictionAllowlistEntry.record;
    output r3 as JurisdictionAllowlistEntry.record;

function issue_jurisdiction_authorize:
    input r0 as address.private;
    input r1 as u8.private;
    assert.eq self.caller aleo10sly4fsk7y5nqw8wlevtspsztlllpsntelm5xnwhu2wkgj6d9spq0mddvr;
    cast r0 r1 true into r2 as JurisdictionAuthorization.record;
    output r2 as JurisdictionAuthorization.record;

function mint:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u8.private;
    assert.eq self.caller aleo10sly4fsk7y5nqw8wlevtspsztlllpsntelm5xnwhu2wkgj6d9spq0mddvr;
    cast r0 r1 r2 into r3 as Token.record;
    output r3 as Token.record;

function transfer:
    input r0 as Token.record;
    input r1 as JurisdictionAuthorization.record;
    input r2 as JurisdictionAllowlistEntry.record;
    input r3 as u64.private;
    input r4 as address.private;
    input r5 as u8.private;
    assert.eq r0.owner self.caller;
    assert.eq r1.owner self.caller;
    gte r0.amount r3 into r6;
    assert.eq r6 true;
    assert.eq r0.jurisdiction r1.jurisdiction;
    assert.eq r1.authorized true;
    assert.eq r2.owner aleo10sly4fsk7y5nqw8wlevtspsztlllpsntelm5xnwhu2wkgj6d9spq0mddvr;
    assert.eq r2.from_jurisdiction r0.jurisdiction;
    assert.eq r2.to_jurisdiction r5;
    assert.eq r2.allowed true;
    sub r0.amount r3 into r7;
    cast r4 r3 r5 into r8 as Token.record;
    cast r0.owner r7 r0.jurisdiction into r9 as Token.record;
    output r9 as Token.record;
    output r8 as Token.record;

function revoke_jurisdiction:
    input r0 as JurisdictionAuthorization.record;
    assert.eq self.caller aleo10sly4fsk7y5nqw8wlevtspsztlllpsntelm5xnwhu2wkgj6d9spq0mddvr;
    cast r0.owner r0.jurisdiction false into r1 as JurisdictionAuthorization.record;
    output r1 as JurisdictionAuthorization.record;

function update_allowlist_entry:
    input r0 as JurisdictionAllowlistEntry.record;
    input r1 as boolean.private;
    assert.eq self.caller aleo10sly4fsk7y5nqw8wlevtspsztlllpsntelm5xnwhu2wkgj6d9spq0mddvr;
    cast aleo10sly4fsk7y5nqw8wlevtspsztlllpsntelm5xnwhu2wkgj6d9spq0mddvr r0.from_jurisdiction r0.to_jurisdiction r1 into r2 as JurisdictionAllowlistEntry.record;
    output r2 as JurisdictionAllowlistEntry.record;

function burn:
    input r0 as Token.record;
    input r1 as u64.private;
    assert.eq r0.owner self.caller;
    gte r0.amount r1 into r2;
    assert.eq r2 true;
    sub r0.amount r1 into r3;
    cast r0.owner r3 r0.jurisdiction into r4 as Token.record;
    output r4 as Token.record;
