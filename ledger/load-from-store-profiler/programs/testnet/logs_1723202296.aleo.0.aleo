import multisig_1723202296.aleo;

program logs_1723202296.aleo;

struct Action:
    program_address as address;
    action_id as u8;

struct Proposal:
    action as Action;
    argument_hash as field;
    nonce as u64;

struct Signature:
    proposal as Proposal;
    signer as address;

record Mint:
    owner as address.private;
    program_address as address.private;
    to as address.private;
    amount as u64.private;
    is_private as boolean.private;

record Redeem:
    owner as address.private;
    program_address as address.private;
    from as address.private;
    amount as u64.private;
    is_private as boolean.private;

record Transfer:
    owner as address.private;
    program_address as address.private;
    from as address.private;
    to as address.private;
    amount as u64.private;
    is_private_from as boolean.private;
    is_private_to as boolean.private;

struct SetLogAddress:
    account as address;

mapping log_address:
    key as boolean.public;
    value as address.public;

function set_log_address:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as SetLogAddress.private;
    hash.bhp256 r1 into r2 as field;
    call multisig_1723202296.aleo/verify r0 0u8 r2 into r3;
    async set_log_address r1 r3 into r4;
    output r4 as logs_1723202296.aleo/set_log_address.future;

finalize set_log_address:
    input r0 as SetLogAddress.public;
    input r1 as multisig_1723202296.aleo/verify.future;
    await r1;
    set r0.account into log_address[true];

function log_mint:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as u64.private;
    input r3 as boolean.private;
    cast r0 self.caller r1 r2 r3 into r4 as Mint.record;
    async log_mint r0 into r5;
    output r4 as Mint.record;
    output r5 as logs_1723202296.aleo/log_mint.future;

finalize log_mint:
    input r0 as address.public;
    get log_address[true] into r1;
    assert.eq r0 r1;

function log_redeem:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as u64.private;
    input r3 as boolean.private;
    cast r0 self.caller r1 r2 r3 into r4 as Redeem.record;
    async log_redeem r0 into r5;
    output r4 as Redeem.record;
    output r5 as logs_1723202296.aleo/log_redeem.future;

finalize log_redeem:
    input r0 as address.public;
    get log_address[true] into r1;
    assert.eq r0 r1;

function log_transfer:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as u64.private;
    input r4 as boolean.private;
    input r5 as boolean.private;
    cast r0 self.caller r1 r2 r3 r4 r5 into r6 as Transfer.record;
    async log_transfer r0 into r7;
    output r6 as Transfer.record;
    output r7 as logs_1723202296.aleo/log_transfer.future;

finalize log_transfer:
    input r0 as address.public;
    get log_address[true] into r1;
    assert.eq r0 r1;
