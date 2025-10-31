import credits.aleo;
import token_registry.aleo;

program token_vesting_linear_12345pm.aleo;

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

record LockedTokensReceipt:
    owner as address.private;
    lock_id as field.private;

struct LockedTokens:
    lock_id as field;
    token_id as field;
    locked_amount as u128;
    claimed_amount as u128;
    start_block as u32;
    blocks_count_per_part as u32;

mapping locks:
    key as field.public;
    value as LockedTokens.public;

function create_lock_private:
    input r0 as field.private;
    input r1 as token_registry.aleo/Token.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    input r5 as u32.public;
    call token_registry.aleo/transfer_private_to_public token_vesting_linear_12345pm.aleo r2 r1 into r6 r7;
    cast r3 r0 into r8 as LockedTokensReceipt.record;
    async create_lock_private r7 r0 r1.token_id r5 r2 r4 into r9;
    output r6 as token_registry.aleo/Token.record;
    output r8 as LockedTokensReceipt.record;
    output r9 as token_vesting_linear_12345pm.aleo/create_lock_private.future;

finalize create_lock_private:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u32.public;
    input r4 as u128.public;
    input r5 as u32.public;
    await r0;
    contains locks[r1] into r6;
    not r6 into r7;
    assert.eq r7 true;
    div r3 1000u32 into r8;
    cast r1 r2 r4 0u128 r5 r8 into r9 as LockedTokens;
    set r9 into locks[r1];

function claim:
    input r0 as LockedTokensReceipt.record;
    input r1 as LockedTokens.private;
    input r2 as u128.private;
    input r3 as boolean.private;
    input r4 as u32.public;
    add r1.claimed_amount r2 into r5;
    assert.eq r0.lock_id r1.lock_id;
    lte r5 r1.locked_amount into r6;
    assert.eq r6 true;
    call token_registry.aleo/transfer_public_to_private r1.token_id r0.owner r2 r3 into r7 r8;
    mul r5 1000u128 into r9;
    div r9 r1.locked_amount into r10;
    hash.bhp256 r1 into r11 as field;
    async claim r8 r1.lock_id r11 r10 r5 r4 into r12;
    output r7 as token_registry.aleo/Token.record;
    output r0 as LockedTokensReceipt.record;
    output r12 as token_vesting_linear_12345pm.aleo/claim.future;

finalize claim:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u128.public;
    input r5 as u32.public;
    get locks[r1] into r6;
    hash.bhp256 r6 into r7 as field;
    assert.eq r2 r7;
    sub r5 r6.start_block into r8;
    cast r8 into r9 as u128;
    cast r6.blocks_count_per_part into r10 as u128;
    div r9 r10 into r11;
    lte r3 r11 into r12;
    assert.eq r12 true;
    cast r6.lock_id r6.token_id r6.locked_amount r4 r6.start_block r6.blocks_count_per_part into r13 as LockedTokens;
    set r13 into locks[r1];
    await r0;
