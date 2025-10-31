import credits.aleo;

program gotesttest.aleo;

function main:
    input r0 as u32.public;
    input r1 as u32.private;
    add r0 r1 into r2;
    output r2 as u32.private;

function getsigner:
    output self.signer as address.private;

function getcaller:
    output self.caller as address.private;

function claim:
    input r0 as u64.public;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async claim r1 into r2;
    output r2 as gotesttest.aleo/claim.future;

finalize claim:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
