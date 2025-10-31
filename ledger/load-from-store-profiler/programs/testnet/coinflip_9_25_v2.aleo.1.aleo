import credits.aleo;

program coinflip_9_25_v2.aleo;

record coin_flip_record:
    owner as address.private;

mapping user_coin_flip_map:
    key as address.public;
    value as boolean.public;

function do_coin_flip:
    cast coinflip_9_25.aleo into r0 as address;
    call credits.aleo/transfer_public_as_signer r0 100000u64 into r1;
    cast self.caller into r2 as coin_flip_record.record;
    async do_coin_flip r1 self.caller into r3;
    output r2 as coin_flip_record.record;
    output r3 as coinflip_9_25_v2.aleo/do_coin_flip.future;

finalize do_coin_flip:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    await r0;
    rand.chacha into r2 as boolean;
    set r2 into user_coin_flip_map[r1];

function do_coin_flip_v2:
    cast coinflip_9_25.aleo into r0 as address;
    call credits.aleo/transfer_public_as_signer r0 100000u64 into r1;
    call credits.aleo/transfer_public self.caller 200000u64 into r2;
    cast self.caller into r3 as coin_flip_record.record;
    async do_coin_flip_v2 r1 r2 self.caller into r4;
    output r3 as coin_flip_record.record;
    output r4 as coinflip_9_25_v2.aleo/do_coin_flip_v2.future;

finalize do_coin_flip_v2:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/transfer_public.future;
    input r2 as address.public;
    await r0;
    rand.chacha into r3 as boolean;
    set r3 into user_coin_flip_map[r2];
    is.eq r3 true into r4;
    branch.eq r4 false to end_then_0_0;
    await r1;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function claim:
    input r0 as coin_flip_record.record;
    call credits.aleo/transfer_public r0.owner 200000u64 into r1;
    async claim r1 r0.owner into r2;
    output r2 as coinflip_9_25_v2.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    get.or_use user_coin_flip_map[r1] false into r2;
    branch.eq r2 false to end_then_0_2;
    remove user_coin_flip_map[r1];
    await r0;
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
