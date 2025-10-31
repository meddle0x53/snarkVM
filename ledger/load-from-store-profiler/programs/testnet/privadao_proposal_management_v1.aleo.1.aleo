program privadao_proposal_management_v1.aleo;

record GovernanceToken:
    owner as address.private;
    amount as u64.private;
    locked_until as u64.private;

struct Vote:
    proposal_id as field;
    voter as address;
    vote as u64;
    weight as u64;

struct VoteAggregate:
    proposal_id as field;
    vote_count as u64;
    vote_tally as [u64; 10u32];
    vote_merkle_root as field;

struct VoteVerification:
    proposal_id as field;
    voter as address;
    vote_hash as field;
    timestamp as u32;

struct VoterHistory:
    minority_votes as u32;
    total_votes as u32;

struct GovernanceTier:
    proposal_types as [u8; 10u32];

struct VoteType:
    single_choice as boolean;
    multiple_choice as boolean;
    ranked_choice as boolean;
    conviction as boolean;
    quadratic as boolean;
    options_count as u8;

struct TreasuryAction:
    action_type as u8;
    asset as field;
    amount as u64;
    recipient as address;

struct Proposal:
    id as field;
    creator as address;
    description as field;
    proposal_type as u8;
    vote_type as VoteType;
    options_count as u8;
    treasury_action as TreasuryAction;
    status as u8;
    discussion_end_time as u32;
    voting_end_time as u32;
    grace_period_end_time as u32;
    required_sponsorship as u64;
    total_sponsorship as u64;
    veto_count as u64;
    veto_threshold as u64;
    amendment_count as u32;
    parent_proposal as field;
    tags as [field; 5u32];
    category as field;
    min_participation as u64;
    security_level as u8;

struct ProposalStatus:
    draft as boolean;
    discussion_end as u32;
    voting_start as u32;
    voting_end as u32;
    executed as boolean;

struct Comment:
    author as address;
    content as field;
    timestamp as u32;

struct Delegation:
    delegator as address;
    delegatee as address;
    category as field;
    amount as u64;
    reputation as u64;

struct DelegationKey:
    delegator as address;
    category as field;

struct VetoKey:
    proposal_id as field;
    token_owner as address;

struct Stake:
    token_owner as address;
    amount as u64;
    start_time as u32;
    duration as u32;

struct DelegationInfo:
    delegatee as address;
    percentage as u8;

struct SlashingRule:
    condition as u8;
    threshold as u32;
    slash_amount as i64;

struct SlashingProposal:
    target as address;
    category as field;
    amount as i64;
    reason as field;

struct DelegateeReputation:
    delegatee_address as address;
    category as field;
    reputation_score as u64;
    proposals_supported as u32;
    proposals_succeeded as u32;
    last_update_time as u32;

struct Reputation:
    score as i64;
    proposal_count as u32;
    vote_count as u32;
    successful_proposals as u32;

struct Sponsorship:
    sponsor as address;
    amount as u64;

struct ConvictionVote:
    voter as address;
    proposal_id as field;
    amount as u64;
    start_time as u32;

struct TreasuryBalance:
    asset as field;
    amount as u64;

struct DAO_Parameters:
    quorum_threshold as u64;
    voting_period as u32;
    grace_period as u32;

struct MultiSigProposal:
    proposal_id as field;
    approvals as u8;
    required_approvals as u8;

struct EncryptionParams:
    public_key as group;
    random as scalar;

struct HomomorphicCiphertext:
    c1 as group;
    c2 as group;

mapping governance_tiers:
    key as u8.public;
    value as GovernanceTier.public;

mapping proposals:
    key as field.public;
    value as Proposal.public;

mapping proposal_status:
    key as field.public;
    value as ProposalStatus.public;

mapping user_vetos:
    key as field.public;
    value as boolean.public;

mapping conviction_votes:
    key as field.public;
    value as ConvictionVote.public;

mapping category_delegations:
    key as field.public;
    value as Delegation.public;

mapping proposal_sponsorships:
    key as field.public;
    value as Sponsorship.public;

mapping delegations:
    key as address.public;
    value as DelegationInfo.public;

mapping comment_content:
    key as field.public;
    value as Comment.public;

mapping proposal_comments:
    key as field.public;
    value as Comment.public;

mapping slashing_proposals:
    key as field.public;
    value as SlashingProposal.public;

mapping user_reputation:
    key as address.public;
    value as Reputation.public;

mapping vote_counts:
    key as field.public;
    value as u64.public;

mapping vote_aggregates:
    key as field.public;
    value as VoteAggregate.public;

