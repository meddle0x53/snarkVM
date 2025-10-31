import credits.aleo;
import token_registry.aleo;

program exchg_test_v0_0_3.aleo;

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

struct BalanceKey:
    wallet_address as address;
    token_id as field;

struct OrderbookState:
    timestamp as u128;
    hash as field;

struct TradesState:
    timestamp as u128;
    hash as field;

mapping balances:
    key as BalanceKey.public;
    value as u128.public;

mapping available_registered_tokens:
    key as field.public;
    value as field.public;

mapping orderbook_state:
    key as field.public;
    value as OrderbookState.public;

mapping trades_state:
    key as field.public;
    value as TradesState.public;

function swap:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as address.public;
    input r5 as address.public;
    assert.eq self.signer aleo15cmzu50y644hcljmk4d90xurdx6ckwemc8kgtv498t9p666g7czsdmej3n;
    assert.neq r0 r1;
    gt r2 0u128 into r6;
    assert.eq r6 true;
    gt r3 0u128 into r7;
    assert.eq r7 true;
    async swap r0 r1 r2 r3 r4 r5 into r8;
    output r8 as exchg_test_v0_0_3.aleo/swap.future;

finalize swap:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as address.public;
    input r5 as address.public;
    cast r4 r0 into r6 as BalanceKey;
    get.or_use balances[r6] 0u128 into r7;
    gte r7 r2 into r8;
    assert.eq r8 true;
    cast r5 r1 into r9 as BalanceKey;
    get.or_use balances[r9] 0u128 into r10;
    gte r10 r3 into r11;
    assert.eq r11 true;
    sub r7 r2 into r12;
    set r12 into balances[r6];
    sub r10 r3 into r13;
    set r13 into balances[r9];
    cast r4 r1 into r14 as BalanceKey;
    get.or_use balances[r14] 0u128 into r15;
    add r15 r3 into r16;
    set r16 into balances[r14];
    cast r5 r0 into r17 as BalanceKey;
    get.or_use balances[r17] 0u128 into r18;
    add r18 r2 into r19;
    set r19 into balances[r17];

function deposit:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    assert.neq r1 1095517519field;
    async deposit r0 r1 r2 into r3;
    output r3 as exchg_test_v0_0_3.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    contains available_registered_tokens[r1] into r3;
    not r3 into r4;
    assert.eq r4 true;
    cast r0 r1 into r5 as BalanceKey;
    get.or_use balances[r5] 0u128 into r6;
    add r6 r2 into r7;
    set r7 into balances[r5];

function deposit_aleo:
    input r0 as address.private;
    input r1 as u128.private;
    cast r1 into r2 as u64;
    call credits.aleo/transfer_public_as_signer exchg_test_v0_0_3.aleo r2 into r3;
    async deposit_aleo r0 r1 r3 into r4;
    output r4 as exchg_test_v0_0_3.aleo/deposit_aleo.future;

finalize deposit_aleo:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    await r2;
    cast r0 1095517519field into r3 as BalanceKey;
    get.or_use balances[r3] 0u128 into r4;
    add r4 r1 into r5;
    set r5 into balances[r3];

function deposit_registered_token:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    input r3 as field.private;
    call token_registry.aleo/transfer_public_as_signer r3 exchg_test_v0_0_3.aleo r2 into r4;
    async deposit_registered_token r0 r1 r2 r3 r4 into r5;
    output r5 as exchg_test_v0_0_3.aleo/deposit_registered_token.future;

finalize deposit_registered_token:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as field.public;
    input r4 as token_registry.aleo/transfer_public_as_signer.future;
    get available_registered_tokens[r1] into r5;
    assert.eq r3 r5;
    await r4;
    cast r0 r1 into r6 as BalanceKey;
    get.or_use balances[r6] 0u128 into r7;
    add r7 r2 into r8;
    set r8 into balances[r6];

function withdraw:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    assert.neq r1 1095517519field;
    async withdraw r0 r1 r2 into r3;
    output r3 as exchg_test_v0_0_3.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    contains available_registered_tokens[r1] into r3;
    not r3 into r4;
    assert.eq r4 true;
    cast r0 r1 into r5 as BalanceKey;
    get.or_use balances[r5] 0u128 into r6;
    gte r6 r2 into r7;
    assert.eq r7 true;
    sub r6 r2 into r8;
    set r8 into balances[r5];

