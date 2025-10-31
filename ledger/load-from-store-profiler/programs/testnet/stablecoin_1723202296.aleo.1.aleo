import multisig_1723202296.aleo;
import kyc_1723202296.aleo;
import aml_1723202296.aleo;
import logs_1723202296.aleo;

program stablecoin_1723202296.aleo;

struct Action:
    program_address as address;
    action_id as u8;

struct Proposal:
    action as Action;
    argument_hash as field;
    nonce as u64;

struct Signature:
    proposal as Proposal;
    signer as address;

struct IssueKYC:
    owner_ as address;
    account as address;
    expiry_block_height as u32;
    secret as field;

struct Block:
    account as address;

struct Unblock:
    account as address;

struct SetLogAddress:
    account as address;

record Token:
    owner as address.private;
    amount as u64.private;

struct MintArgs:
    to as address;
    amount as u64;
    iv as field;

mapping public_balance:
    key as address.public;
    value as u64.public;

function split_token:
    input r0 as Token.record;
    input r1 as u64.private;
    input r2 as u64.private;
    add r1 r2 into r3;
    assert.eq r0.amount r3;
    cast r0.owner r1 into r4 as Token.record;
    cast r0.owner r2 into r5 as Token.record;
    output r4 as Token.record;
    output r5 as Token.record;

function join_tokens:
    input r0 as Token.record;
    input r1 as Token.record;
    add r0.amount r1.amount into r2;
    cast r0.owner r2 into r3 as Token.record;
    output r3 as Token.record;

function mint_public:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as aml_1723202296.aleo/AML.record;
    input r2 as kyc_1723202296.aleo/KYC.record;
    input r3 as u32.private;
    input r4 as address.private;
    input r5 as MintArgs.private;
    hash.bhp256 r5 into r6 as field;
    call multisig_1723202296.aleo/verify r0 0u8 r6 into r7;
    call aml_1723202296.aleo/verify_aml r1 into r8 r9;
    call kyc_1723202296.aleo/verify_kyc r2 r3 into r10 r11;
    call logs_1723202296.aleo/log_mint r4 r5.to r5.amount false into r12 r13;
    assert.eq r5.to r1.account;
    assert.eq r5.to r2.account;
    async mint_public r7 r9 r11 r13 r5 into r14;
    output r8 as aml_1723202296.aleo/AML.record;
    output r10 as kyc_1723202296.aleo/KYC.record;
    output r12 as logs_1723202296.aleo/Mint.record;
    output r14 as stablecoin_1723202296.aleo/mint_public.future;

finalize mint_public:
    input r0 as multisig_1723202296.aleo/verify.future;
    input r1 as aml_1723202296.aleo/verify_aml.future;
    input r2 as kyc_1723202296.aleo/verify_kyc.future;
    input r3 as logs_1723202296.aleo/log_mint.future;
    input r4 as MintArgs.public;
    await r0;
    await r1;
    await r2;
    await r3;
    get.or_use public_balance[r4.to] 0u64 into r5;
    add r5 r4.amount into r6;
    set r6 into public_balance[r4.to];

function mint_private:
    input r0 as multisig_1723202296.aleo/Authorization.record;
    input r1 as aml_1723202296.aleo/AML.record;
    input r2 as kyc_1723202296.aleo/KYC.record;
    input r3 as u32.private;
    input r4 as address.private;
    input r5 as MintArgs.private;
    hash.bhp256 r5 into r6 as field;
    call multisig_1723202296.aleo/verify r0 0u8 r6 into r7;
    assert.eq r5.to r1.account;
    assert.eq r5.to r2.account;
    call aml_1723202296.aleo/verify_aml r1 into r8 r9;
    call kyc_1723202296.aleo/verify_kyc r2 r3 into r10 r11;
    call logs_1723202296.aleo/log_mint r4 r5.to r5.amount true into r12 r13;
    cast r5.to r5.amount into r14 as Token.record;
    async mint_private r7 r9 r11 r13 into r15;
    output r8 as aml_1723202296.aleo/AML.record;
    output r10 as kyc_1723202296.aleo/KYC.record;
    output r12 as logs_1723202296.aleo/Mint.record;
    output r14 as Token.record;
    output r15 as stablecoin_1723202296.aleo/mint_private.future;

finalize mint_private:
    input r0 as multisig_1723202296.aleo/verify.future;
    input r1 as aml_1723202296.aleo/verify_aml.future;
    input r2 as kyc_1723202296.aleo/verify_kyc.future;
    input r3 as logs_1723202296.aleo/log_mint.future;
    await r0;
    await r1;
    await r2;
    await r3;

function redeem_public:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as u64.private;
    assert.eq self.signer r0.account;
    assert.eq self.signer r1.account;
    call aml_1723202296.aleo/verify_aml r0 into r5 r6;
    call kyc_1723202296.aleo/verify_kyc r1 r2 into r7 r8;
    call logs_1723202296.aleo/log_redeem r3 self.signer r4 false into r9 r10;
    async redeem_public r6 r8 r10 self.signer r4 into r11;
    output r5 as aml_1723202296.aleo/AML.record;
    output r7 as kyc_1723202296.aleo/KYC.record;
    output r9 as logs_1723202296.aleo/Redeem.record;
    output r11 as stablecoin_1723202296.aleo/redeem_public.future;

