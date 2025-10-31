import credits.aleo;
import multi_token_support_program.aleo;
import spectre_access_control_v1_001.aleo;
import spectre_acl_manager_v1_001.aleo;

program staking_stcredits_v1_001.aleo;

struct committee_state:
    is_open as boolean;
    commission as u8;

struct bond_state:
    validator as address;
    microcredits as u64;

struct unbond_state:
    microcredits as u64;
    height as u32;

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

struct metadata:
    name as u128;
    symbol as u64;
    decimals as u8;

record token:
    owner as address.private;
    amount as u64.private;

struct approval:
    approver as address;
    spender as address;

struct Config:
    paused as boolean;
    treasury as address;
    protocol_fee as u8;
    instant_withdraw_fee as u8;

struct State:
    withdraw as u64;
    pending_withdraw as u64;
    bonded as u64;
    unbonding as u64;
    resolved_height as u32;

struct CacheState:
    status as u8;
    height as u32;
    bonded as u64;
    unbonding as u64;
    next_index as u32;

struct Withdraw:
    amount as u64;
    pending as boolean;
    height as u32;

struct Delegator:
    delegator as address;
    validator as address;
    bonded as u64;

struct RewardHistory:
    validator as address;
    bonded as u64;
    reward as u64;
    height as u32;

mapping total_supply:
    key as u8.public;
    value as u64.public;

mapping account:
    key as address.public;
    value as u64.public;

mapping approvals:
    key as field.public;
    value as u64.public;

mapping config:
    key as u8.public;
    value as Config.public;

mapping state:
    key as u8.public;
    value as State.public;

mapping cache_state:
    key as u8.public;
    value as CacheState.public;

mapping withdraws:
    key as address.public;
    value as Withdraw.public;

mapping delegators_count:
    key as u8.public;
    value as u32.public;

mapping delegators:
    key as u32.public;
    value as Delegator.public;

mapping delegator_pos:
    key as address.public;
    value as u32.public;

mapping validator_pos:
    key as address.public;
    value as u32.public;

mapping reward_history_count:
    key as u8.public;
    value as u32.public;

mapping reward_history:
    key as u32.public;
    value as RewardHistory.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as staking_stcredits_v1_001.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use account[r0] 0u64 into r3;
    sub r3 r2 into r4;
    set r4 into account[r0];
    get.or_use account[r1] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into account[r1];

function transfer_private:
    input r0 as token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as token.record;
    cast r1 r2 into r5 as token.record;
    output r4 as token.record;
    output r5 as token.record;

function transfer_private_to_public:
    input r0 as token.record;
    input r1 as address.public;
    input r2 as u64.public;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as token.record;
    async transfer_private_to_public r1 r2 into r5;
    output r4 as token.record;
    output r5 as staking_stcredits_v1_001.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];

function transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 into r2 as token.record;
    async transfer_public_to_private self.caller r1 into r3;
    output r2 as token.record;
    output r3 as staking_stcredits_v1_001.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into account[r0];

function initialize:
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r0;
    cast staking_stcredits_v1_001.aleo into r1 as field;
    call multi_token_support_program.aleo/register_token r1 8319383754638649716u128 8319383754638649716u128 6u8 340282366920938463463374607431768211455u128 false staking_stcredits_v1_001.aleo into r2;
    async initialize r0 r2 self.caller into r3;
    output r3 as staking_stcredits_v1_001.aleo/initialize.future;

finalize initialize:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    input r1 as multi_token_support_program.aleo/register_token.future;
    input r2 as address.public;
    await r0;
    await r1;
    contains config[0u8] into r3;
    not r3 into r4;
    assert.eq r4 true;
    cast true r2 0u8 1u8 into r5 as Config;
    set r5 into config[0u8];
    cast 0u64 0u64 0u64 0u64 0u32 into r6 as State;
    set r6 into state[0u8];
    cast 0u8 0u32 0u64 0u64 0u32 into r7 as CacheState;
    set r7 into cache_state[0u8];
    set 0u32 into delegators_count[0u8];
    set 0u32 into reward_history_count[0u8];

