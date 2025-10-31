import zvote_dao_registry_010.aleo;
import daom__approved_proposers_010.aleo;

program daomu__dao_based_ap_010.aleo;

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

struct ApDAOMUpdateProposal:
    dao_id as field;
    proposal_id as field;
    dao_manager as address;
    dao_manager_updater as address;
    voting_system_manager as address;
    proposers_manager as address;

mapping proposal_contents:
    key as field.public;
    value as ApDAOMUpdateProposal.public;

function update_dao_manager:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    call daom__approved_proposers_010.aleo/update_dao_manager r0 r2 r3 into r4;
    cast r0 r1 into r5 as ProposalKey;
    hash.bhp256 r5 into r6 as field;
    async update_dao_manager r6 r2 r3 r4 into r7;
    output r7 as daomu__dao_based_ap_010.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as daom__approved_proposers_010.aleo/update_dao_manager.future;
    get proposal_contents[r0] into r4;
    assert.eq r4.dao_manager r1;
    cast r4.dao_manager_updater r4.voting_system_manager r4.proposers_manager into r5 as ApDaoManagerParams;
    hash.bhp256 r5 into r6 as field;
    assert.eq r6 r2;
    get zvote_dao_registry_010.aleo/results[r0] into r7;
    cast r7 into r8 as boolean;
    assert.eq r8 true;
    await r3;

function create_daom_update_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as field.public;
    call daom__approved_proposers_010.aleo/create_proposal r0 r1 daomu__dao_based_ap_010.aleo r6 r7 into r8;
    cast r0 r1 r2 r3 r4 r5 into r9 as ApDAOMUpdateProposal;
    cast r0 r1 into r10 as ProposalKey;
    hash.bhp256 r10 into r11 as field;
    async create_daom_update_proposal r11 r9 r8 into r12;
    output r12 as daomu__dao_based_ap_010.aleo/create_daom_update_proposal.future;

finalize create_daom_update_proposal:
    input r0 as field.public;
    input r1 as ApDAOMUpdateProposal.public;
    input r2 as daom__approved_proposers_010.aleo/create_proposal.future;
    await r2;
    contains proposal_contents[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into proposal_contents[r0];
