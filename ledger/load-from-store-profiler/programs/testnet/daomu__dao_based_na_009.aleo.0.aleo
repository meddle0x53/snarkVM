import zvote_dao_registry_009.aleo;
import daom__no_approval_009.aleo;

program daomu__dao_based_na_009.aleo;

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

struct NaDaoManagerParams:
    dao_manager_updater as address;
    voting_system_manager as address;

struct DAOMUpdateProposal:
    dao_id as field;
    proposal_id as field;
    dao_manager as address;
    dao_manager_params_hash as field;

mapping proposal_contents:
    key as field.public;
    value as DAOMUpdateProposal.public;

function update_dao_manager:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    call daom__no_approval_009.aleo/update_dao_manager r0 r2 r3 into r4;
    cast r0 r1 into r5 as ProposalKey;
    hash.bhp256 r5 into r6 as field;
    async update_dao_manager r6 r2 r3 r4 into r7;
    output r7 as daomu__dao_based_na_009.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as daom__no_approval_009.aleo/update_dao_manager.future;
    get proposal_contents[r0] into r4;
    assert.eq r4.dao_manager r1;
    assert.eq r4.dao_manager_params_hash r2;
    remove proposal_contents[r0];
    get zvote_dao_registry_009.aleo/results[r0] into r5;
    cast r5 into r6 as boolean;
    assert.eq r6 true;
    await r3;

function create_daom_update_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    input r5 as field.public;
    call daom__no_approval_009.aleo/create_proposal r0 r1 daomu__dao_based_na_009.aleo r4 r5 into r6;
    cast r0 r1 r2 r3 into r7 as DAOMUpdateProposal;
    cast r0 r1 into r8 as ProposalKey;
    hash.bhp256 r8 into r9 as field;
    async create_daom_update_proposal r9 r7 r6 into r10;
    output r10 as daomu__dao_based_na_009.aleo/create_daom_update_proposal.future;

finalize create_daom_update_proposal:
    input r0 as field.public;
    input r1 as DAOMUpdateProposal.public;
    input r2 as daom__no_approval_009.aleo/create_proposal.future;
    await r2;
    contains proposal_contents[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into proposal_contents[r0];
