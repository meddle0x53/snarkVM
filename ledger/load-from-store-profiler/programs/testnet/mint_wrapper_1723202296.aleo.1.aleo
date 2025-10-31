import multisig_1723202296.aleo;
import aml_1723202296.aleo;
import kyc_1723202296.aleo;
import logs_1723202296.aleo;
import stablecoin_1723202296.aleo;

program mint_wrapper_1723202296.aleo;

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

struct Block:
    account as address;

struct Unblock:
    account as address;

struct IssueKYC:
    owner_ as address;
    account as address;
    expiry_block_height as u32;
    secret as field;

struct SetLogAddress:
    account as address;

struct MintArgs:
    to as address;
    amount as u64;
    iv as field;

record MintProposalNotification:
    owner as address.private;
    args as MintArgs.private;
    nonce as u64.private;

closure mint_proposal:
    input r0 as MintArgs;
    input r1 as u64;
    cast aleo169f47jgvzwcv5lnkuaujccqzq4s2rxusx85thhr33v27rk0d8cxs2f5p4q 0u8 into r2 as Action;
    hash.bhp256 r0 into r3 as field;
    cast r2 r3 r1 into r4 as Proposal;
    output r4 as Proposal;

function sign_issue_mint_public:
    input r0 as MintArgs.private;
    input r1 as u64.private;
    input r2 as aml_1723202296.aleo/AML.record;
    input r3 as kyc_1723202296.aleo/KYC.record;
    input r4 as u32.private;
    input r5 as address.private;
    call mint_proposal r0 r1 into r6;
    call multisig_1723202296.aleo/sign r6 into r7;
    call multisig_1723202296.aleo/issue_authorization self.signer r6 into r8 r9;
    call stablecoin_1723202296.aleo/mint_public r8 r2 r3 r4 r5 r0 into r10 r11 r12 r13;
    async sign_issue_mint_public r7 r9 r13 into r14;
    output r14 as mint_wrapper_1723202296.aleo/sign_issue_mint_public.future;

finalize sign_issue_mint_public:
    input r0 as multisig_1723202296.aleo/sign.future;
    input r1 as multisig_1723202296.aleo/issue_authorization.future;
    input r2 as stablecoin_1723202296.aleo/mint_public.future;
    await r0;
    await r1;
    await r2;

function sign_issue_mint_private:
    input r0 as MintArgs.private;
    input r1 as u64.private;
    input r2 as aml_1723202296.aleo/AML.record;
    input r3 as kyc_1723202296.aleo/KYC.record;
    input r4 as u32.private;
    input r5 as address.private;
    call mint_proposal r0 r1 into r6;
    call multisig_1723202296.aleo/sign r6 into r7;
    call multisig_1723202296.aleo/issue_authorization self.signer r6 into r8 r9;
    call stablecoin_1723202296.aleo/mint_private r8 r2 r3 r4 r5 r0 into r10 r11 r12 r13 r14;
    async sign_issue_mint_private r7 r9 r14 into r15;
    output r15 as mint_wrapper_1723202296.aleo/sign_issue_mint_private.future;

finalize sign_issue_mint_private:
    input r0 as multisig_1723202296.aleo/sign.future;
    input r1 as multisig_1723202296.aleo/issue_authorization.future;
    input r2 as stablecoin_1723202296.aleo/mint_private.future;
    await r0;
    await r1;
    await r2;

function sign_notify_1:
    input r0 as MintArgs.private;
    input r1 as u64.private;
    input r2 as address.private;
    call mint_proposal r0 r1 into r3;
    call multisig_1723202296.aleo/sign r3 into r4;
    cast r2 r0 r1 into r5 as MintProposalNotification.record;
    async sign_notify_1 r4 into r6;
    output r5 as MintProposalNotification.record;
    output r6 as mint_wrapper_1723202296.aleo/sign_notify_1.future;

finalize sign_notify_1:
    input r0 as multisig_1723202296.aleo/sign.future;
    await r0;

