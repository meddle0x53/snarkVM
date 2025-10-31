program leomafia.aleo;

record Player:
    owner as address.private;
    game_id as u32.private;
    role as u8.private;
    game_stake as u64.private;
    is_alive as boolean.private;

record VoteStake:
    owner as address.private;
    game_id as u32.private;
    target as address.private;
    amount as u64.private;

mapping game_players:
    key as field.public;
    value as boolean.public;

mapping game_votes:
    key as field.public;
    value as u32.public;

mapping game_role_counts:
    key as field.public;
    value as u32.public;

mapping game_status:
    key as field.public;
    value as boolean.public;

mapping has_joined:
    key as field.public;
    value as boolean.public;

mapping role_commitments:
    key as field.public;
    value as field.public;

mapping protected_players:
    key as field.public;
    value as u32.public;

mapping current_round:
    key as u32.public;
    value as u32.public;

mapping round_deadline:
    key as field.public;
    value as u32.public;

mapping mafia_targets:
    key as field.public;
    value as u32.public;

mapping game_stake_pool:
    key as u32.public;
    value as u64.public;

mapping vote_stake_pool:
    key as field.public;
    value as u64.public;

mapping player_count:
    key as u32.public;
    value as u32.public;

mapping game_started:
    key as u32.public;
    value as boolean.public;

function initialize:
    input r0 as u32.private;
    async initialize r0 into r1;
    output r1 as leomafia.aleo/initialize.future;

finalize initialize:
    input r0 as u32.public;
    hash.bhp256 r0 into r1 as field;
    hash.bhp256 0u8 into r2 as field;
    add r1 r2 into r3;
    get.or_use game_status[r3] false into r4;
    not r4 into r5;
    assert.eq r5 true;
    set true into game_status[r3];
    hash.bhp256 r0 into r6 as field;
    hash.bhp256 0u8 into r7 as field;
    add r6 r7 into r8;
    set 0u32 into game_role_counts[r8];
    hash.bhp256 r0 into r9 as field;
    hash.bhp256 1u8 into r10 as field;
    add r9 r10 into r11;
    set 0u32 into game_role_counts[r11];
    hash.bhp256 r0 into r12 as field;
    hash.bhp256 2u8 into r13 as field;
    add r12 r13 into r14;
    set 0u32 into game_role_counts[r14];
    hash.bhp256 r0 into r15 as field;
    hash.bhp256 3u8 into r16 as field;
    add r15 r16 into r17;
    set 0u32 into game_role_counts[r17];
    set 1u32 into current_round[r0];
    hash.bhp256 r0 into r18 as field;
    hash.bhp256 1u32 into r19 as field;
    add r18 r19 into r20;
    add block.height 10u32 into r21;
    set r21 into round_deadline[r20];
    set 0u64 into game_stake_pool[r0];
    set 0u32 into player_count[r0];
    set false into game_started[r0];

function join_game:
    input r0 as u32.private;
    input r1 as u64.private;
    gte r1 100000u64 into r2;
    assert.eq r2 true;
    cast self.caller r0 0u8 r1 true into r3 as Player.record;
    async join_game r0 self.caller r1 into r4;
    output r3 as Player.record;
    output r4 as leomafia.aleo/join_game.future;

