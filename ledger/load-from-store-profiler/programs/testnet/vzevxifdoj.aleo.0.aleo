program vzevxifdoj.aleo;

struct ContractCall:
    caller as address;
    sender as address;
    destination_chain as [u8; 32u32];
    destination_address as [u8; 20u32];

function callContract:
    input r0 as [u8; 32u32].private;
    input r1 as [u8; 20u32].private;
    cast self.caller self.signer r0 r1 into r2 as ContractCall;
    output r2 as ContractCall.public;
