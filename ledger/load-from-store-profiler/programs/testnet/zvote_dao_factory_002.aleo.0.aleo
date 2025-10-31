import multi_dao_support_program.aleo;
import daom__approved_proposers_001.aleo;
import daom__no_approval_required.aleo;

program zvote_dao_factory_002.aleo;

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

function register_proposer_list_dao:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    call multi_dao_support_program.aleo/register_dao r0 r1 daom__approved_proposers_001.aleo r2 r3 into r7;
    call daom__approved_proposers_001.aleo/init_as_dao_manager r0 r4 r5 r6 into r8;
    async register_proposer_list_dao r7 r8 into r9;
    output r9 as zvote_dao_factory_002.aleo/register_proposer_list_dao.future;

finalize register_proposer_list_dao:
    input r0 as multi_dao_support_program.aleo/register_dao.future;
    input r1 as daom__approved_proposers_001.aleo/init_as_dao_manager.future;
    await r0;
    await r1;

function register_any_proposer_dao:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    input r5 as address.public;
    call multi_dao_support_program.aleo/register_dao r0 r1 daom__no_approval_required.aleo r2 r3 into r6;
    call daom__no_approval_required.aleo/init_as_dao_manager r0 r4 r5 into r7;
    async register_any_proposer_dao r6 r7 into r8;
    output r8 as zvote_dao_factory_002.aleo/register_any_proposer_dao.future;

finalize register_any_proposer_dao:
    input r0 as multi_dao_support_program.aleo/register_dao.future;
    input r1 as daom__no_approval_required.aleo/init_as_dao_manager.future;
    await r0;
    await r1;
