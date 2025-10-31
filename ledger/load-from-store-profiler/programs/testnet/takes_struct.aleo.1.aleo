program takes_struct.aleo;

struct Payload:
    lucky as boolean;
    age as u64;
    balance as i64;
    home as address;

function execute:
    input r0 as Payload.public;
    output r0 as Payload.public;
