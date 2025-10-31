program minimask_game_hive123.aleo;

struct Game:
    id as u32;
    description as field;
    likes as u32;
    dislikes as u32;

mapping games:
    key as u32.public;
    value as Game.public;

mapping has_voted:
    key as address.public;
    value as boolean.public;

function add_game:
    input r0 as u32.public;
    input r1 as field.public;
    async add_game r0 r1 self.caller into r2;
    output r2 as minimask_game_hive123.aleo/add_game.future;

finalize add_game:
    input r0 as u32.public;
    input r1 as field.public;
    input r2 as address.public;
    is.eq r2 aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h into r3;
    assert.eq r3 true;
    contains games[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    cast r0 r1 0u32 0u32 into r6 as Game;
    get.or_use games[r0] r6 into r7;
    set r7 into games[r0];

function delete_game:
    input r0 as u32.public;
    input r1 as field.public;
    async delete_game r0 r1 self.caller into r2;
    output r2 as minimask_game_hive123.aleo/delete_game.future;

finalize delete_game:
    input r0 as u32.public;
    input r1 as field.public;
    input r2 as address.public;
    is.eq r2 aleo1f5enhpxfz3l3pqyh8k9d5xkqu0njv27xp5sv4nedarrk3nrgnuzqm3pp9h into r3;
    assert.eq r3 true;
    contains games[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    cast r0 r1 0u32 0u32 into r6 as Game;
    get.or_use games[r0] r6 into r7;
    remove games[r0];

function like_game:
    input r0 as u32.public;
    async like_game r0 self.caller into r1;
    output r1 as minimask_game_hive123.aleo/like_game.future;

finalize like_game:
    input r0 as u32.public;
    input r1 as address.public;
    contains games[r0] into r2;
    assert.eq r2 true;
    get.or_use has_voted[r1] false into r3;
    not r3 into r4;
    assert.eq r4 true;
    cast r0 123field 0u32 0u32 into r5 as Game;
    get.or_use games[r0] r5 into r6;
    add r6.likes 1u32 into r7;
    cast r6.id r6.description r7 r6.dislikes into r8 as Game;
    set r8 into games[r0];
    set true into has_voted[r1];

function dislike_game:
    input r0 as u32.public;
    async dislike_game r0 self.caller into r1;
    output r1 as minimask_game_hive123.aleo/dislike_game.future;

finalize dislike_game:
    input r0 as u32.public;
    input r1 as address.public;
    contains games[r0] into r2;
    assert.eq r2 true;
    get.or_use has_voted[r1] false into r3;
    not r3 into r4;
    assert.eq r4 true;
    cast r0 123field 0u32 0u32 into r5 as Game;
    get.or_use games[r0] r5 into r6;
    add r6.dislikes 1u32 into r7;
    cast r6.id r6.description r6.likes r7 into r8 as Game;
    set r8 into games[r0];
    set true into has_voted[r1];

function get_game:
    input r0 as u32.public;
    async get_game r0 into r1;
    output r1 as minimask_game_hive123.aleo/get_game.future;

finalize get_game:
    input r0 as u32.public;
    contains games[r0] into r1;
    assert.eq r1 true;
    get games[r0] into r2;

function check_vote:
    input r0 as address.public;
    input r1 as u32.public;
    async check_vote r0 r1 into r2;
    output r2 as minimask_game_hive123.aleo/check_vote.future;

finalize check_vote:
    input r0 as address.public;
    input r1 as u32.public;
    get.or_use has_voted[r0] false into r2;
