import credits.aleo;

program coinflip_9_30_v1.aleo;

record coin_flip_record:
    owner as address.private;
    id as u64.private;
    count as u64.private;
    bet as boolean.private;
    timestamp as u64.private;

mapping coin_flip_state_by_id:
    key as u64.public;
    value as u64.public;

function do_coin_flip:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as boolean.public;
    input r3 as u64.public;
    cast coinflip_9_27_v5.aleo into r4 as address;
    mul r1 100000u64 into r5;
    call credits.aleo/transfer_public_as_signer r4 r5 into r6;
    cast self.caller r0 r1 r2 r3 into r7 as coin_flip_record.record;
    async do_coin_flip r6 self.caller r0 r1 r2 into r8;
    output r7 as coin_flip_record.record;
    output r8 as coinflip_9_30_v1.aleo/do_coin_flip.future;

finalize do_coin_flip:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as boolean.public;
    await r0;
    rand.chacha into r5 as boolean;
    get.or_use coin_flip_state_by_id[r2] 0u64 into r6;
    is.neq r6 0u64 into r7;
    assert.eq r7 true;
    is.eq r5 r4 into r8;
    branch.eq r8 false to end_then_0_0;
    set r3 into coin_flip_state_by_id[r2];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function claim:
    input r0 as coin_flip_record.record;
    mul 200000u64 r0.count into r1;
    call credits.aleo/transfer_public r0.owner r1 into r2;
    async claim r2 r0.id r0.owner into r3;
    output r3 as coinflip_9_30_v1.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as u64.public;
    input r2 as address.public;
    get.or_use coin_flip_state_by_id[r1] 0u64 into r3;
    gt r3 0u64 into r4;
    assert.eq r4 true;
    remove coin_flip_state_by_id[r1];
    await r0;
