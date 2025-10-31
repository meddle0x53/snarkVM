import credits.aleo;
import staking_v1.aleo;

program testst_v1_r1.aleo;

struct Settings:
    unstake_wait as u32;
    stake_paused as boolean;
    global_paused as boolean;
    max_reward_per_notify as u64;
    protocol_fee as u16;
    fee_account as address;
    fixed_stakers as boolean;

function stake0:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    call staking_v1.aleo/stake_public r0 r1 into r3;
    async stake0 r3 into r4;
    output r4 as testst_v1_r1.aleo/stake0.future;

finalize stake0:
    input r0 as staking_v1.aleo/stake_public.future;
    await r0;

function stake1:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    call staking_v1.aleo/stake_public r0 r1 into r3;
    async stake1 self.signer r3 into r4;
    output r4 as testst_v1_r1.aleo/stake1.future;

finalize stake1:
    input r0 as address.public;
    input r1 as staking_v1.aleo/stake_public.future;
    await r1;

function stake2:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    call staking_v1.aleo/stake_public r0 r1 into r3;
    async stake2 self.signer r2 r3 into r4;
    output r4 as testst_v1_r1.aleo/stake2.future;

finalize stake2:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as staking_v1.aleo/stake_public.future;
    await r2;
