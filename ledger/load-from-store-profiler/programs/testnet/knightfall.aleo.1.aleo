program knightfall.aleo;

record GameRequest:
    owner as address.private;
    player_address as address.private;
    opponent_address as address.private;
    amount as u64.private;

record GameRecord:
    owner as address.private;
    player_one as address.private;
    player_two as address.private;
    winnings as u64.private;

struct rank_data:
    games_won as u64;
    games_played as u64;

mapping ranks:
    key as address.public;
    value as rank_data.public;

function collect_stake:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as u64.private;
    cast r0 self.caller r1 r2 into r3 as GameRequest.record;
    output r3 as GameRequest.record;

function create_game:
    input r0 as address.private;
    input r1 as GameRequest.record;
    input r2 as GameRequest.record;
    assert.eq r1.amount r2.amount;
    add r1.amount r2.amount into r3;
    cast r0 r1.player_address r2.player_address r3 into r4 as GameRecord.record;
    output r4 as GameRecord.record;

function finish_game:
    input r0 as address.private;
    input r1 as address.private;
    async finish_game r0 r1 1u64 into r2;
    output r2 as knightfall.aleo/finish_game.future;

finalize finish_game:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    cast 0u64 0u64 into r3 as rank_data;
    get.or_use ranks[r0] r3 into r4;
    add r4.games_won r2 into r5;
    add r4.games_played 1u64 into r6;
    cast r5 r6 into r7 as rank_data;
    cast 0u64 0u64 into r8 as rank_data;
    get.or_use ranks[r1] r8 into r9;
    add r9.games_played 1u64 into r10;
    cast r9.games_won r10 into r11 as rank_data;
    set r7 into ranks[r0];
    set r11 into ranks[r1];
