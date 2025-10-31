import multi_token_support_program.aleo;

program quest_v002.aleo;

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

mapping is_claimed:
    key as field.public;
    value as boolean.public;

mapping account:
    key as field.public;
    value as address.public;

mapping auth_accounts:
    key as boolean.public;
    value as address.public;

mapping total_claims:
    key as boolean.public;
    value as u64.public;

mapping status:
    key as boolean.public;
    value as boolean.public;

function initialize:
    input r0 as address.private;
    input r1 as address.private;
    async initialize self.caller r0 r1 into r2;
    output r2 as quest_v002.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    contains auth_accounts[false] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into auth_accounts[false];
    set r2 into auth_accounts[true];
    set 0u64 into total_claims[true];
    assert.eq r0 aleo1s9jt6t6esqg4caw0lzhr393f80jd5mw2w4mn0hudze60fvnrlq9s9ryctf;

closure verify_signature:
    input r0 as field;
    input r1 as signature;
    input r2 as address;
    sign.verify r1 r2 r0 into r3;
    output r3 as boolean;

function claim:
    input r0 as field.public;
    input r1 as signature.private;
    input r2 as address.public;
    call verify_signature r0 r1 r2 into r3;
    assert.eq r3 true;
    call multi_token_support_program.aleo/transfer_public 5595373416687012447808431171621112175713243308139308694591328825799485714900field self.caller 5000000u128 into r4;
    async claim r4 r0 self.caller r2 into r5;
    output r5 as quest_v002.aleo/claim.future;

finalize claim:
    input r0 as multi_token_support_program.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    await r0;
    get status[true] into r4;
    assert.eq r4 true;
    contains is_claimed[r1] into r5;
    not r5 into r6;
    assert.eq r6 true;
    set true into is_claimed[r1];
    get auth_accounts[false] into r7;
    assert.eq r7 r3;
    set r2 into account[r1];
    get total_claims[true] into r8;
    add r8 1u64 into r9;
    set r9 into total_claims[true];

function update_admin:
    input r0 as address.private;
    async update_admin r0 self.caller into r1;
    output r1 as quest_v002.aleo/update_admin.future;

finalize update_admin:
    input r0 as address.public;
    input r1 as address.public;
    get auth_accounts[true] into r2;
    assert.eq r2 r1;
    set r0 into auth_accounts[true];

function update_signer:
    input r0 as address.private;
    async update_signer r0 self.caller into r1;
    output r1 as quest_v002.aleo/update_signer.future;

finalize update_signer:
    input r0 as address.public;
    input r1 as address.public;
    get auth_accounts[true] into r2;
    assert.eq r2 r1;
    set r0 into auth_accounts[false];

function unpause:
    async unpause self.caller into r0;
    output r0 as quest_v002.aleo/unpause.future;

finalize unpause:
    input r0 as address.public;
    get auth_accounts[true] into r1;
    assert.eq r0 r1;
    set true into status[true];

function pause:
    async pause self.caller into r0;
    output r0 as quest_v002.aleo/pause.future;

finalize pause:
    input r0 as address.public;
    get auth_accounts[true] into r1;
    assert.eq r0 r1;
    set false into status[true];