mapping delegatee_reputations:
    key as address.public;
    value as DelegateeReputation.public;

mapping contract_upgrade:
    key as field.public;
    value as field.public;

mapping contract_upgrades:
    key as field.public;
    value as field.public;

mapping slashing_rules:
    key as u8.public;
    value as SlashingRule.public;

mapping vote_types:
    key as field.public;
    value as VoteType.public;

mapping vote_receipts:
    key as field.public;
    value as field.public;

mapping votes:
    key as field.public;
    value as Vote.public;

mapping vote_results:
    key as field.public;
    value as [u64; 10u32].public;

mapping vote_merkle_proofs:
    key as field.public;
    value as field.public;

mapping vote_verifications:
    key as field.public;
    value as VoteVerification.public;

mapping voter_histories:
    key as address.public;
    value as VoterHistory.public;

mapping stakes:
    key as address.public;
    value as Stake.public;

mapping treasury:
    key as field.public;
    value as TreasuryBalance.public;

mapping dao_parameters:
    key as field.public;
    value as DAO_Parameters.public;

mapping multisig_proposals:
    key as field.public;
    value as MultiSigProposal.public;

mapping token_locks:
    key as address.public;
    value as u32.public;

function create_proposal:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as VoteType.private;
    input r3 as u8.private;
    input r4 as TreasuryAction.private;
    input r5 as u32.private;
    input r6 as u32.private;
    input r7 as u32.private;
    input r8 as u64.private;
    input r9 as u64.private;
    input r10 as [field; 5u32].private;
    input r11 as field.private;
    input r12 as u8.private;
    add r5 r6 into r13;
    add r13 r7 into r14;
    gte r14 604800u32 into r15;
    assert.eq r15 true;
    add r5 r6 into r16;
    add r16 r7 into r17;
    lte r17 2592000u32 into r18;
    assert.eq r18 true;
    lte r12 2u8 into r19;
    assert.eq r19 true;
    hash.bhp256 r0 into r20 as field;
    is.eq r12 0u8 into r21;
    is.eq r12 1u8 into r22;
    mul 100000000000u64 2u64 into r23;
    is.eq r12 2u8 into r24;
    mul 100000000000u64 3u64 into r25;
    ternary r24 r25 100000000000u64 into r26;
    ternary r22 r23 r26 into r27;
    ternary r21 100000000000u64 r27 into r28;
    async create_proposal self.caller r20 r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r28 into r29;
    output r29 as privadao_proposal_management_v1.aleo/create_proposal.future;

finalize create_proposal:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u8.public;
    input r4 as VoteType.public;
    input r5 as u8.public;
    input r6 as TreasuryAction.public;
    input r7 as u32.public;
    input r8 as u32.public;
    input r9 as u32.public;
    input r10 as u64.public;
    input r11 as u64.public;
    input r12 as [field; 5u32].public;
    input r13 as field.public;
    input r14 as u8.public;
    input r15 as u64.public;
    cast r0 r13 0u64 0u32 0u32 block.height into r16 as DelegateeReputation;
    get.or_use delegatee_reputations[r0] r16 into r17;
    lt r17.reputation_score 100u64 into r18;
    lt r17.reputation_score 1000u64 into r19;
    not r18 into r20;
    and r20 r19 into r21;
    ternary r21 1u8 2u8 into r22;
    ternary r18 0u8 r22 into r23;
    get governance_tiers[r23] into r24;
    add block.height r7 into r25;
    add block.height r7 into r26;
    add r26 r8 into r27;
    add block.height r7 into r28;
    add r28 r8 into r29;
    add r29 r9 into r30;
    cast r1 r0 r2 r3 r4 r5 r6 0u8 r25 r27 r30 r10 0u64 0u64 r11 0u32 0field r12 r13 r15 r14 into r31 as Proposal;
    set r31 into proposals[r1];
    set 0u64 into vote_counts[r1];
    cast 0i64 0u32 0u32 0u32 into r32 as Reputation;
    get.or_use user_reputation[r0] r32 into r33;
    add r33.proposal_count 1u32 into r34;
    cast r33.score r34 r33.vote_count r33.successful_proposals into r35 as Reputation;
    set r35 into user_reputation[r0];

function amend_proposal:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as TreasuryAction.private;
    async amend_proposal self.caller r0 r1 r2 into r3;
    output r3 as privadao_proposal_management_v1.aleo/amend_proposal.future;

