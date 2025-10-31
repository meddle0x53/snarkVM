import zvote_dao_registry_015.aleo;
import daom__approved_proposers_015.aleo;

program vsm__dao_based_ap_015.aleo;

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

struct ApDaoManagerParams:
    dao_manager_updater as address;
    voting_system_manager as address;
    proposers_manager as address;

struct VotingSystemProposal:
    dao_id as field;
    proposal_id as field;
    voting_system as address;
    vs_params_hash as field;
    is_add as boolean;

mapping proposal_contents:
    key as field.public;
    value as VotingSystemProposal.public;

mapping executed_already:
    key as field.public;
    value as boolean.public;

function add_voting_system:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    call daom__approved_proposers_015.aleo/add_voting_system r0 r2 r3 into r4;
    cast r0 r1 into r5 as ProposalKey;
    hash.bhp256 r5 into r6 as field;
    async add_voting_system r6 r2 r3 r4 into r7;
    output r7 as vsm__dao_based_ap_015.aleo/add_voting_system.future;

finalize add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as daom__approved_proposers_015.aleo/add_voting_system.future;
    get proposal_contents[r0] into r4;
    assert.eq r4.voting_system r1;
    assert.eq r4.vs_params_hash r2;
    assert.eq r4.is_add true;
    get zvote_dao_registry_015.aleo/results[r0] into r5;
    cast r5 into r6 as boolean;
    assert.eq r6 true;
    contains executed_already[r0] into r7;
    not r7 into r8;
    assert.eq r8 true;
    set true into executed_already[r0];
    await r3;

function remove_voting_system:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    call daom__approved_proposers_015.aleo/remove_voting_system r0 r2 r3 into r4;
    cast r0 r1 into r5 as ProposalKey;
    hash.bhp256 r5 into r6 as field;
    async remove_voting_system r6 r2 r3 r4 into r7;
    output r7 as vsm__dao_based_ap_015.aleo/remove_voting_system.future;

finalize remove_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as daom__approved_proposers_015.aleo/remove_voting_system.future;
    get proposal_contents[r0] into r4;
    assert.eq r4.voting_system r1;
    assert.eq r4.vs_params_hash r2;
    not r4.is_add into r5;
    assert.eq r5 true;
    get zvote_dao_registry_015.aleo/results[r0] into r6;
    cast r6 into r7 as boolean;
    assert.eq r7 true;
    contains executed_already[r0] into r8;
    not r8 into r9;
    assert.eq r9 true;
    set true into executed_already[r0];
    await r3;

function create_approve_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as address.public;
    input r4 as field.public;
    input r5 as address.public;
    input r6 as field.public;
    input r7 as boolean.public;
    call daom__approved_proposers_015.aleo/create_proposal r0 r1 vsm__dao_based_ap_015.aleo r2 r5 r6 into r8;
    cast r0 r1 r3 r4 r7 into r9 as VotingSystemProposal;
    cast r0 r1 into r10 as ProposalKey;
    hash.bhp256 r10 into r11 as field;
    async create_approve_proposal r11 r9 r8 into r12;
    output r12 as vsm__dao_based_ap_015.aleo/create_approve_proposal.future;

finalize create_approve_proposal:
    input r0 as field.public;
    input r1 as VotingSystemProposal.public;
    input r2 as daom__approved_proposers_015.aleo/create_proposal.future;
    await r2;
    contains proposal_contents[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into proposal_contents[r0];
