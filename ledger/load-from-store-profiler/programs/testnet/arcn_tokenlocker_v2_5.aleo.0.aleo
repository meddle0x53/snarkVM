import credits.aleo;
import token_registry.aleo;

program arcn_tokenlocker_v2_5.aleo;

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

mapping locks:
    key as field.public;
    value as LockedTokens.public;

function linear:
    input r0 as field.public;
    input r1 as token_registry.aleo/Token.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    input r5 as u32.public;
    input r6 as boolean.public;
    lte r2 r1.amount into r7;
    assert.eq r7 true;
    gte r4 1000u32 into r8;
    is.eq r4 1u32 into r9;
    or r8 r9 into r10;
    assert.eq r10 true;
    call token_registry.aleo/transfer_private_to_public arcn_tokenlocker_v2_5.aleo r2 r1 into r11 r12;
    cast r3 r0 r1.token_id into r13 as LockedTokensRef;
    async linear r12 r0 r4 r13 r2 r5 r6 into r14;
    output r11 as token_registry.aleo/Token.record;
    output r13 as LockedTokensRef.private;
    output r14 as arcn_tokenlocker_v2_5.aleo/linear.future;

finalize linear:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    input r2 as u32.public;
    input r3 as LockedTokensRef.public;
    input r4 as u128.public;
    input r5 as u32.public;
    input r6 as boolean.public;
    await r0;
    is.eq r5 0u32 into r7;
    lt r5 block.height into r8;
    or r7 r8 into r9;
    ternary r9 block.height r5 into r10;
    contains locks[r1] into r11;
    not r11 into r12;
    assert.eq r12 true;
    is.eq r2 1u32 into r13;
    cast 1000u128 into r14 as u32;
    gte r2 r14 into r15;
    cast 1000u128 into r16 as u32;
    rem r2 r16 into r17;
    is.eq r17 0u32 into r18;
    and r15 r18 into r19;
    or r13 r19 into r20;
    assert.eq r20 true;
    is.eq r2 1u32 into r21;
    branch.eq r21 false to end_then_0_0;
    cast r3.lock_owner r1 r3.token_id r4 0u128 r6 r10 1u32 1000u128 into r22 as LockedTokens;
    set r22 into locks[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    cast 1000u128 into r23 as u32;
    div r2 r23 into r24;
    cast r3.lock_owner r1 r3.token_id r4 0u128 r6 r10 r24 1u128 into r25 as LockedTokens;
    set r25 into locks[r1];
    position end_otherwise_0_1;

function transfer_lock:
    input r0 as field.private;
    input r1 as address.private;
    async transfer_lock r0 r1 self.caller into r2;
    output r2 as arcn_tokenlocker_v2_5.aleo/transfer_lock.future;

finalize transfer_lock:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    get locks[r0] into r3;
    assert.eq r3.lock_owner r2;
    cast r1 r3.lock_id r3.token_id r3.locked_amount r3.claimed_amount r3.cancellable r3.start_block r3.blocks_count_per_tick r3.parts_unlock_per_tick into r4 as LockedTokens;
    set r4 into locks[r0];

function linear_public:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    input r5 as u32.public;
    input r6 as boolean.public;
    gte r4 1000u32 into r7;
    is.eq r4 1u32 into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    call token_registry.aleo/transfer_public_as_signer r1 arcn_tokenlocker_v2_5.aleo r2 into r10;
    cast r3 r0 r1 into r11 as LockedTokensRef;
    async linear_public r10 r0 r4 r11 r2 r5 r6 into r12;
    output r11 as LockedTokensRef.private;
    output r12 as arcn_tokenlocker_v2_5.aleo/linear_public.future;

finalize linear_public:
    input r0 as token_registry.aleo/transfer_public_as_signer.future;
    input r1 as field.public;
    input r2 as u32.public;
    input r3 as LockedTokensRef.public;
    input r4 as u128.public;
    input r5 as u32.public;
    input r6 as boolean.public;
    await r0;
    is.eq r5 0u32 into r7;
    lt r5 block.height into r8;
    or r7 r8 into r9;
    ternary r9 block.height r5 into r10;
    contains locks[r1] into r11;
    not r11 into r12;
    assert.eq r12 true;
    is.eq r2 1u32 into r13;
    cast 1000u128 into r14 as u32;
    gte r2 r14 into r15;
    cast 1000u128 into r16 as u32;
    rem r2 r16 into r17;
    is.eq r17 0u32 into r18;
    and r15 r18 into r19;
    or r13 r19 into r20;
    assert.eq r20 true;
    is.eq r2 1u32 into r21;
    branch.eq r21 false to end_then_0_2;
    cast r3.lock_owner r1 r3.token_id r4 0u128 r6 r10 1u32 1000u128 into r22 as LockedTokens;
    set r22 into locks[r1];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    cast 1000u128 into r23 as u32;
    div r2 r23 into r24;
    cast r3.lock_owner r1 r3.token_id r4 0u128 r6 r10 r24 1u128 into r25 as LockedTokens;
    set r25 into locks[r1];
    position end_otherwise_0_3;

function claim:
    input r0 as LockedTokens.private;
    input r1 as u128.private;
    input r2 as address.private;
    input r3 as boolean.private;
    input r4 as boolean.private;
    add r0.claimed_amount r1 into r5;
    lte r5 r0.locked_amount into r6;
    assert.eq r6 true;
    call token_registry.aleo/transfer_public_to_private r0.token_id r2 r1 r3 into r7 r8;
    mul r5 1000u128 into r9;
    div r9 r0.locked_amount into r10;
    hash.bhp256 r0 into r11 as field;
    ternary r4 self.signer self.caller into r12;
    async claim r8 r0.lock_id r11 r12 r10 r5 into r13;
    output r7 as token_registry.aleo/Token.record;
    output r13 as arcn_tokenlocker_v2_5.aleo/claim.future;

finalize claim:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as address.public;
    input r4 as u128.public;
    input r5 as u128.public;
    gt r4 0u128 into r6;
    assert.eq r6 true;
    get locks[r1] into r7;
    assert.eq r3 r7.lock_owner;
    hash.bhp256 r7 into r8 as field;
    assert.eq r8 r2;
    sub block.height r7.start_block into r9;
    div r9 r7.blocks_count_per_tick into r10;
    cast r10 into r11 as u128;
    mul r7.parts_unlock_per_tick r11 into r12;
    lte r4 r12 into r13;
    assert.eq r13 true;
    cast r7.lock_owner r7.lock_id r7.token_id r7.locked_amount r5 r7.cancellable r7.start_block r7.blocks_count_per_tick r7.parts_unlock_per_tick into r14 as LockedTokens;
    set r14 into locks[r1];
    await r0;

function cancell_lock:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as u128.private;
    call token_registry.aleo/transfer_public r1 r2 r3 into r4;
    async cancell_lock r4 r0 r1 r3 self.caller into r5;
    output r5 as arcn_tokenlocker_v2_5.aleo/cancell_lock.future;

finalize cancell_lock:
    input r0 as token_registry.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as address.public;
    get locks[r1] into r5;
    assert.eq r4 r5.lock_owner;
    assert.eq r2 r5.token_id;
    assert.eq r5.locked_amount r3;
    assert.eq r5.claimed_amount 0u128;
    assert.eq r5.cancellable true;
    cast r5.lock_owner r1 r5.token_id 0u128 0u128 false r5.start_block r5.blocks_count_per_tick r5.parts_unlock_per_tick into r6 as LockedTokens;
    set r6 into locks[r1];
    await r0;

function linear_public_empty:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.private;
    input r3 as u32.public;
    input r4 as u32.public;
    input r5 as boolean.public;
    gte r3 1000u32 into r6;
    is.eq r3 1u32 into r7;
    or r6 r7 into r8;
    assert.eq r8 true;
    cast r2 r0 r1 into r9 as LockedTokensRef;
    async linear_public_empty r0 r3 r9 r4 r5 into r10;
    output r9 as LockedTokensRef.private;
    output r10 as arcn_tokenlocker_v2_5.aleo/linear_public_empty.future;

finalize linear_public_empty:
    input r0 as field.public;
    input r1 as u32.public;
    input r2 as LockedTokensRef.public;
    input r3 as u32.public;
    input r4 as boolean.public;
    is.eq r3 0u32 into r5;
    ternary r5 block.height r3 into r6;
    contains locks[r0] into r7;
    not r7 into r8;
    assert.eq r8 true;
    cast 1000u128 into r9 as u32;
    is.eq r1 r9 into r10;
    branch.eq r10 false to end_then_0_4;
    cast r2.lock_owner r0 r2.token_id 0u128 0u128 r4 r6 1u32 1u128 into r11 as LockedTokens;
    set r11 into locks[r0];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    is.eq r1 1u32 into r12;
    branch.eq r12 false to end_then_1_6;
    cast r2.lock_owner r0 r2.token_id 0u128 0u128 r4 r6 1u32 1000u128 into r13 as LockedTokens;
    set r13 into locks[r0];
    branch.eq true true to end_otherwise_1_7;
    position end_then_1_6;
    cast 1000u128 into r14 as u32;
    lt r1 r14 into r15;
    branch.eq r15 false to end_then_2_8;
    cast r1 into r16 as u128;
    div 1000u128 r16 into r17;
    cast r2.lock_owner r0 r2.token_id 0u128 0u128 r4 r6 1u32 r17 into r18 as LockedTokens;
    set r18 into locks[r0];
    branch.eq true true to end_otherwise_2_9;
    position end_then_2_8;
    cast 1000u128 into r19 as u32;
    div r1 r19 into r20;
    cast r2.lock_owner r0 r2.token_id 0u128 0u128 r4 r6 r20 1u128 into r21 as LockedTokens;
    set r21 into locks[r0];
    position end_otherwise_2_9;
    position end_otherwise_1_7;
    position end_otherwise_0_5;

function deposit:
    input r0 as field.public;
    input r1 as token_registry.aleo/Token.record;
    input r2 as u128.private;
    lte r2 r1.amount into r3;
    assert.eq r3 true;
    call token_registry.aleo/transfer_private_to_public arcn_tokenlocker_v2_5.aleo r2 r1 into r4 r5;
    async deposit r5 self.caller r0 r1.token_id r2 into r6;
    output r4 as token_registry.aleo/Token.record;
    output r6 as arcn_tokenlocker_v2_5.aleo/deposit.future;

finalize deposit:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    await r0;
    get locks[r2] into r5;
    assert.eq r5.lock_owner r1;
    assert.eq r5.token_id r3;
    add r5.locked_amount r4 into r6;
    cast r5.lock_owner r5.lock_id r5.token_id r6 r5.claimed_amount r5.cancellable r5.start_block r5.blocks_count_per_tick r5.parts_unlock_per_tick into r7 as LockedTokens;
    set r7 into locks[r2];
