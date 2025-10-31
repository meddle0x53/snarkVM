program rockpaperscissors_game_v0_1_1.aleo;

struct Game:
    player_hash as field;
    game_index as u64;

struct Stats:
    wins as u64;
    losses as u64;

struct Outcome:
    player_move as u8;
    system_move as u8;
    outcome as u8;

mapping stats:
    key as field.public;
    value as Stats.public;

mapping game_count:
    key as field.public;
    value as u64.public;

mapping history:
    key as field.public;
    value as Outcome.public;

function play:
    input r0 as u8.private;
    lte r0 2u8 into r1;
    assert.eq r1 true;
    hash.bhp256 self.caller into r2 as field;
    async play r2 r0 into r3;
    output r3 as rockpaperscissors_game_v0_1_1.aleo/play.future;

finalize play:
    input r0 as field.public;
    input r1 as u8.public;
    rand.chacha into r2 as u8;
    rem r2 3u8 into r3;
    add r1 3u8 into r4;
    sub r4 r3 into r5;
    rem r5 3u8 into r6;
    cast 0u64 0u64 into r7 as Stats;
    get.or_use stats[r0] r7 into r8;
    cast 0u64 0u64 into r9 as Stats;
    get.or_use stats[5573883837986336656403728900743138501878058223219165284100750751991779905667field] r9 into r10;
    is.eq r6 1u8 into r11;
    branch.eq r11 false to end_then_0_0;
    add r8.wins 1u64 into r12;
    cast r12 r8.losses into r13 as Stats;
    set r13 into stats[r0];
    add r10.losses 1u64 into r14;
    cast r10.wins r14 into r15 as Stats;
    set r15 into stats[5573883837986336656403728900743138501878058223219165284100750751991779905667field];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    is.eq r6 2u8 into r16;
    branch.eq r16 false to end_then_1_2;
    add r8.losses 1u64 into r17;
    cast r8.wins r17 into r18 as Stats;
    set r18 into stats[r0];
    add r10.wins 1u64 into r19;
    cast r19 r10.losses into r20 as Stats;
    set r20 into stats[5573883837986336656403728900743138501878058223219165284100750751991779905667field];
    branch.eq true true to end_otherwise_1_3;
    position end_then_1_2;
    position end_otherwise_1_3;
    position end_otherwise_0_1;
    get.or_use game_count[r0] 0u64 into r21;
    cast r0 r21 into r22 as Game;
    hash.bhp256 r22 into r23 as field;
    cast r1 r3 r6 into r24 as Outcome;
    set r24 into history[r23];
    add r21 1u64 into r25;
    set r25 into game_count[r0];
