import credits.aleo;

program gas_service_20250312.aleo;

struct GasPaidForContractCall:
    caller as address;
    signer as address;
    gas as u64;
    destination_chain as u16;
    destination_address as [u8; 32u32];
    payload_hash as field;
    execution_gas_limit as u64;
    refund_address as address;

struct GasAdded:
    caller as address;
    signer as address;
    gas as u64;
    tx_hash as field;
    log_index as u64;
    refund_address as address;

struct Refunded:
    caller as address;
    signer as address;
    gas as u64;
    tx_hash as field;
    log_index as u64;
    refund_address as address;

function pay_gas_for_contract_call:
    input r0 as u64.public;
    input r1 as u16.public;
    input r2 as [u8; 32u32].public;
    input r3 as field.public;
    input r4 as u64.public;
    input r5 as address.public;
    cast self.caller self.signer r0 r1 r2 r3 r4 r5 into r6 as GasPaidForContractCall;
    call credits.aleo/transfer_public_as_signer aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px r0 into r7;
    async pay_gas_for_contract_call r7 into r8;
    output r6 as GasPaidForContractCall.public;
    output r8 as gas_service_20250312.aleo/pay_gas_for_contract_call.future;

finalize pay_gas_for_contract_call:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    await r0;

function add_gas:
    input r0 as u64.private;
    input r1 as field.private;
    input r2 as u64.private;
    input r3 as address.private;
    cast self.caller self.signer r0 r1 r2 r3 into r4 as GasAdded;
    call credits.aleo/transfer_public_as_signer aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px r0 into r5;
    async add_gas r5 into r6;
    output r4 as GasAdded.public;
    output r6 as gas_service_20250312.aleo/add_gas.future;

finalize add_gas:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    await r0;

function collects_fees:
    input r0 as address.private;
    input r1 as u64.private;
    is.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px into r2;
    assert.eq r2 true;
    call credits.aleo/transfer_public r0 r1 into r3;
    async collects_fees r3 into r4;
    output r4 as gas_service_20250312.aleo/collects_fees.future;

finalize collects_fees:
    input r0 as credits.aleo/transfer_public.future;
    await r0;

function refund:
    input r0 as u64.private;
    input r1 as field.private;
    input r2 as u64.private;
    input r3 as address.private;
    is.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px into r4;
    assert.eq r4 true;
    cast self.caller self.signer r0 r1 r2 r3 into r5 as Refunded;
    call credits.aleo/transfer_public r3 r0 into r6;
    async refund r6 into r7;
    output r5 as Refunded.public;
    output r7 as gas_service_20250312.aleo/refund.future;

finalize refund:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
