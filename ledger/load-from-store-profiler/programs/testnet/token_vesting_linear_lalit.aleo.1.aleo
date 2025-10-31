import credits.aleo;
import token_registry.aleo;

program token_vesting_linear_lalit.aleo;

record LockedTokensReceipt:
    owner as address.private;
    lock_id as field.private;

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
    lock_id as field;
    token_id as field;
    locked_amount as u128;
    claimed_amount as u128;
    start_block as u32;
    block_count_per_part as u32;

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
    call token_registry.aleo/transfer_private_to_public token_vesting_linear_lalit.aleo r2 r1 into r6 r7;
    cast r3 r0 into r8 as LockedTokensReceipt.record;
    async create_lock_private r7 r0 r1.token_id r5 r2 r4 into r9;
    output r6 as token_registry.aleo/Token.record;
    output r8 as LockedTokensReceipt.record;
    output r9 as token_vesting_linear_lalit.aleo/create_lock_private.future;

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
    add r1.claimed_amount r2 into r4;
    assert.eq r0.lock_id r1.lock_id;
    lte r4 r1.locked_amount into r5;
    assert.eq r5 true;
    call token_registry.aleo/transfer_public_to_private r1.token_id r0.owner r2 r3 into r6 r7;
    mul r4 1000u128 into r8;
    div r8 r1.locked_amount into r9;
    hash.bhp256 r1 into r10 as field;
    async claim r7 r1.lock_id r10 r9 r4 into r11;
    output r6 as token_registry.aleo/Token.record;
    output r0 as LockedTokensReceipt.record;
    output r11 as token_vesting_linear_lalit.aleo/claim.future;

finalize claim:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u128.public;
    get locks[r1] into r5;
    hash.bhp256 r5 into r6 as field;
    assert.eq r2 r6;
    sub block.height r5.start_block into r7;
    div r7 r5.block_count_per_part into r8;
    cast r8 into r9 as u128;
    lte r3 r9 into r10;
    assert.eq r10 true;
    cast r5.lock_id r5.token_id r5.locked_amount r4 r5.start_block r5.block_count_per_part into r11 as LockedTokens;
    set r11 into locks[r1];
    await r0;
