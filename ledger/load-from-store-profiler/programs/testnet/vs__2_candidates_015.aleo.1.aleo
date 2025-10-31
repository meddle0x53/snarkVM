import credits.aleo;
import token_registry.aleo;
import zvote_dao_registry_015.aleo;

program vs__2_candidates_015.aleo;

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
    params_hash as field;
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

struct VotingSystemParams:
    quorum as u128;

struct ProposalParams:
    end_block as u32;

mapping scores:
    key as field.public;
    value as u128.public;

mapping custodies:
    key as field.public;
    value as u128.public;

mapping voting_system_params:
    key as field.public;
    value as VotingSystemParams.public;

mapping proposal_params:
    key as field.public;
    value as ProposalParams.public;

function set_result:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    cast r0 r1 into r3 as ProposalKey;
    hash.bhp256 r3 into r4 as field;
    call zvote_dao_registry_015.aleo/set_result r0 r1 r2 into r5;
    async set_result r0 r1 r4 r2 r5 into r6;
    output r6 as vs__2_candidates_015.aleo/set_result.future;

finalize set_result:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as zvote_dao_registry_015.aleo/set_result.future;
    await r4;
    get zvote_dao_registry_015.aleo/proposals[r2] into r5;
    assert.eq r5.voting_system vs__2_candidates_015.aleo;
    get proposal_params[r5.params_hash] into r6;
    gte block.height r6.end_block into r7;
    assert.eq r7 true;
    get voting_system_params[r5.vs_params_hash] into r8;
    cast r0 r1 0field into r9 as ScoreKey;
    hash.bhp256 r9 into r10 as field;
    get.or_use scores[r10] 0u128 into r11;
    cast r0 r1 1field into r12 as ScoreKey;
    hash.bhp256 r12 into r13 as field;
    get.or_use scores[r13] 0u128 into r14;
    gt r11 r14 into r15;
    ternary r15 r11 r14 into r16;
    add r11 r14 into r17;
    gte r17 r8.quorum into r18;
    assert.eq r18 true;
    is.neq r11 r14 into r19;
    assert.eq r19 true;
    gt r11 r14 into r20;
    ternary r20 0field 1field into r21;
    assert.eq r3 r21;

function reference_voting_system_params:
    input r0 as VotingSystemParams.public;
    hash.bhp256 r0 into r1 as field;
    async reference_voting_system_params r1 r0 into r2;
    output r2 as vs__2_candidates_015.aleo/reference_voting_system_params.future;

finalize reference_voting_system_params:
    input r0 as field.public;
    input r1 as VotingSystemParams.public;
    set r1 into voting_system_params[r0];

function reference_proposal_params:
    input r0 as ProposalParams.public;
    hash.bhp256 r0 into r1 as field;
    async reference_proposal_params r1 r0 into r2;
    output r2 as vs__2_candidates_015.aleo/reference_proposal_params.future;

finalize reference_proposal_params:
    input r0 as field.public;
    input r1 as ProposalParams.public;
    set r1 into proposal_params[r0];

function cast_vote:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as field.public;
    input r4 as token_registry.aleo/Token.record;
    cast r0 r1 into r5 as ProposalKey;
    hash.bhp256 r5 into r6 as field;
    cast r0 r1 r3 into r7 as ScoreKey;
    hash.bhp256 r7 into r8 as field;
    call token_registry.aleo/transfer_private_to_public vs__2_candidates_015.aleo r2 r4 into r9 r10;
    cast self.signer r2 r4.token_id r4.external_authorization_required r0 r1 r3 into r11 as CustodyReceipt.record;
    async cast_vote r0 r4.token_id r2 r6 r8 r3 r10 into r12;
    output r9 as token_registry.aleo/Token.record;
    output r11 as CustodyReceipt.record;
    output r12 as vs__2_candidates_015.aleo/cast_vote.future;

finalize cast_vote:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    input r6 as token_registry.aleo/transfer_private_to_public.future;
    await r6;
    get zvote_dao_registry_015.aleo/daos[r0] into r7;
    assert.eq r7.token_id r1;
    get zvote_dao_registry_015.aleo/proposals[r3] into r8;
    get proposal_params[r8.params_hash] into r9;
    lt block.height r9.end_block into r10;
    assert.eq r10 true;
    get.or_use scores[r4] 0u128 into r11;
    add r11 r2 into r12;
    set r12 into scores[r4];

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
    output r10 as vs__2_candidates_015.aleo/withdraw_receipt.future;

finalize withdraw_receipt:
    input r0 as u128.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    await r3;
    get scores[r1] into r4;
    sub r4 r0 into r5;
    set r5 into scores[r1];
