program private_donation.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

record DonationReceipt:
    owner as address.private;
    donation_id as field.private;
    charity_id as field.private;
    amount as u64.private;
    timestamp as u64.private;
    message_hash as field.private;

function donate:
    input r0 as Token.record;
    input r1 as u64.private;
    input r2 as field.private;
    input r3 as u64.private;
    gte r0.amount r1 into r4;
    assert.eq r4 true;
    hash.bhp256 self.caller into r5 as field;
    add 12345field r5 into r6;
    cast r3 into r7 as field;
    add r6 r7 into r8;
    cast r1 into r9 as field;
    add r8 r9 into r10;
    hash.bhp256 r10 into r11 as field;
    sub r0.amount r1 into r12;
    cast r0.owner r12 into r13 as Token.record;
    cast r0.owner r11 12345field r1 r3 r2 into r14 as DonationReceipt.record;
    output r13 as Token.record;
    output r14 as DonationReceipt.record;

function generate_tax_proof:
    input r0 as DonationReceipt.record;
    input r1 as u64.private;
    is.eq r0.owner self.caller into r2;
    assert.eq r2 true;
    is.eq r0.charity_id 12345field into r3;
    assert.eq r3 true;
    div r0.timestamp 31536000u64 into r4;
    is.eq r4 r1 into r5;
    assert.eq r5 true;
    hash.bhp256 self.caller into r6 as field;
    add r0.donation_id r0.charity_id into r7;
    cast r0.amount into r8 as field;
    add r7 r8 into r9;
    cast r1 into r10 as field;
    add r9 r10 into r11;
    add r11 r6 into r12;
    hash.bhp256 r12 into r13 as field;
    output r0 as DonationReceipt.record;
    output r13 as field.private;

function mint_tokens:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;