finalize redeem_public:
    input r0 as aml_1723202296.aleo/verify_aml.future;
    input r1 as kyc_1723202296.aleo/verify_kyc.future;
    input r2 as logs_1723202296.aleo/log_redeem.future;
    input r3 as address.public;
    input r4 as u64.public;
    await r0;
    await r1;
    await r2;
    get.or_use public_balance[r3] 0u64 into r5;
    sub r5 r4 into r6;
    set r6 into public_balance[r3];

function redeem_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as Token.record;
    assert.eq self.signer r0.account;
    assert.eq self.signer r1.account;
    call aml_1723202296.aleo/verify_aml r0 into r5 r6;
    call kyc_1723202296.aleo/verify_kyc r1 r2 into r7 r8;
    call logs_1723202296.aleo/log_redeem r3 self.signer r4.amount true into r9 r10;
    async redeem_private r6 r8 r10 into r11;
    output r5 as aml_1723202296.aleo/AML.record;
    output r7 as kyc_1723202296.aleo/KYC.record;
    output r9 as logs_1723202296.aleo/Redeem.record;
    output r11 as stablecoin_1723202296.aleo/redeem_private.future;

finalize redeem_private:
    input r0 as aml_1723202296.aleo/verify_aml.future;
    input r1 as kyc_1723202296.aleo/verify_kyc.future;
    input r2 as logs_1723202296.aleo/log_redeem.future;
    await r0;
    await r1;
    await r2;

function transfer_public:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as address.public;
    input r3 as u64.public;
    assert.eq self.signer r0.account;
    call aml_1723202296.aleo/verify_aml r0 into r4 r5;
    call logs_1723202296.aleo/log_transfer r1 self.signer r2 r3 false false into r6 r7;
    async transfer_public r5 r7 self.signer r2 r3 into r8;
    output r4 as aml_1723202296.aleo/AML.record;
    output r6 as logs_1723202296.aleo/Transfer.record;
    output r8 as stablecoin_1723202296.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as aml_1723202296.aleo/verify_aml.future;
    input r1 as logs_1723202296.aleo/log_transfer.future;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as u64.public;
    await r0;
    await r1;
    get.or_use public_balance[r2] 0u64 into r5;
    sub r5 r4 into r6;
    set r6 into public_balance[r2];
    get.or_use public_balance[r3] 0u64 into r7;
    add r7 r4 into r8;
    set r8 into public_balance[r3];

function transfer_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as Token.record;
    input r3 as address.private;
    assert.eq self.signer r0.account;
    call aml_1723202296.aleo/verify_aml r0 into r4 r5;
    call logs_1723202296.aleo/log_transfer r1 self.signer r3 r2.amount true true into r6 r7;
    cast r3 r2.amount into r8 as Token.record;
    async transfer_private r5 r7 into r9;
    output r4 as aml_1723202296.aleo/AML.record;
    output r6 as logs_1723202296.aleo/Transfer.record;
    output r8 as Token.record;
    output r9 as stablecoin_1723202296.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as aml_1723202296.aleo/verify_aml.future;
    input r1 as logs_1723202296.aleo/log_transfer.future;
    await r0;
    await r1;

function transfer_private_to_public:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as Token.record;
    input r3 as address.public;
    assert.eq self.signer r0.account;
    call aml_1723202296.aleo/verify_aml r0 into r4 r5;
    call logs_1723202296.aleo/log_transfer r1 self.signer r3 r2.amount true false into r6 r7;
    async transfer_private_to_public r5 r7 r3 r2.amount into r8;
    output r4 as aml_1723202296.aleo/AML.record;
    output r6 as logs_1723202296.aleo/Transfer.record;
    output r8 as stablecoin_1723202296.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as aml_1723202296.aleo/verify_aml.future;
    input r1 as logs_1723202296.aleo/log_transfer.future;
    input r2 as address.public;
    input r3 as u64.public;
    await r0;
    await r1;
    get.or_use public_balance[r2] 0u64 into r4;
    add r4 r3 into r5;
    set r5 into public_balance[r2];

function transfer_public_to_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as u64.public;
    assert.eq self.signer r0.account;
    call aml_1723202296.aleo/verify_aml r0 into r4 r5;
    call logs_1723202296.aleo/log_transfer r1 self.signer r2 r3 false true into r6 r7;
    cast r2 r3 into r8 as Token.record;
    async transfer_public_to_private r5 r7 self.signer r3 into r9;
    output r4 as aml_1723202296.aleo/AML.record;
    output r6 as logs_1723202296.aleo/Transfer.record;
    output r8 as Token.record;
    output r9 as stablecoin_1723202296.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as aml_1723202296.aleo/verify_aml.future;
    input r1 as logs_1723202296.aleo/log_transfer.future;
    input r2 as address.public;
    input r3 as u64.public;
    await r0;
    await r1;
    get.or_use public_balance[r2] 0u64 into r4;
    sub r4 r3 into r5;
    set r5 into public_balance[r2];
