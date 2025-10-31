program aleo_voice3.aleo;

record Voice:
    owner as address.private;
    msg as u128.private;
    hash_msg as u128.private;

record CoBind:
    owner as address.private;
    bind_hash as field.private;

mapping voice_input:
    key as address.public;
    value as u128.public;

function send_voice:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u128.private;
    hash.bhp256 r3 into r4 as u128;
    assert.eq self.caller r0;
    hash.keccak512 r0 into r5 as field;
    hash.keccak512 r1 into r6 as field;
    add r5 r6 into r7;
    assert.eq r2 r7;
    cast r1 r3 r4 into r8 as Voice.record;
    async send_voice r1 r4 into r9;
    output r8 as Voice.record;
    output r9 as aleo_voice3.aleo/send_voice.future;

finalize send_voice:
    input r0 as address.public;
    input r1 as u128.public;
    set r1 into voice_input[r0];

function combine_owner_receiver_hash:
    input r0 as address.private;
    input r1 as address.private;
    assert.eq r0 self.caller;
    hash.keccak512 r0 into r2 as field;
    hash.keccak512 r1 into r3 as field;
    add r2 r3 into r4;
    cast r0 r4 into r5 as CoBind.record;
    output r5 as CoBind.record;
