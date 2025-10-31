program rockpaperscissors_game.aleo;

struct Stats:
    wins as u32;
    losses as u32;

struct GameResult:
    player1_hash as field;
    player2_hash as field;
    result as u8;

mapping stats:
    key as field.public;
    value as Stats.public;

mapping history:
    key as u64.public;
    value as GameResult.public;

mapping game_count:
    key as u64.public;
    value as u64.public;

function play:
    input r0 as u8.private;
    lte r0 2u8 into r1;
    assert.eq r1 true;
    hash.bhp256 self.caller into r2 as field;
    hash.bhp256 aleo1k6xta9a7wdhrsvaj4e6wf8d26e7p50nvfyex0fys5e4n7mr74qgsgk7hru into r3 as field;
    async play r2 r3 r0 into r4;
    output r4 as rockpaperscissors_game.aleo/play.future;

finalize play:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    rand.chacha into r3 as u8;
    rem r3 3u8 into r4;
    add r2 3u8 into r5;
    sub r5 r4 into r6;
    rem r6 3u8 into r7;
    is.eq r7 0u8 into r8;
    not r8 into r9;
    is.eq r7 1u8 into r10;
    and r9 r10 into r11;
    not r10 into r12;
    and r9 r12 into r13;
    ternary r11 1u8 2u8 into r14;
    ternary r8 0u8 r14 into r15;
    cast 0u32 0u32 into r16 as Stats;
    get.or_use stats[r0] r16 into r17;
    cast 0u32 0u32 into r18 as Stats;
    get.or_use stats[r1] r18 into r19;
    is.eq r15 1u8 into r20;
    branch.eq r20 false to end_then_0_0;
    add r17.wins 1u32 into r21;
    cast r21 r17.losses into r22 as Stats;
    set r22 into stats[r0];
    add r19.losses 1u32 into r23;
    cast r19.wins r23 into r24 as Stats;
    set r24 into stats[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    is.eq r15 2u8 into r25;
    branch.eq r25 false to end_then_1_2;
    add r17.losses 1u32 into r26;
    cast r17.wins r26 into r27 as Stats;
    set r27 into stats[r0];
    add r19.wins 1u32 into r28;
    cast r28 r19.losses into r29 as Stats;
    set r29 into stats[r1];
    branch.eq true true to end_otherwise_1_3;
    position end_then_1_2;
    position end_otherwise_1_3;
    position end_otherwise_0_1;
    get.or_use game_count[0u64] 0u64 into r30;
    cast r0 r1 r15 into r31 as GameResult;
    set r31 into history[r30];
    add r30 1u64 into r32;
    set r32 into game_count[0u64];
