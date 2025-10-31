import credits.aleo;
import token_registry.aleo;

program token_vesting_linear_pm1234.aleo;

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

struct LockedTokens:
    lock_id as field;
    token_id as field;
    locked_amount as u128;
    claimed_amount as u128;
    start_block as u32;
    blocks_count_per_part as u32;

mapping locks:
    key as field.public;
    value as LockedTokens.public;

function dummy_function:
    output 42u32 as u32.private;
