import credits.aleo;
import staking_v1.aleo;

program stake_ext_v1.aleo;

struct Settings:
    unstake_wait as u32;
    stake_paused as boolean;
    global_paused as boolean;
    max_reward_per_notify as u64;
    protocol_fee as u16;
    fee_account as address;
    fixed_stakers as boolean;

function stake:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    call staking_v1.aleo/stake_public r0 r1 into r3;
    async stake self.signer r2 r3 into r4;
    output r4 as stake_ext_v1.aleo/stake.future;

finalize stake:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as staking_v1.aleo/stake_public.future;
    await r2;
