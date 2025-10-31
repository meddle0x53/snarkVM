import credits.aleo;

program gas_service_202502280920.aleo;

function add_gas:
    input r0 as u64.private;
    call credits.aleo/transfer_public_as_signer aleo1cz3gvhct7vaja4s4je4qssvcac8tm3lggzjdd5n7ezt9z4ln65rqedqgfa r0 into r1;
    async add_gas r1 into r2;
    output r2 as gas_service_202502280920.aleo/add_gas.future;

finalize add_gas:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    await r0;