function sign_notify_2:
    input r0 as MintArgs.private;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    call mint_proposal r0 r1 into r4;
    call multisig_1723202296.aleo/sign r4 into r5;
    cast r2 r0 r1 into r6 as MintProposalNotification.record;
    cast r3 r0 r1 into r7 as MintProposalNotification.record;
    async sign_notify_2 r5 into r8;
    output r6 as MintProposalNotification.record;
    output r7 as MintProposalNotification.record;
    output r8 as mint_wrapper_1723202296.aleo/sign_notify_2.future;

finalize sign_notify_2:
    input r0 as multisig_1723202296.aleo/sign.future;
    await r0;

function sign_notify_3:
    input r0 as MintArgs.private;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    call mint_proposal r0 r1 into r5;
    call multisig_1723202296.aleo/sign r5 into r6;
    cast r2 r0 r1 into r7 as MintProposalNotification.record;
    cast r3 r0 r1 into r8 as MintProposalNotification.record;
    cast r4 r0 r1 into r9 as MintProposalNotification.record;
    async sign_notify_3 r6 into r10;
    output r7 as MintProposalNotification.record;
    output r8 as MintProposalNotification.record;
    output r9 as MintProposalNotification.record;
    output r10 as mint_wrapper_1723202296.aleo/sign_notify_3.future;

finalize sign_notify_3:
    input r0 as multisig_1723202296.aleo/sign.future;
    await r0;

function dismiss:
    input r0 as MintProposalNotification.record;

function dismiss_sign:
    input r0 as MintProposalNotification.record;
    call mint_proposal r0.args r0.nonce into r1;
    call multisig_1723202296.aleo/sign r1 into r2;
    async dismiss_sign r2 into r3;
    output r3 as mint_wrapper_1723202296.aleo/dismiss_sign.future;

finalize dismiss_sign:
    input r0 as multisig_1723202296.aleo/sign.future;
    await r0;

function dismiss_sign_issue_mint_public:
    input r0 as MintProposalNotification.record;
    input r1 as aml_1723202296.aleo/AML.record;
    input r2 as kyc_1723202296.aleo/KYC.record;
    input r3 as u32.private;
    input r4 as address.private;
    call mint_proposal r0.args r0.nonce into r5;
    call multisig_1723202296.aleo/sign r5 into r6;
    call multisig_1723202296.aleo/issue_authorization self.signer r5 into r7 r8;
    call stablecoin_1723202296.aleo/mint_public r7 r1 r2 r3 r4 r0.args into r9 r10 r11 r12;
    async dismiss_sign_issue_mint_public r6 r8 r12 into r13;
    output r13 as mint_wrapper_1723202296.aleo/dismiss_sign_issue_mint_public.future;

finalize dismiss_sign_issue_mint_public:
    input r0 as multisig_1723202296.aleo/sign.future;
    input r1 as multisig_1723202296.aleo/issue_authorization.future;
    input r2 as stablecoin_1723202296.aleo/mint_public.future;
    await r0;
    await r1;
    await r2;

function dismiss_sign_issue_mint_private:
    input r0 as MintProposalNotification.record;
    input r1 as aml_1723202296.aleo/AML.record;
    input r2 as kyc_1723202296.aleo/KYC.record;
    input r3 as u32.private;
    input r4 as address.private;
    call mint_proposal r0.args r0.nonce into r5;
    call multisig_1723202296.aleo/sign r5 into r6;
    call multisig_1723202296.aleo/issue_authorization self.signer r5 into r7 r8;
    call stablecoin_1723202296.aleo/mint_private r7 r1 r2 r3 r4 r0.args into r9 r10 r11 r12 r13;
    async dismiss_sign_issue_mint_private r6 r8 r13 into r14;
    output r14 as mint_wrapper_1723202296.aleo/dismiss_sign_issue_mint_private.future;

finalize dismiss_sign_issue_mint_private:
    input r0 as multisig_1723202296.aleo/sign.future;
    input r1 as multisig_1723202296.aleo/issue_authorization.future;
    input r2 as stablecoin_1723202296.aleo/mint_private.future;
    await r0;
    await r1;
    await r2;
