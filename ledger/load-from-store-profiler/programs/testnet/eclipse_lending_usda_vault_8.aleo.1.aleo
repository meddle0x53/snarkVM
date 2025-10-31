import credits.aleo;
import token_registry.aleo;
import eclipse_oracle_feed.aleo;
import eclipse_oracle_staking_4.aleo;
import eclipse_oracle_submit_4.aleo;
import eclipse_oracle_aggregate_4.aleo;

program eclipse_lending_usda_vault_8.aleo;

record Position:
    owner as address.private;
    id as u64.private;

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

struct PositionMeta:
    coll_amt as u128;
    debt_amt as u128;
    price_liq as u128;
    max_debt as u128;
    t_last as u64;

mapping liquidated_ids:
    key as u64.public;
    value as boolean.public;

mapping metas:
    key as u64.public;
    value as PositionMeta.public;

mapping next_id:
    key as field.public;
    value as u64.public;

mapping total_fees:
    key as field.public;
    value as u128.public;

mapping total_collateral:
    key as field.public;
    value as u128.public;

mapping liquidation_refund:
    key as u64.public;
    value as u128.public;

mapping liquidation_collateral:
    key as u64.public;
    value as u128.public;

function initialize:
    input r0 as address.public;
    is.eq r0 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r1;
    assert.eq r1 true;
    call token_registry.aleo/register_token 44556677889914field 567137312326300096786987u128 1480805620u128 18u8 1000000000000000000000000u128 false aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r2;
    async initialize r2 into r3;
    output r3 as eclipse_lending_usda_vault_8.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;
    set 0u64 into next_id[0field];

function withdraw:
    input r0 as Position.record;
    input r1 as u128.public;
    input r2 as u64.public;
    is.eq r0.owner self.caller into r3;
    assert.eq r3 true;
    mul r2 99u64 into r4;
    div r4 100u64 into r5;
    call credits.aleo/transfer_public_to_private self.caller r5 into r6 r7;
    async withdraw r7 r0.id r1 r2 into r8;
    cast r0.owner r0.id into r9 as Position.record;
    output r9 as Position.record;
    output r6 as credits.aleo/credits.record;
    output r8 as eclipse_lending_usda_vault_8.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as u64.public;
    input r2 as u128.public;
    input r3 as u64.public;
    get eclipse_oracle_aggregate_4.aleo/latest_price[2field] into r4;
    is.eq r2 r4 into r5;
    assert.eq r5 true;
    await r0;
    get metas[r1] into r6;
    get.or_use liquidated_ids[r1] false into r7;
    not r7 into r8;
    assert.eq r8 true;
    cast r3 into r9 as u128;
    lte r9 r6.coll_amt into r10;
    assert.eq r10 true;
    sub r6.coll_amt r9 into r11;
    mul r11 r2 into r12;
    mul r12 75u128 into r13;
    div r13 100u128 into r14;
    lte r6.debt_amt r14 into r15;
    assert.eq r15 true;
    mul r11 85u128 into r16;
    div r16 100u128 into r17;
    cast block.height into r18 as u64;
    cast r11 r6.debt_amt r17 r14 r18 into r19 as PositionMeta;
    set r19 into metas[r1];
    cast r3 into r20 as u128;
    mul r20 1u128 into r21;
    div r21 100u128 into r22;
    get.or_use total_fees[44556677889914field] 0u128 into r23;
    add r23 r22 into r24;
    set r24 into total_fees[44556677889914field];
    get.or_use total_collateral[44556677889914field] 0u128 into r25;
    mul r9 r2 into r26;
    sub r25 r26 into r27;
    set r27 into total_collateral[44556677889914field];

function deposit:
    input r0 as u64.public;
    input r1 as u128.public;
    input r2 as u64.public;
    input r3 as address.private;
    input r4 as credits.aleo/credits.record;
    call credits.aleo/transfer_private_to_public r4 eclipse_lending_usda_vault_8.aleo r0 into r5 r6;
    add r2 1u64 into r7;
    cast r3 r7 into r8 as Position.record;
    async deposit r6 r7 r0 r1 into r9;
    output r8 as Position.record;
    output r5 as credits.aleo/credits.record;
    output r9 as eclipse_lending_usda_vault_8.aleo/deposit.future;

