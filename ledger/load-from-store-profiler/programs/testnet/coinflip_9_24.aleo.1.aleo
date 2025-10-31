program coinflip_9_24.aleo;

record coin_flip_record:
    owner as address.private;

mapping user_coin_flip_map:
    key as address.public;
    value as boolean.public;

function do_coin_flip:
    cast self.caller into r0 as coin_flip_record.record;
    async do_coin_flip self.caller into r1;
    output r0 as coin_flip_record.record;
    output r1 as coinflip_9_24.aleo/do_coin_flip.future;

finalize do_coin_flip:
    input r0 as address.public;
    rand.chacha into r1 as boolean;
    set r1 into user_coin_flip_map[r0];

function claim:
    input r0 as coin_flip_record.record;
    async claim r0.owner into r1;
    output r1 as coinflip_9_24.aleo/claim.future;

finalize claim:
    input r0 as address.public;
    get user_coin_flip_map[r0] into r1;
    remove user_coin_flip_map[r0];
    is.eq r1 true into r2;
    assert.eq r2 true;
