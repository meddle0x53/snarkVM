import credits.aleo;

program testwithdraw.aleo;

function withdraw:
    input r0 as u64.public;
    input r1 as address.public;
    call credits.aleo/transfer_public r1 r0 into r2;
    async withdraw r2 into r3;
    output r3 as testwithdraw.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public.future;
    await r0;

function supply:
    input r0 as u64.public;
    gt r0 0u64 into r1;
    assert.eq r1 true;
    cast testwithdraw.aleo into r2 as address;
    call credits.aleo/transfer_public_as_signer r2 r0 into r3;
    async supply r3 into r4;
    output r4 as testwithdraw.aleo/supply.future;

finalize supply:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    await r0;
