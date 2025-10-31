import credits.aleo;
import token_registry.aleo;
import eclipse_oracle_feed.aleo;
import eclipse_oracle_staking_2.aleo;
import eclipse_oracle_submit_2.aleo;
import eclipse_oracle_aggregate_2.aleo;
import eclipse_lending_usda_vault_11.aleo;

program eclipse_lending_treasury.aleo;

record stake_position:
    owner as address.private;
    amount as u128.private;
    height as u32.private;
    total_fees as u128.private;

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

mapping total_staked:
    key as field.public;
    value as u128.public;

function stake:
    input r0 as u128.private;
    input r1 as address.private;
    input r2 as token_registry.aleo/Token.record;
    input r3 as u128.public;
    input r4 as u32.public;
    call token_registry.aleo/transfer_private_to_public treasury.aleo r0 r2 into r5 r6;
    cast r1 r0 r4 r3 into r7 as stake_position.record;
    gte r2.amount r0 into r8;
    assert.eq r8 true;
    async stake r6 r0 r1 r3 r4 into r9;
    output r5 as token_registry.aleo/Token.record;
    output r7 as stake_position.record;
    output r9 as eclipse_lending_treasury.aleo/stake.future;

finalize stake:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as u128.public;
    input r4 as u32.public;
    await r0;
    get.or_use eclipse_lending_usda_vault_11.aleo/cumulated_fees[44556677889917field] 0u128 into r5;
    assert.eq r5 r3;
    gt r1 0u128 into r6;
    assert.eq r6 true;
    assert.eq r4 block.height;
    get.or_use total_staked[1234567898field] 0u128 into r7;
    add r7 r1 into r8;
    set r8 into total_staked[1234567898field];

function withdraw:
    input r0 as u128.private;
    input r1 as address.private;
    input r2 as stake_position.record;
    input r3 as u32.public;
    input r4 as u128.public;
    sub r2.amount r0 into r5;
    cast r2.owner r5 r3 r4 into r6 as stake_position.record;
    lte r0 r2.amount into r7;
    assert.eq r7 true;
    call token_registry.aleo/transfer_public_to_private 1234567898field r1 r0 false into r8 r9;
    async withdraw r9 r0 r1 r3 r4 into r10;
    output r8 as token_registry.aleo/Token.record;
    output r6 as stake_position.record;
    output r10 as eclipse_lending_treasury.aleo/withdraw.future;

finalize withdraw:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as u32.public;
    input r4 as u128.public;
    await r0;
    assert.eq r3 block.height;
    gt r1 0u128 into r5;
    assert.eq r5 true;
    get.or_use eclipse_lending_usda_vault_11.aleo/cumulated_fees[44556677889917field] 0u128 into r6;
    assert.eq r6 r4;
    get.or_use total_staked[1234567898field] 0u128 into r7;
    sub r7 r1 into r8;
    set r8 into total_staked[1234567898field];

function claim:
    input r0 as stake_position.record;
    input r1 as address.private;
    input r2 as u32.public;
    input r3 as u128.public;
    input r4 as u128.public;
    cast r0.owner r0.amount r2 r3 into r5 as stake_position.record;
    sub r3 r0.total_fees into r6;
    mul r6 r0.amount into r7;
    div r7 r4 into r8;
    cast r8 into r9 as u64;
    call credits.aleo/transfer_public_to_private r1 r9 into r10 r11;
    async claim r11 r2 r3 r4 into r12;
    output r5 as stake_position.record;
    output r10 as credits.aleo/credits.record;
    output r12 as eclipse_lending_treasury.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as u32.public;
    input r2 as u128.public;
    input r3 as u128.public;
    await r0;
    assert.eq r1 block.height;
    get.or_use eclipse_lending_usda_vault_11.aleo/cumulated_fees[44556677889917field] 0u128 into r4;
    assert.eq r4 r2;
    get.or_use total_staked[1234567898field] 0u128 into r5;
    assert.eq r5 r3;
