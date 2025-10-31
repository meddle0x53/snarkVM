import zvote_dao_registry.aleo;
import daom__approved_proposers_005.aleo;

program psm__dao_based_005.aleo;

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

struct ProposerProposal:
    dao_id as field;
    proposal_id as field;
    proposer as address;
    is_add as boolean;

struct PSMApproveArgs:
    proposer as address;
    is_add as boolean;
    is_proposers_approve_proposal as boolean;

mapping approve_proposer_proposals:
    key as field.public;
    value as ProposerProposal.public;

function add_approved_proposer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    call daom__approved_proposers_005.aleo/add_approved_proposer r0 r2 into r3;
    cast r0 r1 into r4 as ProposalKey;
    hash.bhp256 r4 into r5 as field;
    async add_approved_proposer r5 r2 r3 into r6;
    output r6 as psm__dao_based_005.aleo/add_approved_proposer.future;

finalize add_approved_proposer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as daom__approved_proposers_005.aleo/add_approved_proposer.future;
    get approve_proposer_proposals[r0] into r3;
    assert.eq r3.proposer r1;
    assert.eq r3.is_add true;
    remove approve_proposer_proposals[r0];
    get zvote_dao_registry.aleo/results[r0] into r4;
    cast r4 into r5 as boolean;
    assert.eq r5 true;
    await r2;

function remove_approved_proposer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    call daom__approved_proposers_005.aleo/remove_approved_proposer r0 r2 into r3;
    cast r0 r1 into r4 as ProposalKey;
    hash.bhp256 r4 into r5 as field;
    async remove_approved_proposer r5 r2 r3 into r6;
    output r6 as psm__dao_based_005.aleo/remove_approved_proposer.future;

finalize remove_approved_proposer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as daom__approved_proposers_005.aleo/remove_approved_proposer.future;
    get approve_proposer_proposals[r0] into r3;
    assert.eq r3.proposer r1;
    not r3.is_add into r4;
    assert.eq r4 true;
    remove approve_proposer_proposals[r0];
    get zvote_dao_registry.aleo/results[r0] into r5;
    cast r5 into r6 as boolean;
    assert.eq r6 true;
    await r2;

function create_approve_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as field.public;
    input r5 as boolean.public;
    is.neq r2 psm__dao_based_005.aleo into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    cast r2 r5 true into r8 as PSMApproveArgs;
    hash.bhp256 r8 into r9 as field;
    call daom__approved_proposers_005.aleo/create_proposal r0 r1 r9 r3 r4 into r10;
    cast r0 r1 r2 r5 into r11 as ProposerProposal;
    cast r0 r1 into r12 as ProposalKey;
    hash.bhp256 r12 into r13 as field;
    async create_approve_proposal r13 r11 r10 into r14;
    output r14 as psm__dao_based_005.aleo/create_approve_proposal.future;

finalize create_approve_proposal:
    input r0 as field.public;
    input r1 as ProposerProposal.public;
    input r2 as daom__approved_proposers_005.aleo/create_proposal.future;
    await r2;
    contains approve_proposer_proposals[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into approve_proposer_proposals[r0];
