import credits.aleo;

program father_program.aleo;

mapping father_mapping:
    key as boolean.public;
    value as address.public;

function father_here:
    input r0 as u64.public;
    call credits.aleo/transfer_public_as_signer father_program.aleo r0 into r1;
    async father_here self.caller r1 into r2;
    output r2 as father_program.aleo/father_here.future;

finalize father_here:
    input r0 as address.public;
    input r1 as credits.aleo/transfer_public_as_signer.future;
    await r1;
    set r0 into father_mapping[true];
