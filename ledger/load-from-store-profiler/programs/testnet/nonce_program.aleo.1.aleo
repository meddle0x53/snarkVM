import credits.aleo;

program nonce_program.aleo;

mapping current_nonce:
    key as address.public;
    value as u128.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u128.public;
    call credits.aleo/transfer_public_as_signer r0 r1 into r3;
    async transfer_public r2 self.caller r3 into r4;
    output r4 as nonce_program.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as u128.public;
    input r1 as address.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    await r2;
    get.or_use current_nonce[r1] 0u128 into r3;
    add r3 1u128 into r4;
    assert.eq r0 r3;
    set r4 into current_nonce[r1];
