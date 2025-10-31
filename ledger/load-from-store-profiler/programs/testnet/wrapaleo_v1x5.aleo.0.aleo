import config_v1x5.aleo;
import alphaswap_v1x5.aleo;
import credits.aleo;

program wrapaleo_v1x5.aleo;

struct TokenIdData:
    base as address;
    creator as address;
    salt as u128;

function wrap_public:
    input r0 as u64.public;
    input r1 as address.public;
    call credits.aleo/transfer_public_as_signer wrapaleo_v1x5.aleo r0 into r2;
    cast alphaswap_v1x5.aleo wrapaleo_v1x5.aleo 1u128 into r3 as TokenIdData;
    hash.bhp256 r3 into r4 as field;
    cast r0 into r5 as u128;
    call alphaswap_v1x5.aleo/mint_public r4 r1 r5 into r6;
    async wrap_public r2 r6 into r7;
    output r7 as wrapaleo_v1x5.aleo/wrap_public.future;

finalize wrap_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as alphaswap_v1x5.aleo/mint_public.future;
    await r0;
    await r1;

function unwrap_public:
    input r0 as u64.public;
    input r1 as address.public;
    cast alphaswap_v1x5.aleo wrapaleo_v1x5.aleo 1u128 into r2 as TokenIdData;
    hash.bhp256 r2 into r3 as field;
    cast r0 into r4 as u128;
    call alphaswap_v1x5.aleo/burn_from r3 self.caller r4 into r5;
    call credits.aleo/transfer_public r1 r0 into r6;
    async unwrap_public r5 r6 into r7;
    output r7 as wrapaleo_v1x5.aleo/unwrap_public.future;

finalize unwrap_public:
    input r0 as alphaswap_v1x5.aleo/burn_from.future;
    input r1 as credits.aleo/transfer_public.future;
    await r0;
    await r1;

function wrap_private_to_public:
    input r0 as credits.aleo/credits.record;
    input r1 as u64.public;
    input r2 as address.public;
    call credits.aleo/transfer_private_to_public r0 wrapaleo_v1x5.aleo r1 into r3 r4;
    cast alphaswap_v1x5.aleo wrapaleo_v1x5.aleo 1u128 into r5 as TokenIdData;
    hash.bhp256 r5 into r6 as field;
    cast r1 into r7 as u128;
    call alphaswap_v1x5.aleo/mint_public r6 r2 r7 into r8;
    async wrap_private_to_public r4 r8 into r9;
    output r3 as credits.aleo/credits.record;
    output r9 as wrapaleo_v1x5.aleo/wrap_private_to_public.future;

finalize wrap_private_to_public:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as alphaswap_v1x5.aleo/mint_public.future;
    await r0;
    await r1;

function unwrap_public_to_private:
    input r0 as u64.public;
    input r1 as address.private;
    cast alphaswap_v1x5.aleo wrapaleo_v1x5.aleo 1u128 into r2 as TokenIdData;
    hash.bhp256 r2 into r3 as field;
    cast r0 into r4 as u128;
    call alphaswap_v1x5.aleo/burn_from r3 self.caller r4 into r5;
    call credits.aleo/transfer_public_to_private r1 r0 into r6 r7;
    async unwrap_public_to_private r5 r7 into r8;
    output r6 as credits.aleo/credits.record;
    output r8 as wrapaleo_v1x5.aleo/unwrap_public_to_private.future;

finalize unwrap_public_to_private:
    input r0 as alphaswap_v1x5.aleo/burn_from.future;
    input r1 as credits.aleo/transfer_public_to_private.future;
    await r0;
    await r1;

function init_wrapper:
    input r0 as field.public;
    input r1 as field.public;
    call alphaswap_v1x5.aleo/create_token r0 r1 6u8 0u128 wrapaleo_v1x5.aleo true true 1u128 into r2;
    async init_wrapper r2 into r3;
    output r3 as wrapaleo_v1x5.aleo/init_wrapper.future;

finalize init_wrapper:
    input r0 as alphaswap_v1x5.aleo/create_token.future;
    await r0;
