import zvote_dao_registry_010.aleo;
import daom__approved_proposers_010.aleo;
import daom__no_approval_010.aleo;
import daomu__dao_based_ap_010.aleo;
import daomu__dao_based_na_010.aleo;

program h__update_daom_helper_010.aleo;

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

struct ApDAOMUpdateProposal:
    dao_id as field;
    proposal_id as field;
    dao_manager as address;
    dao_manager_updater as address;
    voting_system_manager as address;
    proposers_manager as address;

struct NaDAOMUpdateProposal:
    dao_id as field;
    proposal_id as field;
    dao_manager as address;
    dao_manager_updater as address;
    voting_system_manager as address;

function update_ap_to_na:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    cast r1 r2 into r3 as NaDaoManagerParams;
    hash.bhp256 r3 into r4 as field;
    call daom__approved_proposers_010.aleo/update_dao_manager_as_signer r0 daom__no_approval_010.aleo r4 into r5;
    call daom__no_approval_010.aleo/init_as_dao_manager r0 r3 into r6;
    async update_ap_to_na r5 r6 into r7;
    output r7 as h__update_daom_helper_010.aleo/update_ap_to_na.future;

finalize update_ap_to_na:
    input r0 as daom__approved_proposers_010.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__no_approval_010.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_na_to_ap:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    cast r1 r2 r3 into r4 as ApDaoManagerParams;
    hash.bhp256 r4 into r5 as field;
    call daom__no_approval_010.aleo/update_dao_manager_as_signer r0 daom__approved_proposers_010.aleo r5 into r6;
    call daom__approved_proposers_010.aleo/init_as_dao_manager r0 r4 into r7;
    async update_na_to_ap r6 r7 into r8;
    output r8 as h__update_daom_helper_010.aleo/update_na_to_ap.future;

finalize update_na_to_ap:
    input r0 as daom__no_approval_010.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__approved_proposers_010.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_na_to_na:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    cast r1 r2 into r3 as NaDaoManagerParams;
    hash.bhp256 r3 into r4 as field;
    call daom__no_approval_010.aleo/update_dao_manager_as_signer r0 daom__no_approval_010.aleo r4 into r5;
    call daom__no_approval_010.aleo/init_as_dao_manager r0 r3 into r6;
    async update_na_to_na r5 r6 into r7;
    output r7 as h__update_daom_helper_010.aleo/update_na_to_na.future;

finalize update_na_to_na:
    input r0 as daom__no_approval_010.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__no_approval_010.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_ap_to_ap:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    cast r1 r2 r3 into r4 as ApDaoManagerParams;
    hash.bhp256 r4 into r5 as field;
    call daom__approved_proposers_010.aleo/update_dao_manager_as_signer r0 daom__approved_proposers_010.aleo r5 into r6;
    call daom__approved_proposers_010.aleo/init_as_dao_manager r0 r4 into r7;
    async update_ap_to_ap r6 r7 into r8;
    output r8 as h__update_daom_helper_010.aleo/update_ap_to_ap.future;

finalize update_ap_to_ap:
    input r0 as daom__approved_proposers_010.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__approved_proposers_010.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function dao_based_update_ap_to_na:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    cast r2 r3 into r4 as NaDaoManagerParams;
    hash.bhp256 r4 into r5 as field;
    call daomu__dao_based_ap_010.aleo/update_dao_manager r0 r1 daom__no_approval_010.aleo r5 into r6;
    call daom__no_approval_010.aleo/init_as_dao_manager r0 r4 into r7;
    async dao_based_update_ap_to_na r6 r7 into r8;
    output r8 as h__update_daom_helper_010.aleo/dao_based_update_ap_to_na.future;

finalize dao_based_update_ap_to_na:
    input r0 as daomu__dao_based_ap_010.aleo/update_dao_manager.future;
    input r1 as daom__no_approval_010.aleo/init_as_dao_manager.future;
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
    call daomu__dao_based_na_010.aleo/update_dao_manager r0 r1 daom__approved_proposers_010.aleo r6 into r7;
    call daom__approved_proposers_010.aleo/init_as_dao_manager r0 r5 into r8;
    async dao_based_update_na_to_ap r7 r8 into r9;
    output r9 as h__update_daom_helper_010.aleo/dao_based_update_na_to_ap.future;

finalize dao_based_update_na_to_ap:
    input r0 as daomu__dao_based_na_010.aleo/update_dao_manager.future;
    input r1 as daom__approved_proposers_010.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function dao_based_update_na_to_na:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    cast r2 r3 into r4 as NaDaoManagerParams;
    hash.bhp256 r4 into r5 as field;
    call daomu__dao_based_na_010.aleo/update_dao_manager r0 r1 daom__no_approval_010.aleo r5 into r6;
    call daom__no_approval_010.aleo/init_as_dao_manager r0 r4 into r7;
    async dao_based_update_na_to_na r6 r7 into r8;
    output r8 as h__update_daom_helper_010.aleo/dao_based_update_na_to_na.future;

finalize dao_based_update_na_to_na:
    input r0 as daomu__dao_based_na_010.aleo/update_dao_manager.future;
    input r1 as daom__no_approval_010.aleo/init_as_dao_manager.future;
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
    call daomu__dao_based_ap_010.aleo/update_dao_manager r0 r1 daom__approved_proposers_010.aleo r6 into r7;
    call daom__approved_proposers_010.aleo/init_as_dao_manager r0 r5 into r8;
    async dao_based_update_ap_to_ap r7 r8 into r9;
    output r9 as h__update_daom_helper_010.aleo/dao_based_update_ap_to_ap.future;

finalize dao_based_update_ap_to_ap:
    input r0 as daomu__dao_based_ap_010.aleo/update_dao_manager.future;
    input r1 as daom__approved_proposers_010.aleo/init_as_dao_manager.future;
    await r0;
    await r1;
