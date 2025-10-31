program test_project_v0.aleo;

mapping m:
    key as u8.public;
    value as boolean.public;

function test_remove:
    input r0 as u8.private;
    async test_remove r0 into r1;
    output r1 as test_project_v0.aleo/test_remove.future;

finalize test_remove:
    input r0 as u8.public;
    set true into m[1u8];
    remove m[r0];
