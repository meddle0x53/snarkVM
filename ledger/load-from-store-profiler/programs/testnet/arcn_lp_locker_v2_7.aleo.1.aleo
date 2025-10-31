import arcn_access_manager_v1.aleo;
import arcn_whitelist.aleo;
import credits.aleo;
import token_registry.aleo;
import arcn_pool_v2_2_2.aleo;

program arcn_lp_locker_v2_7.aleo;

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

struct PoolInfo:
    id as field;
    token1_id as field;
    token2_id as field;
    reserve1 as u128;
    reserve2 as u128;
    lp_total_supply as u128;
    swap_fee as u16;
    ampl_coef as u16;
    pool_type as u8;

struct DepositOwner:
    from as address;
    salt as field;

struct ProtocolFeeConfig:
    rate as u16;
    foundation as address;

struct LpLockInfo:
    receiver as address;
    block_start as u32;

mapping locks:
    key as field.public;
    value as LpLockInfo.public;

function lock_lp:
    input r0 as field.private;
    input r1 as address.private;
    async lock_lp r0 r1 into r2;
    output r2 as arcn_lp_locker_v2_7.aleo/lock_lp.future;

finalize lock_lp:
    input r0 as field.public;
    input r1 as address.public;
    cast arcn_lp_locker_v2_7.aleo r0 into r2 as DepositOwner;
    hash.bhp256 r2 into r3 as field;
    contains arcn_pool_v2_2_2.aleo/amm_deposits[r3] into r4;
    assert.eq r4 true;
    contains locks[r0] into r5;
    not r5 into r6;
    assert.eq r6 true;
    cast r1 block.height into r7 as LpLockInfo;
    set r7 into locks[r0];

function unlock_lp:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.private;
    call arcn_pool_v2_2_2.aleo/transfer_lp_receipt_by_salt r0 r2 r3 r4 r1 r5 false into r6 r7;
    async unlock_lp r7 r0 r1 r2 r3 r4 into r8;
    output r8 as arcn_lp_locker_v2_7.aleo/unlock_lp.future;

finalize unlock_lp:
    input r0 as arcn_pool_v2_2_2.aleo/transfer_lp_receipt_by_salt.future;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as field.public;
    get locks[r1] into r6;
    assert.eq r6.receiver r2;
    sub block.height r6.block_start into r7;
    gte r7 500u32 into r8;
    assert.eq r8 true;
    get arcn_pool_v2_2_2.aleo/amm_pools[r3] into r9;
    assert.eq r9.token1_id r4;
    assert.eq r9.token2_id r5;
    await r0;
    remove locks[r1];
