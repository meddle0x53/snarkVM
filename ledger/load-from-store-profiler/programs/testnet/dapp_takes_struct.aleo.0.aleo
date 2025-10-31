program dapp_takes_struct.aleo;

struct Payload:
    lucky as boolean;
    age as u64;
    balance as i64;
    home as address;

function execute:
    input r0 as [u8; 32u32].public;
    input r1 as [u8; 32u32].public;
    input r2 as [u8; 20u32].public;
    input r3 as Payload.public;
    output r3 as Payload.public;
