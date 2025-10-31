import zpass_12631.aleo;

program pusdc_28541.aleo;

struct Credentials:
    issuer as address;
    holder as address;
    dob as u32;
    nationality as field;

record USDC:
    owner as address.private;
    amount as u64.private;

function mint:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as USDC.record;
    output r2 as USDC.record;

function burn:
    input r0 as USDC.record;

function transfer_private:
    input r0 as zpass_12631.aleo/ZPass.record;
    input r1 as USDC.record;
    input r2 as address.private;
    input r3 as u64.private;
    sub r1.amount r3 into r4;
    cast r1.owner r4 into r5 as USDC.record;
    cast r2 r3 into r6 as USDC.record;
    output r5 as USDC.record;
    output r6 as USDC.record;

function join:
    input r0 as USDC.record;
    input r1 as USDC.record;
    add r0.amount r1.amount into r2;
    cast r0.owner r2 into r3 as USDC.record;
    output r3 as USDC.record;

function split:
    input r0 as USDC.record;
    input r1 as u64.private;
    sub r0.amount r1 into r2;
    cast r0.owner r2 into r3 as USDC.record;
    cast r0.owner r1 into r4 as USDC.record;
    output r3 as USDC.record;
    output r4 as USDC.record;
