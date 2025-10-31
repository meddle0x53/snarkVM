program fantasy_sports_11.aleo;

record Contest:
    owner as address.private;
    contest_id as u64.private;
    entry_fee as u64.private;
    prize_pool as u64.private;
    is_active as boolean.private;

record Entry:
    owner as address.private;
    contest_id as u64.private;
    player as address.private;
    encrypted_team as field.private;
    is_winner as boolean.private;

function create_contest:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as u64.private;
    cast r0 r1 r2 r3 true into r4 as Contest.record;
    output r4 as Contest.record;

function join_contest:
    input r0 as address.private;
    input r1 as Contest.record;
    input r2 as address.private;
    input r3 as field.private;
    is.eq r1.is_active true into r4;
    assert.eq r4 true;
    cast r0 r1.contest_id r2 r3 false into r5 as Entry.record;
    output r5 as Entry.record;

function resolve_winner:
    input r0 as address.private;
    input r1 as Contest.record;
    input r2 as Entry.record;
    is.eq self.caller r1.owner into r3;
    assert.eq r3 true;
    cast r0 r1.contest_id r2.player r2.encrypted_team true into r4 as Entry.record;
    output r4 as Entry.record;

function distribute_prize:
    input r0 as Contest.record;
    input r1 as Entry.record;
    is.eq r0.is_active true into r2;
    assert.eq r2 true;
    is.eq r1.is_winner true into r3;
    assert.eq r3 true;
    cast r0.owner r0.contest_id r0.entry_fee 0u64 false into r4 as Contest.record;
    output r4 as Contest.record;
