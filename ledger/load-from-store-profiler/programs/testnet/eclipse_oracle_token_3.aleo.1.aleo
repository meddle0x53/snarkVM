import credits.aleo;
import token_registry.aleo;

program eclipse_oracle_token_3.aleo;

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

mapping airdrop_done:
    key as field.public;
    value as boolean.public;

mapping role_granted:
    key as field.public;
    value as boolean.public;

mapping rewards_done:
    key as field.public;
    value as boolean.public;

mapping liquidity_last_block:
    key as field.public;
    value as u32.public;

mapping team_last_block:
    key as field.public;
    value as u32.public;

function initialize:
    input r0 as address.public;
    input r1 as u32.public;
    is.eq r0 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r2;
    assert.eq r2 true;
    call token_registry.aleo/register_token 1234567898field 332565922916059772120165u128 5202243u128 8u8 1000000000000000u128 false aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r3;
    async initialize r3 r1 into r4;
    output r4 as eclipse_oracle_token_3.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as u32.public;
    await r0;
    set r1 into team_last_block[1234567898field];
    set r1 into liquidity_last_block[1234567898field];

function airdrop_initial:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    is.eq r8 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r9;
    assert.eq r9 true;
    call token_registry.aleo/mint_public 1234567898field r0 1250000000000u128 0u32 into r10;
    call token_registry.aleo/mint_public 1234567898field r1 1250000000000u128 0u32 into r11;
    call token_registry.aleo/mint_public 1234567898field r2 1250000000000u128 0u32 into r12;
    call token_registry.aleo/mint_public 1234567898field r3 1250000000000u128 0u32 into r13;
    call token_registry.aleo/mint_public 1234567898field r4 1250000000000u128 0u32 into r14;
    call token_registry.aleo/mint_public 1234567898field r5 1250000000000u128 0u32 into r15;
    call token_registry.aleo/mint_public 1234567898field r6 1250000000000u128 0u32 into r16;
    call token_registry.aleo/mint_public 1234567898field r7 1250000000000u128 0u32 into r17;
    async airdrop_initial r10 r11 r12 r13 r14 r15 r16 r17 into r18;
    output r18 as eclipse_oracle_token_3.aleo/airdrop_initial.future;

finalize airdrop_initial:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as token_registry.aleo/mint_public.future;
    input r2 as token_registry.aleo/mint_public.future;
    input r3 as token_registry.aleo/mint_public.future;
    input r4 as token_registry.aleo/mint_public.future;
    input r5 as token_registry.aleo/mint_public.future;
    input r6 as token_registry.aleo/mint_public.future;
    input r7 as token_registry.aleo/mint_public.future;
    get.or_use airdrop_done[1234567898field] false into r8;
    not r8 into r9;
    assert.eq r9 true;
    set true into airdrop_done[1234567898field];
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;

function grant_role:
    input r0 as address.public;
    is.eq r0 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r1;
    assert.eq r1 true;
    call token_registry.aleo/set_role 1234567898field eclipse_oracle_staking_3.aleo 3u8 into r2;
    call token_registry.aleo/set_role 1234567898field eclipse_oracle_aggregate_3.aleo 3u8 into r3;
    async grant_role r2 r3 into r4;
    output r4 as eclipse_oracle_token_3.aleo/grant_role.future;

finalize grant_role:
    input r0 as token_registry.aleo/set_role.future;
    input r1 as token_registry.aleo/set_role.future;
    get.or_use role_granted[1550889366836176646497732008299787839574945461804805546558174182639479650131field] false into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into role_granted[1550889366836176646497732008299787839574945461804805546558174182639479650131field];
    await r0;
    await r1;

function provision_rewards_pool:
    input r0 as address.public;
    is.eq r0 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r1;
    assert.eq r1 true;
    call token_registry.aleo/mint_public 1234567898field eclipse_oracle_staking_3.aleo 400000000000000u128 0u32 into r2;
    async provision_rewards_pool r2 into r3;
    output r3 as eclipse_oracle_token_3.aleo/provision_rewards_pool.future;

finalize provision_rewards_pool:
    input r0 as token_registry.aleo/mint_public.future;
    get.or_use rewards_done[1234567898field] false into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into rewards_done[1234567898field];
    await r0;

function unlock_liquidity:
    input r0 as address.public;
    input r1 as u32.public;
    is.eq r0 aleo18suj4glqvejgu753r8s2u8kn57n3macu2yw06rcjpmu5kldfnqxq6g8kqd into r2;
    assert.eq r2 true;
    call token_registry.aleo/mint_public 1234567898field aleo1c39lrkdvnkchl79qza20vqemyytdmye7xa8wu6pqmzeqqe400yfq4qzg6w 16666666666666u128 0u32 into r3;
    async unlock_liquidity r3 r1 into r4;
    output r4 as eclipse_oracle_token_3.aleo/unlock_liquidity.future;

finalize unlock_liquidity:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as u32.public;
    get.or_use liquidity_last_block[1234567898field] 0u32 into r2;
    add r2 864000u32 into r3;
    gte r1 r3 into r4;
    assert.eq r4 true;
    add r2 864000u32 into r5;
    set r5 into liquidity_last_block[1234567898field];
    await r0;

function unlock_team:
    input r0 as address.public;
    input r1 as u32.public;
    is.eq r0 aleo18suj4glqvejgu753r8s2u8kn57n3macu2yw06rcjpmu5kldfnqxq6g8kqd into r2;
    assert.eq r2 true;
    call token_registry.aleo/mint_public 1234567898field aleo18suj4glqvejgu753r8s2u8kn57n3macu2yw06rcjpmu5kldfnqxq6g8kqd 7916666666666u128 0u32 into r3;
    async unlock_team r3 r1 into r4;
    output r4 as eclipse_oracle_token_3.aleo/unlock_team.future;

finalize unlock_team:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as u32.public;
    get.or_use team_last_block[1234567898field] 0u32 into r2;
    add r2 864000u32 into r3;
    gte r1 r3 into r4;
    assert.eq r4 true;
    add r2 864000u32 into r5;
    set r5 into team_last_block[1234567898field];
    await r0;

function update_admin:
    input r0 as address.public;
    is.eq self.caller aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r1;
    assert.eq r1 true;
    call token_registry.aleo/update_token_management 1234567898field r0 aleo1096dhxrwgf4xz857zru0uy4dxwgy4ztqqzg8fyl74luv3v79d5pslt2jjv into r2;
    async update_admin r2 into r3;
    output r3 as eclipse_oracle_token_3.aleo/update_admin.future;

finalize update_admin:
    input r0 as token_registry.aleo/update_token_management.future;
    await r0;
