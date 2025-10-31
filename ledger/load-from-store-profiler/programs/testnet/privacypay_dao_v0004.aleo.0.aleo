import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;
import ans_coupon_card_v3.aleo;
import credits.aleo;
import multi_token_support_programv1.aleo;
import mtsp_creditsv1.aleo;
import pondo_oraclev1.aleo;
import pondo_staked_aleo_tokenv1.aleo;
import pondo_tokenv1.aleo;
import pondo_delegator1v1.aleo;
import pondo_delegator2v1.aleo;
import pondo_delegator3v1.aleo;
import pondo_delegator4v1.aleo;
import pondo_delegator5v1.aleo;
import pondo_core_protocolv1.aleo;
import ans_registrar_usd2.aleo;
import token_registry.aleo;
import privapay_v0003.aleo;

program privacypay_dao_v0004.aleo;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as field;

struct data:
    metadata as [field; 4u32];

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

struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;

struct validator_state:
    validator as address;
    commission as u8;

struct UnitPriceData:
    price as u64;
    timestamp as u64;

struct CompanyMetadata:
    company_id as field;
    company_name as u128;
    admin as address;

struct VoteAcceptance:
    id as u32;
    acceptance as boolean;

struct Proposal:
    id as u32;
    company_id as field;
    time_limit as u32;
    detail_hash as [field; 2u32];
    proposer as address;

struct ProposalVote:
    proposal_id as u32;
    voter as address;

mapping initial_fee:
    key as boolean.public;
    value as u64.public;

mapping proposals:
    key as u32.public;
    value as Proposal.public;

mapping votes:
    key as field.public;
    value as u128.public;

mapping voters:
    key as u32.public;
    value as u32.public;

mapping is_voted:
    key as field.public;
    value as boolean.public;

mapping dao_token:
    key as field.public;
    value as field.public;

mapping gov_token:
    key as u32.public;
    value as field.public;

mapping proposal_status:
    key as u32.public;
    value as u8.public;

mapping latest_proposal_id:
    key as boolean.public;
    value as u32.public;

mapping admin:
    key as address.public;
    value as boolean.public;

function register:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u128.public;
    input r3 as u128.private;
    input r4 as u8.private;
    input r5 as u128.private;
    input r6 as boolean.private;
    input r7 as address.private;
    call token_registry.aleo/register_token r1 r2 r3 r4 r5 r6 r7 into r8;
    async register r0 r1 self.caller r8 into r9;
    output r9 as privacypay_dao_v0004.aleo/register.future;

finalize register:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as token_registry.aleo/register_token.future;
    await r3;
    get privapay_v0003.aleo/registered_company[r0] into r4;
    assert.eq r4.admin r2;
    set r1 into dao_token[r0];

function initialize:
    input r0 as u64.private;
    async initialize r0 self.caller into r1;
    output r1 as privacypay_dao_v0004.aleo/initialize.future;

finalize initialize:
    input r0 as u64.public;
    input r1 as address.public;
    set true into admin[r1];
    set r0 into initial_fee[true];

function propose:
    input r0 as u32.public;
    input r1 as field.private;
    input r2 as u32.private;
    input r3 as [field; 2u32].private;
    input r4 as token_registry.aleo/Token.record;
    assert.neq self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    cast r0 r1 r2 r3 self.caller into r5 as Proposal;
    async propose r0 r1 r5 r2 r4.token_id into r6;
    output r6 as privacypay_dao_v0004.aleo/propose.future;

finalize propose:
    input r0 as u32.public;
    input r1 as field.public;
    input r2 as Proposal.public;
    input r3 as u32.public;
    input r4 as field.public;
    get dao_token[r1] into r5;
    assert.eq r5 r4;
    get latest_proposal_id[true] into r6;
    add r6 1u32 into r7;
    assert.eq r0 r7;
    set r2 into proposals[r0];
    set 0u8 into proposal_status[r0];
    set r0 into latest_proposal_id[true];
    set r4 into gov_token[r0];

function vote_proposal:
    input r0 as u32.public;
    input r1 as field.private;
    input r2 as token_registry.aleo/Token.record;
    input r3 as boolean.private;
    assert.neq self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    cast r0 self.caller into r4 as ProposalVote;
    hash.bhp256 r4 into r5 as field;
    async vote_proposal r0 r1 r5 r2.token_id r2.amount r2.amount r3 into r6;
    output r6 as privacypay_dao_v0004.aleo/vote_proposal.future;

finalize vote_proposal:
    input r0 as u32.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    input r5 as u128.public;
    input r6 as boolean.public;
    get is_voted[r2] into r7;
    assert.eq r7 false;
    get dao_token[r1] into r8;
    assert.eq r8 r3;
    get gov_token[r0] into r9;
    assert.eq r9 r3;
    get proposal_status[r0] into r10;
    assert.eq r10 0u8;
    get proposals[r0] into r11;
    cast r0 true into r12 as VoteAcceptance;
    hash.bhp256 r12 into r13 as field;
    cast r0 false into r14 as VoteAcceptance;
    hash.bhp256 r14 into r15 as field;
    get votes[r13] into r16;
    get votes[r15] into r17;
    ternary r6 r16 r17 into r18;
    branch.eq r6 false to end_then_0_0;
    add r18 r4 into r19;
    set r19 into votes[r13];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    add r18 r4 into r20;
    set r20 into votes[r15];
    position end_otherwise_0_1;
    get voters[r0] into r21;
    cast r5 into r22 as u32;
    add r21 r22 into r23;
    set r23 into voters[r0];
    set true into is_voted[r2];
    lt block.height r11.time_limit into r24;
    assert.eq r24 true;

function cancel_proposal:
    input r0 as u32.private;
    assert.neq self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    async cancel_proposal r0 self.caller into r1;
    output r1 as privacypay_dao_v0004.aleo/cancel_proposal.future;

finalize cancel_proposal:
    input r0 as u32.public;
    input r1 as address.public;
    get proposals[r0] into r2;
    get privapay_v0003.aleo/registered_company[r2.company_id] into r3;
    is.eq r1 r2.proposer into r4;
    is.eq r1 r3.admin into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    set 3u8 into proposal_status[r0];

function close_proposal:
    input r0 as u32.private;
    input r1 as field.private;
    input r2 as boolean.private;
    assert.neq self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
    async close_proposal r0 r1 self.caller r2 into r3;
    output r3 as privacypay_dao_v0004.aleo/close_proposal.future;

finalize close_proposal:
    input r0 as u32.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as boolean.public;
    get proposals[r0] into r4;
    get privapay_v0003.aleo/registered_company[r1] into r5;
    assert.eq r5.admin r2;
    gte block.height r4.time_limit into r6;
    assert.eq r6 true;
    get proposal_status[r0] into r7;
    is.eq r7 0u8 into r8;
    assert.eq r8 true;
    branch.eq r3 false to end_then_0_2;
    set 1u8 into proposal_status[r0];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    set 2u8 into proposal_status[r0];
    position end_otherwise_0_3;
