import zvote_dao_registry_008.aleo;
import daom__approved_proposers_008.aleo;
import daom__no_approval_008.aleo;

program h__update_daom_helper_008.aleo;

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

struct VotingSystemKey:
    dao_id as field;
    voting_system as address;
    vs_params_hash as field;

function update_ap_to_na:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    call daom__approved_proposers_008.aleo/update_dao_manager_as_signer r0 daom__no_approval_008.aleo into r3;
    call daom__no_approval_008.aleo/init_as_dao_manager r0 r1 r2 into r4;
    async update_ap_to_na r3 r4 into r5;
    output r5 as h__update_daom_helper_008.aleo/update_ap_to_na.future;

finalize update_ap_to_na:
    input r0 as daom__approved_proposers_008.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__no_approval_008.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_na_to_ap:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    call daom__no_approval_008.aleo/update_dao_manager_as_signer r0 daom__approved_proposers_008.aleo into r4;
    call daom__approved_proposers_008.aleo/init_as_dao_manager r0 r1 r2 r3 into r5;
    async update_na_to_ap r4 r5 into r6;
    output r6 as h__update_daom_helper_008.aleo/update_na_to_ap.future;

finalize update_na_to_ap:
    input r0 as daom__no_approval_008.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__approved_proposers_008.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_na_to_na:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    call daom__no_approval_008.aleo/update_dao_manager_as_signer r0 daom__no_approval_008.aleo into r3;
    call daom__no_approval_008.aleo/init_as_dao_manager r0 r1 r2 into r4;
    async update_na_to_na r3 r4 into r5;
    output r5 as h__update_daom_helper_008.aleo/update_na_to_na.future;

finalize update_na_to_na:
    input r0 as daom__no_approval_008.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__no_approval_008.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function update_ap_to_ap:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    call daom__approved_proposers_008.aleo/update_dao_manager_as_signer r0 daom__approved_proposers_008.aleo into r4;
    call daom__approved_proposers_008.aleo/init_as_dao_manager r0 r1 r2 r3 into r5;
    async update_ap_to_ap r4 r5 into r6;
    output r6 as h__update_daom_helper_008.aleo/update_ap_to_ap.future;

finalize update_ap_to_ap:
    input r0 as daom__approved_proposers_008.aleo/update_dao_manager_as_signer.future;
    input r1 as daom__approved_proposers_008.aleo/init_as_dao_manager.future;
    await r0;
    await r1;
