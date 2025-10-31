import zvote_dao_registry.aleo;

program daom__approved_proposers_004.aleo;

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

struct ProposerKey:
    dao_id as field;
    proposer as address;

mapping dao_manager_updaters:
    key as field.public;
    value as address.public;

mapping voting_system_managers:
    key as field.public;
    value as address.public;

mapping proposers_managers:
    key as field.public;
    value as address.public;

mapping approved_proposers:
    key as field.public;
    value as ProposerKey.public;

function update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    call zvote_dao_registry.aleo/update_dao_manager r0 r1 into r2;
    cast r0 self.caller into r3 as ProposerKey;
    hash.bhp256 r3 into r4 as field;
    async update_dao_manager r0 self.caller r4 r2 into r5;
    output r5 as daom__approved_proposers_004.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as zvote_dao_registry.aleo/update_dao_manager.future;
    await r3;
    get dao_manager_updaters[r0] into r4;
    assert.eq r4 r1;
    get voting_system_managers[r0] into r5;
    cast r0 r5 into r6 as ProposerKey;
    hash.bhp256 r6 into r7 as field;
    get proposers_managers[r0] into r8;
    cast r0 r8 into r9 as ProposerKey;
    hash.bhp256 r9 into r10 as field;
    remove proposers_managers[r0];
    remove dao_manager_updaters[r0];
    remove voting_system_managers[r0];
    remove approved_proposers[r2];
    remove approved_proposers[r7];
    remove approved_proposers[r10];

function add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    call zvote_dao_registry.aleo/add_voting_system r0 r1 r2 into r3;
    async add_voting_system r0 self.caller r3 into r4;
    output r4 as daom__approved_proposers_004.aleo/add_voting_system.future;

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
    output r4 as daom__approved_proposers_004.aleo/remove_voting_system.future;

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
    cast r0 self.caller into r5 as ProposerKey;
    hash.bhp256 r5 into r6 as field;
    call zvote_dao_registry.aleo/create_proposal r0 r1 r2 r3 r4 into r7;
    async create_proposal r6 r7 into r8;
    output r8 as daom__approved_proposers_004.aleo/create_proposal.future;

finalize create_proposal:
    input r0 as field.public;
    input r1 as zvote_dao_registry.aleo/create_proposal.future;
    contains approved_proposers[r0] into r2;
    assert.eq r2 true;
    await r1;

function init_as_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    call zvote_dao_registry.aleo/update_dao_manager r0 daom__approved_proposers_004.aleo into r4;
    cast r0 r1 into r5 as ProposerKey;
    hash.bhp256 r5 into r6 as field;
    cast r0 r2 into r7 as ProposerKey;
    hash.bhp256 r7 into r8 as field;
    cast r0 r3 into r9 as ProposerKey;
    hash.bhp256 r9 into r10 as field;
    async init_as_dao_manager r0 r2 r8 r1 r6 r3 r10 r4 into r11;
    output r11 as daom__approved_proposers_004.aleo/init_as_dao_manager.future;

finalize init_as_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as address.public;
    input r4 as field.public;
    input r5 as address.public;
    input r6 as field.public;
    input r7 as zvote_dao_registry.aleo/update_dao_manager.future;
    await r7;
    contains proposers_managers[r0] into r8;
    not r8 into r9;
    assert.eq r9 true;
    set r5 into proposers_managers[r0];
    set r3 into dao_manager_updaters[r0];
    set r1 into voting_system_managers[r0];
    cast r0 r3 into r10 as ProposerKey;
    set r10 into approved_proposers[r4];
    cast r0 r1 into r11 as ProposerKey;
    set r11 into approved_proposers[r2];
    cast r0 r5 into r12 as ProposerKey;
    set r12 into approved_proposers[r6];

function update_dao_manager_as_signer:
    input r0 as field.public;
    input r1 as address.public;
    call zvote_dao_registry.aleo/update_dao_manager r0 r1 into r2;
    cast r0 self.caller into r3 as ProposerKey;
    hash.bhp256 r3 into r4 as field;
    async update_dao_manager_as_signer r0 self.signer r4 r2 into r5;
    output r5 as daom__approved_proposers_004.aleo/update_dao_manager_as_signer.future;

finalize update_dao_manager_as_signer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as zvote_dao_registry.aleo/update_dao_manager.future;
    await r3;
    get dao_manager_updaters[r0] into r4;
    assert.eq r4 r1;
    get voting_system_managers[r0] into r5;
    cast r0 r5 into r6 as ProposerKey;
    hash.bhp256 r6 into r7 as field;
    get proposers_managers[r0] into r8;
    cast r0 r8 into r9 as ProposerKey;
    hash.bhp256 r9 into r10 as field;
    remove proposers_managers[r0];
    remove dao_manager_updaters[r0];
    remove voting_system_managers[r0];
    remove approved_proposers[r2];
    remove approved_proposers[r7];
    remove approved_proposers[r10];

function add_approved_proposer:
    input r0 as field.public;
    input r1 as address.public;
    cast r0 r1 into r2 as ProposerKey;
    hash.bhp256 r2 into r3 as field;
    async add_approved_proposer r0 r3 r1 self.caller into r4;
    output r4 as daom__approved_proposers_004.aleo/add_approved_proposer.future;

finalize add_approved_proposer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    get proposers_managers[r0] into r4;
    assert.eq r4 r3;
    cast r0 r2 into r5 as ProposerKey;
    set r5 into approved_proposers[r1];

function remove_approved_proposer:
    input r0 as field.public;
    input r1 as address.public;
    cast r0 r1 into r2 as ProposerKey;
    hash.bhp256 r2 into r3 as field;
    async remove_approved_proposer r0 r3 self.caller into r4;
    output r4 as daom__approved_proposers_004.aleo/remove_approved_proposer.future;

finalize remove_approved_proposer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    get proposers_managers[r0] into r3;
    assert.eq r3 r2;
    remove approved_proposers[r1];
