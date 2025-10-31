import config_v1x5.aleo;
import alphaswap_v1x5.aleo;
import staking_v1.aleo;

program wstaleo_v1x5.aleo;

struct TokenIdData:
    base as address;
    creator as address;
    salt as u128;

function wrap_public:
    input r0 as u64.public;
    input r1 as address.public;
    call staking_v1.aleo/transfer_from_public self.caller wstaleo_v1x5.aleo r0 into r2;
    cast alphaswap_v1x5.aleo wstaleo_v1x5.aleo 1u128 into r3 as TokenIdData;
    hash.bhp256 r3 into r4 as field;
    cast r0 into r5 as u128;
    call alphaswap_v1x5.aleo/mint_public r4 r1 r5 into r6;
    async wrap_public r2 r6 into r7;
    output r7 as wstaleo_v1x5.aleo/wrap_public.future;

finalize wrap_public:
    input r0 as staking_v1.aleo/transfer_from_public.future;
    input r1 as alphaswap_v1x5.aleo/mint_public.future;
    await r0;
    await r1;

function unwrap_public:
    input r0 as u64.public;
    input r1 as address.public;
    cast alphaswap_v1x5.aleo wstaleo_v1x5.aleo 1u128 into r2 as TokenIdData;
    hash.bhp256 r2 into r3 as field;
    cast r0 into r4 as u128;
    call alphaswap_v1x5.aleo/burn_from r3 self.caller r4 into r5;
    call staking_v1.aleo/transfer_public r1 r0 into r6;
    async unwrap_public r5 r6 into r7;
    output r7 as wstaleo_v1x5.aleo/unwrap_public.future;

finalize unwrap_public:
    input r0 as alphaswap_v1x5.aleo/burn_from.future;
    input r1 as staking_v1.aleo/transfer_public.future;
    await r0;
    await r1;

function init_wrapper:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    call alphaswap_v1x5.aleo/create_token r0 r1 r2 0u128 wstaleo_v1x5.aleo true true 1u128 into r3;
    async init_wrapper r3 into r4;
    output r4 as wstaleo_v1x5.aleo/init_wrapper.future;

finalize init_wrapper:
    input r0 as alphaswap_v1x5.aleo/create_token.future;
    await r0;