finalize join_game:
    input r0 as u32.public;
    input r1 as address.public;
    input r2 as u64.public;
    hash.bhp256 r0 into r3 as field;
    hash.bhp256 0u8 into r4 as field;
    add r3 r4 into r5;
    get.or_use game_status[r5] false into r6;
    assert.eq r6 true;
    hash.bhp256 r1 into r7 as field;
    hash.bhp256 r0 into r8 as field;
    add r7 r8 into r9;
    get.or_use has_joined[r9] false into r10;
    not r10 into r11;
    assert.eq r11 true;
    get.or_use game_started[r0] false into r12;
    not r12 into r13;
    assert.eq r13 true;
    get.or_use player_count[r0] 0u32 into r14;
    rem r14 4u32 into r15;
    cast r15 into r16 as u8;
    hash.bhp256 r1 into r17 as field;
    hash.bhp256 r0 into r18 as field;
    hash.bhp256 r16 into r19 as field;
    add r18 r19 into r20;
    get.or_use game_role_counts[r20] 0u32 into r21;
    add r21 1u32 into r22;
    set r22 into game_role_counts[r20];
    hash.bhp256 r1 into r23 as field;
    hash.bhp256 r0 into r24 as field;
    add r23 r24 into r25;
    set r17 into role_commitments[r25];
    set true into game_players[r25];
    set true into has_joined[r9];
    get.or_use game_stake_pool[r0] 0u64 into r26;
    add r26 r2 into r27;
    set r27 into game_stake_pool[r0];
    add r14 1u32 into r28;
    set r28 into player_count[r0];
    add r14 1u32 into r29;
    gte r29 2u32 into r30;
    branch.eq r30 false to end_then_0_0;
    set true into game_started[r0];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function vote:
    input r0 as u32.private;
    input r1 as address.private;
    input r2 as Player.record;
    input r3 as u64.private;
    assert.eq r2.is_alive true;
    is.eq r2.game_id r0 into r4;
    assert.eq r4 true;
    gte r3 100u64 into r5;
    assert.eq r5 true;
    cast r2.owner r2.game_id r2.role r2.game_stake r2.is_alive into r6 as Player.record;
    cast r2.owner r0 r1 r3 into r7 as VoteStake.record;
    async vote r0 r1 r3 into r8;
    output r6 as Player.record;
    output r7 as VoteStake.record;
    output r8 as leomafia.aleo/vote.future;

finalize vote:
    input r0 as u32.public;
    input r1 as address.public;
    input r2 as u64.public;
    hash.bhp256 r0 into r3 as field;
    hash.bhp256 0u8 into r4 as field;
    add r3 r4 into r5;
    get.or_use game_status[r5] false into r6;
    assert.eq r6 true;
    hash.bhp256 r1 into r7 as field;
    hash.bhp256 r0 into r8 as field;
    add r7 r8 into r9;
    get.or_use game_players[r9] false into r10;
    assert.eq r10 true;
    get.or_use game_started[r0] false into r11;
    assert.eq r11 true;
    get.or_use current_round[r0] 1u32 into r12;
    hash.bhp256 r0 into r13 as field;
    hash.bhp256 r12 into r14 as field;
    add r13 r14 into r15;
    add block.height 1u32 into r16;
    get.or_use round_deadline[r15] r16 into r17;
    lte block.height r17 into r18;
    assert.eq r18 true;
    get.or_use game_votes[r9] 0u32 into r19;
    add r19 1u32 into r20;
    set r20 into game_votes[r9];
    hash.bhp256 r1 into r21 as field;
    hash.bhp256 r0 into r22 as field;
    add r21 r22 into r23;
    get.or_use vote_stake_pool[r23] 0u64 into r24;
    add r24 r2 into r25;
    set r25 into vote_stake_pool[r23];
    add r19 1u32 into r26;
    gte r26 3u32 into r27;
    branch.eq r27 false to end_then_0_2;
    set false into game_players[r9];
    get.or_use role_commitments[r9] 0field into r28;
    hash.bhp256 r1 into r29 as field;
    is.eq r28 r29 into r30;
    branch.eq r30 false to end_then_1_4;
    hash.bhp256 r0 into r31 as field;
    hash.bhp256 1u8 into r32 as field;
    add r31 r32 into r33;
    get.or_use game_role_counts[r33] 0u32 into r34;
    gt r34 0u32 into r35;
    branch.eq r35 false to end_then_2_6;
    sub r34 1u32 into r36;
    set r36 into game_role_counts[r33];
    branch.eq true true to end_otherwise_2_7;
    position end_then_2_6;
    position end_otherwise_2_7;
    branch.eq true true to end_otherwise_1_5;
    position end_then_1_4;
    position end_otherwise_1_5;
    hash.bhp256 r0 into r37 as field;
    hash.bhp256 1u8 into r38 as field;
    add r37 r38 into r39;
    hash.bhp256 r0 into r40 as field;
    hash.bhp256 0u8 into r41 as field;
    add r40 r41 into r42;
    hash.bhp256 r0 into r43 as field;
    hash.bhp256 2u8 into r44 as field;
    add r43 r44 into r45;
    hash.bhp256 r0 into r46 as field;
    hash.bhp256 3u8 into r47 as field;
    add r46 r47 into r48;
    get.or_use game_role_counts[r39] 0u32 into r49;
    get.or_use game_role_counts[r42] 0u32 into r50;
    get.or_use game_role_counts[r45] 0u32 into r51;
    add r50 r51 into r52;
    get.or_use game_role_counts[r48] 0u32 into r53;
    add r52 r53 into r54;
    hash.bhp256 r0 into r55 as field;
    hash.bhp256 0u8 into r56 as field;
    add r55 r56 into r57;
    hash.bhp256 r0 into r58 as field;
    hash.bhp256 2u8 into r59 as field;
    add r58 r59 into r60;
    hash.bhp256 r0 into r61 as field;
    hash.bhp256 1u8 into r62 as field;
    add r61 r62 into r63;
    gte r49 r54 into r64;
    branch.eq r64 false to end_then_1_8;
    set false into game_status[r57];
    set true into game_status[r60];
    branch.eq true true to end_otherwise_1_9;
    position end_then_1_8;
    is.eq r49 0u32 into r65;
    branch.eq r65 false to end_then_2_10;
    set false into game_status[r57];
    set true into game_status[r63];
    branch.eq true true to end_otherwise_2_11;
    position end_then_2_10;
    position end_otherwise_2_11;
    position end_otherwise_1_9;
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;

