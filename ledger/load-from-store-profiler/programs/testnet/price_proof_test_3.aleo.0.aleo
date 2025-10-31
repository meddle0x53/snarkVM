import credits.aleo;

program price_proof_test_3.aleo;

mapping market_state:
    key as address.public;
    value as u8.public;

mapping bet_price_threshold:
    key as boolean.public;
    value as u64.public;

mapping bets:
    key as address.public;
    value as i128.public;

mapping id_to_bettor:
    key as u16.public;
    value as address.public;

mapping next_bettors_index:
    key as boolean.public;
    value as u16.public;

function initialize_market:
    input r0 as u64.private;
    assert.eq self.signer aleo1utnfugwpu6ac8z0dp90mlulvrgf768984huy7gwfcr0676hfmv9qwxkl9n;
    call credits.aleo/transfer_public_as_signer price_proof_test_3.aleo 1000000u64 into r1;
    async initialize_market r0 r1 into r2;
    output r2 as price_proof_test_3.aleo/initialize_market.future;

finalize initialize_market:
    input r0 as u64.public;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    get.or_use market_state[aleo1utnfugwpu6ac8z0dp90mlulvrgf768984huy7gwfcr0676hfmv9qwxkl9n] 0u8 into r2;
    assert.eq r2 0u8;
    set 1u8 into market_state[aleo1utnfugwpu6ac8z0dp90mlulvrgf768984huy7gwfcr0676hfmv9qwxkl9n];
    set r0 into bet_price_threshold[true];
    set 0u16 into next_bettors_index[true];
    await r1;

function place_bet:
    input r0 as u64.private;
    input r1 as boolean.private;
    call credits.aleo/transfer_public_as_signer price_proof_test_3.aleo r0 into r2;
    async place_bet self.signer r1 r0 r2 into r3;
    output r3 as price_proof_test_3.aleo/place_bet.future;

finalize place_bet:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as u64.public;
    input r3 as credits.aleo/transfer_public_as_signer.future;
    get.or_use market_state[aleo1utnfugwpu6ac8z0dp90mlulvrgf768984huy7gwfcr0676hfmv9qwxkl9n] 0u8 into r4;
    assert.eq r4 1u8;
    contains bets[r0] into r5;
    get next_bettors_index[true] into r6;
    lt r6 100u16 into r7;
    or r5 r7 into r8;
    assert.eq r8 true;
    get.or_use bets[r0] 0i128 into r9;
    cast r2 into r10 as i128;
    cast r2 into r11 as i128;
    neg r11 into r12;
    ternary r1 r10 r12 into r13;
    add r9 r13 into r14;
    set r14 into bets[r0];
    not r5 into r15;
    branch.eq r15 false to end_then_0_0;
    get next_bettors_index[true] into r16;
    contains id_to_bettor[r16] into r17;
    not r17 into r18;
    assert.eq r18 true;
    set r0 into id_to_bettor[r16];
    add r16 1u16 into r19;
    set r19 into next_bettors_index[true];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    await r3;
