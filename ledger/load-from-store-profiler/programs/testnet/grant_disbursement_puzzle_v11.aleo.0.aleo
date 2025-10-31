import credits.aleo;
import time_oracle.aleo;

program grant_disbursement_puzzle_v11.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;

struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;

struct Grant:
    credits_amount as u64;
    recipient_rewards_address as address;
    recipient_principal_address as address;
    start_timestamp as u64;
    cliff_timestamp as u64;
    fully_vested_timestamp as u64;
    is_processed as boolean;

mapping grants:
    key as u8.public;
    value as Grant.public;

function initialize:
    async initialize into r0;
    output r0 as grant_disbursement_puzzle_v11.aleo/initialize.future;

finalize initialize:
    contains grants[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    cast 10000000000u64 aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0 aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0 1725479626u64 3000000001u64 4000000000u64 false into r2 as Grant;
    set r2 into grants[0u8];

function process_grant:
    input r0 as u8.private;
    input r1 as u64.private;
    call credits.aleo/transfer_public_as_signer grant_disbursement_puzzle_v11.aleo r1 into r2;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f grant_disbursement_puzzle_v11.aleo r1 into r3;
    async process_grant r2 r3 r0 r1 into r4;
    output r4 as grant_disbursement_puzzle_v11.aleo/process_grant.future;

finalize process_grant:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as u8.public;
    input r3 as u64.public;
    await r0;
    await r1;
    get grants[r2] into r4;
    assert.eq r3 r4.credits_amount;
    not r4.is_processed into r5;
    assert.eq r5 true;
    cast r4.credits_amount r4.recipient_rewards_address r4.recipient_principal_address r4.start_timestamp r4.cliff_timestamp r4.fully_vested_timestamp true into r6 as Grant;
    set r6 into grants[r2];

function withdraw_rewards:
    input r0 as u8.private;
    input r1 as u64.private;
    assert.eq self.caller aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0;
    call credits.aleo/unbond_public grant_disbursement_puzzle_v11.aleo r1 into r2;
    async withdraw_rewards r2 r0 r1 into r3;
    output r3 as grant_disbursement_puzzle_v11.aleo/withdraw_rewards.future;

finalize withdraw_rewards:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    await r0;
    get grants[r1] into r3;
    get time_oracle.aleo/timestamp[0u8] into r4;
    lt r4 r3.cliff_timestamp into r5;
    assert.eq r5 true;
    get credits.aleo/bonded[grant_disbursement_puzzle_v11.aleo] into r6;
    sub r6.microcredits r2 into r7;
    gt r7 r3.credits_amount into r8;
    assert.eq r8 true;

function withdraw_principal:
    input r0 as u8.private;
    input r1 as u64.private;
    assert.eq self.caller aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0;
    call credits.aleo/unbond_public grant_disbursement_puzzle_v11.aleo r1 into r2;
    async withdraw_principal r2 r0 r1 into r3;
    output r3 as grant_disbursement_puzzle_v11.aleo/withdraw_principal.future;

finalize withdraw_principal:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    await r0;
    get grants[r1] into r3;
    get time_oracle.aleo/timestamp[0u8] into r4;
    gte r4 r3.cliff_timestamp into r5;
    assert.eq r5 true;
    sub r4 r3.start_timestamp into r6;
    sub r3.fully_vested_timestamp r3.start_timestamp into r7;
    cast r3.credits_amount into r8 as u128;
    cast r6 into r9 as u128;
    mul r8 r9 into r10;
    cast r7 into r11 as u128;
    div r10 r11 into r12;
    cast r2 into r13 as u128;
    lte r13 r12 into r14;
    assert.eq r14 true;

function claim_withdrawal_public:
    input r0 as u64.private;
    call credits.aleo/claim_unbond_public grant_disbursement_puzzle_v11.aleo into r1;
    call credits.aleo/transfer_public aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0 r0 into r2;
    async claim_withdrawal_public r1 r2 into r3;
    output r3 as grant_disbursement_puzzle_v11.aleo/claim_withdrawal_public.future;

finalize claim_withdrawal_public:
    input r0 as credits.aleo/claim_unbond_public.future;
    input r1 as credits.aleo/transfer_public.future;
    await r0;
    await r1;
