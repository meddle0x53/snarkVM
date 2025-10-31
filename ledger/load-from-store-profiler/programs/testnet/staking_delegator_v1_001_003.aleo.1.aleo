import credits.aleo;
import spectre_access_control_v1_001.aleo;
import spectre_acl_manager_v1_001.aleo;
import multi_token_support_program.aleo;
import staking_stcredits_v1_001.aleo;

program staking_delegator_v1_001_003.aleo;

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

struct metadata:
    name as u128;
    symbol as u64;
    decimals as u8;

function bond:
    input r0 as address.public;
    input r1 as u64.public;
    call spectre_acl_manager_v1_001.aleo/only_staking_operator self.caller into r2;
    call staking_stcredits_v1_001.aleo/bond staking_delegator_v1_001_003.aleo r0 r1 into r3;
    cast staking_stcredits_v1_001.aleo into r4 as address;
    call credits.aleo/bond_public r0 r4 r1 into r5;
    async bond r2 r3 r5 into r6;
    output r6 as staking_delegator_v1_001_003.aleo/bond.future;

finalize bond:
    input r0 as spectre_acl_manager_v1_001.aleo/only_staking_operator.future;
    input r1 as staking_stcredits_v1_001.aleo/bond.future;
    input r2 as credits.aleo/bond_public.future;
    await r0;
    await r1;
    await r2;

function get_address:
    output staking_delegator_v1_001_003.aleo as address.private;
