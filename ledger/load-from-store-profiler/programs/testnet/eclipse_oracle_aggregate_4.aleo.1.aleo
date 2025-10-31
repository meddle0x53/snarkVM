import eclipse_oracle_feed.aleo;
import credits.aleo;
import token_registry.aleo;
import eclipse_oracle_staking_4.aleo;
import eclipse_oracle_submit_4.aleo;

program eclipse_oracle_aggregate_4.aleo;

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

mapping latest_price:
    key as field.public;
    value as u128.public;

mapping proposal_median:
    key as field.public;
    value as u128.public;

mapping proposal_proposer:
    key as field.public;
    value as address.public;

mapping proposal_block:
    key as field.public;
    value as u32.public;

mapping proposal_slashed:
    key as field.public;
    value as boolean.public;

mapping aggregate_done:
    key as field.public;
    value as boolean.public;

mapping slasher:
    key as field.public;
    value as address.public;

mapping slasher_reward:
    key as field.public;
    value as u128.public;

mapping last_propose_block:
    key as field.public;
    value as u32.public;

function propose:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    async propose r0 r1 r2 into r3;
    output r3 as eclipse_oracle_aggregate_4.aleo/propose.future;

finalize propose:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    get.or_use eclipse_oracle_staking_4.aleo/provider_count[r0] 0u32 into r3;
    gte r3 6u32 into r4;
    assert.eq r4 true;
    get.or_use aggregate_done[r0] false into r5;
    not r5 into r6;
    assert.eq r6 true;
    get eclipse_oracle_feed.aleo/feeds[r0] into r7;
    not r7.paused into r8;
    assert.eq r8 true;
    cast r2 into r9 as field;
    add r0 r9 into r10;
    get.or_use eclipse_oracle_staking_4.aleo/stakes[r10] 0u128 into r11;
    cast r7.min_stake into r12 as u128;
    gte r11 r12 into r13;
    assert.eq r13 true;
    get.or_use last_propose_block[r0] 0u32 into r14;
    cast block.height into r15 as u64;
    cast r14 into r16 as u64;
    cast r7.aggregation_window into r17 as u64;
    add r16 r17 into r18;
    gte r15 r18 into r19;
    assert.eq r19 true;
    set block.height into last_propose_block[r0];
    gt r1 0u128 into r20;
    assert.eq r20 true;
    set r1 into proposal_median[r0];
    set r2 into proposal_proposer[r0];
    set block.height into proposal_block[r0];
    set false into proposal_slashed[r0];
    set false into aggregate_done[r0];

function slash_aggregator:
    input r0 as field.public;
    input r1 as address.public;
    call eclipse_oracle_staking_4.aleo/slash r0 r1 into r2;
    async slash_aggregator r2 r0 r1 self.caller into r3;
    output r3 as eclipse_oracle_aggregate_4.aleo/slash_aggregator.future;

finalize slash_aggregator:
    input r0 as eclipse_oracle_staking_4.aleo/slash.future;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    get proposal_proposer[r1] into r4;
    is.eq r2 r4 into r5;
    assert.eq r5 true;
    get eclipse_oracle_feed.aleo/feeds[r1] into r6;
    get proposal_block[r1] into r7;
    add r7 r6.challenge_window into r8;
    lte block.height r8 into r9;
    assert.eq r9 true;
    get.or_use proposal_slashed[r1] false into r10;
    not r10 into r11;
    assert.eq r11 true;
    get proposal_median[r1] into r12;
    cast r6.slashing_threshold into r13 as u128;
    get.or_use eclipse_oracle_staking_4.aleo/provider_count[r1] 0u32 into r14;
    add r1 0field into r15;
    get eclipse_oracle_staking_4.aleo/provider_list[r15] into r16;
    cast r16 into r17 as field;
    add r1 r17 into r18;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r18] 0u128 into r19;
    gte r19 r12 into r20;
    sub r19 r12 into r21;
    sub r12 r19 into r22;
    ternary r20 r21 r22 into r23;
    lt 0u32 r14 into r24;
    lte r23 r13 into r25;
    and r24 r25 into r26;
    ternary r26 1u32 0u32 into r27;
    add r1 1field into r28;
    get eclipse_oracle_staking_4.aleo/provider_list[r28] into r29;
    cast r29 into r30 as field;
    add r1 r30 into r31;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r31] 0u128 into r32;
    gte r32 r12 into r33;
    sub r32 r12 into r34;
    sub r12 r32 into r35;
    ternary r33 r34 r35 into r36;
    lt 1u32 r14 into r37;
    lte r36 r13 into r38;
    and r37 r38 into r39;
    ternary r39 1u32 0u32 into r40;
    add r1 2field into r41;
    get eclipse_oracle_staking_4.aleo/provider_list[r41] into r42;
    cast r42 into r43 as field;
    add r1 r43 into r44;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r44] 0u128 into r45;
    gte r45 r12 into r46;
    sub r45 r12 into r47;
    sub r12 r45 into r48;
    ternary r46 r47 r48 into r49;
    lt 2u32 r14 into r50;
    lte r49 r13 into r51;
    and r50 r51 into r52;
    ternary r52 1u32 0u32 into r53;
    add r1 3field into r54;
    get eclipse_oracle_staking_4.aleo/provider_list[r54] into r55;
    cast r55 into r56 as field;
    add r1 r56 into r57;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r57] 0u128 into r58;
    gte r58 r12 into r59;
    sub r58 r12 into r60;
    sub r12 r58 into r61;
    ternary r59 r60 r61 into r62;
    lt 3u32 r14 into r63;
    lte r62 r13 into r64;
    and r63 r64 into r65;
    ternary r65 1u32 0u32 into r66;
    add r1 4field into r67;
    get eclipse_oracle_staking_4.aleo/provider_list[r67] into r68;
    cast r68 into r69 as field;
    add r1 r69 into r70;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r70] 0u128 into r71;
    gte r71 r12 into r72;
    sub r71 r12 into r73;
    sub r12 r71 into r74;
    ternary r72 r73 r74 into r75;
    lt 4u32 r14 into r76;
    lte r75 r13 into r77;
    and r76 r77 into r78;
    ternary r78 1u32 0u32 into r79;
    add r1 5field into r80;
    get eclipse_oracle_staking_4.aleo/provider_list[r80] into r81;
    cast r81 into r82 as field;
    add r1 r82 into r83;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r83] 0u128 into r84;
    gte r84 r12 into r85;
    sub r84 r12 into r86;
    sub r12 r84 into r87;
    ternary r85 r86 r87 into r88;
    lt 5u32 r14 into r89;
    lte r88 r13 into r90;
    and r89 r90 into r91;
    ternary r91 1u32 0u32 into r92;
    add r1 6field into r93;
    get eclipse_oracle_staking_4.aleo/provider_list[r93] into r94;
    cast r94 into r95 as field;
    add r1 r95 into r96;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r96] 0u128 into r97;
    gte r97 r12 into r98;
    sub r97 r12 into r99;
    sub r12 r97 into r100;
    ternary r98 r99 r100 into r101;
    lt 6u32 r14 into r102;
    lte r101 r13 into r103;
    and r102 r103 into r104;
    ternary r104 1u32 0u32 into r105;
    add r1 7field into r106;
    get eclipse_oracle_staking_4.aleo/provider_list[r106] into r107;
    cast r107 into r108 as field;
    add r1 r108 into r109;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r109] 0u128 into r110;
    gte r110 r12 into r111;
    sub r110 r12 into r112;
    sub r12 r110 into r113;
    ternary r111 r112 r113 into r114;
    lt 7u32 r14 into r115;
    lte r114 r13 into r116;
    and r115 r116 into r117;
    ternary r117 1u32 0u32 into r118;
    add r27 r40 into r119;
    add r119 r53 into r120;
    add r120 r66 into r121;
    add r121 r79 into r122;
    add r122 r92 into r123;
    add r123 r105 into r124;
    add r124 r118 into r125;
    lt r125 6u32 into r126;
    branch.eq r126 false to end_then_0_0;
    await r0;
    set true into proposal_slashed[r1];
    set r3 into slasher[r1];
    cast r6.min_stake into r127 as u128;
    set r127 into slasher_reward[r1];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    assert.eq false true;

