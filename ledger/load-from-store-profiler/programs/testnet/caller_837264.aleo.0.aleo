import callee_837264.aleo;

program caller_837264.aleo;

function get_caller:
    call callee_837264.aleo/caller into r0;
    output r0 as address.public;
