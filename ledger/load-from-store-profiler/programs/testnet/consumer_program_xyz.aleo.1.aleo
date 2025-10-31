import base_program_xyz.aleo;

program consumer_program_xyz.aleo;

record ValuableToken:
    owner as address.private;
    amount as u64.private;

function spend_external_record:
    input r0 as base_program_xyz.aleo/TestRecord.record;
    call base_program_xyz.aleo/spend r0;

function read_external_create_value:
    input r0 as base_program_xyz.aleo/TestRecord.record;
    cast r0.owner r0.amount into r1 as ValuableToken.record;
    output r1 as ValuableToken.record;
