program oversightdao_reserve.aleo;

mapping reserve_balance:
    key as [u8; 32u32].public;
    value as u64.public;

function deposit:
    input r0 as [u8; 32u32].private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    cast 111u8 118u8 101u8 114u8 115u8 105u8 103u8 104u8 116u8 100u8 97u8 111u8 46u8 112u8 110u8 119u8 46u8 97u8 110u8 115u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r3 as [u8; 32u32];
    is.eq r0 r3 into r4;
    assert.eq r4 true;
    async deposit r0 r1 into r5;
    output r5 as oversightdao_reserve.aleo/deposit.future;

finalize deposit:
    input r0 as [u8; 32u32].public;
    input r1 as u64.public;
    get.or_use reserve_balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into reserve_balance[r0];

function withdraw:
    input r0 as [u8; 32u32].private;
    input r1 as u64.private;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    async withdraw r0 r1 into r3;
    output r3 as oversightdao_reserve.aleo/withdraw.future;

finalize withdraw:
    input r0 as [u8; 32u32].public;
    input r1 as u64.public;
    cast 111u8 118u8 101u8 114u8 115u8 105u8 103u8 104u8 116u8 100u8 97u8 111u8 46u8 112u8 110u8 119u8 46u8 97u8 110u8 115u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r2 as [u8; 32u32];
    get.or_use reserve_balance[r2] 0u64 into r3;
    gte r3 r1 into r4;
    assert.eq r4 true;
    sub r3 r1 into r5;
    cast 111u8 118u8 101u8 114u8 115u8 105u8 103u8 104u8 116u8 100u8 97u8 111u8 46u8 112u8 110u8 119u8 46u8 97u8 110u8 115u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r6 as [u8; 32u32];
    set r5 into reserve_balance[r6];

function validate_reserve:
    input r0 as [u8; 32u32].private;
    async validate_reserve r0 into r1;
    output r1 as oversightdao_reserve.aleo/validate_reserve.future;

finalize validate_reserve:
    input r0 as [u8; 32u32].public;
    cast 111u8 118u8 101u8 114u8 115u8 105u8 103u8 104u8 116u8 100u8 97u8 111u8 46u8 112u8 110u8 119u8 46u8 97u8 110u8 115u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r1 as [u8; 32u32];
    contains reserve_balance[r1] into r2;
    assert.eq r2 true;

closure encode_ans:
    input r0 as [u8; 32u32];
    assert.eq true true;
    output r0 as [u8; 32u32];
