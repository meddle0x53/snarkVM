program aleo_monopoly_test02.aleo;

record Buildings:
    owner as address.private;
    amount as u64.private;
    buildings as u64.private;

record Reveal_Versus:
    owner as address.private;
    versus_hash as field.private;

struct TokenInfo:
    name as field;
    symbol as field;
    decimals as u8;
    circulating_supply as u64;
    total_supply as u64;
    testers as u64;
    admin as address;

struct TestToken:
    name as field;
    symbol as field;
    decimals as u8;
    circulating_supply as u64;
    total_supply as u64;
    admin as address;

struct BuildingInfo:
    building_id as field;
    max_building as u64;
    receiver as address;
    building_price as u64;
    total_building as u64;

record Reward:
    owner as address.private;
    amount as u64.private;

struct GlobalState:
    next_token_id as field;
    admin as address;

struct Versus:
    game_id as field;
    player as address;
    opponent as address;
    game_begins as boolean;
    player_goal as u64;
    opponent_goal as u64;
    max_game as u8;

struct Tournament:
    tournament_id as field;
    target_amount as u64;
    criteria_amount as u64;
    winners as u64;
    winners_active as boolean;
    active as boolean;
    admin as address;

mapping account:
    key as address.public;
    value as u64.public;

mapping get_reward:
    key as address.public;
    value as u64.public;

mapping tokens:
    key as u64.public;
    value as TokenInfo.public;

mapping test_token:
    key as u64.public;
    value as TestToken.public;

mapping unique_building:
    key as field.public;
    value as BuildingInfo.public;

mapping global_tournament_state:
    key as field.public;
    value as Tournament.public;

mapping global_state:
    key as boolean.public;
    value as GlobalState.public;

mapping versus_player:
    key as field.public;
    value as Versus.public;

function init:
    input r0 as boolean.private;
    async init aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m into r1;
    output self.caller as address.private;
    output r1 as aleo_monopoly_test02.aleo/init.future;

finalize init:
    input r0 as address.public;
    cast 0field aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m into r1 as GlobalState;
    get.or_use global_state[true] r1 into r2;
    assert.eq r2.next_token_id 0field;
    assert.eq r0 r2.admin;
    cast 1field r2.admin into r3 as GlobalState;
    set r3 into global_state[true];
    get.or_use account[r0] 0u64 into r4;
    is.eq r4 0u64 into r5;
    assert.eq r5 true;
    add r4 60000000u64 into r6;
    set r6 into account[r0];
    add 0u64 60000000u64 into r7;
    cast 4577111110111112111108121field 4577111110111112111108121field 6u8 r7 15000000000000u64 r2.admin into r8 as TestToken;
    set r8 into test_token[15000000000000u64];

function change_admin:
    input r0 as address.private;
    async change_admin r0 into r1;
    output self.caller as address.private;
    output r1 as aleo_monopoly_test02.aleo/change_admin.future;

finalize change_admin:
    input r0 as address.public;
    get global_state[true] into r1;
    assert.eq r0 r1.admin;
    cast r1.next_token_id r0 into r2 as GlobalState;
    set r2 into global_state[true];

function issue:
    input r0 as address.private;
    input r1 as u64.private;
    async issue r0 r1 into r2;
    output r0 as address.private;
    output r1 as u64.private;
    output r2 as aleo_monopoly_test02.aleo/issue.future;

finalize issue:
    input r0 as address.public;
    input r1 as u64.public;
    cast 0field aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m into r2 as GlobalState;
    get.or_use global_state[true] r2 into r3;
    is.eq r3.next_token_id 1field into r4;
    assert.eq r4 true;
    cast 4577111110111112111108121field 4577111110111112111108121field 6u8 0u64 15000000000000u64 r3.admin into r5 as TestToken;
    get.or_use test_token[15000000000000u64] r5 into r6;
    get.or_use account[r0] 0u64 into r7;
    add r6.circulating_supply r1 into r8;
    lte r8 r6.total_supply into r9;
    assert.eq r9 true;
    is.eq r1 10000u64 into r10;
    assert.eq r10 true;
    cast r6.name r6.symbol r6.decimals r8 r6.total_supply r3.admin into r11 as TestToken;
    set r11 into test_token[15000000000000u64];
    is.eq r7 0u64 into r12;
    assert.eq r12 true;
    add r7 r1 into r13;
    set r13 into account[r0];

