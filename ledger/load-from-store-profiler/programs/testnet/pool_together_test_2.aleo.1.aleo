program pool_together_test_2.aleo;

struct Pool:
    pool_id as u64;
    total_credits as u64;
    total_paleo as u64;
    total_players as u64;
    closed as boolean;

struct PlayerPool:
    player as address;
    pool_id as u64;

struct PlayerSlot:
    pool_id as u64;
    player_id as u64;

mapping pool_counter:
    key as u8.public;
    value as u64.public;

mapping pools:
    key as u64.public;
    value as Pool.public;

mapping balances:
    key as field.public;
    value as u64.public;

mapping player_slots:
    key as field.public;
    value as address.public;

mapping pool_to_winner_slot:
    key as u64.public;
    value as u64.public;

function initialize_pool_public:
    async initialize_pool_public into r0;
    output r0 as pool_together_test_2.aleo/initialize_pool_public.future;

finalize initialize_pool_public:
    set 1u64 into pool_counter[0u8];
    cast 0u8 into r0 as u64;
    cast 1u64 0u64 0u64 0u64 false into r1 as Pool;
    set r1 into pools[r0];

function join_pool_public:
    input r0 as u64.public;
    input r1 as u64.public;
    async join_pool_public self.signer r0 r1 into r2;
    output r2 as pool_together_test_2.aleo/join_pool_public.future;

finalize join_pool_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get pool_counter[0u8] into r3;
    cast 0u64 0u64 0u64 0u64 false into r4 as Pool;
    get.or_use pools[r3] r4 into r5;
    not r5.closed into r6;
    assert.eq r6 true;
    cast r0 r3 into r7 as PlayerPool;
    hash.bhp256 r7 into r8 as field;
    get.or_use balances[r8] 0u64 into r9;
    add r9 r1 into r10;
    set r10 into balances[r8];
    cast r3 r5.total_players into r11 as PlayerSlot;
    hash.bhp256 r11 into r12 as field;
    set r0 into player_slots[r12];
    cast r1 into r13 as u64;
    add r5.total_credits r13 into r14;
    cast r2 into r15 as u64;
    add r5.total_paleo r15 into r16;
    add r5.total_players 1u64 into r17;
    cast r3 r14 r16 r17 false into r18 as Pool;
    set r18 into pools[r3];

function select_winner_public:
    async select_winner_public into r0;
    output r0 as pool_together_test_2.aleo/select_winner_public.future;

finalize select_winner_public:
    rand.chacha into r0 as u64;
    get pool_counter[0u8] into r1;
    get pools[r1] into r2;
    not r2.closed into r3;
    assert.eq r3 true;
    rem r0 r2.total_players into r4;
    set r4 into pool_to_winner_slot[r2.pool_id];
    cast r2.pool_id r2.total_credits r2.total_paleo r2.total_players true into r5 as Pool;
    set r5 into pools[r2.pool_id];
    add r1 1u64 into r6;
    set r6 into pool_counter[0u8];
