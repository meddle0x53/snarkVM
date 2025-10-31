import credits.aleo;
import staking_v1.aleo;
import staker_v1_b.aleo;
import multisig_v1x1.aleo;

program staker_multisig_v1x1_b.aleo;

struct Settings:
    unstake_wait as u32;
    stake_paused as boolean;
    global_paused as boolean;
    max_reward_per_notify as u64;
    protocol_fee as u16;
    fee_account as address;
    fixed_stakers as boolean;

struct Operation:
    program_id as address;
    op_type as u8;
    params as field;
    op_salt as u64;
    delay as u32;

struct Request:
    operation as Operation;
    multisig as address;

struct SetOperatorParams:
    operator as address;
    flag as boolean;

function set_operator:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as u64.public;
    input r3 as [address; 3u32].public;
    input r4 as [signature; 3u32].private;
    cast r0 r1 into r5 as SetOperatorParams;
    hash.bhp256 r5 into r6 as field;
    cast staker_multisig_v1x1_b.aleo 3u8 r6 r2 0u32 into r7 as Operation;
    call multisig_v1x1.aleo/new_request r7 true r3 r4 into r8;
    call staker_v1_b.aleo/set_operator r0 r1 into r9;
    async set_operator r8 r9 into r10;
    output r10 as staker_multisig_v1x1_b.aleo/set_operator.future;

finalize set_operator:
    input r0 as multisig_v1x1.aleo/new_request.future;
    input r1 as staker_v1_b.aleo/set_operator.future;
    await r0;
    await r1;

function add_admin:
    input r0 as address.public;
    input r1 as u64.public;
    hash.bhp256 r0 into r2 as field;
    cast staker_multisig_v1x1_b.aleo 1u8 r2 r1 1200u32 into r3 as Operation;
    call multisig_v1x1.aleo/execute r3 into r4;
    call staker_v1_b.aleo/set_admin r0 true into r5;
    async add_admin r4 r5 into r6;
    output r6 as staker_multisig_v1x1_b.aleo/add_admin.future;

finalize add_admin:
    input r0 as multisig_v1x1.aleo/execute.future;
    input r1 as staker_v1_b.aleo/set_admin.future;
    await r0;
    await r1;

function remove_admin:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as [address; 3u32].public;
    input r3 as [signature; 3u32].private;
    assert.neq r0 staker_multisig_v1x1_b.aleo;
    hash.bhp256 r0 into r4 as field;
    cast staker_multisig_v1x1_b.aleo 2u8 r4 r1 0u32 into r5 as Operation;
    call multisig_v1x1.aleo/new_request r5 true r2 r3 into r6;
    call staker_v1_b.aleo/set_admin r0 false into r7;
    async remove_admin r6 r7 into r8;
    output r8 as staker_multisig_v1x1_b.aleo/remove_admin.future;

finalize remove_admin:
    input r0 as multisig_v1x1.aleo/new_request.future;
    input r1 as staker_v1_b.aleo/set_admin.future;
    await r0;
    await r1;
