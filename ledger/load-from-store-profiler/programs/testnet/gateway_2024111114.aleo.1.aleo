program gateway_2024111114.aleo;

record AxelarMessage:
    owner as address.private;
    destination_address as [u8; 20u32].private;
    destination_chain as [u8; 20u32].private;

function main:
    input r0 as [u8; 20u32].private;
    cast 101u8 116u8 104u8 101u8 114u8 101u8 117u8 109u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r1 as [u8; 20u32];
    cast self.caller r0 r1 into r2 as AxelarMessage.record;
    output r2 as AxelarMessage.record;
