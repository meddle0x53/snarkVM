program multisig_1723202296.aleo;

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

record Authorization:
    owner as address.private;
    proposal as Proposal.private;

mapping next_nonce:
    key as Action.public;
    value as u64.public;

mapping signers:
    key as address.public;
    value as boolean.public;

mapping required_sigs:
    key as Action.public;
    value as u8.public;

mapping has_signed:
    key as Signature.public;
    value as boolean.public;

mapping sigs:
    key as Proposal.public;
    value as u8.public;

mapping has_signed_cancellation:
    key as Signature.public;
    value as boolean.public;

mapping cancellation_sigs:
    key as Proposal.public;
    value as u8.public;

function initialize:
    async initialize self.signer into r0;
    output r0 as multisig_1723202296.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    cast aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u 0u8 into r1 as Action;
    contains next_nonce[r1] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set 1u64 into next_nonce[r1];
    set true into signers[r0];
    cast aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u 2u8 into r4 as Action;
    contains next_nonce[r4] into r5;
    not r5 into r6;
    assert.eq r6 true;
    set 1u8 into required_sigs[r4];
    set 1u8 into required_sigs[r1];
    set 2u64 into next_nonce[r4];

function sign:
    input r0 as Proposal.private;
    cast r0 self.signer into r1 as Signature;
    async sign r1 into r2;
    output r2 as multisig_1723202296.aleo/sign.future;

finalize sign:
    input r0 as Signature.public;
    contains signers[r0.signer] into r1;
    assert.eq r1 true;
    contains has_signed[r0] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into has_signed[r0];
    get.or_use sigs[r0.proposal] 0u8 into r4;
    add r4 1u8 into r5;
    set r5 into sigs[r0.proposal];

function sign_cancellation:
    input r0 as Proposal.private;
    assert.eq r0.argument_hash 0field;
    cast r0 self.signer into r1 as Signature;
    async sign_cancellation r1 into r2;
    output r2 as multisig_1723202296.aleo/sign_cancellation.future;

finalize sign_cancellation:
    input r0 as Signature.public;
    contains signers[r0.signer] into r1;
    assert.eq r1 true;
    contains has_signed_cancellation[r0] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into has_signed_cancellation[r0];
    get.or_use cancellation_sigs[r0.proposal] 0u8 into r4;
    add r4 1u8 into r5;
    set r5 into cancellation_sigs[r0.proposal];

function issue_authorization:
    input r0 as address.private;
    input r1 as Proposal.private;
    cast r0 r1 into r2 as Authorization.record;
    async issue_authorization self.signer into r3;
    output r2 as Authorization.record;
    output r3 as multisig_1723202296.aleo/issue_authorization.future;

finalize issue_authorization:
    input r0 as address.public;
    contains signers[r0] into r1;
    assert.eq r1 true;

function verify:
    input r0 as Authorization.record;
    input r1 as u8.private;
    input r2 as field.private;
    assert.eq r0.proposal.action.program_address self.caller;
    assert.eq r0.proposal.action.action_id r1;
    assert.eq r0.proposal.argument_hash r2;
    async verify r0.proposal into r3;
    output r3 as multisig_1723202296.aleo/verify.future;

finalize verify:
    input r0 as Proposal.public;
    get sigs[r0] into r1;
    get required_sigs[r0.action] into r2;
    gte r1 r2 into r3;
    assert.eq r3 true;
    get.or_use next_nonce[r0.action] 0u64 into r4;
    assert.eq r0.nonce r4;
    add r4 1u64 into r5;
    set r5 into next_nonce[r0.action];

function cancel:
    input r0 as Proposal.private;
    async cancel r0 into r1;
    output r1 as multisig_1723202296.aleo/cancel.future;

finalize cancel:
    input r0 as Proposal.public;
    get cancellation_sigs[r0] into r1;
    get required_sigs[r0.action] into r2;
    gte r1 r2 into r3;
    assert.eq r3 true;
    get.or_use next_nonce[r0.action] 0u64 into r4;
    assert.eq r0.nonce r4;
    add r4 1u64 into r5;
    set r5 into next_nonce[r0.action];

function set_required_sigs_:
    input r0 as Action.private;
    input r1 as u8.private;
    assert.eq self.caller aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u;
    async set_required_sigs_ r0 r1 into r2;
    output r2 as multisig_1723202296.aleo/set_required_sigs_.future;

finalize set_required_sigs_:
    input r0 as Action.public;
    input r1 as u8.public;
    set r1 into required_sigs[r0];

function add_signer_:
    input r0 as address.private;
    assert.eq self.caller aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u;
    async add_signer_ r0 into r1;
    output r1 as multisig_1723202296.aleo/add_signer_.future;

finalize add_signer_:
    input r0 as address.public;
    set true into signers[r0];

function remove_signer_:
    input r0 as address.private;
    assert.eq self.caller aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u;
    async remove_signer_ r0 into r1;
    output r1 as multisig_1723202296.aleo/remove_signer_.future;

finalize remove_signer_:
    input r0 as address.public;
    remove signers[r0];
