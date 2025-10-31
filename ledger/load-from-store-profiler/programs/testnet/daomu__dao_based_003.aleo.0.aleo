import zvote_dao_registry.aleo;
import daom__approved_proposers_003.aleo;

program daomu__dao_based_003.aleo;

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

struct DAOMUpdateProposal:
    dao_id as field;
    proposal_id as field;
    dao_manager as address;

struct DAOMUpdateArgs:
    new_daom as address;
    is_daom_udpate_proposal as boolean;

mapping daom_update_proposals:
    key as field.public;
    value as DAOMUpdateProposal.public;

function update_dao_manager:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    call daom__approved_proposers_003.aleo/update_dao_manager r0 r2 into r3;
    cast r0 r1 into r4 as ProposalKey;
    hash.bhp256 r4 into r5 as field;
    async update_dao_manager r5 r2 r3 into r6;
    output r6 as daomu__dao_based_003.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as daom__approved_proposers_003.aleo/update_dao_manager.future;
    get daom_update_proposals[r0] into r3;
    assert.eq r3.dao_manager r1;
    remove daom_update_proposals[r0];
    get zvote_dao_registry.aleo/results[r0] into r4;
    cast r4 into r5 as boolean;
    assert.eq r5 true;
    await r2;

function create_daom_update_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as field.public;
    cast r2 true into r5 as DAOMUpdateArgs;
    hash.bhp256 r5 into r6 as field;
    call daom__approved_proposers_003.aleo/create_proposal r0 r1 r6 r3 r4 into r7;
    cast r0 r1 r2 into r8 as DAOMUpdateProposal;
    cast r0 r1 into r9 as ProposalKey;
    hash.bhp256 r9 into r10 as field;
    async create_daom_update_proposal r10 r8 r7 into r11;
    output r11 as daomu__dao_based_003.aleo/create_daom_update_proposal.future;

finalize create_daom_update_proposal:
    input r0 as field.public;
    input r1 as DAOMUpdateProposal.public;
    input r2 as daom__approved_proposers_003.aleo/create_proposal.future;
    await r2;
    contains daom_update_proposals[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into daom_update_proposals[r0];
