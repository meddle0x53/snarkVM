import credits.aleo;
import token_registry.aleo;
import zvote_dao_registry.aleo;

program vs__2_candidates_005.aleo;

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

record CustodyReceipt:
    owner as address.private;
    amount as u128.private;
    token_id as field.private;
    external_authorization_required as boolean.private;
    dao_id as field.private;
    proposal_id as field.private;
    candidate as field.private;

struct ScoreKey:
    dao_id as field;
    proposal_id as field;
    candidate as field;

struct ProposalParams:
    candidates as [field; 2u32];

struct VotingSystemParams:
    quorum as u128;

mapping proposals:
    key as field.public;
    value as ProposalParams.public;

mapping scores:
    key as field.public;
    value as u128.public;

mapping custodies:
    key as field.public;
    value as u128.public;

mapping voting_system_params:
    key as field.public;
    value as VotingSystemParams.public;

function set_result:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    cast r0 r1 into r3 as ProposalKey;
    hash.bhp256 r3 into r4 as field;
    call zvote_dao_registry.aleo/set_result r0 r1 r2 into r5;
    async set_result r0 r1 r4 r2 r5 into r6;
    output r6 as vs__2_candidates_005.aleo/set_result.future;

finalize set_result:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as zvote_dao_registry.aleo/set_result.future;
    await r4;
    get zvote_dao_registry.aleo/proposals[r2] into r5;
    get proposals[r2] into r6;
    get voting_system_params[r5.vs_params_hash] into r7;
    cast r0 r1 r6.candidates[0u32] into r8 as ScoreKey;
    hash.bhp256 r8 into r9 as field;
    get scores[r9] into r10;
    cast r0 r1 r6.candidates[1u32] into r11 as ScoreKey;
    hash.bhp256 r11 into r12 as field;
    get scores[r12] into r13;
    gt r10 r13 into r14;
    ternary r14 r10 r13 into r15;
    gte r15 r7.quorum into r16;
    is.neq r10 r13 into r17;
    and r16 r17 into r18;
    assert.eq r18 true;
    gt r10 r13 into r19;
    ternary r19 r6.candidates[0u32] r6.candidates[1u32] into r20;
    assert.eq r3 r20;

function reference_voting_system_params:
    input r0 as VotingSystemParams.public;
    hash.bhp256 r0 into r1 as field;
    async reference_voting_system_params r1 r0 into r2;
    output r2 as vs__2_candidates_005.aleo/reference_voting_system_params.future;

finalize reference_voting_system_params:
    input r0 as field.public;
    input r1 as VotingSystemParams.public;
    set r1 into voting_system_params[r0];

function initiate_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as ProposalParams.public;
    input r3 as VotingSystemParams.public;
    cast r0 r1 into r4 as ProposalKey;
    hash.bhp256 r4 into r5 as field;
    hash.bhp256 r3 into r6 as field;
    async initiate_proposal r0 r5 r2 r6 self.caller into r7;
    output r7 as vs__2_candidates_005.aleo/initiate_proposal.future;

finalize initiate_proposal:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as ProposalParams.public;
    input r3 as field.public;
    input r4 as address.public;
    contains proposals[r1] into r5;
    not r5 into r6;
    assert.eq r6 true;
    get zvote_dao_registry.aleo/proposals[r1] into r7;
    get zvote_dao_registry.aleo/daos[r0] into r8;
    assert.eq r7.voting_system vs__2_candidates_005.aleo;
    assert.eq r7.vs_params_hash r3;
    assert.eq r8.dao_manager r4;
    set r2 into proposals[r1];

function cast_vote:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as token_registry.aleo/Token.record;
    cast r0 r2 into r5 as ProposalKey;
    hash.bhp256 r5 into r6 as field;
    cast r0 r2 r3 into r7 as ScoreKey;
    hash.bhp256 r7 into r8 as field;
    call token_registry.aleo/transfer_private_to_public vs__2_candidates_005.aleo r1 r4 into r9 r10;
    cast self.signer r1 r4.token_id r4.external_authorization_required r0 r2 r3 into r11 as CustodyReceipt.record;
    async cast_vote r0 r4.token_id r1 r6 r8 r3 r10 into r12;
    output r9 as token_registry.aleo/Token.record;
    output r11 as CustodyReceipt.record;
    output r12 as vs__2_candidates_005.aleo/cast_vote.future;

finalize cast_vote:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    input r6 as token_registry.aleo/transfer_private_to_public.future;
    await r6;
    get zvote_dao_registry.aleo/daos[r0] into r7;
    assert.eq r7.token_id r1;
    get proposals[r3] into r8;
    is.eq r5 r8.candidates[0u32] into r9;
    is.eq r5 r8.candidates[1u32] into r10;
    or r9 r10 into r11;
    assert.eq r11 true;
    get.or_use scores[r4] 0u128 into r12;
    add r12 r2 into r13;
    set r13 into scores[r4];

function withdraw_receipt:
    input r0 as u128.public;
    input r1 as CustodyReceipt.record;
    cast r1.dao_id r1.proposal_id into r2 as ProposalKey;
    hash.bhp256 r2 into r3 as field;
    cast r1.dao_id r1.proposal_id r1.candidate into r4 as ScoreKey;
    hash.bhp256 r4 into r5 as field;
    call token_registry.aleo/transfer_public_to_private r1.token_id r1.owner r0 r1.external_authorization_required into r6 r7;
    sub r1.amount r0 into r8;
    cast self.signer r8 r1.token_id r1.external_authorization_required r1.dao_id r1.proposal_id r1.candidate into r9 as CustodyReceipt.record;
    async withdraw_receipt r0 r5 r1.candidate r7 into r10;
    output r9 as CustodyReceipt.record;
    output r6 as token_registry.aleo/Token.record;
    output r10 as vs__2_candidates_005.aleo/withdraw_receipt.future;

finalize withdraw_receipt:
    input r0 as u128.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    await r3;
    get scores[r1] into r4;
    sub r4 r0 into r5;
    set r5 into scores[r1];
