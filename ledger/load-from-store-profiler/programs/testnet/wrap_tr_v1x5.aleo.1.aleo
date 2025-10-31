import config_v1x5.aleo;
import alphaswap_v1x5.aleo;
import credits.aleo;
import token_registry.aleo;

program wrap_tr_v1x5.aleo;

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

function register_token:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u8.public;
    hash.bhp256 r0 into r4 as u128;
    cast r1 into r5 as field;
    cast r2 into r6 as field;
    call alphaswap_v1x5.aleo/create_token r5 r6 r3 0u128 wrap_tr_v1x5.aleo true true r4 into r7;
    async register_token r0 r1 r2 r3 r7 into r8;
    output r8 as wrap_tr_v1x5.aleo/register_token.future;

finalize register_token:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u8.public;
    input r4 as alphaswap_v1x5.aleo/create_token.future;
    await r4;
    get token_registry.aleo/registered_tokens[r0] into r5;
    assert.eq r5.external_authorization_required false;
    assert.eq r1 r5.name;
    assert.eq r2 r5.symbol;
    assert.eq r3 r5.decimals;

function wrap_public_as_signer:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    call token_registry.aleo/transfer_public_as_signer r0 wrap_tr_v1x5.aleo r1 into r3;
    hash.bhp256 r0 into r4 as u128;
    cast alphaswap_v1x5.aleo wrap_tr_v1x5.aleo r4 into r5 as TokenIdData;
    hash.bhp256 r5 into r6 as field;
    call alphaswap_v1x5.aleo/mint_public r6 r2 r1 into r7;
    async wrap_public_as_signer r3 r7 into r8;
    output r8 as wrap_tr_v1x5.aleo/wrap_public_as_signer.future;

finalize wrap_public_as_signer:
    input r0 as token_registry.aleo/transfer_public_as_signer.future;
    input r1 as alphaswap_v1x5.aleo/mint_public.future;
    await r0;
    await r1;

function wrap_public:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    call token_registry.aleo/transfer_from_public r0 self.caller wrap_tr_v1x5.aleo r1 into r3;
    hash.bhp256 r0 into r4 as u128;
    cast alphaswap_v1x5.aleo wrap_tr_v1x5.aleo r4 into r5 as TokenIdData;
    hash.bhp256 r5 into r6 as field;
    call alphaswap_v1x5.aleo/mint_public r6 r2 r1 into r7;
    async wrap_public r3 r7 into r8;
    output r8 as wrap_tr_v1x5.aleo/wrap_public.future;

finalize wrap_public:
    input r0 as token_registry.aleo/transfer_from_public.future;
    input r1 as alphaswap_v1x5.aleo/mint_public.future;
    await r0;
    await r1;

function unwrap_public:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    hash.bhp256 r0 into r3 as u128;
    cast alphaswap_v1x5.aleo wrap_tr_v1x5.aleo r3 into r4 as TokenIdData;
    hash.bhp256 r4 into r5 as field;
    call alphaswap_v1x5.aleo/burn_from r5 self.caller r1 into r6;
    call token_registry.aleo/transfer_public r0 r2 r1 into r7;
    async unwrap_public r6 r7 into r8;
    output r8 as wrap_tr_v1x5.aleo/unwrap_public.future;

finalize unwrap_public:
    input r0 as alphaswap_v1x5.aleo/burn_from.future;
    input r1 as token_registry.aleo/transfer_public.future;
    await r0;
    await r1;

function get_swap_token_id:
    input r0 as field.private;
    hash.bhp256 r0 into r1 as u128;
    cast alphaswap_v1x5.aleo wrap_tr_v1x5.aleo r1 into r2 as TokenIdData;
    hash.bhp256 r2 into r3 as field;
    output r3 as field.private;
