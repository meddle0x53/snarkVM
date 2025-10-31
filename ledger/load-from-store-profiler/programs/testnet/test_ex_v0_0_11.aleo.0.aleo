import credits.aleo;
import token_registry.aleo;

program test_ex_v0_0_11.aleo;

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
    salt as field;

struct OrderbookState:
    timestamp as u128;
    hash as field;

struct TradesState:
    timestamp as u128;
    hash as field;

mapping balances:
    key as field.public;
    value as u128.public;

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
    input r4 as address.private;
    input r5 as field.private;
    input r6 as address.private;
    input r7 as field.private;
    assert.eq self.signer aleo1q6zhtdwagcsuueg7gf40k640tswktst8w9vdc0ss93qsa8xcqcfq0mkwyp;
    gt r2 0u128 into r8;
    assert.eq r8 true;
    gt r3 0u128 into r9;
    assert.eq r9 true;
    cast r4 r0 r5 into r10 as BalanceKey;
    hash.bhp256 r10 into r11 as field;
    cast r4 r1 r5 into r12 as BalanceKey;
    hash.bhp256 r12 into r13 as field;
    cast r6 r0 r7 into r14 as BalanceKey;
    hash.bhp256 r14 into r15 as field;
    cast r6 r1 r7 into r16 as BalanceKey;
    hash.bhp256 r16 into r17 as field;
    async swap r0 r1 r2 r3 r11 r13 r15 r17 into r18;
    output r18 as test_ex_v0_0_11.aleo/swap.future;

finalize swap:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as field.public;
    input r5 as field.public;
    input r6 as field.public;
    input r7 as field.public;
    get.or_use balances[r4] 0u128 into r8;
    gte r8 r2 into r9;
    assert.eq r9 true;
    get.or_use balances[r7] 0u128 into r10;
    gte r10 r3 into r11;
    assert.eq r11 true;
    sub r8 r2 into r12;
    set r12 into balances[r4];
    sub r10 r3 into r13;
    set r13 into balances[r7];
    get.or_use balances[r5] 0u128 into r14;
    add r14 r3 into r15;
    set r15 into balances[r5];
    get.or_use balances[r6] 0u128 into r16;
    add r16 r2 into r17;
    set r17 into balances[r6];

function balance_key:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as field.private;
    cast r0 r2 r1 into r3 as BalanceKey;
    hash.bhp256 r3 into r4 as field;
    output r4 as field.private;

function deposit_aleo_pub:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    cast r2 into r3 as u64;
    call credits.aleo/transfer_public_as_signer test_ex_v0_0_11.aleo r3 into r4;
    cast r0 1095517519field r1 into r5 as BalanceKey;
    hash.bhp256 r5 into r6 as field;
    async deposit_aleo_pub r6 r2 r4 into r7;
    output r6 as field.private;
    output r7 as test_ex_v0_0_11.aleo/deposit_aleo_pub.future;

finalize deposit_aleo_pub:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    await r2;
    get.or_use balances[r0] 0u128 into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];

function withdraw_aleo_pub:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    cast r2 into r3 as u64;
    call credits.aleo/transfer_public r0 r3 into r4;
    cast r0 1095517519field r1 into r5 as BalanceKey;
    hash.bhp256 r5 into r6 as field;
    async withdraw_aleo_pub r6 r2 r4 into r7;
    output r7 as test_ex_v0_0_11.aleo/withdraw_aleo_pub.future;

finalize withdraw_aleo_pub:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_public.future;
    get.or_use balances[r0] 0u128 into r3;
    gte r3 r1 into r4;
    assert.eq r4 true;
    await r2;
    sub r3 r1 into r5;
    set r5 into balances[r0];

