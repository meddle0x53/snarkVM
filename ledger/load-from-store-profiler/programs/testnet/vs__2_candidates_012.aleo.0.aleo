import credits.aleo;
import token_registry.aleo;
import zvote_dao_registry_011.aleo;

program vs__2_candidates_012.aleo;

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
    call zvote_dao_registry_011.aleo/set_result r0 r1 r2 into r5;
    async set_result r0 r1 r4 r2 r5 into r6;
    output r6 as vs__2_candidates_012.aleo/set_result.future;

finalize set_result:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as zvote_dao_registry_011.aleo/set_result.future;
    await r4;
    get zvote_dao_registry_011.aleo/proposals[r2] into r5;
    assert.eq r5.voting_system vs__2_candidates_012.aleo;
    get voting_system_params[r5.vs_params_hash] into r6;
    cast r0 r1 0field into r7 as ScoreKey;
    hash.bhp256 r7 into r8 as field;
    get scores[r8] into r9;
    cast r0 r1 1field into r10 as ScoreKey;
    hash.bhp256 r10 into r11 as field;
    get scores[r11] into r12;
    gt r9 r12 into r13;
    ternary r13 r9 r12 into r14;
    gte r14 r6.quorum into r15;
    is.neq r9 r12 into r16;
    and r15 r16 into r17;
    assert.eq r17 true;
    gt r9 r12 into r18;
    ternary r18 0field 1field into r19;
    assert.eq r3 r19;

function reference_voting_system_params:
    input r0 as VotingSystemParams.public;
    hash.bhp256 r0 into r1 as field;
    async reference_voting_system_params r1 r0 into r2;
    output r2 as vs__2_candidates_012.aleo/reference_voting_system_params.future;

finalize reference_voting_system_params:
    input r0 as field.public;
    input r1 as VotingSystemParams.public;
    set r1 into voting_system_params[r0];

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
    call token_registry.aleo/transfer_private_to_public vs__2_candidates_012.aleo r1 r4 into r9 r10;
    cast self.signer r1 r4.token_id r4.external_authorization_required r0 r2 r3 into r11 as CustodyReceipt.record;
    async cast_vote r0 r4.token_id r1 r6 r8 r3 r10 into r12;
    output r9 as token_registry.aleo/Token.record;
    output r11 as CustodyReceipt.record;
    output r12 as vs__2_candidates_012.aleo/cast_vote.future;

finalize cast_vote:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    input r6 as token_registry.aleo/transfer_private_to_public.future;
    await r6;
    get zvote_dao_registry_011.aleo/daos[r0] into r7;
    assert.eq r7.token_id r1;
    get.or_use scores[r4] 0u128 into r8;
    add r8 r2 into r9;
    set r9 into scores[r4];

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
    output r10 as vs__2_candidates_012.aleo/withdraw_receipt.future;

finalize withdraw_receipt:
    input r0 as u128.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    await r3;
    get scores[r1] into r4;
    sub r4 r0 into r5;
    set r5 into scores[r1];