finalize amend_proposal:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as TreasuryAction.public;
    get proposals[r1] into r4;
    is.eq r4.status 0u8 into r5;
    assert.eq r5 true;
    is.eq r4.creator r0 into r6;
    assert.eq r6 true;
    hash.bhp256 r2 into r7 as field;
    add r4.amendment_count 1u32 into r8;
    cast r7 r0 r2 r4.proposal_type r4.vote_type r4.options_count r3 0u8 r4.discussion_end_time r4.voting_end_time r4.grace_period_end_time r4.required_sponsorship r4.total_sponsorship 0u64 r4.veto_threshold r8 r1 r4.tags r4.category r4.min_participation r4.security_level into r9 as Proposal;
    set r9 into proposals[r7];
    add r4.amendment_count 1u32 into r10;
    cast r4.id r4.creator r4.description r4.proposal_type r4.vote_type r4.options_count r4.treasury_action r4.status r4.discussion_end_time r4.voting_end_time r4.grace_period_end_time r4.required_sponsorship r4.total_sponsorship r4.veto_count r4.veto_threshold r10 r4.parent_proposal r4.tags r4.category r4.min_participation r4.security_level into r11 as Proposal;
    set r11 into proposals[r1];

function sponsor_proposal:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as GovernanceToken.record;
    async sponsor_proposal self.caller r0 r1 r2.owner into r3;
    output r3 as privadao_proposal_management_v1.aleo/sponsor_proposal.future;

finalize sponsor_proposal:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as address.public;
    get proposals[r1] into r4;
    is.eq r4.status 0u8 into r5;
    assert.eq r5 true;
    cast r3 r2 into r6 as Sponsorship;
    set r6 into proposal_sponsorships[r1];
    add r4.total_sponsorship r2 into r7;
    cast r4.id r4.creator r4.description r4.proposal_type r4.vote_type r4.options_count r4.treasury_action r4.status r4.discussion_end_time r4.voting_end_time r4.grace_period_end_time r4.required_sponsorship r7 r4.veto_count r4.veto_threshold r4.amendment_count r4.parent_proposal r4.tags r4.category r4.min_participation r4.security_level into r8 as Proposal;
    set r8 into proposals[r1];
    cast 0i64 0u32 0u32 0u32 into r9 as Reputation;
    get.or_use user_reputation[r0] r9 into r10;
    div r2 100u64 into r11;
    cast r11 into r12 as i64;
    add r10.score r12 into r13;
    cast r13 r10.proposal_count r10.vote_count r10.successful_proposals into r14 as Reputation;
    set r14 into user_reputation[r0];

function veto_proposal:
    input r0 as field.private;
    input r1 as GovernanceToken.record;
    async veto_proposal self.caller r0 r1.owner r1.amount r1.locked_until into r2;
    output r2 as privadao_proposal_management_v1.aleo/veto_proposal.future;

