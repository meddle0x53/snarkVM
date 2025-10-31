program charity_fundraising.aleo;

record FundraisingGoal:
    owner as address.private;
    total_donations as u64.private;
    goal as u64.private;
    charity as address.private;

function donate:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as FundraisingGoal.record;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    add r2.total_donations r1 into r4;
    cast r2.charity r4 r2.goal r2.charity into r5 as FundraisingGoal.record;
    output r5 as FundraisingGoal.record;

function withdraw_funds:
    input r0 as address.private;
    input r1 as FundraisingGoal.record;
    is.eq self.caller r0 into r2;
    assert.eq r2 true;
    gte r1.total_donations r1.goal into r3;
    assert.eq r3 true;
    cast r1.charity 0u64 r1.goal r1.charity into r4 as FundraisingGoal.record;
    output r4 as FundraisingGoal.record;
