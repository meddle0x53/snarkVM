import credits.aleo;
import token_registry.aleo;
import official_oracle_v2.aleo;

program learn_and_earn_token_3515.aleo;

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

struct UniqueID:
    chunk_1 as u128;
    chunk_2 as u128;

struct PcrValues:
    pcr_0_chunk_1 as u128;
    pcr_0_chunk_2 as u128;
    pcr_0_chunk_3 as u128;
    pcr_1_chunk_1 as u128;
    pcr_1_chunk_2 as u128;
    pcr_1_chunk_3 as u128;
    pcr_2_chunk_1 as u128;
    pcr_2_chunk_2 as u128;
    pcr_2_chunk_3 as u128;

struct AttestedData:
    data as u128;
    attestation_timestamp as u128;

struct PositionData:
    block_index as u8;
    shift_a as u8;
    shift_b as u8;
    mask_a as u128;
    mask_b as u128;

struct DataChunk:
    f0 as u128;
    f1 as u128;
    f2 as u128;
    f3 as u128;
    f4 as u128;
    f5 as u128;
    f6 as u128;
    f7 as u128;
    f8 as u128;
    f9 as u128;
    f10 as u128;
    f11 as u128;
    f12 as u128;
    f13 as u128;
    f14 as u128;
    f15 as u128;
    f16 as u128;
    f17 as u128;
    f18 as u128;
    f19 as u128;
    f20 as u128;
    f21 as u128;
    f22 as u128;
    f23 as u128;
    f24 as u128;
    f25 as u128;
    f26 as u128;
    f27 as u128;
    f28 as u128;
    f29 as u128;
    f30 as u128;
    f31 as u128;

struct Report:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;
    c8 as DataChunk;
    c9 as DataChunk;

struct ReportData:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;

record Compensation:
    owner as address.private;
    amount as u128.private;
    currency as u128.private;
    price_limit as u128.private;
    expiry_block as u32.private;

mapping has_minted:
    key as u8.public;
    value as boolean.public;

mapping total_committed:
    key as u8.public;
    value as u128.public;

mapping expiry_schedule:
    key as u32.public;
    value as u128.public;

function initialize:
    assert.eq self.caller aleo1kmzwjeprmskjvhyjtmevq9fkanda57fn0af9fpe7830psw59dvrskmmdaj;
    call token_registry.aleo/register_token 619083925159field 71619063553950105623552u128 71619063553950105623552u128 6u8 1000000000000000u128 false learn_and_earn_token_3515.aleo into r0;
    async initialize r0 into r1;
    output r1 as learn_and_earn_token_3515.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function setup_treasury:
    assert.eq self.caller aleo1kmzwjeprmskjvhyjtmevq9fkanda57fn0af9fpe7830psw59dvrskmmdaj;
    call token_registry.aleo/mint_public 619083925159field learn_and_earn_token_3515.aleo 1000000000000000u128 4294967295u32 into r0;
    async setup_treasury r0 into r1;
    output r1 as learn_and_earn_token_3515.aleo/setup_treasury.future;

finalize setup_treasury:
    input r0 as token_registry.aleo/mint_public.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

closure isValidCurrency:
    input r0 as u128;
    is.eq r0 325436984254736568690754472542545613141u128 into r1;
    is.eq r0 298333406399166460220216814461649767877u128 into r2;
    or r1 r2 into r3;
    is.eq r0 77627430694699498847744475143514157246u128 into r4;
    or r3 r4 into r5;
    output r5 as boolean;

function issue_agreement:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as u128.private;
    input r3 as u128.private;
    input r4 as u32.private;
    assert.eq self.caller aleo1kmzwjeprmskjvhyjtmevq9fkanda57fn0af9fpe7830psw59dvrskmmdaj;
    gt r1 0u128 into r5;
    assert.eq r5 true;
    call isValidCurrency r2 into r6;
    assert.eq r6 true;
    cast r0 r1 r2 r3 r4 into r7 as Compensation.record;
    async issue_agreement r1 r4 into r8;
    output r7 as Compensation.record;
    output r8 as learn_and_earn_token_3515.aleo/issue_agreement.future;

finalize issue_agreement:
    input r0 as u128.public;
    input r1 as u32.public;
    contains has_minted[0u8] into r2;
    assert.eq r2 true;
    gt r1 block.height into r3;
    assert.eq r3 true;
    get.or_use total_committed[0u8] 0u128 into r4;
    add r4 r0 into r5;
    lte r5 1000000000000000u128 into r6;
    assert.eq r6 true;
    set r5 into total_committed[0u8];
    get.or_use expiry_schedule[r1] 0u128 into r7;
    add r7 r0 into r8;
    set r8 into expiry_schedule[r1];

function claim:
    input r0 as Compensation.record;
    assert.eq self.caller r0.owner;
    call token_registry.aleo/transfer_public 619083925159field r0.owner r0.amount into r1;
    async claim r0.amount r0.currency r0.price_limit r0.expiry_block r1 into r2;
    output r2 as learn_and_earn_token_3515.aleo/claim.future;

finalize claim:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u32.public;
    input r4 as token_registry.aleo/transfer_public.future;
    gte r3 block.height into r5;
    assert.eq r5 true;
    get official_oracle_v2.aleo/sgx_attested_data[r1] into r6;
    contains official_oracle_v2.aleo/nitro_attested_data[r1] into r7;
    branch.eq r7 false to end_then_0_0;
    get official_oracle_v2.aleo/nitro_attested_data[r1] into r8;
    gte r6.attestation_timestamp r8.attestation_timestamp into r9;
    ternary r9 r6.data r8.data into r10;
    lt r10 r2 into r11;
    assert.eq r11 true;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    lt r6.data r2 into r12;
    assert.eq r12 true;
    position end_otherwise_0_1;
    get expiry_schedule[r3] into r13;
    sub r13 r0 into r14;
    is.eq r14 0u128 into r15;
    branch.eq r15 false to end_then_0_2;
    remove expiry_schedule[r3];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    set r14 into expiry_schedule[r3];
    position end_otherwise_0_3;
    await r4;

function cancel:
    input r0 as u32.private;
    async cancel r0 into r1;
    output r1 as learn_and_earn_token_3515.aleo/cancel.future;

finalize cancel:
    input r0 as u32.public;
    lt r0 block.height into r1;
    assert.eq r1 true;
    get.or_use expiry_schedule[r0] 0u128 into r2;
    gt r2 0u128 into r3;
    branch.eq r3 false to end_then_0_4;
    remove expiry_schedule[r0];
    get total_committed[0u8] into r4;
    sub r4 r2 into r5;
    set r5 into total_committed[0u8];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    position end_otherwise_0_5;

function get_token_hash:
    input r0 as address.private;
    cast r0 619083925159field into r1 as TokenOwner;
    hash.bhp256 r1 into r2 as field;
    output r2 as field.public;