finalize veto_proposal:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as u64.public;
    input r4 as u64.public;
    get proposals[r1] into r5;
    lt r5.status 3u8 into r6;
    assert.eq r6 true;
    cast r1 r2 into r7 as VetoKey;
    hash.bhp256 r7 into r8 as field;
    get.or_use user_vetos[r8] false into r9;
    not r9 into r10;
    assert.eq r10 true;
    cast r1 r2 into r11 as VetoKey;
    hash.bhp256 r11 into r12 as field;
    set true into user_vetos[r12];
    div r4 2592000u64 into r13;
    add 100u64 r13 into r14;
    mul r3 r14 into r15;
    div r15 100u64 into r16;
    add r5.veto_count r16 into r17;
    cast r5.id r5.creator r5.description r5.proposal_type r5.vote_type r5.options_count r5.treasury_action r5.status r5.discussion_end_time r5.voting_end_time r5.grace_period_end_time r5.required_sponsorship r5.total_sponsorship r17 r5.veto_threshold r5.amendment_count r5.parent_proposal r5.tags r5.category r5.min_participation r5.security_level into r18 as Proposal;
    set r18 into proposals[r1];
    gte r5.veto_count r5.veto_threshold into r19;
    branch.eq r19 false to end_then_0_0;
    div r4 2592000u64 into r20;
    add 100u64 r20 into r21;
    mul r3 r21 into r22;
    div r22 100u64 into r23;
    add r5.veto_count r23 into r24;
    cast r5.id r5.creator r5.description r5.proposal_type r5.vote_type r5.options_count r5.treasury_action 4u8 r5.discussion_end_time r5.voting_end_time r5.grace_period_end_time r5.required_sponsorship r5.total_sponsorship r24 r5.veto_threshold r5.amendment_count r5.parent_proposal r5.tags r5.category r5.min_participation r5.security_level into r25 as Proposal;
    set r25 into proposals[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function execute_proposal:
    input r0 as field.private;
    async execute_proposal r0 into r1;
    output r1 as privadao_proposal_management_v1.aleo/execute_proposal.future;

finalize execute_proposal:
    input r0 as field.public;
    get proposals[r0] into r1;
    is.eq r1.status 2u8 into r2;
    gte block.height r1.grace_period_end_time into r3;
    and r2 r3 into r4;
    assert.eq r4 true;
    lt r1.veto_count r1.veto_threshold into r5;
    assert.eq r5 true;
    get vote_aggregates[r0] into r6;
    add r6.vote_tally[0u32] r6.vote_tally[1u32] into r7;
    gte r7 r1.min_participation into r8;
    assert.eq r8 true;
    div r7 2u64 into r9;
    gt r6.vote_tally[0u32] r9 into r10;
    branch.eq r10 false to end_then_0_2;
    is.eq r1.security_level 2u8 into r11;
    branch.eq r11 false to end_then_1_4;
    cast r0 0u8 3u8 into r12 as MultiSigProposal;
    set r12 into multisig_proposals[r0];
    branch.eq true true to end_otherwise_1_5;
    position end_then_1_4;
    is.eq r1.proposal_type 0u8 into r13;
    branch.eq r13 false to end_then_2_6;
    cast r1.treasury_action.asset 0u64 into r14 as TreasuryBalance;
    get.or_use treasury[r1.treasury_action.asset] r14 into r15;
    is.eq r1.treasury_action.action_type 0u8 into r16;
    branch.eq r16 false to end_then_3_8;
    gte r15.amount r1.treasury_action.amount into r17;
    assert.eq r17 true;
    sub r15.amount r1.treasury_action.amount into r18;
    cast r1.treasury_action.asset r18 into r19 as TreasuryBalance;
    set r19 into treasury[r1.treasury_action.asset];
    branch.eq true true to end_otherwise_3_9;
    position end_then_3_8;
    is.eq r1.treasury_action.action_type 1u8 into r20;
    branch.eq r20 false to end_then_4_10;
    add r15.amount r1.treasury_action.amount into r21;
    cast r1.treasury_action.asset r21 into r22 as TreasuryBalance;
    set r22 into treasury[r1.treasury_action.asset];
    branch.eq true true to end_otherwise_4_11;
    position end_then_4_10;
    is.eq r1.treasury_action.action_type 2u8 into r23;
    branch.eq r23 false to end_then_5_12;
    gte r15.amount r1.treasury_action.amount into r24;
    assert.eq r24 true;
    sub r15.amount r1.treasury_action.amount into r25;
    cast r1.treasury_action.asset r25 into r26 as TreasuryBalance;
    set r26 into treasury[r1.treasury_action.asset];
    branch.eq true true to end_otherwise_5_13;
    position end_then_5_12;
    position end_otherwise_5_13;
    position end_otherwise_4_11;
    position end_otherwise_3_9;
    branch.eq true true to end_otherwise_2_7;
    position end_then_2_6;
    is.eq r1.proposal_type 1u8 into r27;
    branch.eq r27 false to end_then_3_14;
    cast 100000000000u64 604800u32 172800u32 into r28 as DAO_Parameters;
    get.or_use dao_parameters[0field] r28 into r29;
    sub r1.voting_end_time r1.discussion_end_time into r30;
    sub r1.grace_period_end_time r1.voting_end_time into r31;
    cast r1.treasury_action.amount r30 r31 into r32 as DAO_Parameters;
    set r32 into dao_parameters[0field];
    branch.eq true true to end_otherwise_3_15;
    position end_then_3_14;
    is.eq r1.proposal_type 2u8 into r33;
    branch.eq r33 false to end_then_4_16;
    set r1.description into contract_upgrades[0field];
    branch.eq true true to end_otherwise_4_17;
    position end_then_4_16;
    is.eq r1.proposal_type 3u8 into r34;
    branch.eq r34 false to end_then_5_18;
    get slashing_proposals[r0] into r35;
    get delegatee_reputations[r35.target] into r36;
    sub block.height r36.last_update_time into r37;
    cast r37 into r38 as u64;
    mul r38 1u64 into r39;
    sub r36.reputation_score r39 into r40;
    cast r35.amount into r41 as u64;
    sub r40 r41 into r42;
    cast r36.delegatee_address r36.category r42 r36.proposals_supported r36.proposals_succeeded block.height into r43 as DelegateeReputation;
    set r43 into delegatee_reputations[r35.target];
    remove slashing_proposals[r0];
    branch.eq true true to end_otherwise_5_19;
    position end_then_5_18;
    position end_otherwise_5_19;
    position end_otherwise_4_17;
    position end_otherwise_3_15;
    position end_otherwise_2_7;
    cast r1.id r1.creator r1.description r1.proposal_type r1.vote_type r1.options_count r1.treasury_action 3u8 r1.discussion_end_time r1.voting_end_time r1.grace_period_end_time r1.required_sponsorship r1.total_sponsorship r1.veto_count r1.veto_threshold r1.amendment_count r1.parent_proposal r1.tags r1.category r1.min_participation r1.security_level into r44 as Proposal;
    set r44 into proposals[r0];
    get user_reputation[r1.creator] into r45;
    add r45.score 100i64 into r46;
    add r45.successful_proposals 1u32 into r47;
    cast r46 r45.proposal_count r45.vote_count r47 into r48 as Reputation;
    set r45 into user_reputation[r1.creator];
    position end_otherwise_1_5;
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
    cast r1.id r1.creator r1.description r1.proposal_type r1.vote_type r1.options_count r1.treasury_action 4u8 r1.discussion_end_time r1.voting_end_time r1.grace_period_end_time r1.required_sponsorship r1.total_sponsorship r1.veto_count r1.veto_threshold r1.amendment_count r1.parent_proposal r1.tags r1.category r1.min_participation r1.security_level into r49 as Proposal;
    set r49 into proposals[r0];
    get user_reputation[r1.creator] into r50;
    sub r50.score 50i64 into r51;
    cast r51 r50.proposal_count r50.vote_count r50.successful_proposals into r52 as Reputation;
    set r50 into user_reputation[r1.creator];

function add_comment:
    input r0 as field.private;
    input r1 as field.private;
    async add_comment self.caller r0 r1 into r2;
    output r2 as privadao_proposal_management_v1.aleo/add_comment.future;

finalize add_comment:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get proposals[r1] into r3;
    cast r0 r2 block.height into r4 as Comment;
    set r4 into proposal_comments[r1];

function delegate_votes:
    input r0 as address.private;
    input r1 as u8.private;
    lte r1 100u8 into r2;
    assert.eq r2 true;
    cast r0 r1 into r3 as DelegationInfo;
    async delegate_votes self.caller r3 into r4;
    output r4 as privadao_proposal_management_v1.aleo/delegate_votes.future;

finalize delegate_votes:
    input r0 as address.public;
    input r1 as DelegationInfo.public;
    set r1 into delegations[r0];

function delegate_category:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u64.private;
    input r3 as GovernanceToken.record;
    gte r3.amount r2 into r4;
    assert.eq r4 true;
    async delegate_category self.caller r0 r1 r2 r3.owner into r5;
    output r5 as privadao_proposal_management_v1.aleo/delegate_category.future;

finalize delegate_category:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as u64.public;
    input r4 as address.public;
    cast r1 r2 0u64 0u32 0u32 block.height into r5 as DelegateeReputation;
    get.or_use delegatee_reputations[r1] r5 into r6;
    cast r4 r1 r2 r3 r6.reputation_score into r7 as Delegation;
    cast r0 r2 into r8 as DelegationKey;
    hash.bhp256 r8 into r9 as field;
    set r7 into category_delegations[r9];

function propose_slashing:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as i64.private;
    input r3 as field.private;
    async propose_slashing r0 r1 r2 r3 into r4;
    output r4 as privadao_proposal_management_v1.aleo/propose_slashing.future;

finalize propose_slashing:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as i64.public;
    input r3 as field.public;
    hash.bhp256 r0 into r4 as field;
    cast r0 r1 r2 r3 into r5 as SlashingProposal;
    set r5 into slashing_proposals[r4];

function advance_proposal_phase:
    input r0 as field.private;
    async advance_proposal_phase r0 into r1;
    output r1 as privadao_proposal_management_v1.aleo/advance_proposal_phase.future;

finalize advance_proposal_phase:
    input r0 as field.public;
    get proposals[r0] into r1;
    is.eq r1.status 0u8 into r2;
    gte block.height r1.discussion_end_time into r3;
    and r2 r3 into r4;
    branch.eq r4 false to end_then_0_20;
    cast r1.id r1.creator r1.description r1.proposal_type r1.vote_type r1.options_count r1.treasury_action 1u8 r1.discussion_end_time r1.voting_end_time r1.grace_period_end_time r1.required_sponsorship r1.total_sponsorship r1.veto_count r1.veto_threshold r1.amendment_count r1.parent_proposal r1.tags r1.category r1.min_participation r1.security_level into r5 as Proposal;
    branch.eq true true to end_otherwise_0_21;
    position end_then_0_20;
    is.eq r1.status 1u8 into r6;
    gte block.height r1.voting_end_time into r7;
    and r6 r7 into r8;
    branch.eq r8 false to end_then_1_22;
    cast r1.id r1.creator r1.description r1.proposal_type r1.vote_type r1.options_count r1.treasury_action 2u8 r1.discussion_end_time r1.voting_end_time r1.grace_period_end_time r1.required_sponsorship r1.total_sponsorship r1.veto_count r1.veto_threshold r1.amendment_count r1.parent_proposal r1.tags r1.category r1.min_participation r1.security_level into r9 as Proposal;
    branch.eq true true to end_otherwise_1_23;
    position end_then_1_22;
    is.eq r1.status 2u8 into r10;
    gte block.height r1.grace_period_end_time into r11;
    and r10 r11 into r12;
    branch.eq r12 false to end_then_2_24;
    cast r1.id r1.creator r1.description r1.proposal_type r1.vote_type r1.options_count r1.treasury_action 3u8 r1.discussion_end_time r1.voting_end_time r1.grace_period_end_time r1.required_sponsorship r1.total_sponsorship r1.veto_count r1.veto_threshold r1.amendment_count r1.parent_proposal r1.tags r1.category r1.min_participation r1.security_level into r13 as Proposal;
    is.eq r1.status 2u8 into r14;
    gte block.height r1.grace_period_end_time into r15;
    and r14 r15 into r16;
    assert.eq r16 true;
    lt r1.veto_count r1.veto_threshold into r17;
    assert.eq r17 true;
    get vote_aggregates[r0] into r18;
    add r18.vote_tally[0u32] r18.vote_tally[1u32] into r19;
    gte r19 r1.min_participation into r20;
    assert.eq r20 true;
    div r19 2u64 into r21;
    gt r18.vote_tally[0u32] r21 into r22;
    branch.eq r22 false to end_then_3_26;
    is.eq r1.security_level 2u8 into r23;
    branch.eq r23 false to end_then_4_28;
    cast r0 0u8 3u8 into r24 as MultiSigProposal;
    set r24 into multisig_proposals[r0];
    branch.eq true true to end_otherwise_4_29;
    position end_then_4_28;
    is.eq r1.proposal_type 0u8 into r25;
    branch.eq r25 false to end_then_5_30;
    cast r1.treasury_action.asset 0u64 into r26 as TreasuryBalance;
    get.or_use treasury[r1.treasury_action.asset] r26 into r27;
    is.eq r1.treasury_action.action_type 0u8 into r28;
    branch.eq r28 false to end_then_6_32;
    gte r27.amount r1.treasury_action.amount into r29;
    assert.eq r29 true;
    sub r27.amount r1.treasury_action.amount into r30;
    cast r1.treasury_action.asset r30 into r31 as TreasuryBalance;
    set r31 into treasury[r1.treasury_action.asset];
    branch.eq true true to end_otherwise_6_33;
    position end_then_6_32;
    is.eq r1.treasury_action.action_type 1u8 into r32;
    branch.eq r32 false to end_then_7_34;
    add r27.amount r1.treasury_action.amount into r33;
    cast r1.treasury_action.asset r33 into r34 as TreasuryBalance;
    set r34 into treasury[r1.treasury_action.asset];
    branch.eq true true to end_otherwise_7_35;
    position end_then_7_34;
    is.eq r1.treasury_action.action_type 2u8 into r35;
    branch.eq r35 false to end_then_8_36;
    gte r27.amount r1.treasury_action.amount into r36;
    assert.eq r36 true;
    sub r27.amount r1.treasury_action.amount into r37;
    cast r1.treasury_action.asset r37 into r38 as TreasuryBalance;
    set r38 into treasury[r1.treasury_action.asset];
    branch.eq true true to end_otherwise_8_37;
    position end_then_8_36;
    position end_otherwise_8_37;
    position end_otherwise_7_35;
    position end_otherwise_6_33;
    branch.eq true true to end_otherwise_5_31;
    position end_then_5_30;
    is.eq r1.proposal_type 1u8 into r39;
    branch.eq r39 false to end_then_6_38;
    cast 100000000000u64 604800u32 172800u32 into r40 as DAO_Parameters;
    get.or_use dao_parameters[0field] r40 into r41;
    sub r1.voting_end_time r1.discussion_end_time into r42;
    sub r1.grace_period_end_time r1.voting_end_time into r43;
    cast r1.treasury_action.amount r42 r43 into r44 as DAO_Parameters;
    set r44 into dao_parameters[0field];
    branch.eq true true to end_otherwise_6_39;
    position end_then_6_38;
    is.eq r1.proposal_type 2u8 into r45;
    branch.eq r45 false to end_then_7_40;
    set r1.description into contract_upgrades[0field];
    branch.eq true true to end_otherwise_7_41;
    position end_then_7_40;
    is.eq r1.proposal_type 3u8 into r46;
    branch.eq r46 false to end_then_8_42;
    get slashing_proposals[r0] into r47;
    get delegatee_reputations[r47.target] into r48;
    sub block.height r48.last_update_time into r49;
    cast r49 into r50 as u64;
    mul r50 1u64 into r51;
    sub r48.reputation_score r51 into r52;
    cast r47.amount into r53 as u64;
    sub r52 r53 into r54;
    cast r48.delegatee_address r48.category r54 r48.proposals_supported r48.proposals_succeeded block.height into r55 as DelegateeReputation;
    set r55 into delegatee_reputations[r47.target];
    remove slashing_proposals[r0];
    branch.eq true true to end_otherwise_8_43;
    position end_then_8_42;
    position end_otherwise_8_43;
    position end_otherwise_7_41;
    position end_otherwise_6_39;
    position end_otherwise_5_31;
    cast r1.id r1.creator r1.description r1.proposal_type r1.vote_type r1.options_count r1.treasury_action 3u8 r1.discussion_end_time r1.voting_end_time r1.grace_period_end_time r1.required_sponsorship r1.total_sponsorship r1.veto_count r1.veto_threshold r1.amendment_count r1.parent_proposal r1.tags r1.category r1.min_participation r1.security_level into r56 as Proposal;
    set r56 into proposals[r0];
    get user_reputation[r1.creator] into r57;
    add r57.score 100i64 into r58;
    add r57.successful_proposals 1u32 into r59;
    cast r58 r57.proposal_count r57.vote_count r59 into r60 as Reputation;
    set r60 into user_reputation[r1.creator];
    position end_otherwise_4_29;
    branch.eq true true to end_otherwise_3_27;
    position end_then_3_26;
    position end_otherwise_3_27;
    cast r1.id r1.creator r1.description r1.proposal_type r1.vote_type r1.options_count r1.treasury_action 4u8 r1.discussion_end_time r1.voting_end_time r1.grace_period_end_time r1.required_sponsorship r1.total_sponsorship r1.veto_count r1.veto_threshold r1.amendment_count r1.parent_proposal r1.tags r1.category r1.min_participation r1.security_level into r61 as Proposal;
    set r61 into proposals[r0];
    get user_reputation[r61.creator] into r62;
    sub r62.score 50i64 into r63;
    cast r63 r62.proposal_count r62.vote_count r62.successful_proposals into r64 as Reputation;
    set r64 into user_reputation[r61.creator];
    branch.eq true true to end_otherwise_2_25;
    position end_then_2_24;
    cast r1.id r1.creator r1.description r1.proposal_type r1.vote_type r1.options_count r1.treasury_action 1u8 r1.discussion_end_time r1.voting_end_time r1.grace_period_end_time r1.required_sponsorship r1.total_sponsorship r1.veto_count r1.veto_threshold r1.amendment_count r1.parent_proposal r1.tags r1.category r1.min_participation r1.security_level into r65 as Proposal;
    position end_otherwise_2_25;
    position end_otherwise_1_23;
    position end_otherwise_0_21;
    set r1 into proposals[r0];

function cast_vote:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as GovernanceToken.record;
    async cast_vote self.caller r0 r1 r2.amount r2.locked_until into r3;
    output r3 as privadao_proposal_management_v1.aleo/cast_vote.future;

finalize cast_vote:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    get proposals[r1] into r5;
    is.eq r5.status 1u8 into r6;
    assert.eq r6 true;
    lt r5.veto_count r5.veto_threshold into r7;
    assert.eq r7 true;
    gte block.height r5.discussion_end_time into r8;
    lt block.height r5.voting_end_time into r9;
    and r8 r9 into r10;
    assert.eq r10 true;
    cast 0field aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0field 0u32 into r11 as VoteVerification;
    get.or_use vote_verifications[r1] r11 into r12;
    is.neq r12.timestamp 0u32 into r13;
    branch.eq r13 false to end_then_0_44;
    get vote_results[r1] into r14;
    hash.bhp256 r12.vote_hash into r15 as field;
    cast r15 into r16 as u8;
    set r14 into vote_results[r1];
    branch.eq true true to end_otherwise_0_45;
    position end_then_0_44;
    position end_otherwise_0_45;
    div r4 2592000u64 into r17;
    add 100u64 r17 into r18;
    mul r3 r18 into r19;
    div r19 100u64 into r20;
    cast r0 0u64 0u32 0u32 into r21 as Stake;
    get.or_use stakes[r0] r21 into r22;
    is.eq r22.amount 0u64 into r23;
    sub block.height r22.start_time into r24;
    cast r24 into r25 as u64;
    mul r22.amount r25 into r26;
    div r26 10000u64 into r27;
    ternary r23 0u64 r27 into r28;
    add r20 r28 into r29;
    hash.bhp256 r0 into r30 as field;
    cast r0 r0 r5.category 0u64 0u64 into r31 as Delegation;
    get.or_use category_delegations[r30] r31 into r32;
    is.neq r32.delegatee r0 into r33;
    branch.eq r33 false to end_then_0_46;
    branch.eq true true to end_otherwise_0_47;
    position end_then_0_46;
    position end_otherwise_0_47;
    get vote_types[r1] into r34;
    branch.eq r34.conviction false to end_then_0_48;
    cast r0 r1 r29 block.height into r35 as ConvictionVote;
    set r35 into conviction_votes[r1];
    branch.eq true true to end_otherwise_0_49;
    position end_then_0_48;
    branch.eq r34.quadratic false to end_then_1_50;
    branch.eq true true to end_otherwise_1_51;
    position end_then_1_50;
    position end_otherwise_1_51;
    position end_otherwise_0_49;
    cast 0u64 0u64 0u64 0u64 0u64 0u64 0u64 0u64 0u64 0u64 into r36 as [u64; 10u32];
    get.or_use vote_results[r1] r36 into r37;
    set r37 into vote_results[r1];
    cast r0 into r38 as field;
    add r38 r1 into r39;
    cast r2 into r40 as field;
    add r39 r40 into r41;
    hash.bhp256 r41 into r42 as field;
    cast r1 r0 r42 block.height into r43 as VoteVerification;
    set r43 into vote_verifications[r1];
    is.neq r32.delegatee r0 into r44;
    branch.eq r44 false to end_then_0_52;
    get delegatee_reputations[r32.delegatee] into r45;
    add r45.proposals_supported 1u32 into r46;
    cast r45.delegatee_address r45.category r45.reputation_score r46 r45.proposals_succeeded r45.last_update_time into r47 as DelegateeReputation;
    set r47 into delegatee_reputations[r32.delegatee];
    branch.eq true true to end_otherwise_0_53;
    position end_then_0_52;
    position end_otherwise_0_53;
    get slashing_rules[0u8] into r48;
    cast 0u32 0u32 into r49 as VoterHistory;
    get.or_use voter_histories[r0] r49 into r50;
    add r50.total_votes 1u32 into r51;
    cast r50.minority_votes r51 into r52 as VoterHistory;
    set r50 into voter_histories[r0];

function submit_vote_aggregate:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as [u64; 10u32].private;
    input r3 as field.private;
    async submit_vote_aggregate r0 r1 r2 r3 into r4;
    output r4 as privadao_proposal_management_v1.aleo/submit_vote_aggregate.future;

finalize submit_vote_aggregate:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as [u64; 10u32].public;
    input r3 as field.public;
    cast r0 r1 r2 r3 into r4 as VoteAggregate;
    set r4 into vote_aggregates[r0];

function verify_vote:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as u64.private;
    input r3 as field.private;
    async verify_vote r0 r1 r2 r3 into r4;
    output r4 as privadao_proposal_management_v1.aleo/verify_vote.future;

finalize verify_vote:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as field.public;
    get vote_aggregates[r0] into r4;
    get.or_use vote_merkle_proofs[r0] 0field into r5;
    is.eq r5 r3 into r6;
    assert.eq r6 true;

closure encrypt_vote:
    input r0 as u64;
    input r1 as EncryptionParams;
    mul 1540945439182663264862696551825005342995406165131907382295858612069623286213group r1.random into r2;
    cast r0 into r3 as scalar;
    mul 1540945439182663264862696551825005342995406165131907382295858612069623286213group r3 into r4;
    mul r1.public_key r1.random into r5;
    add r5 r4 into r6;
    cast r2 r6 into r7 as HomomorphicCiphertext;
    output r7 as HomomorphicCiphertext;
