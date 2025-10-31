import credits.aleo;
import token_registry.aleo;

program aanya_vesting_token.aleo;

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

record AccessPermission:
    owner as address.private;

struct VestingSchedule:
    block_duration as u32;
    start_height as u32;
    number_of_interval as u32;
    total_amount as u128;
    claimed_amount as u128;
    token_id as field;

mapping vesting_schedule:
    key as address.public;
    value as VestingSchedule.public;

mapping registered_token:
    key as field.public;
    value as boolean.public;

function create_access_record:
    input r0 as address.private;
    assert.eq self.caller aleo1v7nr80exf6p2709py6xf692v9f69l5cm230w23tz2p9fhx954qpq7cm7p4;
    cast r0 into r1 as AccessPermission.record;
    output r1 as AccessPermission.record;

function enroll_token:
    input r0 as field.private;
    assert.eq self.caller aleo1v7nr80exf6p2709py6xf692v9f69l5cm230w23tz2p9fhx954qpq7cm7p4;
    async enroll_token r0 into r1;
    output r1 as aanya_vesting_token.aleo/enroll_token.future;

finalize enroll_token:
    input r0 as field.public;
    get token_registry.aleo/registered_tokens[r0] into r1;
    get.or_use registered_token[r0] false into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into registered_token[r0];

function add_deposit:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as u32.private;
    input r3 as u32.private;
    input r4 as u32.private;
    input r5 as field.private;
    assert.eq self.caller aleo1v7nr80exf6p2709py6xf692v9f69l5cm230w23tz2p9fhx954qpq7cm7p4;
    call token_registry.aleo/transfer_public r5 aanya_vesting_token.aleo r1 into r6;
    hash.bhp256 r0 into r7 as address;
    async add_deposit r1 r7 r2 r3 r4 r5 r6 into r8;
    output r8 as aanya_vesting_token.aleo/add_deposit.future;

finalize add_deposit:
    input r0 as u128.public;
    input r1 as address.public;
    input r2 as u32.public;
    input r3 as u32.public;
    input r4 as u32.public;
    input r5 as field.public;
    input r6 as token_registry.aleo/transfer_public.future;
    await r6;
    get registered_token[r5] into r7;
    cast 0u32 0u32 0u32 0u128 0u128 r5 into r8 as VestingSchedule;
    get.or_use vesting_schedule[r1] r8 into r9;
    add r9.total_amount r0 into r10;
    gt r3 block.height into r11;
    assert.eq r11 true;
    cast r2 r3 r4 r10 r9.claimed_amount r5 into r12 as VestingSchedule;
    set r12 into vesting_schedule[r1];

function redeem_tokens:
    input r0 as AccessPermission.record;
    input r1 as u128.private;
    input r2 as field.private;
    input r3 as boolean.private;
    call token_registry.aleo/transfer_public_to_private r2 r0.owner r1 r3 into r4 r5;
    hash.bhp256 r0.owner into r6 as address;
    cast r0.owner into r7 as AccessPermission.record;
    async redeem_tokens r1 r2 r6 r5 into r8;
    output r4 as token_registry.aleo/Token.record;
    output r7 as AccessPermission.record;
    output r8 as aanya_vesting_token.aleo/redeem_tokens.future;

finalize redeem_tokens:
    input r0 as u128.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    await r3;
    get vesting_schedule[r2] into r4;
    add r4.claimed_amount r0 into r5;
    lte r5 r4.total_amount into r6;
    assert.eq r6 true;
    gt block.height r4.start_height into r7;
    assert.eq r7 true;
    sub block.height r4.start_height into r8;
    div r4.block_duration r4.number_of_interval into r9;
    gt r8 r9 into r10;
    assert.eq r10 true;
    cast r4.number_of_interval into r11 as u128;
    mul r4.total_amount r11 into r12;
    cast r4.block_duration into r13 as u128;
    div r12 r13 into r14;
    is.eq r0 r14 into r15;
    assert.eq r15 true;
    cast r4.block_duration r4.start_height r4.number_of_interval r4.total_amount r5 r4.token_id into r16 as VestingSchedule;
    set r16 into vesting_schedule[r2];
