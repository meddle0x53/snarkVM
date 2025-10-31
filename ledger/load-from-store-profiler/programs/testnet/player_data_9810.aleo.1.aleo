program player_data_9810.aleo;

record PlayerData:
    owner as address.private;
    avgscore as u32.private;
    miscdata as u32.private;
    player_id as u32.private;
    bet_amount as u32.private;

function create_player_data:
    input r0 as u32.public;
    input r1 as u32.public;
    input r2 as u32.public;
    input r3 as u32.public;
    cast self.caller r1 r2 r0 r3 into r4 as PlayerData.record;
    output r4 as PlayerData.record;

function update_avgscore:
    input r0 as PlayerData.record;
    input r1 as u32.public;
    assert.eq r0.owner self.caller;
    cast r0.owner r1 r0.miscdata r0.player_id r0.bet_amount into r2 as PlayerData.record;
    output r2 as PlayerData.record;

function update_miscdata:
    input r0 as PlayerData.record;
    input r1 as u32.public;
    assert.eq r0.owner self.caller;
    cast r0.owner r0.avgscore r1 r0.player_id r0.bet_amount into r2 as PlayerData.record;
    output r2 as PlayerData.record;

function update_player_data:
    input r0 as PlayerData.record;
    input r1 as u32.public;
    input r2 as u32.public;
    assert.eq r0.owner self.caller;
    cast r0.owner r1 r2 r0.player_id r0.bet_amount into r3 as PlayerData.record;
    output r3 as PlayerData.record;

function share_player_data:
    input r0 as PlayerData.record;
    assert.eq r0.owner self.caller;
    output r0 as PlayerData.record;
    output r0.player_id as u32.private;
    output r0.avgscore as u32.private;
    output r0.miscdata as u32.private;
    output r0.owner as address.private;

function compare_avgscores:
    input r0 as PlayerData.record;
    input r1 as PlayerData.record;
    gte r0.avgscore r1.avgscore into r2;
    gte r0.avgscore r1.avgscore into r3;
    sub r0.avgscore r1.avgscore into r4;
    sub r1.avgscore r0.avgscore into r5;
    ternary r3 r4 r5 into r6;
    output r6 as u32.private;
    output r2 as boolean.private;

function get_player_info:
    input r0 as PlayerData.record;
    output r0.player_id as u32.private;
    output r0.avgscore as u32.private;
    output r0.miscdata as u32.private;
