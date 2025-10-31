import multisig_1723202296.aleo;
import kyc_1723202296.aleo;

program kyc_wrapper_1723202296.aleo;

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

closure kyc_proposal:
    input r0 as IssueKYC;
    input r1 as u64;
    cast aleo1sjwnzc7rh4z6zdgtu90mhand5umw7tg2ay47kqgl0lep5v3qksxqtcm5l9 0u8 into r2 as Action;
    hash.bhp256 r0 into r3 as field;
    cast r2 r3 r1 into r4 as Proposal;
    output r4 as Proposal;

function sign_issue_2:
    input r0 as IssueKYC.private;
    input r1 as u64.private;
    call kyc_proposal r0 r1 into r2;
    call multisig_1723202296.aleo/sign r2 into r3;
    call multisig_1723202296.aleo/issue_authorization self.signer r2 into r4 r5;
    call kyc_1723202296.aleo/issue_kyc r4 r0 into r6 r7;
    cast r0.account r0.account r0.expiry_block_height r0.secret into r8 as IssueKYC;
    add r1 1u64 into r9;
    call kyc_proposal r8 r9 into r10;
    call multisig_1723202296.aleo/sign r10 into r11;
    call multisig_1723202296.aleo/issue_authorization self.signer r10 into r12 r13;
    call kyc_1723202296.aleo/issue_kyc r12 r8 into r14 r15;
    async sign_issue_2 r3 r5 r7 r11 r13 r15 into r16;
    output r16 as kyc_wrapper_1723202296.aleo/sign_issue_2.future;

finalize sign_issue_2:
    input r0 as multisig_1723202296.aleo/sign.future;
    input r1 as multisig_1723202296.aleo/issue_authorization.future;
    input r2 as kyc_1723202296.aleo/issue_kyc.future;
    input r3 as multisig_1723202296.aleo/sign.future;
    input r4 as multisig_1723202296.aleo/issue_authorization.future;
    input r5 as kyc_1723202296.aleo/issue_kyc.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