function monopoly_buy:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    sub r1 5000u64 into r3;
    cast r0 r3 r2 into r4 as Buildings.record;
    async monopoly_buy r0 5000u64 1u64 into r5;
    output r4 as Buildings.record;
    output 5000u64 as u64.private;
    output r5 as aleo_monopoly_test02.aleo/monopoly_buy.future;

finalize monopoly_buy:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    hash.keccak512 r0 into r3 as field;
    get.or_use account[r0] 0u64 into r4;
    gt r4 0u64 into r5;
    assert.eq r5 true;
    rand.chacha into r6 as field;
    cast r6 0u64 r0 r1 0u64 into r7 as BuildingInfo;
    get.or_use unique_building[r3] r7 into r8;
    get.or_use account[r0] 0u64 into r9;
    sub r9 r8.building_price into r10;
    set r10 into account[r0];
    gt r9 r8.building_price into r11;
    assert.eq r11 true;
    is.eq r8.receiver r0 into r12;
    assert.eq r12 true;
    gte r8.max_building 0u64 into r13;
    assert.eq r13 true;
    lte r8.total_building 100000u64 into r14;
    assert.eq r14 true;
    add r8.max_building r2 into r15;
    add r8.building_price 500u64 into r16;
    add r8.total_building r2 into r17;
    cast r8.building_id r15 r8.receiver r16 r17 into r18 as BuildingInfo;
    set r18 into unique_building[r3];

function monopoly_rent:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    cast r0 r1 r2 into r3 as Buildings.record;
    async monopoly_rent r0 150u64 1u64 into r4;
    output r3 as Buildings.record;
    output 150u64 as u64.private;
    output r4 as aleo_monopoly_test02.aleo/monopoly_rent.future;

finalize monopoly_rent:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    hash.keccak512 r0 into r3 as field;
    cast 123field 0u64 r0 0u64 0u64 into r4 as BuildingInfo;
    get.or_use unique_building[r3] r4 into r5;
    is.eq r5.receiver r0 into r6;
    assert.eq r6 true;
    gte r5.max_building 1u64 into r7;
    assert.eq r7 true;
    get.or_use account[r0] 0u64 into r8;
    gt r8 0u64 into r9;
    assert.eq r9 true;
    get.or_use account[r0] 0u64 into r10;
    rand.chacha into r11 as u64;
    gt 9223372036854775808u64 r11 into r12;
    mul r5.max_building 150u64 into r13;
    add r10 r13 into r14;
    mul r5.max_building 150u64 into r15;
    sub r10 r15 into r16;
    ternary r12 r14 r16 into r17;
    set r17 into account[r0];

function monopoly_sale:
    input r0 as address.private;
    input r1 as address.private;
    async monopoly_sale r0 r1 into r2;
    output r0 as address.private;
    output r1 as address.private;
    output r2 as aleo_monopoly_test02.aleo/monopoly_sale.future;

finalize monopoly_sale:
    input r0 as address.public;
    input r1 as address.public;
    hash.keccak512 r0 into r2 as field;
    hash.keccak512 r1 into r3 as field;
    cast 123field 0u64 r0 0u64 0u64 into r4 as BuildingInfo;
    get.or_use unique_building[r2] r4 into r5;
    is.eq r5.receiver r0 into r6;
    assert.eq r6 true;
    gte r5.max_building 1u64 into r7;
    assert.eq r7 true;
    get.or_use account[r0] 0u64 into r8;
    gt r8 0u64 into r9;
    assert.eq r9 true;
    get.or_use account[r1] 0u64 into r10;
    gte r10 5000u64 into r11;
    assert.eq r11 true;
    assert.eq r1 aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m;
    get.or_use account[r1] 0u64 into r12;
    mul r5.max_building r5.building_price into r13;
    mul r5.max_building 1000u64 into r14;
    sub r13 r14 into r15;
    sub r12 r15 into r16;
    set r16 into account[r1];
    get.or_use account[r0] 0u64 into r17;
    mul r5.max_building r5.building_price into r18;
    add r17 r18 into r19;
    set r19 into account[r0];
    lte r5.max_building r5.max_building into r20;
    assert.eq r20 true;
    mul r5.max_building 600u64 into r21;
    sub r5.building_price r21 into r22;
    sub r5.total_building r5.max_building into r23;
    cast r5.building_id r5.max_building r0 r22 r23 into r24 as BuildingInfo;
    set r24 into unique_building[r2];
    add r5.max_building r5.max_building into r25;
    gte r25 r5.max_building into r26;
    assert.eq r26 true;
    cast r5.building_id r25 r1 r5.building_price r5.total_building into r27 as BuildingInfo;
    set r27 into unique_building[r3];
    remove unique_building[r2];

