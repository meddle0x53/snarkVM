import zvote_dao_registry_014.aleo;
import daom__no_approval_014.aleo;

program daomu__dao_based_na_014.aleo;

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
    token_id as field;
    dao_manager as address;
    dao_manager_params_hash as field;

mapping proposal_contents:
    key as field.public;
    value as DAOMUpdateProposal.public;

mapping executed_already:
    key as field.public;
    value as boolean.public;

function update_dao_manager:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as address.public;
    input r4 as field.public;
    call daom__no_approval_014.aleo/update_dao_manager r0 r2 r3 r4 into r5;
    cast r0 r1 into r6 as ProposalKey;
    hash.bhp256 r6 into r7 as field;
    async update_dao_manager r7 r2 r3 r4 r5 into r8;
    output r8 as daomu__dao_based_na_014.aleo/update_dao_manager.future;

finalize update_dao_manager:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as daom__no_approval_014.aleo/update_dao_manager.future;
    get proposal_contents[r0] into r5;
    assert.eq r5.dao_manager r2;
    assert.eq r5.token_id r1;
    assert.eq r3 r5.dao_manager_params_hash;
    get zvote_dao_registry_014.aleo/results[r0] into r6;
    cast r6 into r7 as boolean;
    assert.eq r7 true;
    contains executed_already[r0] into r8;
    not r8 into r9;
    assert.eq r9 true;
    set true into executed_already[r0];
    await r4;

function create_daom_update_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as address.public;
    input r4 as field.public;
    input r5 as address.public;
    input r6 as field.public;
    call daom__no_approval_014.aleo/create_proposal r0 r1 daomu__dao_based_na_014.aleo r5 r6 into r7;
    cast r0 r1 r2 r3 r4 into r8 as DAOMUpdateProposal;
    cast r0 r1 into r9 as ProposalKey;
    hash.bhp256 r9 into r10 as field;
    async create_daom_update_proposal r10 r8 r7 into r11;
    output r11 as daomu__dao_based_na_014.aleo/create_daom_update_proposal.future;

finalize create_daom_update_proposal:
    input r0 as field.public;
    input r1 as DAOMUpdateProposal.public;
    input r2 as daom__no_approval_014.aleo/create_proposal.future;
    await r2;
    contains proposal_contents[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into proposal_contents[r0];