finalize deposit:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u128.public;
    get.or_use next_id[44556677889914field] 0u64 into r4;
    add r4 1u64 into r5;
    is.eq r1 r5 into r6;
    assert.eq r6 true;
    add r4 1u64 into r7;
    set r7 into next_id[44556677889914field];
    get eclipse_oracle_aggregate_4.aleo/latest_price[2field] into r8;
    is.eq r3 r8 into r9;
    assert.eq r9 true;
    await r0;
    cast r2 into r10 as u128;
    mul r10 r3 into r11;
    mul r11 85u128 into r12;
    div r12 100u128 into r13;
    mul r11 75u128 into r14;
    div r14 100u128 into r15;
    cast r2 into r16 as u128;
    cast block.height into r17 as u64;
    cast r16 0u128 r13 r15 r17 into r18 as PositionMeta;
    set r18 into metas[r1];
    get.or_use total_collateral[44556677889914field] 0u128 into r19;
    add r19 r11 into r20;
    set r20 into total_collateral[44556677889914field];

function mint:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as Position.record;
    is.eq r2.owner self.caller into r3;
    assert.eq r3 true;
    call token_registry.aleo/mint_private 44556677889914field self.caller r0 false 0u32 into r4 r5;
    async mint r5 r2.id r0 r1 into r6;
    cast r2.owner r2.id into r7 as Position.record;
    output r7 as Position.record;
    output r4 as token_registry.aleo/Token.record;
    output r6 as eclipse_lending_usda_vault_8.aleo/mint.future;

finalize mint:
    input r0 as token_registry.aleo/mint_private.future;
    input r1 as u64.public;
    input r2 as u128.public;
    input r3 as u128.public;
    gt r2 0u128 into r4;
    assert.eq r4 true;
    gt r3 0u128 into r5;
    assert.eq r5 true;
    get.or_use liquidated_ids[r1] false into r6;
    is.eq r6 false into r7;
    assert.eq r7 true;
    get eclipse_oracle_aggregate_4.aleo/latest_price[2field] into r8;
    is.eq r3 r8 into r9;
    assert.eq r9 true;
    await r0;
    get metas[r1] into r10;
    mul r10.coll_amt r3 into r11;
    add r10.debt_amt r2 into r12;
    mul r11 75u128 into r13;
    div r13 100u128 into r14;
    mul r11 85u128 into r15;
    div r15 100u128 into r16;
    cast block.height into r17 as u64;
    cast r10.coll_amt r12 r16 r14 r17 into r18 as PositionMeta;
    set r18 into metas[r1];

function burn:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as Position.record;
    input r3 as token_registry.aleo/Token.record;
    is.eq r2.owner self.caller into r4;
    assert.eq r4 true;
    call token_registry.aleo/burn_private r3 r0 into r5 r6;
    async burn r6 r2.id r0 r1 into r7;
    cast r2.owner r2.id into r8 as Position.record;
    output r8 as Position.record;
    output r5 as token_registry.aleo/Token.record;
    output r7 as eclipse_lending_usda_vault_8.aleo/burn.future;

finalize burn:
    input r0 as token_registry.aleo/burn_private.future;
    input r1 as u64.public;
    input r2 as u128.public;
    input r3 as u128.public;
    gt r2 0u128 into r4;
    assert.eq r4 true;
    gt r3 0u128 into r5;
    assert.eq r5 true;
    get.or_use liquidated_ids[r1] false into r6;
    is.eq r6 false into r7;
    assert.eq r7 true;
    get eclipse_oracle_aggregate_4.aleo/latest_price[2field] into r8;
    is.eq r3 r8 into r9;
    assert.eq r9 true;
    await r0;
    get metas[r1] into r10;
    gte r10.debt_amt r2 into r11;
    assert.eq r11 true;
    sub r10.debt_amt r2 into r12;
    mul r10.coll_amt r3 into r13;
    mul r13 75u128 into r14;
    div r14 100u128 into r15;
    mul r13 85u128 into r16;
    div r16 100u128 into r17;
    cast block.height into r18 as u64;
    cast r10.coll_amt r12 r17 r15 r18 into r19 as PositionMeta;
    set r19 into metas[r1];

