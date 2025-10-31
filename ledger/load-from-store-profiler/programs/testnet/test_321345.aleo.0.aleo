program test_321345.aleo;

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
    input r0 as u128.private;
    input r1 as u128.private;
    cast r1 into r2 as P;
    cast self.caller r0 1scalar r2 into r3 as CC;
    cast self.signer r3 into r4 as CCR.record;
    output r4 as CCR.record;
