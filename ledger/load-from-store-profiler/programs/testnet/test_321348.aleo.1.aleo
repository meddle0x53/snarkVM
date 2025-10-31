import test_321347.aleo;

program test_321348.aleo;

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
    call test_321347.aleo/c aleo1ejcm4cpwcjtenxlg37utj8dn7s88xs5asvl5u25w4udkd7e7dcpqvaeyaz r0 r1 into r2;
    output r2 as test_321347.aleo/CCR.record;
