import vzevxifdoj.aleo;

program dapp_20241221_1458.aleo;

struct ContractCall:
    caller as address;
    sender as address;
    destination_chain as [u8; 32u32];
    destination_address as [u8; 20u32];

function main:
    cast 101u8 116u8 104u8 45u8 115u8 101u8 112u8 111u8 108u8 105u8 97u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r0 as [u8; 32u32];
    cast 219u8 172u8 47u8 180u8 175u8 34u8 233u8 154u8 206u8 107u8 67u8 253u8 99u8 127u8 87u8 102u8 235u8 197u8 223u8 246u8 into r1 as [u8; 20u32];
    call vzevxifdoj.aleo/callContract r0 r1 into r2;
    cast 72u8 101u8 108u8 108u8 111u8 44u8 32u8 87u8 111u8 114u8 108u8 100u8 33u8 into r3 as [u8; 13u32];
    output r2 as ContractCall.public;
    output r3 as [u8; 13u32].public;
