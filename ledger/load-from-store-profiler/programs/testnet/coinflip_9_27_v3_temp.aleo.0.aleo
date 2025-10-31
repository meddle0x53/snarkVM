import credits.aleo;

program coinflip_9_27_v3_temp.aleo;

record coin_flip_record:
    owner as address.private;
    id as u64.private;
    count as u64.private;

mapping user_coin_flip_map:
    key as address.public;
    value as u64.public;

mapping coin_flip_state_by_id:
    key as u64.public;
    value as u64.public;

function do_coin_flip:
    input r0 as u64.private;
    input r1 as u64.private;
    cast coinflip_9_27_v3.aleo into r2 as address;
    call credits.aleo/transfer_public_as_signer r2 100000u64 into r3;
    cast self.caller r0 r1 into r4 as coin_flip_record.record;
    async do_coin_flip r3 self.caller r0 r1 into r5;
    output r4 as coin_flip_record.record;
    output r5 as coinflip_9_27_v3_temp.aleo/do_coin_flip.future;

finalize do_coin_flip:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    await r0;
    rand.chacha into r4 as boolean;
    get.or_use user_coin_flip_map[r1] 0u64 into r5;
    is.eq r4 true into r6;
    branch.eq r6 false to end_then_0_0;
    set r3 into coin_flip_state_by_id[r2];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function claim:
    input r0 as coin_flip_record.record;
    mul 200000u64 r0.count into r1;
    call credits.aleo/transfer_public r0.owner r1 into r2;
    async claim r2 r0.owner r0.id into r3;
    output r3 as coinflip_9_27_v3_temp.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use coin_flip_state_by_id[r2] 0u64 into r3;
    gt r3 0u64 into r4;
    branch.eq r4 false to end_then_0_2;
    remove coin_flip_state_by_id[r2];
    await r0;
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
