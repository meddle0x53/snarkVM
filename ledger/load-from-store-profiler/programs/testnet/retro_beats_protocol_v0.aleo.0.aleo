import credits.aleo;

program retro_beats_protocol_v0.aleo;

mapping account:
    key as address.public;
    value as u64.public;

mapping leaderboard:
    key as address.public;
    value as u64.public;

function transfer_back:
    input r0 as u64.public;
    gt r0 0u64 into r1;
    add 0u64 10000000u64 into r2;
    add 0u64 0u64 into r3;
    ternary r1 r2 r3 into r4;
    call credits.aleo/transfer_public self.caller r4 into r5;
    async transfer_back retro_beats_protocol_v0.aleo self.caller r4 r5 into r6;
    output r6 as retro_beats_protocol_v0.aleo/transfer_back.future;

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