function deposit_aleo:
    input r0 as credits.aleo/credits.record;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u128.private;
    assert.eq r0.owner r1;
    cast r3 into r4 as u64;
    call credits.aleo/transfer_private_to_public r0 test_ex_v0_0_11.aleo r4 into r5 r6;
    cast r1 1095517519field r2 into r7 as BalanceKey;
    hash.bhp256 r7 into r8 as field;
    async deposit_aleo r8 r3 r6 into r9;
    output r5 as credits.aleo/credits.record;
    output r8 as field.private;
    output r9 as test_ex_v0_0_11.aleo/deposit_aleo.future;

finalize deposit_aleo:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_private_to_public.future;
    await r2;
    get.or_use balances[r0] 0u128 into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];

function deposit_registered_token:
    input r0 as token_registry.aleo/Token.record;
    input r1 as address.private;
    input r2 as field.private;
    input r3 as u128.private;
    input r4 as field.private;
    assert.eq r0.owner r1;
    assert.eq r0.token_id r4;
    call token_registry.aleo/transfer_private_to_public test_ex_v0_0_11.aleo r3 r0 into r5 r6;
    cast r1 r4 r2 into r7 as BalanceKey;
    hash.bhp256 r7 into r8 as field;
    async deposit_registered_token r8 r4 r3 r6 into r9;
    output r5 as token_registry.aleo/Token.record;
    output r8 as field.private;
    output r9 as test_ex_v0_0_11.aleo/deposit_registered_token.future;

finalize deposit_registered_token:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as token_registry.aleo/transfer_private_to_public.future;
    await r3;
    get.or_use balances[r0] 0u128 into r4;
    add r4 r2 into r5;
    set r5 into balances[r0];

function withdraw_aleo:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    cast r2 into r3 as u64;
    call credits.aleo/transfer_public_to_private r0 r3 into r4 r5;
    cast r0 1095517519field r1 into r6 as BalanceKey;
    hash.bhp256 r6 into r7 as field;
    async withdraw_aleo r7 r2 r5 into r8;
    output r4 as credits.aleo/credits.record;
    output r7 as field.private;
    output r8 as test_ex_v0_0_11.aleo/withdraw_aleo.future;

finalize withdraw_aleo:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_public_to_private.future;
    get.or_use balances[r0] 0u128 into r3;
    gte r3 r1 into r4;
    assert.eq r4 true;
    await r2;
    sub r3 r1 into r5;
    set r5 into balances[r0];

function withdraw_registered_token:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u128.private;
    input r3 as field.private;
    call token_registry.aleo/transfer_public_to_private r3 r0 r2 false into r4 r5;
    cast r0 r3 r1 into r6 as BalanceKey;
    hash.bhp256 r6 into r7 as field;
    async withdraw_registered_token r7 r2 r3 r5 into r8;
    output r4 as token_registry.aleo/Token.record;
    output r7 as field.private;
    output r8 as test_ex_v0_0_11.aleo/withdraw_registered_token.future;

finalize withdraw_registered_token:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as field.public;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    get.or_use balances[r0] 0u128 into r4;
    gte r4 r1 into r5;
    assert.eq r5 true;
    await r3;
    sub r4 r1 into r6;
    set r6 into balances[r0];

function update_orderbook_state:
    input r0 as field.private;
    input r1 as OrderbookState.private;
    assert.eq self.signer aleo1q6zhtdwagcsuueg7gf40k640tswktst8w9vdc0ss93qsa8xcqcfq0mkwyp;
    async update_orderbook_state r0 r1 into r2;
    output r2 as test_ex_v0_0_11.aleo/update_orderbook_state.future;

finalize update_orderbook_state:
    input r0 as field.public;
    input r1 as OrderbookState.public;
    set r1 into orderbook_state[r0];

function update_trades_state:
    input r0 as field.private;
    input r1 as TradesState.private;
    assert.eq self.signer aleo1q6zhtdwagcsuueg7gf40k640tswktst8w9vdc0ss93qsa8xcqcfq0mkwyp;
    async update_trades_state r0 r1 into r2;
    output r2 as test_ex_v0_0_11.aleo/update_trades_state.future;

finalize update_trades_state:
    input r0 as field.public;
    input r1 as TradesState.public;
    set r1 into trades_state[r0];
