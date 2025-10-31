import config_v1x5.aleo;
import alphaswap_v1x5.aleo;
import credits.aleo;
import token_registry.aleo;

program tr_wrapper_v1x5.aleo;

struct TokenInfo:
    name as field;
    symbol as field;
    decimals as u8;
    total_supply as u128;
    admin as address;
    mintable as boolean;
    burnable as boolean;

struct TokenIdData:
    base as address;
    creator as address;
    salt as u128;

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

struct SaltData:
    wrapper as address;
    reg_token_id as field;

mapping reg2swap:
    key as field.public;
    value as field.public;

function register_token:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u8.public;
    cast tr_wrapper_v1x5.aleo r0 into r4 as SaltData;
    hash.bhp256 r4 into r5 as u128;
    cast r1 into r6 as field;
    cast r2 into r7 as field;
    call alphaswap_v1x5.aleo/create_token r6 r7 r3 0u128 tr_wrapper_v1x5.aleo true true r5 into r8;
    cast tr_wrapper_v1x5.aleo r0 into r9 as SaltData;
    hash.bhp256 r9 into r10 as u128;
    cast alphaswap_v1x5.aleo tr_wrapper_v1x5.aleo r10 into r11 as TokenIdData;
    hash.bhp256 r11 into r12 as field;
    async register_token r0 r12 r1 r2 r3 r8 into r13;
    output r12 as field.private;
    output r13 as tr_wrapper_v1x5.aleo/register_token.future;

finalize register_token:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as u8.public;
    input r5 as alphaswap_v1x5.aleo/create_token.future;
    await r5;
    get alphaswap_v1x5.aleo/tokens[r1] into r6;
    assert.eq r6.admin tr_wrapper_v1x5.aleo;
    get token_registry.aleo/registered_tokens[r0] into r7;
    assert.eq r2 r7.name;
    assert.eq r3 r7.symbol;
    assert.eq r4 r7.decimals;
    assert.eq r7.external_authorization_required false;
    set r1 into reg2swap[r0];

function wrap_public_as_signer:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    call token_registry.aleo/transfer_public_as_signer r0 tr_wrapper_v1x5.aleo r1 into r3;
    cast tr_wrapper_v1x5.aleo r0 into r4 as SaltData;
    hash.bhp256 r4 into r5 as u128;
    cast alphaswap_v1x5.aleo tr_wrapper_v1x5.aleo r5 into r6 as TokenIdData;
    hash.bhp256 r6 into r7 as field;
    call alphaswap_v1x5.aleo/mint_public r7 r2 r1 into r8;
    async wrap_public_as_signer r0 r3 r8 into r9;
    output r9 as tr_wrapper_v1x5.aleo/wrap_public_as_signer.future;

finalize wrap_public_as_signer:
    input r0 as field.public;
    input r1 as token_registry.aleo/transfer_public_as_signer.future;
    input r2 as alphaswap_v1x5.aleo/mint_public.future;
    await r1;
    await r2;
    contains reg2swap[r0] into r3;
    assert.eq r3 true;

function wrap_public:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    call token_registry.aleo/transfer_from_public r0 self.caller tr_wrapper_v1x5.aleo r1 into r3;
    cast tr_wrapper_v1x5.aleo r0 into r4 as SaltData;
    hash.bhp256 r4 into r5 as u128;
    cast alphaswap_v1x5.aleo tr_wrapper_v1x5.aleo r5 into r6 as TokenIdData;
    hash.bhp256 r6 into r7 as field;
    call alphaswap_v1x5.aleo/mint_public r7 r2 r1 into r8;
    async wrap_public r0 r3 r8 into r9;
    output r9 as tr_wrapper_v1x5.aleo/wrap_public.future;

finalize wrap_public:
    input r0 as field.public;
    input r1 as token_registry.aleo/transfer_from_public.future;
    input r2 as alphaswap_v1x5.aleo/mint_public.future;
    await r1;
    await r2;
    contains reg2swap[r0] into r3;
    assert.eq r3 true;

function unwrap_public:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    cast tr_wrapper_v1x5.aleo r0 into r3 as SaltData;
    hash.bhp256 r3 into r4 as u128;
    cast alphaswap_v1x5.aleo tr_wrapper_v1x5.aleo r4 into r5 as TokenIdData;
    hash.bhp256 r5 into r6 as field;
    call alphaswap_v1x5.aleo/burn_from r6 self.caller r1 into r7;
    call token_registry.aleo/transfer_public r0 r2 r1 into r8;
    async unwrap_public r0 r7 r8 into r9;
    output r9 as tr_wrapper_v1x5.aleo/unwrap_public.future;

finalize unwrap_public:
    input r0 as field.public;
    input r1 as alphaswap_v1x5.aleo/burn_from.future;
    input r2 as token_registry.aleo/transfer_public.future;
    await r1;
    await r2;
    contains reg2swap[r0] into r3;
    assert.eq r3 true;

function get_swap_token_id:
    input r0 as field.private;
    cast tr_wrapper_v1x5.aleo r0 into r1 as SaltData;
    hash.bhp256 r1 into r2 as u128;
    cast alphaswap_v1x5.aleo tr_wrapper_v1x5.aleo r2 into r3 as TokenIdData;
    hash.bhp256 r3 into r4 as field;
    output r4 as field.private;
