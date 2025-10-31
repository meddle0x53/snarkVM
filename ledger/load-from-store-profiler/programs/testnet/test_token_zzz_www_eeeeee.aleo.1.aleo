import token_test_zzz.aleo;
import credits.aleo;

program test_token_zzz_www_eeeeee.aleo;

function main:
    input r0 as address.public;
    input r1 as u64.public;
    call token_test_zzz.aleo/mint_private r0 r1 into r2;
    output r2 as token_test_zzz.aleo/Token.record;
