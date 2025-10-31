import zvote_dao_registry_011.aleo;

program daom__no_approval_011.aleo;

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

struct NaDaoManagerParams:
    dao_manager_updater as address;
    voting_system_manager as address;

mapping dao_manager_params:
    key as field.public;
    value as NaDaoManagerParams.public;

function update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry_011.aleo/update_dao_manager r0 r1 r2 into r3;
    async update_dao_manager r0 self.caller r3 into r4;
    output r4 as daom__no_approval_011.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry_011.aleo/update_dao_manager.future;
    get zvote_dao_registry_011.aleo/daos[r0] into r3;
    get dao_manager_params[r3.dao_manager_params_hash] into r4;
    assert.eq r4.dao_manager_updater r1;
    await r2;

function add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry_011.aleo/add_voting_system r0 r1 r2 into r3;
    async add_voting_system r0 self.caller r3 into r4;
    output r4 as daom__no_approval_011.aleo/add_voting_system.future;

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
    output r4 as daom__no_approval_011.aleo/remove_voting_system.future;

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
    call zvote_dao_registry_011.aleo/create_proposal r0 r1 r2 r3 r4 into r5;
    async create_proposal r5 into r6;
    output r6 as daom__no_approval_011.aleo/create_proposal.future;

finalize create_proposal:
    input r0 as zvote_dao_registry_011.aleo/create_proposal.future;
    await r0;

function init_as_dao_manager:
    input r0 as field.public;
    input r1 as NaDaoManagerParams.public;
    hash.bhp256 r1 into r2 as field;
    async init_as_dao_manager r0 r1 r2 into r3;
    output r3 as daom__no_approval_011.aleo/init_as_dao_manager.future;

finalize init_as_dao_manager:
    input r0 as field.public;
    input r1 as NaDaoManagerParams.public;
    input r2 as field.public;
    get zvote_dao_registry_011.aleo/daos[r0] into r3;
    assert.eq r3.dao_manager daom__no_approval_011.aleo;
    assert.eq r3.dao_manager_params_hash r2;
    set r1 into dao_manager_params[r2];

function reference_dao_manager_params:
    input r0 as NaDaoManagerParams.public;
    hash.bhp256 r0 into r1 as field;
    async reference_dao_manager_params r0 r1 into r2;
    output r2 as daom__no_approval_011.aleo/reference_dao_manager_params.future;

finalize reference_dao_manager_params:
    input r0 as NaDaoManagerParams.public;
    input r1 as field.public;
    set r0 into dao_manager_params[r1];

function update_dao_manager_as_signer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry_011.aleo/update_dao_manager r0 r1 r2 into r3;
    async update_dao_manager_as_signer r0 self.signer r3 into r4;
    output r4 as daom__no_approval_011.aleo/update_dao_manager_as_signer.future;

finalize update_dao_manager_as_signer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry_011.aleo/update_dao_manager.future;
    get zvote_dao_registry_011.aleo/daos[r0] into r3;
    get dao_manager_params[r3.dao_manager_params_hash] into r4;
    assert.eq r4.dao_manager_updater r1;
    await r2;
