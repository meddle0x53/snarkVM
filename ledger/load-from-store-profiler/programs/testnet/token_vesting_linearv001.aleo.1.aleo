import credits.aleo;
import token_registry.aleo;

program token_vesting_linearv001.aleo;

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

record LockedTokenReceipt:
    owner as address.private;
    lock_id as field.private;

struct LockedTokens:
    lock_id as field;
    token_id as field;
    locked_amount as u128;
    claimed_amount as u128;
    blocks_start as u32;
    blocks_count_per_part as u32;

mapping locks:
    key as field.public;
    value as LockedTokens.public;

function create_lock_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.private;
    input r2 as field.private;
    input r3 as address.private;
    input r4 as u32.public;
    input r5 as u32.public;
    call token_registry.aleo/transfer_private_to_public token_vesting_linearv001.aleo r1 r0 into r6 r7;
    cast r3 r2 into r8 as LockedTokenReceipt.record;
    async create_lock_private r7 r2 r0.token_id r1 r4 r5 into r9;
    output r6 as token_registry.aleo/Token.record;
    output r8 as LockedTokenReceipt.record;
    output r9 as token_vesting_linearv001.aleo/create_lock_private.future;

finalize create_lock_private:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u32.public;
    input r5 as u32.public;
    await r0;
    contains locks[r1] into r6;
    not r6 into r7;
    assert.eq r7 true;
    cast 1000u128 into r8 as u32;
    div r4 r8 into r9;
    cast r1 r2 r3 0u128 r5 r9 into r10 as LockedTokens;
    set r10 into locks[r1];

function claim:
    input r0 as LockedTokenReceipt.record;
    input r1 as LockedTokens.private;
    input r2 as u128.private;
    input r3 as boolean.public;
    add r1.claimed_amount r2 into r4;
    is.eq r0.lock_id r1.lock_id into r5;
    assert.eq r5 true;
    lte r4 r1.locked_amount into r6;
    assert.eq r6 true;
    call token_registry.aleo/transfer_public_to_private r1.token_id r0.owner r2 r3 into r7 r8;
    mul r4 1000u128 into r9;
    div r9 r1.locked_amount into r10;
    hash.bhp256 r1 into r11 as field;
    async claim r8 r1.lock_id r11 r10 r4 into r12;
    output r7 as token_registry.aleo/Token.record;
    output r0 as LockedTokenReceipt.record;
    output r12 as token_vesting_linearv001.aleo/claim.future;

finalize claim:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u128.public;
    get locks[r1] into r5;
    hash.bhp256 r5 into r6 as field;
    assert.eq r2 r6;
    sub block.height r5.blocks_start into r7;
    div r7 r5.blocks_count_per_part into r8;
    cast r8 into r9 as u128;
    lte r3 r9 into r10;
    assert.eq r10 true;
    cast r5.lock_id r5.token_id r5.locked_amount r4 r5.blocks_start r5.blocks_count_per_part into r11 as LockedTokens;
    set r11 into locks[r1];
    await r0;
