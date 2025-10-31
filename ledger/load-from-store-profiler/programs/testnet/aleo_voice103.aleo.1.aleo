program aleo_voice103.aleo;

struct TotalMessage:
    messenger as address;
    total_messages as u64;

record Voice:
    owner as address.private;
    sent_from as address.private;
    msg as field.private;
    date as u128.private;

record Voice2:
    owner as address.private;
    sent_to as address.private;
    msg as field.private;
    date as u128.private;

mapping voice_input:
    key as address.public;
    value as TotalMessage.public;

function send_voice:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u128.private;
    assert.eq self.caller r0;
    assert.neq self.caller r1;
    cast r1 r0 r2 r3 into r4 as Voice.record;
    cast r0 r1 r2 r3 into r5 as Voice2.record;
    async send_voice r0 r1 into r6;
    output r4 as Voice.record;
    output r5 as Voice2.record;
    output r6 as aleo_voice103.aleo/send_voice.future;

finalize send_voice:
    input r0 as address.public;
    input r1 as address.public;
    cast r0 0u64 into r2 as TotalMessage;
    get.or_use voice_input[r0] r2 into r3;
    add r3.total_messages 1u64 into r4;
    cast r0 r4 into r5 as TotalMessage;
    set r5 into voice_input[r0];
