import zvote_dao_registry.aleo;

program daom__no_approval_005.aleo;

struct Dao:
    dao_id as field;
    token_id as field;
    dao_manager as address;

struct Proposal:
    proposal_id as field;
    dao_id as field;
    content as field;
    voting_system as address;
    vs_params_hash as field;

struct VotingSystemKey:
    dao_id as field;
    voting_system as address;
    vs_params_hash as field;

mapping dao_manager_updaters:
    key as field.public;
    value as address.public;

mapping voting_system_managers:
    key as field.public;
    value as address.public;

function update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    call zvote_dao_registry.aleo/update_dao_manager r0 r1 into r2;
    async update_dao_manager r0 self.caller r2 into r3;
    output r3 as daom__no_approval_005.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry.aleo/update_dao_manager.future;
    await r2;
    get dao_manager_updaters[r0] into r3;
    assert.eq r3 r1;
    remove dao_manager_updaters[r0];
    remove voting_system_managers[r0];

function add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry.aleo/add_voting_system r0 r1 r2 into r3;
    async add_voting_system r0 self.caller r3 into r4;
    output r4 as daom__no_approval_005.aleo/add_voting_system.future;

finalize add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry.aleo/add_voting_system.future;
    get voting_system_managers[r0] into r3;
    assert.eq r1 r3;
    await r2;

function remove_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry.aleo/remove_voting_system r0 r1 r2 into r3;
    async remove_voting_system r0 self.caller r3 into r4;
    output r4 as daom__no_approval_005.aleo/remove_voting_system.future;

finalize remove_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry.aleo/remove_voting_system.future;
    get voting_system_managers[r0] into r3;
    assert.eq r1 r3;
    await r2;

function create_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as address.public;
    input r4 as field.public;
    call zvote_dao_registry.aleo/create_proposal r0 r1 r2 r3 r4 into r5;
    async create_proposal r5 into r6;
    output r6 as daom__no_approval_005.aleo/create_proposal.future;

finalize create_proposal:
    input r0 as zvote_dao_registry.aleo/create_proposal.future;
    await r0;

function init_as_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    call zvote_dao_registry.aleo/update_dao_manager r0 daom__no_approval_005.aleo into r3;
    async init_as_dao_manager r0 r2 r1 r3 into r4;
    output r4 as daom__no_approval_005.aleo/init_as_dao_manager.future;

finalize init_as_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as zvote_dao_registry.aleo/update_dao_manager.future;
    await r3;
    set r2 into dao_manager_updaters[r0];
    set r1 into voting_system_managers[r0];

function update_dao_manager_as_signer:
    input r0 as field.public;
    input r1 as address.public;
    call zvote_dao_registry.aleo/update_dao_manager r0 r1 into r2;
    async update_dao_manager_as_signer r0 self.signer r2 into r3;
    output r3 as daom__no_approval_005.aleo/update_dao_manager_as_signer.future;

finalize update_dao_manager_as_signer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as zvote_dao_registry.aleo/update_dao_manager.future;
    await r2;
    get dao_manager_updaters[r0] into r3;
    assert.eq r3 r1;
    remove dao_manager_updaters[r0];
    remove voting_system_managers[r0];
