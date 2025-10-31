import test_321345.aleo;

program test_321346.aleo;

struct P:
    n as u128;

struct CC:
    s as address;
    dc as u128;
    dca as scalar;
    p as P;

function main:
    input r0 as u128.private;
    input r1 as u128.private;
    call test_321345.aleo/c r0 r1 into r2;
    output r2 as test_321345.aleo/CCR.record;
