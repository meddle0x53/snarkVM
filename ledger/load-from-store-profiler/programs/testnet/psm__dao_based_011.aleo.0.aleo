import zvote_dao_registry_011.aleo;
import daom__approved_proposers_011.aleo;

program psm__dao_based_011.aleo;

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

struct ProposerProposal:
    dao_id as field;
    proposal_id as field;
    proposer as address;
    is_add as boolean;

mapping proposal_contents:
    key as field.public;
    value as ProposerProposal.public;

function add_approved_proposer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    call daom__approved_proposers_011.aleo/add_approved_proposer r0 r2 into r3;
    cast r0 r1 into r4 as ProposalKey;
    hash.bhp256 r4 into r5 as field;
    async add_approved_proposer r5 r2 r3 into r6;
    output r6 as psm__dao_based_011.aleo/add_approved_proposer.future;

finalize add_approved_proposer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as daom__approved_proposers_011.aleo/add_approved_proposer.future;
    get proposal_contents[r0] into r3;
    assert.eq r3.proposer r1;
    assert.eq r3.is_add true;
    remove proposal_contents[r0];
    get zvote_dao_registry_011.aleo/results[r0] into r4;
    cast r4 into r5 as boolean;
    assert.eq r5 true;
    await r2;

function remove_approved_proposer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    call daom__approved_proposers_011.aleo/remove_approved_proposer r0 r2 into r3;
    cast r0 r1 into r4 as ProposalKey;
    hash.bhp256 r4 into r5 as field;
    async remove_approved_proposer r5 r2 r3 into r6;
    output r6 as psm__dao_based_011.aleo/remove_approved_proposer.future;

finalize remove_approved_proposer:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as daom__approved_proposers_011.aleo/remove_approved_proposer.future;
    get proposal_contents[r0] into r3;
    assert.eq r3.proposer r1;
    not r3.is_add into r4;
    assert.eq r4 true;
    remove proposal_contents[r0];
    get zvote_dao_registry_011.aleo/results[r0] into r5;
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
    is.neq r2 psm__dao_based_011.aleo into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    call daom__approved_proposers_011.aleo/create_proposal r0 r1 psm__dao_based_011.aleo r3 r4 into r8;
    cast r0 r1 r2 r5 into r9 as ProposerProposal;
    cast r0 r1 into r10 as ProposalKey;
    hash.bhp256 r10 into r11 as field;
    async create_approve_proposal r11 r9 r8 into r12;
    output r12 as psm__dao_based_011.aleo/create_approve_proposal.future;

finalize create_approve_proposal:
    input r0 as field.public;
    input r1 as ProposerProposal.public;
    input r2 as daom__approved_proposers_011.aleo/create_proposal.future;
    await r2;
    contains proposal_contents[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into proposal_contents[r0];
