import credits.aleo;
import token_registry.aleo;
import eclipse_oracle_feed.aleo;
import eclipse_oracle_staking_2.aleo;
import eclipse_oracle_submit_2.aleo;
import eclipse_oracle_aggregate_2.aleo;

program eclipse_lending_usda_vault_4.aleo;

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

function initialize:
    input r0 as address.public;
    is.eq r0 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r1;
    assert.eq r1 true;
    call token_registry.aleo/register_token 44556677889911field 567137312326300096786987u128 1480805620u128 18u8 1000000000000000000u128 false aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r2;
    async initialize r2 into r3;
    output r3 as eclipse_lending_usda_vault_4.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;
    set 0u64 into next_id[0field];

function deposit:
    input r0 as u64.public;
    input r1 as u128.public;
    input r2 as u64.public;
    input r3 as address.private;
    input r4 as credits.aleo/credits.record;
    call credits.aleo/transfer_private_to_public r4 eclipse_lending_usda_vault_4.aleo r0 into r5 r6;
    add r2 1u64 into r7;
    cast r3 r7 into r8 as Position.record;
    async deposit r6 r7 r0 r1 r3 into r9;
    output r8 as Position.record;
    output r5 as credits.aleo/credits.record;
    output r9 as eclipse_lending_usda_vault_4.aleo/deposit.future;

finalize deposit:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u128.public;
    input r4 as address.public;
    get.or_use next_id[44556677889911field] 0u64 into r5;
    add r5 1u64 into r6;
    is.eq r1 r6 into r7;
    assert.eq r7 true;
    add r5 1u64 into r8;
    set r8 into next_id[44556677889911field];
    await r0;
    cast r2 into r9 as u128;
    mul r9 r3 into r10;
    mul r10 125u128 into r11;
    div r11 100u128 into r12;
    mul r10 125u128 into r13;
    div r13 100u128 into r14;
    cast r2 into r15 as u128;
    cast block.height into r16 as u64;
    cast r15 0u128 r12 r14 r16 into r17 as PositionMeta;
    set r17 into metas[r1];
