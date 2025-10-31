import multisig_v1.aleo;
import credits.aleo;
import staking_v1.aleo;

program staking_multisig_v1.aleo;

struct Operation:
    program_id as address;
    op_type as u8;
    params as field;
    op_salt as u64;
    delay as u32;

struct Request:
    operation as Operation;
    multisig as address;

struct Settings:
    unstake_wait as u32;
    stake_paused as boolean;
    global_paused as boolean;
    max_reward_per_notify as u64;
    protocol_fee as u16;
    fee_account as address;

function update_settings:
    input r0 as Settings.public;
    input r1 as u64.public;
    input r2 as [address; 3u32].public;
    input r3 as [signature; 3u32].private;
    hash.bhp256 r0 into r4 as field;
    cast staking_multisig_v1.aleo 3u8 r4 r1 0u32 into r5 as Operation;
    call multisig_v1.aleo/new_request r5 true r2 r3 into r6;
    call staking_v1.aleo/update_settings r0 into r7;
    async update_settings r6 r7 into r8;
    output r8 as staking_multisig_v1.aleo/update_settings.future;

finalize update_settings:
    input r0 as multisig_v1.aleo/new_request.future;
    input r1 as staking_v1.aleo/update_settings.future;
    await r0;
    await r1;

function add_admin:
    input r0 as address.public;
    input r1 as u64.public;
    hash.bhp256 r0 into r2 as field;
    cast staking_multisig_v1.aleo 1u8 r2 r1 17280u32 into r3 as Operation;
    call multisig_v1.aleo/execute r3 into r4;
    call staking_v1.aleo/set_admin r0 true into r5;
    async add_admin r4 r5 into r6;
    output r6 as staking_multisig_v1.aleo/add_admin.future;

finalize add_admin:
    input r0 as multisig_v1.aleo/execute.future;
    input r1 as staking_v1.aleo/set_admin.future;
    await r0;
    await r1;

function remove_admin:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as [address; 3u32].public;
    input r3 as [signature; 3u32].private;
    assert.neq self.caller r0;
    hash.bhp256 r0 into r4 as field;
    cast staking_multisig_v1.aleo 2u8 r4 r1 0u32 into r5 as Operation;
    call multisig_v1.aleo/new_request r5 true r2 r3 into r6;
    call staking_v1.aleo/set_admin r0 false into r7;
    async remove_admin r6 r7 into r8;
    output r8 as staking_multisig_v1.aleo/remove_admin.future;

finalize remove_admin:
    input r0 as multisig_v1.aleo/new_request.future;
    input r1 as staking_v1.aleo/set_admin.future;
    await r0;
    await r1;