function liquidate:
    input r0 as u64.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as token_registry.aleo/Token.record;
    call token_registry.aleo/burn_private r4 r2 into r5 r6;
    async liquidate r6 r0 r2 r1 into r7;
    output r5 as token_registry.aleo/Token.record;
    output r7 as eclipse_lending_usda_vault_8.aleo/liquidate.future;

finalize liquidate:
    input r0 as token_registry.aleo/burn_private.future;
    input r1 as u64.public;
    input r2 as u128.public;
    input r3 as u128.public;
    await r0;
    get eclipse_oracle_aggregate_4.aleo/latest_price[2field] into r4;
    is.eq r3 r4 into r5;
    assert.eq r5 true;
    get metas[r1] into r6;
    lte r3 r6.price_liq into r7;
    assert.eq r7 true;
    gt r2 r6.debt_amt into r8;
    sub r2 r6.debt_amt into r9;
    ternary r8 r9 0u128 into r10;
    set r10 into liquidation_refund[r1];
    set r6.coll_amt into liquidation_collateral[r1];
    remove metas[r1];
    set true into liquidated_ids[r1];

function claim_refund:
    input r0 as u64.public;
    input r1 as u128.public;
    call token_registry.aleo/mint_private 44556677889914field self.caller r1 false 0u32 into r2 r3;
    async claim_refund r3 r0 r1 into r4;
    output r2 as token_registry.aleo/Token.record;
    output r4 as eclipse_lending_usda_vault_8.aleo/claim_refund.future;

finalize claim_refund:
    input r0 as token_registry.aleo/mint_private.future;
    input r1 as u64.public;
    input r2 as u128.public;
    await r0;
    get.or_use liquidation_refund[r1] 0u128 into r3;
    is.eq r2 r3 into r4;
    assert.eq r4 true;
    remove liquidation_refund[r1];

function claim_collateral:
    input r0 as u64.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public_to_private self.caller r1 into r2 r3;
    async claim_collateral r3 r0 r1 into r4;
    output r2 as credits.aleo/credits.record;
    output r4 as eclipse_lending_usda_vault_8.aleo/claim_collateral.future;

finalize claim_collateral:
    input r0 as credits.aleo/transfer_public_to_private.future;
    input r1 as u64.public;
    input r2 as u64.public;
    await r0;
    get.or_use liquidation_collateral[r1] 0u128 into r3;
    cast r2 into r4 as u128;
    is.eq r4 r3 into r5;
    assert.eq r5 true;
    remove liquidation_collateral[r1];
    get.or_use total_collateral[44556677889914field] 0u128 into r6;
    cast r2 into r7 as u128;
    get eclipse_oracle_aggregate_4.aleo/latest_price[2field] into r8;
    mul r7 r8 into r9;
    sub r6 r9 into r10;
    set r10 into total_collateral[44556677889914field];

function claim_fees:
    input r0 as u64.public;
    input r1 as address.private;
    is.eq r1 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r2;
    assert.eq r2 true;
    call credits.aleo/transfer_public eclipse_lending_treasury.aleo r0 into r3;
    async claim_fees r3 r0 into r4;
    output r4 as eclipse_lending_usda_vault_8.aleo/claim_fees.future;

finalize claim_fees:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as u64.public;
    get.or_use total_fees[44556677889914field] 0u128 into r2;
    cast r1 into r3 as u128;
    is.eq r2 r3 into r4;
    assert.eq r4 true;
    await r0;
    set 0u128 into total_fees[44556677889914field];