function approve_public:
    input r0 as address.public;
    input r1 as u64.public;
    cast self.caller r0 into r2 as approval;
    hash.bhp256 r2 into r3 as field;
    async approve_public r3 r1 into r4;
    output r4 as staking_stcredits_v1_001.aleo/approve_public.future;

finalize approve_public:
    input r0 as field.public;
    input r1 as u64.public;
    get.or_use approvals[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into approvals[r0];

function unapprove_public:
    input r0 as address.public;
    input r1 as u64.public;
    cast self.caller r0 into r2 as approval;
    hash.bhp256 r2 into r3 as field;
    async unapprove_public r3 r1 into r4;
    output r4 as staking_stcredits_v1_001.aleo/unapprove_public.future;

finalize unapprove_public:
    input r0 as field.public;
    input r1 as u64.public;
    get approvals[r0] into r2;
    sub r2 r1 into r3;
    set r3 into approvals[r0];

function transfer_from_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    cast r0 self.caller into r3 as approval;
    hash.bhp256 r3 into r4 as field;
    async transfer_from_public r4 r0 r1 r2 into r5;
    output r5 as staking_stcredits_v1_001.aleo/transfer_from_public.future;

finalize transfer_from_public:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as u64.public;
    get approvals[r0] into r4;
    sub r4 r3 into r5;
    set r5 into approvals[r0];
    get account[r1] into r6;
    sub r6 r3 into r7;
    set r7 into account[r1];
    get.or_use account[r2] 0u64 into r8;
    add r8 r3 into r9;
    set r9 into account[r2];

function get_metadata:
    cast 8319383754638649716u128 8319383754638649716u64 6u8 into r0 as metadata;
    output r0 as metadata.private;

function wrap_mtsp:
    input r0 as u64.public;
    cast staking_stcredits_v1_001.aleo into r1 as field;
    cast r0 into r2 as u128;
    call multi_token_support_program.aleo/mint_public r1 self.caller r2 4294967295u32 into r3;
    async wrap_mtsp r3 self.caller r0 into r4;
    output r4 as staking_stcredits_v1_001.aleo/wrap_mtsp.future;

finalize wrap_mtsp:
    input r0 as multi_token_support_program.aleo/mint_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get account[r1] into r3;
    sub r3 r2 into r4;
    set r4 into account[r1];
    get.or_use account[staking_stcredits_v1_001.aleo] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into account[staking_stcredits_v1_001.aleo];

function unwrap_mtsp:
    input r0 as u64.public;
    cast staking_stcredits_v1_001.aleo into r1 as field;
    cast r0 into r2 as u128;
    call multi_token_support_program.aleo/burn_public r1 self.caller r2 into r3;
    async unwrap_mtsp r3 self.caller r0 into r4;
    output r4 as staking_stcredits_v1_001.aleo/unwrap_mtsp.future;

finalize unwrap_mtsp:
    input r0 as multi_token_support_program.aleo/burn_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get.or_use account[r1] 0u64 into r3;
    add r3 r2 into r4;
    set r4 into account[r1];
    get account[staking_stcredits_v1_001.aleo] into r5;
    sub r5 r2 into r6;
    set r6 into account[staking_stcredits_v1_001.aleo];

function register_delegator:
    input r0 as address.public;
    input r1 as address.public;
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r2;
    async register_delegator r2 r0 r1 into r3;
    output r3 as staking_stcredits_v1_001.aleo/register_delegator.future;

finalize register_delegator:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    input r1 as address.public;
    input r2 as address.public;
    await r0;
    cast 0u8 0u32 0u64 0u64 0u32 into r3 as CacheState;
    set r3 into cache_state[0u8];
    cast true 0u8 into r4 as committee_state;
    get.or_use credits.aleo/committee[r2] r4 into r5;
    assert.eq r5.is_open true;
    contains credits.aleo/bonded[r1] into r6;
    not r6 into r7;
    assert.eq r7 true;
    contains credits.aleo/unbonding[r1] into r8;
    not r8 into r9;
    assert.eq r9 true;
    contains delegator_pos[r1] into r10;
    not r10 into r11;
    assert.eq r11 true;
    contains validator_pos[r2] into r12;
    not r12 into r13;
    assert.eq r13 true;
    get delegators_count[0u8] into r14;
    add r14 1u32 into r15;
    set r15 into delegators_count[0u8];
    cast r1 r2 0u64 into r16 as Delegator;
    set r16 into delegators[r14];
    set r14 into delegator_pos[r1];
    set r14 into validator_pos[r2];

function unregister_delegator:
    input r0 as address.public;
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r1;
    async unregister_delegator r1 r0 into r2;
    output r2 as staking_stcredits_v1_001.aleo/unregister_delegator.future;

finalize unregister_delegator:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    input r1 as address.public;
    await r0;
    cast 0u8 0u32 0u64 0u64 0u32 into r2 as CacheState;
    set r2 into cache_state[0u8];
    get delegator_pos[r1] into r3;
    get delegators[r3] into r4;
    contains credits.aleo/bonded[r1] into r5;
    not r5 into r6;
    assert.eq r6 true;
    contains credits.aleo/unbonding[r1] into r7;
    not r7 into r8;
    assert.eq r8 true;
    get delegators_count[0u8] into r9;
    gte r9 1u32 into r10;
    assert.eq r10 true;
    sub r9 1u32 into r11;
    is.neq r3 r11 into r12;
    branch.eq r12 false to end_then_0_0;
    sub r9 1u32 into r13;
    get delegators[r13] into r14;
    set r14 into delegators[r3];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    sub r9 1u32 into r15;
    set r15 into delegators_count[0u8];
    sub r9 1u32 into r16;
    remove delegators[r16];
    remove delegator_pos[r1];
    remove validator_pos[r4.validator];

function bond:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    assert.eq r0 self.caller;
    call credits.aleo/transfer_public r0 r2 into r3;
    async bond r3 r0 r1 r2 into r4;
    output r4 as staking_stcredits_v1_001.aleo/bond.future;

finalize bond:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as u64.public;
    get config[0u8] into r4;
    not r4.paused into r5;
    assert.eq r5 true;
    get cache_state[0u8] into r6;
    assert.eq r6.status 2u8;
    cast 0u8 0u32 0u64 0u64 0u32 into r7 as CacheState;
    set r7 into cache_state[0u8];
    get state[0u8] into r8;
    cast staking_stcredits_v1_001.aleo into r9 as address;
    get.or_use credits.aleo/account[r9] 0u64 into r10;
    add r8.withdraw r3 into r11;
    gte r10 r11 into r12;
    assert.eq r12 true;
    add r10 r8.unbonding into r13;
    add r8.withdraw r8.pending_withdraw into r14;
    add r14 r3 into r15;
    gte r13 r15 into r16;
    assert.eq r16 true;
    await r0;
    get delegator_pos[r1] into r17;
    get delegators[r17] into r18;
    assert.eq r18.validator r2;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r19 as bond_state;
    get.or_use credits.aleo/bonded[r1] r19 into r20;
    add r20.microcredits r3 into r21;
    cast r1 r2 r21 into r22 as Delegator;
    set r22 into delegators[r17];
    gt r20.microcredits r18.bonded into r23;
    sub.w r20.microcredits r18.bonded into r24;
    ternary r23 r24 0u64 into r25;
    get reward_history_count[0u8] into r26;
    cast r2 r20.microcredits r25 block.height into r27 as RewardHistory;
    set r27 into reward_history[r26];
    add r26 1u32 into r28;
    set r28 into reward_history_count[0u8];
    cast r4.protocol_fee into r29 as u64;
    mul r25 r29 into r30;
    div r30 100u64 into r31;
    gt r31 0u64 into r32;
    branch.eq r32 false to end_then_0_2;
    add r10 r8.bonded into r33;
    add r33 r8.unbonding into r34;
    sub r34 r8.withdraw into r35;
    sub r35 r8.pending_withdraw into r36;
    get.or_use total_supply[0u8] 0u64 into r37;
    gt r36 0u64 into r38;
    ternary r38 r36 1u64 into r39;
    gt r37 0u64 into r40;
    ternary r40 r37 1u64 into r41;
    cast r31 into r42 as u128;
    cast r41 into r43 as u128;
    mul r42 r43 into r44;
    cast r39 into r45 as u128;
    div r44 r45 into r46;
    cast r46 into r47 as u64;
    get.or_use account[r4.treasury] 0u64 into r48;
    add r48 r47 into r49;
    set r49 into account[r4.treasury];
    add r37 r47 into r50;
    set r50 into total_supply[0u8];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;

function unbond:
    input r0 as address.public;
    input r1 as u64.public;
    call spectre_acl_manager_v1_001.aleo/only_staking_operator self.caller into r2;
    call credits.aleo/unbond_public r0 r1 into r3;
    async unbond r2 r3 r0 r1 into r4;
    output r4 as staking_stcredits_v1_001.aleo/unbond.future;

finalize unbond:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_operator.future;
    input r1 as credits.aleo/unbond_public.future;
    input r2 as address.public;
    input r3 as u64.public;
    await r0;
    get config[0u8] into r4;
    not r4.paused into r5;
    assert.eq r5 true;
    get cache_state[0u8] into r6;
    assert.eq r6.status 2u8;
    cast 0u8 0u32 0u64 0u64 0u32 into r7 as CacheState;
    set r7 into cache_state[0u8];
    get state[0u8] into r8;
    get delegator_pos[r2] into r9;
    get delegators[r9] into r10;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r11 as bond_state;
    get.or_use credits.aleo/bonded[r2] r11 into r12;
    sub r12.microcredits r3 into r13;
    cast r2 r10.validator r13 into r14 as Delegator;
    set r14 into delegators[r9];
    gt r12.microcredits r10.bonded into r15;
    sub.w r12.microcredits r10.bonded into r16;
    ternary r15 r16 0u64 into r17;
    get reward_history_count[0u8] into r18;
    cast r10.validator r12.microcredits r17 block.height into r19 as RewardHistory;
    set r19 into reward_history[r18];
    add r18 1u32 into r20;
    set r20 into reward_history_count[0u8];
    cast r4.protocol_fee into r21 as u64;
    mul r17 r21 into r22;
    div r22 100u64 into r23;
    gt r23 0u64 into r24;
    branch.eq r24 false to end_then_0_4;
    cast staking_stcredits_v1_001.aleo into r25 as address;
    get.or_use credits.aleo/account[r25] 0u64 into r26;
    add r26 r8.bonded into r27;
    add r27 r8.unbonding into r28;
    sub r28 r8.withdraw into r29;
    sub r29 r8.pending_withdraw into r30;
    get.or_use total_supply[0u8] 0u64 into r31;
    gt r30 0u64 into r32;
    ternary r32 r30 1u64 into r33;
    gt r31 0u64 into r34;
    ternary r34 r31 1u64 into r35;
    cast r23 into r36 as u128;
    cast r35 into r37 as u128;
    mul r36 r37 into r38;
    cast r33 into r39 as u128;
    div r38 r39 into r40;
    cast r40 into r41 as u64;
    get.or_use account[r4.treasury] 0u64 into r42;
    add r42 r41 into r43;
    set r43 into account[r4.treasury];
    add r31 r41 into r44;
    set r44 into total_supply[0u8];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    position end_otherwise_0_5;
    await r1;

function claim_unbond:
    input r0 as address.private;
    call credits.aleo/claim_unbond_public r0 into r1;
    async claim_unbond r1 r0 into r2;
    output r2 as staking_stcredits_v1_001.aleo/claim_unbond.future;

finalize claim_unbond:
    input r0 as credits.aleo/claim_unbond_public.future;
    input r1 as address.public;
    await r0;
    get config[0u8] into r2;
    not r2.paused into r3;
    assert.eq r3 true;
    cast 0u8 0u32 0u64 0u64 0u32 into r4 as CacheState;
    set r4 into cache_state[0u8];
    contains delegator_pos[r1] into r5;
    assert.eq r5 true;

function resolve_withdrawal:
    async resolve_withdrawal into r0;
    output r0 as staking_stcredits_v1_001.aleo/resolve_withdrawal.future;

finalize resolve_withdrawal:
    get config[0u8] into r0;
    not r0.paused into r1;
    assert.eq r1 true;
    get state[0u8] into r2;
    cast staking_stcredits_v1_001.aleo into r3 as address;
    get.or_use credits.aleo/account[r3] 0u64 into r4;
    add r2.withdraw r2.pending_withdraw into r5;
    gte r4 r5 into r6;
    assert.eq r6 true;
    add r2.withdraw r2.pending_withdraw into r7;
    cast r7 0u64 r2.bonded r2.unbonding block.height into r8 as State;
    set r8 into state[0u8];

function resolve_withdrawal_force:
    input r0 as u64.public;
    input r1 as u32.public;
    call spectre_acl_manager_v1_001.aleo/only_staking_operator self.caller into r2;
    async resolve_withdrawal_force r2 r0 r1 into r3;
    output r3 as staking_stcredits_v1_001.aleo/resolve_withdrawal_force.future;

finalize resolve_withdrawal_force:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_operator.future;
    input r1 as u64.public;
    input r2 as u32.public;
    await r0;
    get config[0u8] into r3;
    not r3.paused into r4;
    assert.eq r4 true;
    get state[0u8] into r5;
    cast staking_stcredits_v1_001.aleo into r6 as address;
    get.or_use credits.aleo/account[r6] 0u64 into r7;
    add r5.withdraw r1 into r8;
    gte r7 r8 into r9;
    assert.eq r9 true;
    gt r2 0u32 into r10;
    ternary r10 r2 block.height into r11;
    gte r11 r5.resolved_height into r12;
    lte r11 block.height into r13;
    and r12 r13 into r14;
    assert.eq r14 true;
    add r5.withdraw r1 into r15;
    sub r5.pending_withdraw r1 into r16;
    cast r15 r16 r5.bonded r5.unbonding r11 into r17 as State;
    set r17 into state[0u8];

function supply:
    input r0 as u64.public;
    gt r0 0u64 into r1;
    assert.eq r1 true;
    cast staking_stcredits_v1_001.aleo into r2 as address;
    call credits.aleo/transfer_public_as_signer r2 r0 into r3;
    async supply r3 self.signer r0 into r4;
    output r4 as staking_stcredits_v1_001.aleo/supply.future;

finalize supply:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    get config[0u8] into r3;
    not r3.paused into r4;
    assert.eq r4 true;
    get cache_state[0u8] into r5;
    assert.eq r5.status 2u8;
    get state[0u8] into r6;
    cast staking_stcredits_v1_001.aleo into r7 as address;
    get.or_use credits.aleo/account[r7] 0u64 into r8;
    add r8 r6.bonded into r9;
    add r9 r6.unbonding into r10;
    sub r10 r6.withdraw into r11;
    sub r11 r6.pending_withdraw into r12;
    get.or_use total_supply[0u8] 0u64 into r13;
    await r0;
    gt r12 0u64 into r14;
    ternary r14 r12 1u64 into r15;
    gt r13 0u64 into r16;
    ternary r16 r13 1u64 into r17;
    cast r2 into r18 as u128;
    cast r17 into r19 as u128;
    mul r18 r19 into r20;
    cast r15 into r21 as u128;
    div r20 r21 into r22;
    cast r22 into r23 as u64;
    get.or_use account[r1] 0u64 into r24;
    add r24 r23 into r25;
    set r25 into account[r1];
    add r13 r23 into r26;
    set r26 into total_supply[0u8];

function withdraw:
    input r0 as u64.public;
    input r1 as boolean.public;
    async withdraw self.caller r0 r1 into r2;
    output r2 as staking_stcredits_v1_001.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as boolean.public;
    get config[0u8] into r3;
    not r3.paused into r4;
    assert.eq r4 true;
    get cache_state[0u8] into r5;
    assert.eq r5.status 2u8;
    get state[0u8] into r6;
    cast staking_stcredits_v1_001.aleo into r7 as address;
    get.or_use credits.aleo/account[r7] 0u64 into r8;
    add r8 r6.bonded into r9;
    add r9 r6.unbonding into r10;
    sub r10 r6.withdraw into r11;
    sub r11 r6.pending_withdraw into r12;
    get.or_use total_supply[0u8] 0u64 into r13;
    gt r12 0u64 into r14;
    ternary r14 r12 1u64 into r15;
    gt r13 0u64 into r16;
    ternary r16 r13 1u64 into r17;
    cast r1 into r18 as u128;
    cast r15 into r19 as u128;
    mul r18 r19 into r20;
    cast r17 into r21 as u128;
    div r20 r21 into r22;
    cast r22 into r23 as u64;
    get.or_use account[r0] 0u64 into r24;
    sub r24 r1 into r25;
    set r25 into account[r0];
    sub r13 r1 into r26;
    set r26 into total_supply[0u8];
    add r6.withdraw r6.pending_withdraw into r27;
    gt r8 r27 into r28;
    add r6.withdraw r6.pending_withdraw into r29;
    sub.w r8 r29 into r30;
    ternary r28 r30 0u64 into r31;
    gte r31 r23 into r32;
    ternary r32 r23 r31 into r33;
    sub r23 r33 into r34;
    branch.eq r2 false to end_then_0_6;
    contains withdraws[r0] into r35;
    not r35 into r36;
    assert.eq r36 true;
    is.eq r34 0u64 into r37;
    assert.eq r37 true;
    branch.eq true true to end_otherwise_0_7;
    position end_then_0_6;
    position end_otherwise_0_7;
    cast r3.instant_withdraw_fee into r38 as u64;
    mul r23 r38 into r39;
    div r39 100u64 into r40;
    sub r33 r40 into r41;
    ternary r2 r41 r33 into r42;
    add r6.withdraw r42 into r43;
    add r6.pending_withdraw r34 into r44;
    cast r43 r44 r6.bonded r6.unbonding r6.resolved_height into r45 as State;
    set r45 into state[0u8];
    cast 0u64 false 0u32 into r46 as Withdraw;
    get.or_use withdraws[r0] r46 into r47;
    add r47.amount r42 into r48;
    add r48 r34 into r49;
    gt r34 0u64 into r50;
    or r47.pending r50 into r51;
    add block.height 360u32 into r52;
    ternary r2 block.height r52 into r53;
    cast r49 r51 r53 into r54 as Withdraw;
    set r54 into withdraws[r0];

function claim:
    input r0 as u64.public;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async claim r1 self.caller r0 into r2;
    output r2 as staking_stcredits_v1_001.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    get config[0u8] into r3;
    not r3.paused into r4;
    assert.eq r4 true;
    get state[0u8] into r5;
    get withdraws[r1] into r6;
    assert.eq r6.amount r2;
    not r6.pending into r7;
    add r5.resolved_height 360u32 into r8;
    ternary r7 block.height r8 into r9;
    lte r6.height r9 into r10;
    assert.eq r10 true;
    remove withdraws[r1];
    sub r5.withdraw r2 into r11;
    cast r11 r5.pending_withdraw r5.bonded r5.unbonding r5.resolved_height into r12 as State;
    set r12 into state[0u8];
    await r0;

function cache:
    input r0 as u32.public;
    call spectre_acl_manager_v1_001.aleo/only_staking_operator self.caller into r1;
    async cache r1 r0 into r2;
    output r2 as staking_stcredits_v1_001.aleo/cache.future;

finalize cache:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_operator.future;
    input r1 as u32.public;
    await r0;
    get config[0u8] into r2;
    not r2.paused into r3;
    assert.eq r3 true;
    is.eq r1 0u32 into r4;
    get cache_state[0u8] into r5;
    ternary r4 1u8 r5.status into r6;
    ternary r4 block.height r5.height into r7;
    ternary r4 0u64 r5.bonded into r8;
    ternary r4 0u64 r5.unbonding into r9;
    ternary r4 0u32 r5.next_index into r10;
    assert.eq r6 1u8;
    assert.eq r1 r10;
    get delegators_count[0u8] into r11;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r12 as Delegator;
    cast aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc 0u64 into r13 as bond_state;
    cast 0u64 0u32 into r14 as unbond_state;
    contains credits.aleo/bonded[aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc] into r15;
    not r15 into r16;
    contains credits.aleo/unbonding[aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc] into r17;
    not r17 into r18;
    and r16 r18 into r19;
    assert.eq r19 true;
    add r1 0u32 into r20;
    get.or_use delegators[r20] r12 into r21;
    get.or_use credits.aleo/bonded[r21.delegator] r13 into r22;
    get.or_use credits.aleo/unbonding[r21.delegator] r14 into r23;
    add r8 r22.microcredits into r24;
    add r9 r23.microcredits into r25;
    add r1 1u32 into r26;
    get.or_use delegators[r26] r12 into r27;
    get.or_use credits.aleo/bonded[r27.delegator] r13 into r28;
    get.or_use credits.aleo/unbonding[r27.delegator] r14 into r29;
    add r24 r28.microcredits into r30;
    add r25 r29.microcredits into r31;
    add r1 2u32 into r32;
    get.or_use delegators[r32] r12 into r33;
    get.or_use credits.aleo/bonded[r33.delegator] r13 into r34;
    get.or_use credits.aleo/unbonding[r33.delegator] r14 into r35;
    add r30 r34.microcredits into r36;
    add r31 r35.microcredits into r37;
    add r1 3u32 into r38;
    get.or_use delegators[r38] r12 into r39;
    get.or_use credits.aleo/bonded[r39.delegator] r13 into r40;
    get.or_use credits.aleo/unbonding[r39.delegator] r14 into r41;
    add r36 r40.microcredits into r42;
    add r37 r41.microcredits into r43;
    add r1 4u32 into r44;
    get.or_use delegators[r44] r12 into r45;
    get.or_use credits.aleo/bonded[r45.delegator] r13 into r46;
    get.or_use credits.aleo/unbonding[r45.delegator] r14 into r47;
    add r42 r46.microcredits into r48;
    add r43 r47.microcredits into r49;
    add r1 5u32 into r50;
    get.or_use delegators[r50] r12 into r51;
    get.or_use credits.aleo/bonded[r51.delegator] r13 into r52;
    get.or_use credits.aleo/unbonding[r51.delegator] r14 into r53;
    add r48 r52.microcredits into r54;
    add r49 r53.microcredits into r55;
    add r1 6u32 into r56;
    get.or_use delegators[r56] r12 into r57;
    get.or_use credits.aleo/bonded[r57.delegator] r13 into r58;
    get.or_use credits.aleo/unbonding[r57.delegator] r14 into r59;
    add r54 r58.microcredits into r60;
    add r55 r59.microcredits into r61;
    add r1 7u32 into r62;
    get.or_use delegators[r62] r12 into r63;
    get.or_use credits.aleo/bonded[r63.delegator] r13 into r64;
    get.or_use credits.aleo/unbonding[r63.delegator] r14 into r65;
    add r60 r64.microcredits into r66;
    add r61 r65.microcredits into r67;
    add r1 8u32 into r68;
    get.or_use delegators[r68] r12 into r69;
    get.or_use credits.aleo/bonded[r69.delegator] r13 into r70;
    get.or_use credits.aleo/unbonding[r69.delegator] r14 into r71;
    add r66 r70.microcredits into r72;
    add r67 r71.microcredits into r73;
    add r1 9u32 into r74;
    get.or_use delegators[r74] r12 into r75;
    get.or_use credits.aleo/bonded[r75.delegator] r13 into r76;
    get.or_use credits.aleo/unbonding[r75.delegator] r14 into r77;
    add r72 r76.microcredits into r78;
    add r73 r77.microcredits into r79;
    add r1 10u32 into r80;
    gte r80 r11 into r81;
    not r81 into r82;
    ternary r82 1u8 2u8 into r83;
    not r81 into r84;
    ternary r84 r7 block.height into r85;
    not r81 into r86;
    ternary r86 r80 0u32 into r87;
    cast r83 r85 r78 r79 r87 into r88 as CacheState;
    set r88 into cache_state[0u8];
    branch.eq r81 false to end_then_0_8;
    get state[0u8] into r89;
    cast r89.withdraw r89.pending_withdraw r78 r79 r89.resolved_height into r90 as State;
    set r90 into state[0u8];
    branch.eq true true to end_otherwise_0_9;
    position end_then_0_8;
    position end_otherwise_0_9;

function set_treasury:
    input r0 as address.public;
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r1;
    async set_treasury r1 r0 into r2;
    output r2 as staking_stcredits_v1_001.aleo/set_treasury.future;

finalize set_treasury:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    input r1 as address.public;
    await r0;
    get config[0u8] into r2;
    cast r2.paused r1 r2.protocol_fee r2.instant_withdraw_fee into r3 as Config;
    set r3 into config[0u8];

function set_protocol_fee:
    input r0 as u8.public;
    gte r0 0u8 into r1;
    lte r0 100u8 into r2;
    and r1 r2 into r3;
    assert.eq r3 true;
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r4;
    async set_protocol_fee r4 r0 into r5;
    output r5 as staking_stcredits_v1_001.aleo/set_protocol_fee.future;

finalize set_protocol_fee:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    input r1 as u8.public;
    await r0;
    get config[0u8] into r2;
    cast r2.paused r2.treasury r1 r2.instant_withdraw_fee into r3 as Config;
    set r3 into config[0u8];

function set_instant_withdraw_fee:
    input r0 as u8.public;
    gte r0 0u8 into r1;
    lte r0 100u8 into r2;
    and r1 r2 into r3;
    assert.eq r3 true;
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r4;
    async set_instant_withdraw_fee r4 r0 into r5;
    output r5 as staking_stcredits_v1_001.aleo/set_instant_withdraw_fee.future;

finalize set_instant_withdraw_fee:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    input r1 as u8.public;
    await r0;
    get config[0u8] into r2;
    cast r2.paused r2.treasury r2.protocol_fee r1 into r3 as Config;
    set r3 into config[0u8];

function pause:
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r0;
    async pause r0 into r1;
    output r1 as staking_stcredits_v1_001.aleo/pause.future;

finalize pause:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    await r0;
    get config[0u8] into r1;
    cast true r1.treasury r1.protocol_fee r1.instant_withdraw_fee into r2 as Config;
    set r2 into config[0u8];

function unpause:
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r0;
    async unpause r0 into r1;
    output r1 as staking_stcredits_v1_001.aleo/unpause.future;

finalize unpause:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    await r0;
    get config[0u8] into r1;
    cast false r1.treasury r1.protocol_fee r1.instant_withdraw_fee into r2 as Config;
    set r2 into config[0u8];

function rescue_tokens:
    input r0 as address.public;
    input r1 as u64.public;
    call spectre_acl_manager_v1_001.aleo/only_staking_admin self.caller into r2;
    call credits.aleo/transfer_public r0 r1 into r3;
    async rescue_tokens r2 r3 into r4;
    output r4 as staking_stcredits_v1_001.aleo/rescue_tokens.future;

finalize rescue_tokens:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;
    input r1 as credits.aleo/transfer_public.future;
    await r0;
    await r1;
