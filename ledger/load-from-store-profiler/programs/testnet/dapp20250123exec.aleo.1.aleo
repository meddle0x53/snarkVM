import ac64caccf8221554ec3f89bf.aleo;
import e21ab62fb17400301d9f0156b6c3031.aleo;

program dapp20250123exec.aleo;

struct ContractCall:
    caller as address;
    sender as address;
    destination_chain as [u128; 2u32];
    destination_address as [u128; 4u32];

struct Proof:
    weighted_signer as address;
    signaturee as signature;
    nonce as [u128; 2u32];

struct Message:
    source_chain as [u128; 2u32];
    message_id as [u128; 8u32];
    source_address as [u128; 4u32];
    contract_address as [u128; 4u32];
    payload_hash as group;

function main:
    cast 129497940983541880690546129557858025472u128 0u128 into r0 as [u128; 2u32];
    cast 133428732892731792184924403750533621091u128 61650339138018452844815768796358770688u128 0u128 0u128 into r1 as [u128; 4u32];
    call ac64caccf8221554ec3f89bf.aleo/callContract r0 r1 into r2;
    cast 72u8 101u8 108u8 108u8 111u8 44u8 32u8 87u8 111u8 114u8 108u8 100u8 33u8 into r3 as [u8; 13u32];
    output r2 as ContractCall.public;
    output r3 as [u8; 13u32].public;

function execute:
    input r0 as [u128; 2u32].private;
    input r1 as [u128; 8u32].private;
    input r2 as [u128; 4u32].private;
    input r3 as [u8; 13u32].private;
    hash.keccak256 r3 into r4 as group;
    cast 133428732892731792184924403750533621091u128 61650339138018452844815768796358770688u128 0u128 0u128 into r5 as [u128; 4u32];
    cast r0 r1 r2 r5 r4 into r6 as Message;
    hash.keccak256 r6 into r7 as group;
    call ac64caccf8221554ec3f89bf.aleo/validate_message r7 into r8;
    async execute r8 into r9;
    output r6 as Message.public;
    output r7 as group.public;
    output r9 as dapp20250123exec.aleo/execute.future;

finalize execute:
    input r0 as ac64caccf8221554ec3f89bf.aleo/validate_message.future;
    await r0;
