import callee_457218.aleo;

program caller_457218.aleo;

function get_caller:
    call callee_457218.aleo/caller into r0;
    output r0 as address.private;
