import credits.aleo;

program zump8_v0_1_0.aleo;

struct Token:
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    token_owner as address;

struct TokenOwner:
    account as address;
    token_name as u128;

struct Balance:
    token_name as u128;
    account as address;
    balance as u128;

mapping registered_tokens:
    key as u128.public;
    value as Token.public;

mapping balances:
    key as field.public;
    value as Balance.public;

function register_token:
    input r0 as u128.public;
    input r1 as u128.public;
    cast r0 r1 6u8 1000000000000000u128 self.caller into r2 as Token;
    async register_token r2 into r3;
    output r3 as zump8_v0_1_0.aleo/register_token.future;

finalize register_token:
    input r0 as Token.public;
    contains registered_tokens[r0.name] into r1;
    assert.eq r1 false;
    set r0 into registered_tokens[r0.name];

function buy:
    input r0 as u128.public;
    input r1 as u128.public;
    cast self.caller r0 into r2 as TokenOwner;
    hash.bhp256 r2 into r3 as field;
    call credits.aleo/transfer_public zump8_v0_1_0.aleo 1u64 into r4;
    async buy r0 r1 self.caller r3 r4 into r5;
    output r5 as zump8_v0_1_0.aleo/buy.future;

finalize buy:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as credits.aleo/transfer_public.future;
    await r4;
    get balances[r3] into r5;
    get registered_tokens[r0] into r6;
    add r5.balance r1 into r7;
    cast r0 r2 r7 into r8 as Balance;
    set r8 into balances[r3];
    sub r6.supply r1 into r9;
    cast r6.name r6.symbol r6.decimals r9 r6.token_owner into r10 as Token;
    set r10 into registered_tokens[r10.name];
