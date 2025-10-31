import multisig_1723202296.aleo;

program kyc_1723202296.aleo;

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

record KYC:
    owner as address.private;
    account as address.private;
    expiry_block_height as u32.private;

struct IssueKYC:
    owner_ as address;
    account as address;
    expiry_block_height as u32;
    secret as field;

function issue_kyc:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as IssueKYC.private;
    hash.bhp256 r1 into r2 as field;
    call multisig_1723202296.aleo/verify r0 0u8 r2 into r3;
    cast r1.owner_ r1.account r1.expiry_block_height into r4 as KYC.record;
    async issue_kyc r3 into r5;
    output r4 as KYC.record;
    output r5 as kyc_1723202296.aleo/issue_kyc.future;

finalize issue_kyc:
    input r0 as multisig_1723202296.aleo/verify.future;
    await r0;

function verify_kyc:
    input r0 as KYC.record;
    input r1 as u32.private;
    lte r1 r0.expiry_block_height into r2;
    assert.eq r2 true;
    cast r0.owner r0.account r0.expiry_block_height into r3 as KYC.record;
    async verify_kyc r1 into r4;
    output r3 as KYC.record;
    output r4 as kyc_1723202296.aleo/verify_kyc.future;

finalize verify_kyc:
    input r0 as u32.public;
    lt block.height r0 into r1;
    assert.eq r1 true;
