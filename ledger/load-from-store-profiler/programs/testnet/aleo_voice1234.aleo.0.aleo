import credits.aleo;
import staking_v1.aleo;

program aleo_voice1234.aleo;

struct Settings:
    unstake_wait as u32;
    stake_paused as boolean;
    global_paused as boolean;
    max_reward_per_notify as u64;
    protocol_fee as u16;
    fee_account as address;

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
    key as field.public;
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
    output r7 as aleo_voice1234.aleo/send_voice.future;

finalize send_voice:
    input r0 as address.public;
    input r1 as address.public;
    hash.keccak512 r0 into r2 as field;
    cast r0 0u64 into r3 as TotalMessage;
    get.or_use voice_input[r2] r3 into r4;
    get.or_use staking_v1.aleo/account[r0] 0u64 into r5;
    gte r5 5u64 into r6;
    assert.eq r6 true;
    add r4.total_messages 1u64 into r7;
    cast r0 r7 into r8 as TotalMessage;
    set r8 into voice_input[r2];