function finalize_aggregate:
    input r0 as field.public;
    input r1 as address.public;
    call token_registry.aleo/mint_public 12345678987field r1 1u128 0u32 into r2;
    async finalize_aggregate r2 r0 r1 into r3;
    output r3 as eclipse_oracle_aggregate_4.aleo/finalize_aggregate.future;

finalize finalize_aggregate:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as field.public;
    input r2 as address.public;
    get.or_use aggregate_done[r1] false into r3;
    not r3 into r4;
    assert.eq r4 true;
    get eclipse_oracle_feed.aleo/feeds[r1] into r5;
    get proposal_block[r1] into r6;
    add r6 r5.challenge_window into r7;
    gt block.height r7 into r8;
    assert.eq r8 true;
    get.or_use proposal_slashed[r1] false into r9;
    not r9 into r10;
    assert.eq r10 true;
    cast r2 into r11 as field;
    add r1 r11 into r12;
    get.or_use eclipse_oracle_staking_4.aleo/stakes[r12] 0u128 into r13;
    cast r5.min_stake into r14 as u128;
    gte r13 r14 into r15;
    assert.eq r15 true;
    get proposal_median[r1] into r16;
    set r16 into latest_price[r1];
    await r0;

function claim_slash:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    call token_registry.aleo/mint_public 12345678987field r1 r2 0u32 into r3;
    async claim_slash r3 r0 r1 r2 into r4;
    output r4 as eclipse_oracle_aggregate_4.aleo/claim_slash.future;

finalize claim_slash:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as u128.public;
    get slasher[r1] into r4;
    is.eq r2 r4 into r5;
    assert.eq r5 true;
    get slasher_reward[r1] into r6;
    is.eq r3 r6 into r7;
    assert.eq r7 true;
    await r0;
    set 0u128 into slasher_reward[r1];
    set aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into slasher[r1];

function slash_provider:
    input r0 as field.public;
    input r1 as address.public;
    call eclipse_oracle_staking_4.aleo/slash r0 r1 into r2;
    async slash_provider r2 r0 r1 into r3;
    output r3 as eclipse_oracle_aggregate_4.aleo/slash_provider.future;

finalize slash_provider:
    input r0 as eclipse_oracle_staking_4.aleo/slash.future;
    input r1 as field.public;
    input r2 as address.public;
    get eclipse_oracle_feed.aleo/feeds[r1] into r3;
    not r3.paused into r4;
    assert.eq r4 true;
    get proposal_median[r1] into r5;
    cast r2 into r6 as field;
    add r1 r6 into r7;
    get.or_use eclipse_oracle_submit_4.aleo/temp_price[r7] 0u128 into r8;
    gte r8 r5 into r9;
    sub r8 r5 into r10;
    sub r5 r8 into r11;
    ternary r9 r10 r11 into r12;
    cast r3.slashing_threshold into r13 as u128;
    gt r12 r13 into r14;
    assert.eq r14 true;
    await r0;
