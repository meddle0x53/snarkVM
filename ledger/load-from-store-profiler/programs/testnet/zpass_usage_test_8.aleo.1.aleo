import zpass_merkle_8.aleo;

program zpass_usage_test_8.aleo;

function verify_zpass:
    input r0 as zpass_merkle_8.aleo/ZPass.record;
    input r1 as [field; 3u32].private;
    input r2 as u128.private;
    input r3 as u128.public;
    gt r2 r3 into r4;
    assert.eq r4 true;
    hash.psd2 r2 into r5 as field;
    call zpass_merkle_8.aleo/verify r0 r5 r1 into r6;
    output r6 as boolean.private;
