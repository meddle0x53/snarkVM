import gateway_20241111_1610.aleo;

program dapp_20241111_1610.aleo;

struct AxelarMessage:
    destination_address as [u8; 20u32];
    destination_chain as [u8; 20u32];

struct DappPayload:
    foo as u32;
    bar as u32;

function main:
    input r0 as [u8; 20u32].public;
    call gateway_20241111_1610.aleo/main r0 into r1;
    cast 6u32 2u32 into r2 as DappPayload;
    output r2 as DappPayload.private;
