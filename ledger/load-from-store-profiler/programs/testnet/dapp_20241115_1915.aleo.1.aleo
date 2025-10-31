import gateway_20241115_1915.aleo;

program dapp_20241115_1915.aleo;

struct AxelarMessage:
    caller as address;
    signer as address;
    destination_address as [u8; 20u32];
    destination_chain as [u8; 20u32];

struct DappPayload:
    caller as address;
    signer as address;
    foo as u32;
    bar as u32;

function main:
    input r0 as [u8; 20u32].public;
    call gateway_20241115_1915.aleo/main r0 into r1;
    cast self.caller self.signer 6u32 2u32 into r2 as DappPayload;
    output r2 as DappPayload.public;
