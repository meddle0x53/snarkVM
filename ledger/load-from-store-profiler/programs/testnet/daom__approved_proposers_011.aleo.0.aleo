import zvote_dao_registry_011.aleo;

program daom__approved_proposers_011.aleo;

struct Dao:
    dao_id as field;
    token_id as field;
    dao_manager as address;
    dao_manager_params_hash as field;

struct Proposal:
    dao_id as field;
    proposal_id as field;
    content as address;
    voting_system as address;
    vs_params_hash as field;

struct VotingSystemKey:
    dao_id as field;
    voting_system as address;
    vs_params_hash as field;

struct ProposerKey:
    dao_id as field;
    proposer as address;

struct ApDaoManagerParams:
    dao_manager_updater as address;
    voting_system_manager as address;
    proposers_manager as address;

mapping approved_proposers:
    key as field.public;
    value as ProposerKey.public;

mapping dao_manager_params:
    key as field.public;
    value as ApDaoManagerParams.public;

function update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry_011.aleo/update_dao_manager r0 r1 r2 into r3;
    async update_dao_manager r0 self.caller r3 into r4;
    output r4 as daom__approved_proposers_011.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry_011.aleo/update_dao_manager.future;
    get zvote_dao_registry_011.aleo/daos[r0] into r3;
    get dao_manager_params[r3.dao_manager_params_hash] into r4;
    assert.eq r4.dao_manager_updater r1;
    cast r0 r4.voting_system_manager into r5 as ProposerKey;
    hash.bhp256 r5 into r6 as field;
    cast r0 r4.proposers_manager into r7 as ProposerKey;
    hash.bhp256 r7 into r8 as field;
    cast r0 r4.dao_manager_updater into r9 as ProposerKey;
    hash.bhp256 r9 into r10 as field;
    await r2;
    remove approved_proposers[r10];
    remove approved_proposers[r6];
    remove approved_proposers[r8];

function add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry_011.aleo/add_voting_system r0 r1 r2 into r3;
    async add_voting_system r0 self.caller r3 into r4;
    output r4 as daom__approved_proposers_011.aleo/add_voting_system.future;

finalize add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry_011.aleo/add_voting_system.future;
    get zvote_dao_registry_011.aleo/daos[r0] into r3;
    get dao_manager_params[r3.dao_manager_params_hash] into r4;
    assert.eq r1 r4.voting_system_manager;
    await r2;

function remove_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry_011.aleo/remove_voting_system r0 r1 r2 into r3;
    async remove_voting_system r0 self.caller r3 into r4;
    output r4 as daom__approved_proposers_011.aleo/remove_voting_system.future;

finalize remove_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry_011.aleo/remove_voting_system.future;
    get zvote_dao_registry_011.aleo/daos[r0] into r3;
    get dao_manager_params[r3.dao_manager_params_hash] into r4;
    assert.eq r1 r4.voting_system_manager;
    await r2;

function create_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as field.public;
    cast r0 self.caller into r5 as ProposerKey;
    hash.bhp256 r5 into r6 as field;
    call zvote_dao_registry_011.aleo/create_proposal r0 r1 r2 r3 r4 into r7;
    async create_proposal r6 r7 into r8;
    output r8 as daom__approved_proposers_011.aleo/create_proposal.future;

finalize create_proposal:
    input r0 as field.public;
    input r1 as zvote_dao_registry_011.aleo/create_proposal.future;
    contains approved_proposers[r0] into r2;
    assert.eq r2 true;
    await r1;

function init_as_dao_manager:
    input r0 as field.public;
    input r1 as ApDaoManagerParams.public;
    cast r0 r1.dao_manager_updater into r2 as ProposerKey;
    hash.bhp256 r2 into r3 as field;
    cast r0 r1.voting_system_manager into r4 as ProposerKey;
    hash.bhp256 r4 into r5 as field;
    cast r0 r1.proposers_manager into r6 as ProposerKey;
    hash.bhp256 r6 into r7 as field;
    hash.bhp256 r1 into r8 as field;
    async init_as_dao_manager r0 r1 r8 r5 r3 r7 into r9;
    output r9 as daom__approved_proposers_011.aleo/init_as_dao_manager.future;

finalize init_as_dao_manager:
    input r0 as field.public;
    input r1 as ApDaoManagerParams.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    get zvote_dao_registry_011.aleo/daos[r0] into r6;
    assert.eq r6.dao_manager daom__approved_proposers_011.aleo;
    assert.eq r6.dao_manager_params_hash r2;
    set r1 into dao_manager_params[r2];
    cast r0 r1.dao_manager_updater into r7 as ProposerKey;
    set r7 into approved_proposers[r4];
    cast r0 r1.voting_system_manager into r8 as ProposerKey;
    set r8 into approved_proposers[r3];
    cast r0 r1.proposers_manager into r9 as ProposerKey;
    set r9 into approved_proposers[r5];

function reference_dao_manager_params:
    input r0 as ApDaoManagerParams.public;
    hash.bhp256 r0 into r1 as field;
    async reference_dao_manager_params r0 r1 into r2;
    output r2 as daom__approved_proposers_011.aleo/reference_dao_manager_params.future;

finalize reference_dao_manager_params:
    input r0 as ApDaoManagerParams.public;
    input r1 as field.public;
    set r0 into dao_manager_params[r1];

function update_dao_manager_as_signer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry_011.aleo/update_dao_manager r0 r1 r2 into r3;
    async update_dao_manager_as_signer r0 self.signer r3 into r4;
    output r4 as daom__approved_proposers_011.aleo/update_dao_manager_as_signer.future;

finalize update_dao_manager_as_signer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry_011.aleo/update_dao_manager.future;
    get zvote_dao_registry_011.aleo/daos[r0] into r3;
    get dao_manager_params[r3.dao_manager_params_hash] into r4;
    assert.eq r4.dao_manager_updater r1;
    cast r0 r4.voting_system_manager into r5 as ProposerKey;
    hash.bhp256 r5 into r6 as field;
    cast r0 r4.proposers_manager into r7 as ProposerKey;
    hash.bhp256 r7 into r8 as field;
    cast r0 r4.dao_manager_updater into r9 as ProposerKey;
    hash.bhp256 r9 into r10 as field;
    await r2;
    remove approved_proposers[r10];
    remove approved_proposers[r6];
    remove approved_proposers[r8];

function add_approved_proposer:
    input r0 as field.public;
    input r1 as address.public;
    cast r0 r1 into r2 as ProposerKey;
    hash.bhp256 r2 into r3 as field;
    async add_approved_proposer r0 r3 r1 self.caller into r4;
    output r4 as daom__approved_proposers_011.aleo/add_approved_proposer.future;

finalize add_approved_proposer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    get zvote_dao_registry_011.aleo/daos[r0] into r4;
    get dao_manager_params[r4.dao_manager_params_hash] into r5;
    assert.eq r5.proposers_manager r3;
    cast r0 r2 into r6 as ProposerKey;
    set r6 into approved_proposers[r1];

function remove_approved_proposer:
    input r0 as field.public;
    input r1 as address.public;
    cast r0 r1 into r2 as ProposerKey;
    hash.bhp256 r2 into r3 as field;
    async remove_approved_proposer r0 r3 self.caller into r4;
    output r4 as daom__approved_proposers_011.aleo/remove_approved_proposer.future;

finalize remove_approved_proposer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    get zvote_dao_registry_011.aleo/daos[r0] into r3;
    get dao_manager_params[r3.dao_manager_params_hash] into r4;
    assert.eq r4.proposers_manager r2;
    remove approved_proposers[r1];
