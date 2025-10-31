import vzevxifdoj.aleo;

program xtaustbucx.aleo;

struct ContractCall:
    caller as address;
    sender as address;
    destination_chain as [u8; 32u32];
    destination_address as [u8; 20u32];

struct Payload:
    foo as u64;
    bar as u32;

function main:
    cast 69u8 116u8 104u8 101u8 114u8 101u8 117u8 109u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r0 as [u8; 32u32];
    cast 18u8 52u8 86u8 120u8 144u8 171u8 205u8 239u8 18u8 52u8 86u8 120u8 144u8 171u8 205u8 239u8 18u8 52u8 86u8 120u8 into r1 as [u8; 20u32];
    call vzevxifdoj.aleo/callContract r0 r1 into r2;
    cast 4u64 3u32 into r3 as Payload;
    output r2 as ContractCall.public;
    output r3 as Payload.public;
