program benchmark_aaaaaaaaaaaaaaa_01.aleo;

record MyRecord:
    owner as address.private;
    val as u128.private;

mapping my_map:
    key as field.public;
    value as u128.public;

function noop:
    input r0 as u128.private;
    output r0 as u128.private;

function sum:
    input r0 as u128.private;
    input r1 as u128.private;
    add r0 r1 into r2;
    output r2 as u128.private;

function many_inputs:
    input r0 as [u128; 8u32].private;

function many_inputs_outputs:
    input r0 as [u128; 8u32].private;
    output r0 as [u128; 8u32].private;

function create_record:
    input r0 as u128.private;
    cast self.caller r0 into r1 as MyRecord.record;
    output r1 as MyRecord.record;

function set_mapping:
    input r0 as u128.private;
    async set_mapping r0 into r1;
    output r1 as benchmark_aaaaaaaaaaaaaaa_01.aleo/set_mapping.future;

finalize set_mapping:
    input r0 as u128.public;
    set r0 into my_map[0field];
