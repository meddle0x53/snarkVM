import multisig_1723202296.aleo;

program multisig_controller_1723202296.aleo;

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

struct AddSigner:
    account as address;

struct RemoveSigner:
    account as address;

struct SetRequiredSigs:
    action as Action;
    required_sigs as u8;

function add_signer:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as AddSigner.private;
    hash.bhp256 r1 into r2 as field;
    call multisig_1723202296.aleo/verify r0 0u8 r2 into r3;
    call multisig_1723202296.aleo/add_signer_ r1.account into r4;
    async add_signer r3 r4 into r5;
    output r5 as multisig_controller_1723202296.aleo/add_signer.future;

finalize add_signer:
    input r0 as multisig_1723202296.aleo/verify.future;
    input r1 as multisig_1723202296.aleo/add_signer_.future;
    await r0;
    await r1;

function remove_signer:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as RemoveSigner.private;
    hash.bhp256 r1 into r2 as field;
    call multisig_1723202296.aleo/verify r0 0u8 r2 into r3;
    call multisig_1723202296.aleo/remove_signer_ r1.account into r4;
    async remove_signer r3 r4 into r5;
    output r5 as multisig_controller_1723202296.aleo/remove_signer.future;

finalize remove_signer:
    input r0 as multisig_1723202296.aleo/verify.future;
    input r1 as multisig_1723202296.aleo/remove_signer_.future;
    await r0;
    await r1;

function set_required_sigs:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as SetRequiredSigs.private;
    hash.bhp256 r1 into r2 as field;
    call multisig_1723202296.aleo/verify r0 2u8 r2 into r3;
    call multisig_1723202296.aleo/set_required_sigs_ r1.action r1.required_sigs into r4;
    async set_required_sigs r3 r4 into r5;
    output r5 as multisig_controller_1723202296.aleo/set_required_sigs.future;

finalize set_required_sigs:
    input r0 as multisig_1723202296.aleo/verify.future;
    input r1 as multisig_1723202296.aleo/set_required_sigs_.future;
    await r0;
    await r1;
