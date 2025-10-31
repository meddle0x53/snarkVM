import zvote_dao_registry.aleo;
import daom__no_approval_005.aleo;

program vsm__dao_based_na_005.aleo;

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

struct ProposalKey:
    dao_id as field;
    proposal_id as field;

struct VotingSystemKey:
    dao_id as field;
    voting_system as address;
    vs_params_hash as field;

struct VotingSystemProposal:
    dao_id as field;
    proposal_id as field;
    voting_system as address;
    vs_params_hash as field;
    is_add as boolean;

struct VSMApproveArgs:
    voting_system as address;
    vs_params_hash as field;
    is_add as boolean;
    is_vs_approve_proposal as boolean;

mapping voting_system_proposals:
    key as field.public;
    value as VotingSystemProposal.public;

function add_voting_system:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    call daom__no_approval_005.aleo/add_voting_system r0 r2 r3 into r4;
    cast r0 r1 into r5 as ProposalKey;
    hash.bhp256 r5 into r6 as field;
    async add_voting_system r6 r2 r3 r4 into r7;
    output r7 as vsm__dao_based_na_005.aleo/add_voting_system.future;

finalize add_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as daom__no_approval_005.aleo/add_voting_system.future;
    get voting_system_proposals[r0] into r4;
    assert.eq r4.voting_system r1;
    assert.eq r4.vs_params_hash r2;
    assert.eq r4.is_add true;
    remove voting_system_proposals[r0];
    get zvote_dao_registry.aleo/results[r0] into r5;
    cast r5 into r6 as boolean;
    assert.eq r6 true;
    await r3;

function remove_voting_system:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    call daom__no_approval_005.aleo/remove_voting_system r0 r2 r3 into r4;
    cast r0 r1 into r5 as ProposalKey;
    hash.bhp256 r5 into r6 as field;
    async remove_voting_system r6 r2 r3 r4 into r7;
    output r7 as vsm__dao_based_na_005.aleo/remove_voting_system.future;

finalize remove_voting_system:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as daom__no_approval_005.aleo/remove_voting_system.future;
    get voting_system_proposals[r0] into r4;
    assert.eq r4.voting_system r1;
    assert.eq r4.vs_params_hash r2;
    not r4.is_add into r5;
    assert.eq r5 true;
    remove voting_system_proposals[r0];
    get zvote_dao_registry.aleo/results[r0] into r6;
    cast r6 into r7 as boolean;
    assert.eq r7 true;
    await r3;

function create_approve_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    input r5 as field.public;
    input r6 as boolean.public;
    cast r2 r3 r6 true into r7 as VSMApproveArgs;
    hash.bhp256 r7 into r8 as field;
    call daom__no_approval_005.aleo/create_proposal r0 r1 r8 r4 r5 into r9;
    cast r0 r1 r2 r3 r6 into r10 as VotingSystemProposal;
    cast r0 r1 into r11 as ProposalKey;
    hash.bhp256 r11 into r12 as field;
    async create_approve_proposal r12 r10 r9 into r13;
    output r13 as vsm__dao_based_na_005.aleo/create_approve_proposal.future;

finalize create_approve_proposal:
    input r0 as field.public;
    input r1 as VotingSystemProposal.public;
    input r2 as daom__no_approval_005.aleo/create_proposal.future;
    await r2;
    contains voting_system_proposals[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into voting_system_proposals[r0];
