import zvote_dao_registry_011.aleo;
import daom__approved_proposers_011.aleo;
import daom__no_approval_011.aleo;
import daomu__dao_based_ap_011.aleo;
import daomu__dao_based_na_011.aleo;

program h__update_daom_helper_011.aleo;

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

struct VotingSystemKey:
    dao_id as field;
    voting_system as address;
    vs_params_hash as field;

struct ApDaoManagerParams:
    dao_manager_updater as address;
    voting_system_manager as address;
    proposers_manager as address;

struct NaDaoManagerParams:
    dao_manager_updater as address;
    voting_system_manager as address;

struct DAOMUpdateProposal:
    dao_id as field;
    proposal_id as field;
    dao_manager as address;
    dao_manager_params_hash as field;

function update_ap_to_na:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    cast r1 r2 into r3 as NaDaoManagerParams;
    hash.bhp256 r3 into r4 as field;
    call daom__approved_proposers_011.aleo/update_dao_manager_as_signer r0 daom__no_approval_011.aleo r4 into r5;
    call daom__no_approval_011.aleo/init_as_dao_manager r0 r3 into r6;
    async update_ap_to_na r5 r6 into r7;
    output r7 as h__update_daom_helper_011.aleo/update_ap_to_na.future;

finalize update_ap_to_na:
    input r0 as daom__approved_proposers_011.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__no_approval_011.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_na_to_ap:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    cast r1 r2 r3 into r4 as ApDaoManagerParams;
    hash.bhp256 r4 into r5 as field;
    call daom__no_approval_011.aleo/update_dao_manager_as_signer r0 daom__approved_proposers_011.aleo r5 into r6;
    call daom__approved_proposers_011.aleo/init_as_dao_manager r0 r4 into r7;
    async update_na_to_ap r6 r7 into r8;
    output r8 as h__update_daom_helper_011.aleo/update_na_to_ap.future;

finalize update_na_to_ap:
    input r0 as daom__no_approval_011.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__approved_proposers_011.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_na_to_na:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    cast r1 r2 into r3 as NaDaoManagerParams;
    hash.bhp256 r3 into r4 as field;
    call daom__no_approval_011.aleo/update_dao_manager_as_signer r0 daom__no_approval_011.aleo r4 into r5;
    call daom__no_approval_011.aleo/init_as_dao_manager r0 r3 into r6;
    async update_na_to_na r5 r6 into r7;
    output r7 as h__update_daom_helper_011.aleo/update_na_to_na.future;

finalize update_na_to_na:
    input r0 as daom__no_approval_011.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__no_approval_011.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_ap_to_ap:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    cast r1 r2 r3 into r4 as ApDaoManagerParams;
    hash.bhp256 r4 into r5 as field;
    call daom__approved_proposers_011.aleo/update_dao_manager_as_signer r0 daom__approved_proposers_011.aleo r5 into r6;
    call daom__approved_proposers_011.aleo/init_as_dao_manager r0 r4 into r7;
    async update_ap_to_ap r6 r7 into r8;
    output r8 as h__update_daom_helper_011.aleo/update_ap_to_ap.future;

finalize update_ap_to_ap:
    input r0 as daom__approved_proposers_011.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__approved_proposers_011.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function propose_update_ap_to_na:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as field.public;
    cast r2 r3 into r6 as NaDaoManagerParams;
    hash.bhp256 r6 into r7 as field;
    call daomu__dao_based_ap_011.aleo/create_daom_update_proposal r0 r1 daom__no_approval_011.aleo r7 r4 r5 into r8;
    call daom__no_approval_011.aleo/reference_dao_manager_params r6 into r9;
    async propose_update_ap_to_na r8 r9 into r10;
    output r10 as h__update_daom_helper_011.aleo/propose_update_ap_to_na.future;

finalize propose_update_ap_to_na:
    input r0 as daomu__dao_based_ap_011.aleo/create_daom_update_proposal.future;
    input r1 as daom__no_approval_011.aleo/reference_dao_manager_params.future;
    await r0;
    await r1;

function propose_update_na_to_ap:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as field.public;
    cast r2 r3 r4 into r7 as ApDaoManagerParams;
    hash.bhp256 r7 into r8 as field;
    call daomu__dao_based_na_011.aleo/create_daom_update_proposal r0 r1 daom__approved_proposers_011.aleo r8 r5 r6 into r9;
    call daom__approved_proposers_011.aleo/reference_dao_manager_params r7 into r10;
    async propose_update_na_to_ap r9 r10 into r11;
    output r11 as h__update_daom_helper_011.aleo/propose_update_na_to_ap.future;

finalize propose_update_na_to_ap:
    input r0 as daomu__dao_based_na_011.aleo/create_daom_update_proposal.future;
    input r1 as daom__approved_proposers_011.aleo/reference_dao_manager_params.future;
    await r0;
    await r1;