function mint_reward:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as Reward.record;
    async mint_reward r0 r1 into r3;
    output r2 as Reward.record;
    output r3 as aleo_monopoly_test02.aleo/mint_reward.future;

finalize mint_reward:
    input r0 as address.public;
    input r1 as u64.public;
    cast 4577111110111112111108121field 4577111110111112111108121field 6u8 0u64 15000000000000u64 0u64 aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m into r2 as TokenInfo;
    get.or_use tokens[15000000000000u64] r2 into r3;
    add r3.circulating_supply r1 into r4;
    lte r4 r3.total_supply into r5;
    assert.eq r5 true;
    add r3.testers 1u64 into r6;
    cast r3.name r3.symbol r3.decimals r4 r3.total_supply r6 r3.admin into r7 as TokenInfo;
    set r7 into tokens[15000000000000u64];
    get.or_use account[r0] 0u64 into r8;
    gte r8 12000u64 into r9;
    assert.eq r9 true;
    lte r3.testers 5000u64 into r10;
    assert.eq r10 true;
    get.or_use get_reward[r0] 0u64 into r11;
    assert.eq r11 0u64;
    get.or_use get_reward[r0] 0u64 into r12;
    add r12 r1 into r13;
    set r13 into get_reward[r0];

function play_request:
    input r0 as address.private;
    input r1 as address.private;
    async play_request r0 r1 into r2;
    output r2 as aleo_monopoly_test02.aleo/play_request.future;

finalize play_request:
    input r0 as address.public;
    input r1 as address.public;
    cast 123field r0 r1 false 0u64 0u64 0u8 into r2 as Versus;
    get.or_use versus_player[123field] r2 into r3;
    assert.neq r0 r1;
    assert.eq r3.max_game 0u8;
    get.or_use account[r0] 0u64 into r4;
    get.or_use account[r1] 0u64 into r5;
    gte r4 1000u64 into r6;
    assert.eq r6 true;
    gte r5 1000u64 into r7;
    assert.eq r7 true;
    hash.keccak512 r0 into r8 as field;
    hash.keccak512 r1 into r9 as field;
    add r8 r9 into r10;
    cast r10 r0 r1 false 0u64 0u64 0u8 into r11 as Versus;
    set r11 into versus_player[r10];

function accept_request:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as field.private;
    async accept_request self.caller r1 r2 into r3;
    output r3 as aleo_monopoly_test02.aleo/accept_request.future;

finalize accept_request:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as field.public;
    cast r2 r0 r1 false 0u64 0u64 0u8 into r3 as Versus;
    get.or_use versus_player[r2] r3 into r4;
    assert.neq r0 r1;
    assert.eq r4.max_game 0u8;
    get.or_use account[r0] 0u64 into r5;
    get.or_use account[r1] 0u64 into r6;
    gte r5 1000u64 into r7;
    assert.eq r7 true;
    gte r6 1000u64 into r8;
    assert.eq r8 true;
    add r5 1000u64 into r9;
    add r6 1000u64 into r10;
    hash.keccak512 r0 into r11 as field;
    hash.keccak512 r1 into r12 as field;
    add r11 r12 into r13;
    assert.eq r13 r4.game_id;
    assert.eq r13 r2;
    assert.eq r4.game_begins false;
    cast r13 r0 r1 true r9 r10 1u8 into r14 as Versus;
    set r14 into versus_player[r13];

function check_request:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as field.private;
    async check_request self.caller r1 r2 into r3;
    output r3 as aleo_monopoly_test02.aleo/check_request.future;

finalize check_request:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as field.public;
    cast r2 r0 r1 false 0u64 0u64 0u8 into r3 as Versus;
    get.or_use versus_player[r2] r3 into r4;
    assert.neq r0 r1;
    get.or_use account[r0] 0u64 into r5;
    get.or_use account[r1] 0u64 into r6;
    assert.eq r4.max_game 1u8;
    gte r5 1000u64 into r7;
    gte r6 1000u64 into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    hash.keccak512 r0 into r10 as field;
    hash.keccak512 r1 into r11 as field;
    add r10 r11 into r12;
    assert.eq r12 r4.game_id;
    assert.eq r12 r2;
    assert.eq r4.game_begins false;
    gte r5 r4.player_goal into r13;
    gte r6 r4.opponent_goal into r14;
    or r13 r14 into r15;
    assert.eq r15 true;
    gte r5 r4.player_goal into r16;
    add r5 1000u64 into r17;
    add r5 0u64 into r18;
    ternary r16 r17 r18 into r19;
    set r19 into account[r0];
    gte r6 r4.opponent_goal into r20;
    add r6 1000u64 into r21;
    add r6 0u64 into r22;
    ternary r20 r21 r22 into r23;
    set r23 into account[r1];
    remove versus_player[r4.game_id];

