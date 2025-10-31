import credits.aleo;

program retro_beats_protocol_v1.aleo;

mapping account:
    key as address.public;
    value as u64.public;

mapping leaderboard:
    key as address.public;
    value as u64.public;

function transfer_back:
    input r0 as u64.public;
    input r1 as u64.public;
    gt r0 0u64 into r2;
    add 0u64 r1 into r3;
    add 0u64 0u64 into r4;
    ternary r2 r3 r4 into r5;
    call credits.aleo/transfer_public self.caller r5 into r6;
    async transfer_back retro_beats_protocol_v1.aleo self.caller r5 r6 into r7;
    output r7 as retro_beats_protocol_v1.aleo/transfer_back.future;

finalize transfer_back:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as credits.aleo/transfer_public.future;
    is.eq r2 10000000u64 into r4;
    branch.eq r4 false to end_then_0_0;
    await r3;
    get.or_use leaderboard[r1] 0u64 into r5;
    add r5 1u64 into r6;
    set r6 into leaderboard[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