function investigate:
    input r0 as u32.private;
    input r1 as address.private;
    input r2 as Player.record;
    assert.eq r2.is_alive true;
    is.eq r2.role 2u8 into r3;
    assert.eq r3 true;
    is.eq r2.game_id r0 into r4;
    assert.eq r4 true;
    async investigate r0 r1 into r5;
    output r5 as leomafia.aleo/investigate.future;

finalize investigate:
    input r0 as u32.public;
    input r1 as address.public;
    hash.bhp256 r0 into r2 as field;
    hash.bhp256 0u8 into r3 as field;
    add r2 r3 into r4;
    get.or_use game_status[r4] false into r5;
    assert.eq r5 true;
    hash.bhp256 r1 into r6 as field;
    hash.bhp256 r0 into r7 as field;
    add r6 r7 into r8;
    get.or_use game_players[r8] false into r9;
    assert.eq r9 true;
    get.or_use game_started[r0] false into r10;
    assert.eq r10 true;
    get.or_use current_round[r0] 1u32 into r11;
    hash.bhp256 r0 into r12 as field;
    hash.bhp256 r11 into r13 as field;
    add r12 r13 into r14;
    add block.height 1u32 into r15;
    get.or_use round_deadline[r14] r15 into r16;
    lte block.height r16 into r17;
    assert.eq r17 true;

function protect:
    input r0 as u32.private;
    input r1 as address.private;
    input r2 as Player.record;
    assert.eq r2.is_alive true;
    is.eq r2.role 3u8 into r3;
    assert.eq r3 true;
    is.eq r2.game_id r0 into r4;
    assert.eq r4 true;
    async protect r0 r1 into r5;
    output r5 as leomafia.aleo/protect.future;

finalize protect:
    input r0 as u32.public;
    input r1 as address.public;
    hash.bhp256 r0 into r2 as field;
    hash.bhp256 0u8 into r3 as field;
    add r2 r3 into r4;
    get.or_use game_status[r4] false into r5;
    assert.eq r5 true;
    hash.bhp256 r1 into r6 as field;
    hash.bhp256 r0 into r7 as field;
    add r6 r7 into r8;
    get.or_use game_players[r8] false into r9;
    assert.eq r9 true;
    get.or_use game_started[r0] false into r10;
    assert.eq r10 true;
    get.or_use current_round[r0] 1u32 into r11;
    hash.bhp256 r0 into r12 as field;
    hash.bhp256 r11 into r13 as field;
    add r12 r13 into r14;
    add block.height 1u32 into r15;
    get.or_use round_deadline[r14] r15 into r16;
    lte block.height r16 into r17;
    assert.eq r17 true;
    set r11 into protected_players[r8];

function mafia_vote:
    input r0 as u32.private;
    input r1 as address.private;
    input r2 as Player.record;
    assert.eq r2.is_alive true;
    is.eq r2.role 1u8 into r3;
    assert.eq r3 true;
    is.eq r2.game_id r0 into r4;
    assert.eq r4 true;
    async mafia_vote r0 r1 into r5;
    output r5 as leomafia.aleo/mafia_vote.future;

