import eclipse_oracle_feed.aleo;
import credits.aleo;
import token_registry.aleo;
import eclipse_oracle_staking_4.aleo;

program eclipse_oracle_submit_4.aleo;

struct FeedConfig:
    creator as address;
    min_stake as u64;
    slashing_threshold as u64;
    aggregation_window as u32;
    challenge_window as u32;
    paused as boolean;

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

mapping temp_price:
    key as field.public;
    value as u128.public;

mapping last_ts:
    key as field.public;
    value as u64.public;

mapping provider_pending_reward:
    key as address.public;
    value as u16.public;

function submit_price:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    async submit_price r0 r1 r2 into r3;
    output r3 as eclipse_oracle_submit_4.aleo/submit_price.future;

finalize submit_price:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    get eclipse_oracle_feed.aleo/feeds[r0] into r3;
    not r3.paused into r4;
    assert.eq r4 true;
    cast r2 into r5 as field;
    add r0 r5 into r6;
    get.or_use eclipse_oracle_staking_4.aleo/stakes[r6] 0u128 into r7;
    gt r7 0u128 into r8;
    assert.eq r8 true;
    cast block.height into r9 as u64;
    get.or_use last_ts[r6] 0u64 into r10;
    gt r9 r10 into r11;
    assert.eq r11 true;
    is.neq r10 0u64 into r12;
    branch.eq r12 false to end_then_0_0;
    sub r9 r10 into r13;
    cast r3.aggregation_window into r14 as u64;
    lte r13 r14 into r15;
    assert.eq r15 true;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    gt r1 0u128 into r16;
    assert.eq r16 true;
    set r9 into last_ts[r6];
    set r1 into temp_price[r6];
    get.or_use provider_pending_reward[r2] 0u16 into r17;
    add r17 1u16 into r18;
    set r18 into provider_pending_reward[r2];

function claim_pending_reward:
    input r0 as address.public;
    input r1 as u16.public;
    is.eq r0 self.caller into r2;
    assert.eq r2 true;
    cast r1 into r3 as u128;
    call token_registry.aleo/mint_public 12345678987field r0 r3 0u32 into r4;
    async claim_pending_reward r4 r0 r1 into r5;
    output r5 as eclipse_oracle_submit_4.aleo/claim_pending_reward.future;

finalize claim_pending_reward:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as address.public;
    input r2 as u16.public;
    get.or_use provider_pending_reward[r1] 0u16 into r3;
    gt r3 0u16 into r4;
    assert.eq r4 true;
    is.eq r3 r2 into r5;
    assert.eq r5 true;
    set 0u16 into provider_pending_reward[r1];
    await r0;
