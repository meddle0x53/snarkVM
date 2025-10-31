import credits.aleo;
import father_program.aleo;

program son_program.aleo;

mapping son_mapping:
    key as address.public;
    value as u64.public;

function call_father:
    input r0 as u64.public;
    call father_program.aleo/father_here r0 into r1;
    async call_father self.caller r0 r1 into r2;
    output r2 as son_program.aleo/call_father.future;

finalize call_father:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as father_program.aleo/father_here.future;
    await r2;
    set r1 into son_mapping[r0];
