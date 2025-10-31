import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;

program aleo_voice101.aleo;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as field;

struct data:
    metadata as [field; 4u32];

struct TotalMessage:
    messenger as address;
    total_messages as u64;

record Voice:
    owner as address.private;
    sent_from as address.private;
    msg as field.private;
    hash_msg as field.private;
    date as u128.private;

record Voice2:
    owner as address.private;
    sent_to as address.private;
    msg as field.private;
    hash_msg as field.private;
    date as u128.private;

mapping voice_input:
    key as address.public;
    value as TotalMessage.public;

function send_voice:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u128.private;
    hash.bhp256 r2 into r4 as field;
    assert.eq self.caller r0;
    assert.neq self.caller r1;
    cast r1 r0 r2 r4 r3 into r5 as Voice.record;
    cast r0 r1 r2 r4 r3 into r6 as Voice2.record;
    async send_voice r0 r1 into r7;
    output r5 as Voice.record;
    output r6 as Voice2.record;
    output r7 as aleo_voice101.aleo/send_voice.future;

finalize send_voice:
    input r0 as address.public;
    input r1 as address.public;
    get aleo_name_service_registry_v4.aleo/primary_names[r0] into r2;
    get aleo_name_service_registry_v4.aleo/primary_names[r1] into r3;
    is.eq r2 r2 into r4;
    assert.eq r4 true;
    is.eq r3 r3 into r5;
    assert.eq r5 true;
    cast r0 0u64 into r6 as TotalMessage;
    get.or_use voice_input[r0] r6 into r7;
    add r7.total_messages 1u64 into r8;
    cast r0 r8 into r9 as TotalMessage;
    set r9 into voice_input[r0];