function propose_update_na_to_na:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as field.public;
    cast r2 r3 into r6 as NaDaoManagerParams;
    hash.bhp256 r6 into r7 as field;
    call daomu__dao_based_na_011.aleo/create_daom_update_proposal r0 r1 daom__no_approval_011.aleo r7 r4 r5 into r8;
    call daom__no_approval_011.aleo/reference_dao_manager_params r6 into r9;
    async propose_update_na_to_na r8 r9 into r10;
    output r10 as h__update_daom_helper_011.aleo/propose_update_na_to_na.future;

finalize propose_update_na_to_na:
    input r0 as daomu__dao_based_na_011.aleo/create_daom_update_proposal.future;
    input r1 as daom__no_approval_011.aleo/reference_dao_manager_params.future;
    await r0;
    await r1;

function propose_update_ap_to_ap:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as field.public;
    cast r2 r3 r4 into r7 as ApDaoManagerParams;
    hash.bhp256 r7 into r8 as field;
    call daomu__dao_based_ap_011.aleo/create_daom_update_proposal r0 r1 daom__approved_proposers_011.aleo r8 r5 r6 into r9;
    call daom__approved_proposers_011.aleo/reference_dao_manager_params r7 into r10;
    async propose_update_ap_to_ap r9 r10 into r11;
    output r11 as h__update_daom_helper_011.aleo/propose_update_ap_to_ap.future;

finalize propose_update_ap_to_ap:
    input r0 as daomu__dao_based_ap_011.aleo/create_daom_update_proposal.future;
    input r1 as daom__approved_proposers_011.aleo/reference_dao_manager_params.future;
    await r0;
    await r1;

function dao_based_update_ap_to_na:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    cast r2 r3 into r4 as NaDaoManagerParams;
    hash.bhp256 r4 into r5 as field;
    call daomu__dao_based_ap_011.aleo/update_dao_manager r0 r1 daom__no_approval_011.aleo r5 into r6;
    call daom__no_approval_011.aleo/init_as_dao_manager r0 r4 into r7;
    async dao_based_update_ap_to_na r6 r7 into r8;
    output r8 as h__update_daom_helper_011.aleo/dao_based_update_ap_to_na.future;

finalize dao_based_update_ap_to_na:
    input r0 as daomu__dao_based_ap_011.aleo/update_dao_manager.future;
    input r1 as daom__no_approval_011.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function dao_based_update_na_to_ap:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    cast r2 r3 r4 into r5 as ApDaoManagerParams;
    hash.bhp256 r5 into r6 as field;
    call daomu__dao_based_na_011.aleo/update_dao_manager r0 r1 daom__approved_proposers_011.aleo r6 into r7;
    call daom__approved_proposers_011.aleo/init_as_dao_manager r0 r5 into r8;
    async dao_based_update_na_to_ap r7 r8 into r9;
    output r9 as h__update_daom_helper_011.aleo/dao_based_update_na_to_ap.future;

finalize dao_based_update_na_to_ap:
    input r0 as daomu__dao_based_na_011.aleo/update_dao_manager.future;
    input r1 as daom__approved_proposers_011.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function dao_based_update_na_to_na:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    cast r2 r3 into r4 as NaDaoManagerParams;
    hash.bhp256 r4 into r5 as field;
    call daomu__dao_based_na_011.aleo/update_dao_manager r0 r1 daom__no_approval_011.aleo r5 into r6;
    call daom__no_approval_011.aleo/init_as_dao_manager r0 r4 into r7;
    async dao_based_update_na_to_na r6 r7 into r8;
    output r8 as h__update_daom_helper_011.aleo/dao_based_update_na_to_na.future;

finalize dao_based_update_na_to_na:
    input r0 as daomu__dao_based_na_011.aleo/update_dao_manager.future;
    input r1 as daom__no_approval_011.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function dao_based_update_ap_to_ap:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    cast r2 r3 r4 into r5 as ApDaoManagerParams;
    hash.bhp256 r5 into r6 as field;
    call daomu__dao_based_ap_011.aleo/update_dao_manager r0 r1 daom__approved_proposers_011.aleo r6 into r7;
    call daom__approved_proposers_011.aleo/init_as_dao_manager r0 r5 into r8;
    async dao_based_update_ap_to_ap r7 r8 into r9;
    output r9 as h__update_daom_helper_011.aleo/dao_based_update_ap_to_ap.future;

finalize dao_based_update_ap_to_ap:
    input r0 as daomu__dao_based_ap_011.aleo/update_dao_manager.future;
    input r1 as daom__approved_proposers_011.aleo/init_as_dao_manager.future;
    await r0;
    await r1;
