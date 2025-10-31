import credits.aleo;
import token_registry.aleo;

program compliant_token_aanya.aleo;

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

mapping registered_project:
    key as field.public;
    value as address.public;

mapping project_time:
    key as field.public;
    value as u32.public;

mapping project_balance:
    key as field.public;
    value as u128.public;

mapping project_goal:
    key as field.public;
    value as u128.public;

function register_project:
    input r0 as field.private;
    input r1 as u32.private;
    input r2 as u128.private;
    async register_project self.caller r0 r1 into r3;
    output r3 as compliant_token_aanya.aleo/register_project.future;

finalize register_project:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u32.public;
    set r0 into registered_project[r1];
    set r2 into project_time[r1];
    set 0u128 into project_goal[r1];

function fund_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.private;
    input r2 as field.private;
    call token_registry.aleo/transfer_private_to_public compliant_token_sandip.aleo r1 r0 into r3 r4;
    async fund_private r4 r1 r2 into r5;
    output r3 as token_registry.aleo/Token.record;
    output r5 as compliant_token_aanya.aleo/fund_private.future;

finalize fund_private:
    input r0 as token_registry.aleo/transfer_private_to_public.future;
    input r1 as u128.public;
    input r2 as field.public;
    await r0;
    get.or_use project_balance[r2] 0u128 into r3;
    add r3 r1 into r4;
    set r4 into project_balance[r2];
    get project_time[r2] into r5;
    lt block.height r5 into r6;
    assert.eq r6 true;

function get_money:
    input r0 as field.private;
    input r1 as u128.private;
    call token_registry.aleo/transfer_public 71619063553950105623552field self.caller r1 into r2;
    async get_money self.caller r0 r1 r2 into r3;
    output r3 as compliant_token_aanya.aleo/get_money.future;

finalize get_money:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as token_registry.aleo/transfer_public.future;
    await r3;
    get.or_use project_balance[r1] 0u128 into r4;
    sub r4 r2 into r5;
    set r5 into project_balance[r1];
    get project_time[r1] into r6;
    gt block.height r6 into r7;
    assert.eq r7 true;
