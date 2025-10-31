program zvote_dao_registry_015.aleo;

struct Dao:
    dao_id as field;
    token_id as field;
    dao_manager as address;
    dao_manager_params_hash as field;

struct Proposal:
    dao_id as field;
    proposal_id as field;
    content as address;
    params_hash as field;
    voting_system as address;
    vs_params_hash as field;

struct ProposalKey:
    dao_id as field;
    proposal_id as field;

struct VotingSystemKey:
    dao_id as field;
    voting_system as address;
    vs_params_hash as field;

mapping daos:
    key as field.public;
    value as Dao.public;

mapping proposals:
    key as field.public;
    value as Proposal.public;

mapping voting_systems:
    key as field.public;
    value as VotingSystemKey.public;

mapping results:
    key as field.public;
    value as field.public;

function register_dao:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    input r5 as field.public;
    cast r0 r1 r2 r3 into r6 as Dao;
    cast r0 r4 r5 into r7 as VotingSystemKey;
    hash.bhp256 r7 into r8 as field;
    async register_dao r6 r7 r8 into r9;
    output r9 as zvote_dao_registry_015.aleo/register_dao.future;

finalize register_dao:
    input r0 as Dao.public;
    input r1 as VotingSystemKey.public;
    input r2 as field.public;
    contains daos[r0.dao_id] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r0 into daos[r0.dao_id];
    set r1 into voting_systems[r2];

function update_dao_manager:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    async update_dao_manager r0 r1 r2 r3 self.caller into r4;
    output r4 as zvote_dao_registry_015.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    get daos[r0] into r5;
    assert.eq r4 r5.dao_manager;
    cast r5.dao_id r1 r2 r3 into r6 as Dao;
    set r6 into daos[r5.dao_id];

function update_dao_token_id:
    input r0 as field.public;
    input r1 as field.public;
    async update_dao_token_id r0 r1 self.caller into r2;
    output r2 as zvote_dao_registry_015.aleo/update_dao_token_id.future;

finalize update_dao_token_id:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    get daos[r0] into r3;
    assert.eq r2 r3.dao_manager;
    cast r3.dao_id r1 r3.dao_manager r3.dao_manager_params_hash into r4 as Dao;
    set r4 into daos[r3.dao_id];

function add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    cast r0 r1 r2 into r3 as VotingSystemKey;
    hash.bhp256 r3 into r4 as field;
    async add_voting_system r3 r4 self.caller into r5;
    output r5 as zvote_dao_registry_015.aleo/add_voting_system.future;

finalize add_voting_system:
    input r0 as VotingSystemKey.public;
    input r1 as field.public;
    input r2 as address.public;
    get daos[r0.dao_id] into r3;
    assert.eq r2 r3.dao_manager;
    set r0 into voting_systems[r1];

function remove_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    cast r0 r1 r2 into r3 as VotingSystemKey;
    hash.bhp256 r3 into r4 as field;
    async remove_voting_system r0 r4 self.caller into r5;
    output r5 as zvote_dao_registry_015.aleo/remove_voting_system.future;

finalize remove_voting_system:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    get daos[r0] into r3;
    assert.eq r2 r3.dao_manager;
    remove voting_systems[r1];

function create_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    input r5 as field.public;
    cast r0 r1 into r6 as ProposalKey;
    hash.bhp256 r6 into r7 as field;
    cast r0 r1 r2 r3 r4 r5 into r8 as Proposal;
    cast r0 r4 r5 into r9 as VotingSystemKey;
    hash.bhp256 r9 into r10 as field;
    async create_proposal r8 r7 r10 self.caller into r11;
    output r11 as zvote_dao_registry_015.aleo/create_proposal.future;

finalize create_proposal:
    input r0 as Proposal.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as address.public;
    get daos[r0.dao_id] into r4;
    assert.eq r3 r4.dao_manager;
    contains voting_systems[r2] into r5;
    assert.eq r5 true;
    contains proposals[r1] into r6;
    not r6 into r7;
    assert.eq r7 true;
    set r0 into proposals[r1];

function set_result:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    cast r0 r1 into r3 as ProposalKey;
    hash.bhp256 r3 into r4 as field;
    async set_result r4 r2 self.caller into r5;
    output r5 as zvote_dao_registry_015.aleo/set_result.future;

finalize set_result:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    get proposals[r0] into r3;
    assert.eq r3.voting_system r2;
    contains results[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    set r1 into results[r0];
