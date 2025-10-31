import credits.aleo;
import token_registry.aleo;
import wrapped_credits.aleo;
import arcn_tokenlocker_v2_8.aleo;

program arcn_lock_distributor_v2_8.aleo;

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

struct LockedTokens:
    lock_owner as address;
    lock_id as field;
    token_id as field;
    locked_amount as u128;
    claimed_amount as u128;
    cancellable as boolean;
    start_block as u32;
    blocks_count_per_tick as u32;
    parts_unlock_per_tick as u128;

struct LockedTokensRef:
    lock_owner as address;
    lock_id as field;
    token_id as field;

struct TeamLock:
    id as field;
    distributed as u128;
    availabe_to_distribure as u128;
    lock_admin as address;
    vesting_lock_id as field;
    scheduled_shares as u128;
    schedulable as boolean;

struct ShareOwner:
    share_owner as address;
    lock_id as field;

struct ShareValue:
    share_size as u128;
    extracted_tokens as u128;

mapping team_locks:
    key as field.public;
    value as TeamLock.public;

mapping used_vesting_lock_ids:
    key as field.public;
    value as field.public;

mapping user_shares:
    key as field.public;
    value as ShareValue.public;

function create_lock:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    async create_lock r0 r1 r2 self.caller into r3;
    output r3 as arcn_lock_distributor_v2_8.aleo/create_lock.future;

finalize create_lock:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    get arcn_tokenlocker_v2_8.aleo/locks[r1] into r4;
    assert.eq r4.lock_owner r3;
    contains team_locks[r0] into r5;
    not r5 into r6;
    assert.eq r6 true;
    contains used_vesting_lock_ids[r1] into r7;
    not r7 into r8;
    assert.eq r8 true;
    cast r0 0u128 0u128 r2 r1 0u128 true into r9 as TeamLock;
    set r9 into team_locks[r0];
    set r0 into used_vesting_lock_ids[r1];
    cast r2 r0 into r10 as ShareOwner;
    hash.bhp256 r10 into r11 as field;
    cast 1u128 0u128 into r12 as ShareValue;
    set r12 into user_shares[r11];

function set_shares:
    input r0 as field.public;
    input r1 as address.private;
    input r2 as u128.public;
    input r3 as boolean.public;
    cast r1 r0 into r4 as ShareOwner;
    hash.bhp256 r4 into r5 as field;
    async set_shares r0 r5 r2 self.caller r3 into r6;
    output r6 as arcn_lock_distributor_v2_8.aleo/set_shares.future;

finalize set_shares:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as address.public;
    input r4 as boolean.public;
    get team_locks[r0] into r5;
    assert.eq r5.lock_admin r3;
    assert.eq r5.schedulable true;
    cast 0u128 0u128 into r6 as ShareValue;
    get.or_use user_shares[r1] r6 into r7;
    add r7.share_size r2 into r8;
    ternary r4 r8 r2 into r9;
    cast r9 r7.extracted_tokens into r10 as ShareValue;
    set r10 into user_shares[r1];
    sub r5.scheduled_shares r7.share_size into r11;
    add r11 r9 into r12;
    cast r0 r5.distributed r5.availabe_to_distribure r5.lock_admin r5.vesting_lock_id r12 true into r13 as TeamLock;
    set r13 into team_locks[r0];

function claim_from_vesting:
    input r0 as LockedTokens.private;
    input r1 as u128.private;
    input r2 as boolean.private;
    input r3 as boolean.private;
    call arcn_tokenlocker_v2_8.aleo/claim r0 r1 self.signer r2 r3 into r4 r5;
    call token_registry.aleo/transfer_private_to_public arcn_lock_distributor_v2_8.aleo r4.amount r4 into r6 r7;
    async claim_from_vesting r0.lock_id r1 r5 r7 into r8;
    output r8 as arcn_lock_distributor_v2_8.aleo/claim_from_vesting.future;

