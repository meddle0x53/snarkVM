program test_get_aleo.aleo;

mapping test:
    key as field.public;
    value as u64.public;

function main:
    async main into r0;
    output r0 as test_get_aleo.aleo/main.future;

finalize main:
    get test[1field] into r0;
