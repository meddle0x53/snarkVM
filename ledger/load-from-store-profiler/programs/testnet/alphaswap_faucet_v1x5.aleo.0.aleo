import config_v1x5.aleo;
import alphaswap_v1x5.aleo;

program alphaswap_faucet_v1x5.aleo;

mapping faucets:
    key as field.public;
    value as u128.public;

mapping admins:
    key as address.public;
    value as boolean.public;

function init:
    assert.eq self.caller aleo1tdszx3hcgnyp2jw3y3fzvw27vremxcs24u4pys6vptg9y2jfsvps8e8ffz;
    async init self.caller into r0;
    output r0 as alphaswap_faucet_v1x5.aleo/init.future;

finalize init:
    input r0 as address.public;
    contains admins[r0] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into admins[r0];

function claim:
    input r0 as field.public;
    input r1 as u128.public;
    assert.eq self.caller self.signer;
    call alphaswap_v1x5.aleo/transfer_public r0 self.caller r1 into r2;
    async claim r0 r1 r2 into r3;
    output r3 as alphaswap_faucet_v1x5.aleo/claim.future;

finalize claim:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as alphaswap_v1x5.aleo/transfer_public.future;
    await r2;
    get faucets[r0] into r3;
    lte r1 r3 into r4;
    assert.eq r4 true;

function set_faucet:
    input r0 as field.public;
    input r1 as u128.public;
    async set_faucet self.caller r0 r1 into r2;
    output r2 as alphaswap_faucet_v1x5.aleo/set_faucet.future;

finalize set_faucet:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get admins[r0] into r3;
    assert.eq r3 true;
    set r2 into faucets[r1];

function set_admin:
    input r0 as address.public;
    input r1 as boolean.public;
    async set_admin self.caller r0 r1 into r2;
    output r2 as alphaswap_faucet_v1x5.aleo/set_admin.future;

finalize set_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    get admins[r0] into r3;
    assert.eq r3 true;
    set r2 into admins[r1];

function withdraw:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    call alphaswap_v1x5.aleo/transfer_public r0 r1 r2 into r3;
    async withdraw self.caller r0 r2 r3 into r4;
    output r4 as alphaswap_faucet_v1x5.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as alphaswap_v1x5.aleo/transfer_public.future;
    await r3;
    get admins[r0] into r4;
    assert.eq r4 true;
