import vzevxifdoj.aleo;

program dapp_20241209_1528.aleo;

struct ContractCall:
    caller as address;
    sender as address;
    destination_chain as [u8; 32u32];
    destination_address as [u8; 20u32];

function main:
    cast 101u8 116u8 104u8 101u8 114u8 101u8 117u8 109u8 45u8 115u8 101u8 112u8 111u8 108u8 105u8 97u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r0 as [u8; 32u32];
    cast 150u8 247u8 181u8 191u8 31u8 163u8 214u8 88u8 215u8 38u8 21u8 19u8 171u8 152u8 112u8 111u8 225u8 21u8 13u8 137u8 into r1 as [u8; 20u32];
    call vzevxifdoj.aleo/callContract r0 r1 into r2;
    cast 72u8 101u8 108u8 108u8 111u8 44u8 32u8 87u8 111u8 114u8 108u8 100u8 33u8 into r3 as [u8; 13u32];
    output r2 as ContractCall.public;
    output r3 as [u8; 13u32].public;
