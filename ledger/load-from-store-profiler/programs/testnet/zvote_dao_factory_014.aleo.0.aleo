import zvote_dao_registry_014.aleo;
import daom__approved_proposers_014.aleo;
import daom__no_approval_014.aleo;

program zvote_dao_factory_014.aleo;

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

function register_proposer_list_dao:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    cast r4 r5 r6 into r7 as ApDaoManagerParams;
    hash.bhp256 r7 into r8 as field;
    call zvote_dao_registry_014.aleo/register_dao r0 r1 daom__approved_proposers_014.aleo r8 r2 r3 into r9;
    call daom__approved_proposers_014.aleo/init_as_dao_manager r0 r7 into r10;
    async register_proposer_list_dao r9 r10 into r11;
    output r11 as zvote_dao_factory_014.aleo/register_proposer_list_dao.future;

finalize register_proposer_list_dao:
    input r0 as zvote_dao_registry_014.aleo/register_dao.future;
    input r1 as daom__approved_proposers_014.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function register_any_proposer_dao:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    input r5 as address.public;
    cast r4 r5 into r6 as NaDaoManagerParams;
    hash.bhp256 r6 into r7 as field;
    call zvote_dao_registry_014.aleo/register_dao r0 r1 daom__no_approval_014.aleo r7 r2 r3 into r8;
    call daom__no_approval_014.aleo/init_as_dao_manager r0 r6 into r9;
    async register_any_proposer_dao r8 r9 into r10;
    output r10 as zvote_dao_factory_014.aleo/register_any_proposer_dao.future;

finalize register_any_proposer_dao:
    input r0 as zvote_dao_registry_014.aleo/register_dao.future;
    input r1 as daom__no_approval_014.aleo/init_as_dao_manager.future;
    await r0;
    await r1;