function init_tournament:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as u64.private;
    input r4 as boolean.private;
    async init_tournament self.caller r0 r1 r2 r3 r4 into r5;
    output r5 as aleo_monopoly_test02.aleo/init_tournament.future;

finalize init_tournament:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    input r5 as boolean.public;
    cast r1 0u64 0u64 0u64 false true aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m into r6 as Tournament;
    get.or_use global_tournament_state[123field] r6 into r7;
    assert.eq r0 r7.admin;
    cast r1 r2 r3 r4 false true r7.admin into r8 as Tournament;
    set r8 into global_tournament_state[r1];

function tournament_game:
    input r0 as address.private;
    async tournament_game r0 into r1;
    output r1 as aleo_monopoly_test02.aleo/tournament_game.future;

finalize tournament_game:
    input r0 as address.public;
    cast 123field 0u64 0u64 0u64 false true aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m into r1 as Tournament;
    get.or_use global_tournament_state[123field] r1 into r2;
    assert.eq r2.active true;
    get.or_use account[r0] 0u64 into r3;
    gte r3 r2.target_amount into r4;
    gte r3 r2.criteria_amount into r5;
    and r4 r5 into r6;
    assert.eq r6 true;
    is.eq r2.winners_active false into r7;
    assert.eq r7 true;
    sub r2.winners 1u64 into r8;
    gt r2.winners 0u64 into r9;
    assert.eq r9 true;
    get.or_use get_reward[r0] 0u64 into r10;
    add r10 5000u64 into r11;
    set r11 into get_reward[r0];
    cast r2.tournament_id r2.target_amount r2.criteria_amount r8 true true aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m into r12 as Tournament;
    set r12 into global_tournament_state[r2.tournament_id];

function end_tournament:
    input r0 as field.private;
    input r1 as boolean.private;
    async end_tournament r0 self.caller into r2;
    output r2 as aleo_monopoly_test02.aleo/end_tournament.future;

finalize end_tournament:
    input r0 as field.public;
    input r1 as address.public;
    cast 123field 0u64 0u64 0u64 false true aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m into r2 as Tournament;
    get.or_use global_tournament_state[123field] r2 into r3;
    assert.eq r1 r3.admin;
    assert.eq r0 r3.tournament_id;
    assert.eq r3.winners 0u64;
    remove global_tournament_state[r3.tournament_id];

function combine_owner_opponent_hash:
    input r0 as address.private;
    input r1 as address.private;
    assert.eq r0 self.caller;
    assert.neq r1 self.caller;
    hash.keccak512 r0 into r2 as field;
    hash.keccak512 r1 into r3 as field;
    add r2 r3 into r4;
    cast r0 r4 into r5 as Reveal_Versus.record;
    output r5 as Reveal_Versus.record;

function send_token:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as u64.private;
    async send_token r0 r1 r2 into r3;
    output r2 as u64.private;
    output r3 as aleo_monopoly_test02.aleo/send_token.future;

finalize send_token:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    assert.eq r0 aleo1az8p9vlllyqwtj0c2g9svkd0e5v0p3zzdflwwrpa7kpe8xrfxgfqqpru7m;
    get.or_use account[r0] 0u64 into r3;
    get.or_use account[r1] 0u64 into r4;
    gte r3 r2 into r5;
    assert.eq r5 true;
    hash.keccak512 r1 into r6 as field;
    cast 123field 0u64 r1 0u64 0u64 into r7 as BuildingInfo;
    get.or_use unique_building[r6] r7 into r8;
    gte r8.max_building 1u64 into r9;
    assert.eq r9 true;
    sub r3 r2 into r10;
    set r10 into account[r0];
    add r4 r2 into r11;
    set r11 into account[r1];

function hashed_address:
    input r0 as address.private;
    hash.keccak512 r0 into r1 as address;
    hash.keccak512 r0 into r2 as field;
    cast r1 r2 into r3 as Reveal_Versus.record;
    output r3 as Reveal_Versus.record;
