import multisig_1723202296.aleo;

program aml_1723202296.aleo;

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

record AML:
    owner as address.private;
    account as address.private;
    version as u32.private;

struct Block:
    account as address;

struct Unblock:
    account as address;

mapping aml_blocklist:
    key as address.public;
    value as boolean.public;

mapping aml_version:
    key as boolean.public;
    value as u32.public;

function block_:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as Block.private;
    hash.bhp256 r1 into r2 as field;
    call multisig_1723202296.aleo/verify r0 0u8 r2 into r3;
    async block_ r1 r3 into r4;
    output r4 as aml_1723202296.aleo/block_.future;

finalize block_:
    input r0 as Block.public;
    input r1 as multisig_1723202296.aleo/verify.future;
    await r1;
    set true into aml_blocklist[r0.account];
    get.or_use aml_version[true] 0u32 into r2;
    add r2 1u32 into r3;
    set r3 into aml_version[true];

function unblock:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as Unblock.private;
    hash.bhp256 r1 into r2 as field;
    call multisig_1723202296.aleo/verify r0 1u8 r2 into r3;
    async unblock r1 r3 into r4;
    output r4 as aml_1723202296.aleo/unblock.future;

finalize unblock:
    input r0 as Unblock.public;
    input r1 as multisig_1723202296.aleo/verify.future;
    await r1;
    remove aml_blocklist[r0.account];
    get.or_use aml_version[true] 0u32 into r2;
    add r2 1u32 into r3;
    set r3 into aml_version[true];

function issue_aml:
    input r0 as address.private;
    input r1 as u32.private;
    cast self.signer r0 r1 into r2 as AML.record;
    async issue_aml r0 r1 into r3;
    output r2 as AML.record;
    output r3 as aml_1723202296.aleo/issue_aml.future;

finalize issue_aml:
    input r0 as address.public;
    input r1 as u32.public;
    contains aml_blocklist[r0] into r2;
    not r2 into r3;
    assert.eq r3 true;
    get.or_use aml_version[true] 0u32 into r4;
    assert.eq r1 r4;

function verify_aml:
    input r0 as AML.record;
    cast r0.owner r0.account r0.version into r1 as AML.record;
    async verify_aml r0.version into r2;
    output r1 as AML.record;
    output r2 as aml_1723202296.aleo/verify_aml.future;

finalize verify_aml:
    input r0 as u32.public;
    get.or_use aml_version[true] 0u32 into r1;
    assert.eq r0 r1;
