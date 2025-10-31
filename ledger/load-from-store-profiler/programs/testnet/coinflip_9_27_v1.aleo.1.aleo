import credits.aleo;

program coinflip_9_27_v1.aleo;

record coin_flip_record:
    owner as address.private;

mapping user_coin_flip_map:
    key as address.public;
    value as u16.public;

function do_coin_flip:
    input r0 as u16.private;
    cast coinflip_9_27_v1.aleo into r1 as address;
    cast r0 into r2 as u64;
    mul r2 100000u64 into r3;
    call credits.aleo/transfer_public_as_signer r1 r3 into r4;
    cast self.caller into r5 as coin_flip_record.record;
    async do_coin_flip r4 self.caller r0 into r6;
    output r5 as coin_flip_record.record;
    output r6 as coinflip_9_27_v1.aleo/do_coin_flip.future;

finalize do_coin_flip:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u16.public;
    await r0;
    rand.chacha into r3 as boolean;
    get.or_use user_coin_flip_map[r1] 0u16 into r4;
    is.eq r3 true into r5;
    branch.eq r5 false to end_then_0_0;
    mul 1u16 r2 into r6;
    add r4 r6 into r7;
    set r7 into user_coin_flip_map[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function claim:
    input r0 as coin_flip_record.record;
    input r1 as u16.private;
    cast r1 into r2 as u64;
    mul 200000u64 r2 into r3;
    call credits.aleo/transfer_public r0.owner r3 into r4;
    async claim r4 r0.owner r1 into r5;
    output r5 as coinflip_9_27_v1.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u16.public;
    get.or_use user_coin_flip_map[r1] 0u16 into r3;
    gte r3 r2 into r4;
    branch.eq r4 false to end_then_0_2;
    sub r3 r2 into r5;
    set r5 into user_coin_flip_map[r1];
    await r0;
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
