program base_program_xyz.aleo;

record TestRecord:
    owner as address.private;
    amount as u64.private;

function mint:
    input r0 as u64.private;
    cast self.caller r0 into r1 as TestRecord.record;
    output r1 as TestRecord.record;

function spend:
    input r0 as TestRecord.record;
