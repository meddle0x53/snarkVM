program pool_together_test_1.aleo;

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

function join_pool_public:
    input r0 as u64.public;
    input r1 as u64.public;
    async join_pool_public self.signer r0 r1 into r2;
    output r2 as pool_together_test_1.aleo/join_pool_public.future;

finalize join_pool_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get pool_counter[0u8] into r3;
    get pools[r3] into r4;
    not r4.closed into r5;
    assert.eq r5 true;
    cast r0 r3 into r6 as PlayerPool;
    hash.bhp256 r6 into r7 as field;
    get balances[r7] into r8;
    add r8 r1 into r9;
    set r9 into balances[r7];
    cast r3 r4.total_players into r10 as PlayerSlot;
    hash.bhp256 r10 into r11 as field;
    set r0 into player_slots[r11];
    cast r1 into r12 as u64;
    add r4.total_credits r12 into r13;
    cast r2 into r14 as u64;
    add r4.total_paleo r14 into r15;
    add r4.total_players 1u64 into r16;
    cast r3 r13 r15 r16 false into r17 as Pool;
    set r17 into pools[r3];

function select_winner_public:
    async select_winner_public into r0;
    output r0 as pool_together_test_1.aleo/select_winner_public.future;

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
