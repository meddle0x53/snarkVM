import credits.aleo;
import token_v1.aleo;

program handler_v1.aleo;

function init:
    input r0 as u64.public;
    input r1 as u64.public;
    call token_v1.aleo/initialize r0 r1 into r2;
    async init r2 into r3;
    output r3 as handler_v1.aleo/init.future;

finalize init:
    input r0 as token_v1.aleo/initialize.future;
    await r0;

function buy_token:
    input r0 as u64.public;
    call token_v1.aleo/mint_public self.caller r0 into r1;
    async buy_token r1 into r2;
    output r2 as handler_v1.aleo/buy_token.future;

finalize buy_token:
    input r0 as token_v1.aleo/mint_public.future;
    await r0;