function withdraw_aleo:
    input r0 as address.private;
    input r1 as u128.private;
    cast r1 into r2 as u64;
    call credits.aleo/transfer_public r0 r2 into r3;
    async withdraw_aleo r0 r1 r3 into r4;
    output r4 as exchg_test_v0_0_3.aleo/withdraw_aleo.future;

finalize withdraw_aleo:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_public.future;
    cast r0 1095517519field into r3 as BalanceKey;
    get.or_use balances[r3] 0u128 into r4;
    gte r4 r1 into r5;
    assert.eq r5 true;
    await r2;
    sub r4 r1 into r6;
    set r6 into balances[r3];

function withdraw_registered_token:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    input r3 as field.private;
    call token_registry.aleo/transfer_public r3 r0 r2 into r4;
    async withdraw_registered_token r0 r1 r2 r3 r4 into r5;
    output r5 as exchg_test_v0_0_3.aleo/withdraw_registered_token.future;

finalize withdraw_registered_token:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as field.public;
    input r4 as token_registry.aleo/transfer_public.future;
    get available_registered_tokens[r1] into r5;
    assert.eq r3 r5;
    cast r0 r1 into r6 as BalanceKey;
    get.or_use balances[r6] 0u128 into r7;
    gte r7 r2 into r8;
    assert.eq r8 true;
    await r4;
    sub r7 r2 into r9;
    set r9 into balances[r6];

function update_orderbook_state:
    input r0 as field.private;
    input r1 as OrderbookState.private;
    assert.eq self.signer aleo15cmzu50y644hcljmk4d90xurdx6ckwemc8kgtv498t9p666g7czsdmej3n;
    async update_orderbook_state r0 r1 into r2;
    output r2 as exchg_test_v0_0_3.aleo/update_orderbook_state.future;

finalize update_orderbook_state:
    input r0 as field.public;
    input r1 as OrderbookState.public;
    set r1 into orderbook_state[r0];

function update_trades_state:
    input r0 as field.private;
    input r1 as TradesState.private;
    assert.eq self.signer aleo15cmzu50y644hcljmk4d90xurdx6ckwemc8kgtv498t9p666g7czsdmej3n;
    async update_trades_state r0 r1 into r2;
    output r2 as exchg_test_v0_0_3.aleo/update_trades_state.future;

finalize update_trades_state:
    input r0 as field.public;
    input r1 as TradesState.public;
    set r1 into trades_state[r0];

function update_registered_token:
    input r0 as field.private;
    input r1 as field.private;
    assert.eq self.signer aleo15cmzu50y644hcljmk4d90xurdx6ckwemc8kgtv498t9p666g7czsdmej3n;
    async update_registered_token r0 r1 into r2;
    output r2 as exchg_test_v0_0_3.aleo/update_registered_token.future;

finalize update_registered_token:
    input r0 as field.public;
    input r1 as field.public;
    set r1 into available_registered_tokens[r0];

function set_balance:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    assert.eq self.signer aleo15cmzu50y644hcljmk4d90xurdx6ckwemc8kgtv498t9p666g7czsdmej3n;
    async set_balance r0 r1 r2 into r3;
    output r3 as exchg_test_v0_0_3.aleo/set_balance.future;

finalize set_balance:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    cast r0 r1 into r3 as BalanceKey;
    set r2 into balances[r3];

function migrate_aleo:
    input r0 as address.private;
    input r1 as u128.private;
    assert.eq self.signer aleo15cmzu50y644hcljmk4d90xurdx6ckwemc8kgtv498t9p666g7czsdmej3n;
    cast r1 into r2 as u64;
    call credits.aleo/transfer_public r0 r2 into r3;
    async migrate_aleo r3 into r4;
    output r4 as exchg_test_v0_0_3.aleo/migrate_aleo.future;

finalize migrate_aleo:
    input r0 as credits.aleo/transfer_public.future;
    await r0;

function migrate_registered_token:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    assert.eq self.signer aleo15cmzu50y644hcljmk4d90xurdx6ckwemc8kgtv498t9p666g7czsdmej3n;
    call token_registry.aleo/transfer_public r1 r0 r2 into r3;
    async migrate_registered_token r3 into r4;
    output r4 as exchg_test_v0_0_3.aleo/migrate_registered_token.future;

finalize migrate_registered_token:
    input r0 as token_registry.aleo/transfer_public.future;
    await r0;
