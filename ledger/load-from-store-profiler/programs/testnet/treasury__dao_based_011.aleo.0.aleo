import credits.aleo;
import token_registry.aleo;
import zvote_dao_registry_011.aleo;
import daom__approved_proposers_011.aleo;

program treasury__dao_based_011.aleo;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

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

struct ProposerKey:
    dao_id as field;
    proposer as address;

struct ApDaoManagerParams:
    dao_manager_updater as address;
    voting_system_manager as address;
    proposers_manager as address;

struct HookedTransfer:
    proposal_id as field;
    token_id as field;
    recipient as address;
    amount as u128;
    triggering_result as field;

mapping hooked_transfers:
    key as field.public;
    value as HookedTransfer.public;

function transfer_public:
    input r0 as HookedTransfer.public;
    cast 123field r0.proposal_id into r1 as ProposalKey;
    hash.bhp256 r1 into r2 as field;
    call token_registry.aleo/transfer_public r0.token_id r0.recipient r0.amount into r3;
    async transfer_public r0 r2 r3 into r4;
    output r4 as treasury__dao_based_011.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as HookedTransfer.public;
    input r1 as field.public;
    input r2 as token_registry.aleo/transfer_public.future;
    await r2;
    get zvote_dao_registry_011.aleo/results[r1] into r3;
    assert.eq r3 r0.triggering_result;
    get hooked_transfers[r1] into r4;
    assert.eq r0 r4;

function hook_transfer_to_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as u128.public;
    input r4 as field.public;
    cast 123field self.caller into r5 as ProposerKey;
    hash.bhp256 r5 into r6 as field;
    cast 123field r0 into r7 as ProposalKey;
    hash.bhp256 r7 into r8 as field;
    cast r0 r1 r2 r3 r4 into r9 as HookedTransfer;
    async hook_transfer_to_proposal r9 r8 r6 into r10;
    output r10 as treasury__dao_based_011.aleo/hook_transfer_to_proposal.future;

finalize hook_transfer_to_proposal:
    input r0 as HookedTransfer.public;
    input r1 as field.public;
    input r2 as field.public;
    contains daom__approved_proposers_011.aleo/approved_proposers[r2] into r3;
    assert.eq r3 true;
    contains zvote_dao_registry_011.aleo/proposals[r1] into r4;
    not r4 into r5;
    assert.eq r5 true;
    set r0 into hooked_transfers[r1];