finalize mafia_vote:
    input r0 as u32.public;
    input r1 as address.public;
    hash.bhp256 r0 into r2 as field;
    hash.bhp256 0u8 into r3 as field;
    add r2 r3 into r4;
    get.or_use game_status[r4] false into r5;
    assert.eq r5 true;
    hash.bhp256 r1 into r6 as field;
    hash.bhp256 r0 into r7 as field;
    add r6 r7 into r8;
    get.or_use game_players[r8] false into r9;
    assert.eq r9 true;
    get.or_use game_started[r0] false into r10;
    assert.eq r10 true;
    get.or_use current_round[r0] 1u32 into r11;
    hash.bhp256 r0 into r12 as field;
    hash.bhp256 r11 into r13 as field;
    add r12 r13 into r14;
    add block.height 1u32 into r15;
    get.or_use round_deadline[r14] r15 into r16;
    lte block.height r16 into r17;
    assert.eq r17 true;
    get.or_use mafia_targets[r8] 0u32 into r18;
    add r18 1u32 into r19;
    set r19 into mafia_targets[r8];

function end_round:
    input r0 as u32.private;
    async end_round r0 into r1;
    output r1 as leomafia.aleo/end_round.future;

finalize end_round:
    input r0 as u32.public;
    hash.bhp256 r0 into r1 as field;
    hash.bhp256 0u8 into r2 as field;
    add r1 r2 into r3;
    get.or_use game_status[r3] false into r4;
    assert.eq r4 true;
    get.or_use current_round[r0] 1u32 into r5;
    hash.bhp256 r0 into r6 as field;
    hash.bhp256 r5 into r7 as field;
    add r6 r7 into r8;
    get.or_use round_deadline[r8] 0u32 into r9;
    gt block.height r9 into r10;
    assert.eq r10 true;
    get.or_use game_started[r0] false into r11;
    assert.eq r11 true;
    add r5 1u32 into r12;
    set r12 into current_round[r0];
    hash.bhp256 r0 into r13 as field;
    hash.bhp256 r12 into r14 as field;
    add r13 r14 into r15;
    add block.height 10u32 into r16;
    set r16 into round_deadline[r15];
    hash.bhp256 r0 into r17 as field;
    hash.bhp256 1u8 into r18 as field;
    add r17 r18 into r19;
    hash.bhp256 r0 into r20 as field;
    hash.bhp256 0u8 into r21 as field;
    add r20 r21 into r22;
    hash.bhp256 r0 into r23 as field;
    hash.bhp256 2u8 into r24 as field;
    add r23 r24 into r25;
    hash.bhp256 r0 into r26 as field;
    hash.bhp256 3u8 into r27 as field;
    add r26 r27 into r28;
    get.or_use game_role_counts[r19] 0u32 into r29;
    get.or_use game_role_counts[r22] 0u32 into r30;
    get.or_use game_role_counts[r25] 0u32 into r31;
    add r30 r31 into r32;
    get.or_use game_role_counts[r28] 0u32 into r33;
    add r32 r33 into r34;
    hash.bhp256 r0 into r35 as field;
    hash.bhp256 0u8 into r36 as field;
    add r35 r36 into r37;
    hash.bhp256 r0 into r38 as field;
    hash.bhp256 2u8 into r39 as field;
    add r38 r39 into r40;
    hash.bhp256 r0 into r41 as field;
    hash.bhp256 1u8 into r42 as field;
    add r41 r42 into r43;
    gte r29 r34 into r44;
    branch.eq r44 false to end_then_0_12;
    set false into game_status[r37];
    set true into game_status[r40];
    branch.eq true true to end_otherwise_0_13;
    position end_then_0_12;
    is.eq r29 0u32 into r45;
    branch.eq r45 false to end_then_1_14;
    set false into game_status[r37];
    set true into game_status[r43];
    branch.eq true true to end_otherwise_1_15;
    position end_then_1_14;
    position end_otherwise_1_15;
    position end_otherwise_0_13;

function distribute_rewards:
    input r0 as u32.private;
    async distribute_rewards r0 into r1;
    output r1 as leomafia.aleo/distribute_rewards.future;

finalize distribute_rewards:
    input r0 as u32.public;
    hash.bhp256 r0 into r1 as field;
    hash.bhp256 0u8 into r2 as field;
    add r1 r2 into r3;
    get.or_use game_status[r3] false into r4;
    not r4 into r5;
    assert.eq r5 true;
