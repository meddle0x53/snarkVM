program test_321347.aleo;

struct P:
    n as u128;

struct CC:
    s as address;
    dc as u128;
    dca as scalar;
    p as P;

record CCR:
    owner as address.private;
    cc as CC.private;

function c:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as u128.private;
    cast r2 into r3 as P;
    cast self.caller r1 1scalar r3 into r4 as CC;
    cast r0 r4 into r5 as CCR.record;
    output r5 as CCR.record;
