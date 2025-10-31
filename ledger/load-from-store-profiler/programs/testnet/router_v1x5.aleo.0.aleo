import config_v1x5.aleo;
import alphaswap_v1x5.aleo;

program router_v1x5.aleo;

function swap_exact_tokens_for_tokens_1:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u128.public;
    input r5 as address.public;
    assert.neq r3 0u128;
    call alphaswap_v1x5.aleo/transfer_from_public r0 self.caller router_v1x5.aleo r3 into r6;
    call alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens r0 r1 r3 0u128 router_v1x5.aleo into r7;
    call alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens r1 r2 340282366920938463463374607431768211455u128 r4 r5 into r8;
    async swap_exact_tokens_for_tokens_1 r6 r7 r8 into r9;
    output r9 as router_v1x5.aleo/swap_exact_tokens_for_tokens_1.future;

finalize swap_exact_tokens_for_tokens_1:
    input r0 as alphaswap_v1x5.aleo/transfer_from_public.future;
    input r1 as alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens.future;
    input r2 as alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens.future;
    await r0;
    await r1;
    await r2;

function swap_exact_tokens_for_tokens_2:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u128.public;
    input r5 as u128.public;
    input r6 as address.public;
    assert.neq r4 0u128;
    call alphaswap_v1x5.aleo/transfer_from_public r0 self.caller router_v1x5.aleo r4 into r7;
    call alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens r0 r1 r4 0u128 router_v1x5.aleo into r8;
    call alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens r1 r2 340282366920938463463374607431768211455u128 0u128 router_v1x5.aleo into r9;
    call alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens r2 r3 340282366920938463463374607431768211455u128 r5 r6 into r10;
    async swap_exact_tokens_for_tokens_2 r7 r8 r9 r10 into r11;
    output r11 as router_v1x5.aleo/swap_exact_tokens_for_tokens_2.future;

finalize swap_exact_tokens_for_tokens_2:
    input r0 as alphaswap_v1x5.aleo/transfer_from_public.future;
    input r1 as alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens.future;
    input r2 as alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens.future;
    input r3 as alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens.future;
    await r0;
    await r1;
    await r2;
    await r3;

function swap_exact_private_for_public:
    input r0 as alphaswap_v1x5.aleo/PrivateToken.record;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as address.public;
    assert.neq r2 0u128;
    call alphaswap_v1x5.aleo/transfer_private_to_public r0 router_v1x5.aleo r2 into r5 r6;
    call alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens r0.token r1 r2 r3 r4 into r7;
    async swap_exact_private_for_public r6 r7 into r8;
    output r5 as alphaswap_v1x5.aleo/PrivateToken.record;
    output r8 as router_v1x5.aleo/swap_exact_private_for_public.future;

finalize swap_exact_private_for_public:
    input r0 as alphaswap_v1x5.aleo/transfer_private_to_public.future;
    input r1 as alphaswap_v1x5.aleo/swap_exact_tokens_for_tokens.future;
    await r0;
    await r1;

function swap_private_for_exact_public:
    input r0 as alphaswap_v1x5.aleo/PrivateToken.record;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as address.public;
    input r5 as address.public;
    assert.neq r3 0u128;
    call alphaswap_v1x5.aleo/transfer_private_to_public r0 router_v1x5.aleo r2 into r6 r7;
    call alphaswap_v1x5.aleo/swap_tokens_for_exact_tokens r0.token r1 r2 r3 r4 into r8;
    call alphaswap_v1x5.aleo/transfer_all_public r0.token r5 into r9;
    async swap_private_for_exact_public r7 r8 r9 into r10;
    output r6 as alphaswap_v1x5.aleo/PrivateToken.record;
    output r10 as router_v1x5.aleo/swap_private_for_exact_public.future;

finalize swap_private_for_exact_public:
    input r0 as alphaswap_v1x5.aleo/transfer_private_to_public.future;
    input r1 as alphaswap_v1x5.aleo/swap_tokens_for_exact_tokens.future;
    input r2 as alphaswap_v1x5.aleo/transfer_all_public.future;
    await r0;
    await r1;
    await r2;
