program gateway_20241111_1551.aleo;

struct AxelarMessage:
    destination_address as [u8; 20u32];
    destination_chain as [u8; 20u32];

function main:
    input r0 as [u8; 20u32].private;
    cast 101u8 116u8 104u8 101u8 114u8 101u8 117u8 109u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r1 as [u8; 20u32];
    cast r0 r1 into r2 as AxelarMessage;
    output r2 as AxelarMessage.private;