finalize claim_from_vesting:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as arcn_tokenlocker_v2_8.aleo/claim.future;
    input r3 as token_registry.aleo/transfer_private_to_public.future;
    await r2;
    await r3;
    get used_vesting_lock_ids[r0] into r4;
    get team_locks[r4] into r5;
    add r5.availabe_to_distribure r1 into r6;
    cast r4 r5.distributed r6 r5.lock_admin r5.vesting_lock_id r5.scheduled_shares false into r7 as TeamLock;
    set r7 into team_locks[r4];

function claim_share:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as boolean.private;
    gt r2 0u128 into r5;
    assert.eq r5 true;
    call token_registry.aleo/transfer_public_to_private r1 r3 r2 r4 into r6 r7;
    cast self.caller r0 into r8 as ShareOwner;
    hash.bhp256 r8 into r9 as field;
    async claim_share r7 r0 r1 r9 r2 into r10;
    output r6 as token_registry.aleo/Token.record;
    output r10 as arcn_lock_distributor_v2_8.aleo/claim_share.future;

finalize claim_share:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    get team_locks[r1] into r5;
    get arcn_tokenlocker_v2_8.aleo/locks[r5.vesting_lock_id] into r6;
    is.eq r2 r6.token_id into r7;
    assert.eq r7 true;
    get user_shares[r3] into r8;
    add r4 r8.extracted_tokens into r9;
    add r5.availabe_to_distribure r5.distributed into r10;
    mul r10 r8.share_size into r11;
    div r11 r5.scheduled_shares into r12;
    lte r9 r12 into r13;
    assert.eq r13 true;
    await r0;
    add r5.distributed r4 into r14;
    sub r5.availabe_to_distribure r4 into r15;
    cast r1 r14 r15 r5.lock_admin r5.vesting_lock_id r5.scheduled_shares false into r16 as TeamLock;
    set r16 into team_locks[r1];
    add r4 r8.extracted_tokens into r17;
    cast r8.share_size r17 into r18 as ShareValue;
    set r18 into user_shares[r3];

function claim_full:
    input r0 as LockedTokens.private;
    input r1 as field.private;
    input r2 as u128.private;
    input r3 as u128.private;
    input r4 as address.private;
    input r5 as boolean.private;
    input r6 as boolean.private;
    call arcn_tokenlocker_v2_8.aleo/claim r0 r2 self.signer r5 r6 into r7 r8;
    call token_registry.aleo/transfer_private_to_public arcn_lock_distributor_v2_8.aleo r7.amount r7 into r9 r10;
    call token_registry.aleo/transfer_public r0.token_id r4 r3 into r11;
    cast self.caller r1 into r12 as ShareOwner;
    hash.bhp256 r12 into r13 as field;
    async claim_full r8 r10 r11 r1 r0.lock_id r2 r13 r3 into r14;
    output r14 as arcn_lock_distributor_v2_8.aleo/claim_full.future;

finalize claim_full:
    input r0 as arcn_tokenlocker_v2_8.aleo/claim.future;
    input r1 as token_registry.aleo/transfer_private_to_public.future;
    input r2 as token_registry.aleo/transfer_public.future;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as u128.public;
    input r6 as field.public;
    input r7 as u128.public;
    await r0;
    await r1;
    get used_vesting_lock_ids[r4] into r8;
    is.eq r8 r3 into r9;
    assert.eq r9 true;
    get team_locks[r8] into r10;
    get user_shares[r6] into r11;
    add r7 r11.extracted_tokens into r12;
    add r10.availabe_to_distribure r10.distributed into r13;
    add r13 r5 into r14;
    mul r14 r11.share_size into r15;
    div r15 r10.scheduled_shares into r16;
    lte r12 r16 into r17;
    assert.eq r17 true;
    await r2;
    add r10.distributed r7 into r18;
    add r10.availabe_to_distribure r5 into r19;
    sub r19 r7 into r20;
    cast r8 r18 r20 r10.lock_admin r10.vesting_lock_id r10.scheduled_shares false into r21 as TeamLock;
    set r21 into team_locks[r8];
    add r7 r11.extracted_tokens into r22;
    cast r11.share_size r22 into r23 as ShareValue;
    set r23 into user_shares[r6];
