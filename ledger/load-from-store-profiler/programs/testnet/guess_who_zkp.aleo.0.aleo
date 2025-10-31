program guess_who_zkp.aleo;

struct Character:
    id as u8;
    hair_color as u8;
    eye_color as u8;
    glasses as boolean;
    facial_hair as boolean;
    hat as boolean;
    gender as u8;

struct GameState:
    player1 as address;
    player2 as address;
    player1_character as Character;
    player2_character as Character;
    current_turn as address;
    game_active as boolean;
    winner as address;
    questions_asked as u8;
    reward_claimed as boolean;

mapping games:
    key as field.public;
    value as GameState.public;

mapping player_balances:
    key as address.public;
    value as u64.public;

function create_game:
    input r0 as address.private;
    input r1 as Character.private;
    async create_game 123field r0 r1 into r2;
    output 123field as field.private;
    output r2 as guess_who_zkp.aleo/create_game.future;

finalize create_game:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as Character.public;
    get.or_use player_balances[r1] 0u64 into r3;
    gte r3 100000u64 into r4;
    assert.eq r4 true;
    cast 0u8 0u8 0u8 false false false 0u8 into r5 as Character;
    cast r1 r1 r2 r5 r1 false r1 0u8 false into r6 as GameState;
    set r6 into games[r0];
    sub r3 100000u64 into r7;
    set r7 into player_balances[r1];

function join_game:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as Character.private;
    async join_game r0 r1 r2 into r3;
    output r3 as guess_who_zkp.aleo/join_game.future;

finalize join_game:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as Character.public;
    get games[r0] into r3;
    not r3.game_active into r4;
    assert.eq r4 true;
    is.eq r3.player2 r3.player1 into r5;
    assert.eq r5 true;
    get.or_use player_balances[r1] 0u64 into r6;
    gte r6 100000u64 into r7;
    assert.eq r7 true;
    cast r3.player1 r1 r3.player1_character r2 r3.player1 true r3.winner 0u8 false into r8 as GameState;
    set r8 into games[r0];
    sub r6 100000u64 into r9;
    set r9 into player_balances[r1];

function ask_question:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as u8.private;
    input r3 as u8.private;
    gte r2 0u8 into r4;
    lte r2 6u8 into r5;
    and r4 r5 into r6;
    assert.eq r6 true;
    async ask_question r0 r1 r2 r3 into r7;
    output r7 as guess_who_zkp.aleo/ask_question.future;

finalize ask_question:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u8.public;
    input r3 as u8.public;
    get games[r0] into r4;
    is.eq r4.current_turn r1 into r5;
    assert.eq r5 true;
    is.eq r1 r4.player1 into r6;
    ternary r6 r4.player2_character.id r4.player1_character.id into r7;
    ternary r6 r4.player2_character.hair_color r4.player1_character.hair_color into r8;
    ternary r6 r4.player2_character.eye_color r4.player1_character.eye_color into r9;
    ternary r6 r4.player2_character.glasses r4.player1_character.glasses into r10;
    ternary r6 r4.player2_character.facial_hair r4.player1_character.facial_hair into r11;
    ternary r6 r4.player2_character.hat r4.player1_character.hat into r12;
    ternary r6 r4.player2_character.gender r4.player1_character.gender into r13;
    cast r7 r8 r9 r10 r11 r12 r13 into r14 as Character;
    is.eq r2 0u8 into r15;
    is.eq r14.id r3 into r16;
    is.eq r2 1u8 into r17;
    is.eq r14.hair_color r3 into r18;
    is.eq r2 2u8 into r19;
    is.eq r14.eye_color r3 into r20;
    is.eq r2 3u8 into r21;
    is.eq r3 1u8 into r22;
    is.eq r22 r14.glasses into r23;
    is.eq r2 4u8 into r24;
    is.eq r3 1u8 into r25;
    is.eq r25 r14.facial_hair into r26;
    is.eq r2 5u8 into r27;
    is.eq r3 1u8 into r28;
    is.eq r28 r14.hat into r29;
    is.eq r2 6u8 into r30;
    is.eq r14.gender r3 into r31;
    ternary r30 r31 false into r32;
    ternary r27 r29 r32 into r33;
    ternary r24 r26 r33 into r34;
    ternary r21 r23 r34 into r35;
    ternary r19 r20 r35 into r36;
    ternary r17 r18 r36 into r37;
    ternary r15 r16 r37 into r38;
    is.eq r1 r4.player1 into r39;
    ternary r39 r4.player2 r4.player1 into r40;
    ternary r38 r4.current_turn r40 into r41;
    add r4.questions_asked 1u8 into r42;
    not r38 into r43;
    lt r42 10u8 into r44;
    and r43 r44 into r45;
    ternary r38 r1 r4.winner into r46;
    cast r4.player1 r4.player2 r4.player1_character r4.player2_character r41 r45 r46 r42 r4.reward_claimed into r47 as GameState;
    set r47 into games[r0];

function claim_reward:
    input r0 as field.private;
    input r1 as address.private;
    async claim_reward r0 r1 into r2;
    output r2 as guess_who_zkp.aleo/claim_reward.future;

finalize claim_reward:
    input r0 as field.public;
    input r1 as address.public;
    get games[r0] into r2;
    not r2.game_active into r3;
    assert.eq r3 true;
    is.eq r2.winner r1 into r4;
    assert.eq r4 true;
    not r2.reward_claimed into r5;
    assert.eq r5 true;
    mul 100000u64 2u64 into r6;
    mul r6 10u64 into r7;
    div r7 100u64 into r8;
    sub r6 r8 into r9;
    get.or_use player_balances[r1] 0u64 into r10;
    add r10 r9 into r11;
    set r11 into player_balances[r1];
    get.or_use player_balances[aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m] 0u64 into r12;
    add r12 r8 into r13;
    set r13 into player_balances[aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m];
    cast r2.player1 r2.player2 r2.player1_character r2.player2_character r2.current_turn false r2.winner r2.questions_asked true into r14 as GameState;
    set r14 into games[r0];

function end_game:
    input r0 as field.private;
    async end_game r0 into r1;
    output r1 as guess_who_zkp.aleo/end_game.future;

finalize end_game:
    input r0 as field.public;
    get games[r0] into r1;
    assert.eq r1.game_active true;
    gte r1.questions_asked 10u8 into r2;
    assert.eq r2 true;
    mul 100000u64 2u64 into r3;
    mul r3 10u64 into r4;
    div r4 100u64 into r5;
    sub r3 r5 into r6;
    div r6 2u64 into r7;
    get.or_use player_balances[r1.player1] 0u64 into r8;
    get.or_use player_balances[r1.player2] 0u64 into r9;
    add r8 r7 into r10;
    set r10 into player_balances[r1.player1];
    add r9 r7 into r11;
    set r11 into player_balances[r1.player2];
    get.or_use player_balances[aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m] 0u64 into r12;
    add r12 r5 into r13;
    set r13 into player_balances[aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m];
    remove games[r0];
