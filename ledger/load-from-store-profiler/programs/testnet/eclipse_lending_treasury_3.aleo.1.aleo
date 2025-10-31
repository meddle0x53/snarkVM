import credits.aleo;
import token_registry.aleo;
import eclipse_oracle_feed.aleo;
import eclipse_oracle_staking_4.aleo;
import eclipse_oracle_submit_4.aleo;
import eclipse_oracle_aggregate_4.aleo;
import eclipse_lending_usda_vault_11.aleo;

program eclipse_lending_treasury_3.aleo;

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
    call token_registry.aleo/transfer_private_to_public eclipse_lending_treasury_3.aleo r0 r2 into r5 r6;
    is.eq r5.token_id 1234567898field into r7;
    assert.eq r7 true;
    cast r1 r0 r4 r3 into r8 as stake_position.record;
    gte r2.amount r0 into r9;
    assert.eq r9 true;
    async stake r6 r0 r1 r3 r4 into r10;
    output r5 as token_registry.aleo/Token.record;
    output r8 as stake_position.record;
    output r10 as eclipse_lending_treasury_3.aleo/stake.future;

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
    add r4 60u32 into r7;
    lte block.height r7 into r8;
    assert.eq r8 true;
    gte block.height r4 into r9;
    assert.eq r9 true;
    get.or_use total_staked[1234567898field] 0u128 into r10;
    add r10 r1 into r11;
    set r11 into total_staked[1234567898field];

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
    output r10 as eclipse_lending_treasury_3.aleo/withdraw.future;

finalize withdraw:
    input r0 as token_registry.aleo/transfer_public_to_private.future;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as u32.public;
    input r4 as u128.public;
    await r0;
    add r3 60u32 into r5;
    lte block.height r5 into r6;
    assert.eq r6 true;
    gte block.height r3 into r7;
    assert.eq r7 true;
    gt r1 0u128 into r8;
    assert.eq r8 true;
    get.or_use eclipse_lending_usda_vault_11.aleo/cumulated_fees[44556677889917field] 0u128 into r9;
    assert.eq r9 r4;
    get.or_use total_staked[1234567898field] 0u128 into r10;
    sub r10 r1 into r11;
    set r11 into total_staked[1234567898field];

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
    output r12 as eclipse_lending_treasury_3.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as u32.public;
    input r2 as u128.public;
    input r3 as u128.public;
    await r0;
    add r1 60u32 into r4;
    lte block.height r4 into r5;
    assert.eq r5 true;
    gte block.height r1 into r6;
    assert.eq r6 true;
    get.or_use eclipse_lending_usda_vault_11.aleo/cumulated_fees[44556677889917field] 0u128 into r7;
    assert.eq r7 r2;
    get.or_use total_staked[1234567898field] 0u128 into r8;
    assert.eq r8 r3;
