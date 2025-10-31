import credits.aleo;

program price_proof_test_2.aleo;

mapping market_state:
    key as address.public;
    value as u8.public;

mapping bets:
    key as address.public;
    value as u64.public;

function initialize_market:
    assert.eq self.signer aleo1utnfugwpu6ac8z0dp90mlulvrgf768984huy7gwfcr0676hfmv9qwxkl9n;
    call credits.aleo/transfer_public_as_signer price_proof_test_2.aleo 1000000u64 into r0;
    async initialize_market r0 into r1;
    output r1 as price_proof_test_2.aleo/initialize_market.future;

finalize initialize_market:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    get.or_use market_state[aleo1utnfugwpu6ac8z0dp90mlulvrgf768984huy7gwfcr0676hfmv9qwxkl9n] 0u8 into r1;
    assert.eq r1 0u8;
    set 1u8 into market_state[aleo1utnfugwpu6ac8z0dp90mlulvrgf768984huy7gwfcr0676hfmv9qwxkl9n];
    await r0;

function place_bet:
    input r0 as u64.private;
    call credits.aleo/transfer_public_as_signer price_proof_test_2.aleo r0 into r1;
    async place_bet self.signer r0 r1 into r2;
    output r2 as price_proof_test_2.aleo/place_bet.future;

finalize place_bet:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    get.or_use market_state[aleo1utnfugwpu6ac8z0dp90mlulvrgf768984huy7gwfcr0676hfmv9qwxkl9n] 0u8 into r3;
    assert.eq r3 1u8;
    get.or_use bets[r0] 0u64 into r4;
    add r4 r1 into r5;
    set r5 into bets[r0];
    await r2;
