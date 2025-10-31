import multisig_1723202296.aleo;
import aml_1723202296.aleo;
import kyc_1723202296.aleo;
import logs_1723202296.aleo;
import stablecoin_1723202296.aleo;

program redeem_wrapper_1723202296.aleo;

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

function split_redeem_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as u64.private;
    input r6 as u64.private;
    call stablecoin_1723202296.aleo/split_token r4 r5 r6 into r7 r8;
    call stablecoin_1723202296.aleo/redeem_private r0 r1 r2 r3 r7 into r9 r10 r11 r12;
    async split_redeem_private r12 into r13;
    output r9 as aml_1723202296.aleo/AML.record;
    output r10 as kyc_1723202296.aleo/KYC.record;
    output r11 as logs_1723202296.aleo/Redeem.record;
    output r8 as stablecoin_1723202296.aleo/Token.record;
    output r13 as redeem_wrapper_1723202296.aleo/split_redeem_private.future;

finalize split_redeem_private:
    input r0 as stablecoin_1723202296.aleo/redeem_private.future;
    await r0;

function join2_redeem_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as stablecoin_1723202296.aleo/Token.record;
    input r6 as address.private;
    call stablecoin_1723202296.aleo/join_tokens r4 r5 into r7;
    call stablecoin_1723202296.aleo/redeem_private r0 r1 r2 r3 r7 into r8 r9 r10 r11;
    async join2_redeem_private r11 into r12;
    output r8 as aml_1723202296.aleo/AML.record;
    output r9 as kyc_1723202296.aleo/KYC.record;
    output r10 as logs_1723202296.aleo/Redeem.record;
    output r12 as redeem_wrapper_1723202296.aleo/join2_redeem_private.future;

finalize join2_redeem_private:
    input r0 as stablecoin_1723202296.aleo/redeem_private.future;
    await r0;

function join3_redeem_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as stablecoin_1723202296.aleo/Token.record;
    input r6 as stablecoin_1723202296.aleo/Token.record;
    input r7 as address.private;
    call stablecoin_1723202296.aleo/join_tokens r4 r5 into r8;
    call stablecoin_1723202296.aleo/join_tokens r8 r6 into r9;
    call stablecoin_1723202296.aleo/redeem_private r0 r1 r2 r3 r9 into r10 r11 r12 r13;
    async join3_redeem_private r13 into r14;
    output r10 as aml_1723202296.aleo/AML.record;
    output r11 as kyc_1723202296.aleo/KYC.record;
    output r12 as logs_1723202296.aleo/Redeem.record;
    output r14 as redeem_wrapper_1723202296.aleo/join3_redeem_private.future;

finalize join3_redeem_private:
    input r0 as stablecoin_1723202296.aleo/redeem_private.future;
    await r0;

function join4_redeem_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as stablecoin_1723202296.aleo/Token.record;
    input r6 as stablecoin_1723202296.aleo/Token.record;
    input r7 as stablecoin_1723202296.aleo/Token.record;
    input r8 as address.private;
    call stablecoin_1723202296.aleo/join_tokens r4 r5 into r9;
    call stablecoin_1723202296.aleo/join_tokens r9 r6 into r10;
    call stablecoin_1723202296.aleo/join_tokens r10 r7 into r11;
    call stablecoin_1723202296.aleo/redeem_private r0 r1 r2 r3 r11 into r12 r13 r14 r15;
    async join4_redeem_private r15 into r16;
    output r12 as aml_1723202296.aleo/AML.record;
    output r13 as kyc_1723202296.aleo/KYC.record;
    output r14 as logs_1723202296.aleo/Redeem.record;
    output r16 as redeem_wrapper_1723202296.aleo/join4_redeem_private.future;

finalize join4_redeem_private:
    input r0 as stablecoin_1723202296.aleo/redeem_private.future;
    await r0;

function join2_split_redeem_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as stablecoin_1723202296.aleo/Token.record;
    input r6 as u64.private;
    input r7 as u64.private;
    call stablecoin_1723202296.aleo/join_tokens r4 r5 into r8;
    call stablecoin_1723202296.aleo/split_token r8 r6 r7 into r9 r10;
    call stablecoin_1723202296.aleo/redeem_private r0 r1 r2 r3 r9 into r11 r12 r13 r14;
    async join2_split_redeem_private r14 into r15;
    output r11 as aml_1723202296.aleo/AML.record;
    output r12 as kyc_1723202296.aleo/KYC.record;
    output r13 as logs_1723202296.aleo/Redeem.record;
    output r10 as stablecoin_1723202296.aleo/Token.record;
    output r15 as redeem_wrapper_1723202296.aleo/join2_split_redeem_private.future;

finalize join2_split_redeem_private:
    input r0 as stablecoin_1723202296.aleo/redeem_private.future;
    await r0;

function join3_split_redeem_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as stablecoin_1723202296.aleo/Token.record;
    input r6 as stablecoin_1723202296.aleo/Token.record;
    input r7 as u64.private;
    input r8 as u64.private;
    call stablecoin_1723202296.aleo/join_tokens r4 r5 into r9;
    call stablecoin_1723202296.aleo/join_tokens r9 r6 into r10;
    call stablecoin_1723202296.aleo/split_token r10 r7 r8 into r11 r12;
    call stablecoin_1723202296.aleo/redeem_private r0 r1 r2 r3 r11 into r13 r14 r15 r16;
    async join3_split_redeem_private r16 into r17;
    output r13 as aml_1723202296.aleo/AML.record;
    output r14 as kyc_1723202296.aleo/KYC.record;
    output r15 as logs_1723202296.aleo/Redeem.record;
    output r12 as stablecoin_1723202296.aleo/Token.record;
    output r17 as redeem_wrapper_1723202296.aleo/join3_split_redeem_private.future;

finalize join3_split_redeem_private:
    input r0 as stablecoin_1723202296.aleo/redeem_private.future;
    await r0;

function join4_split_redeem_private:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as kyc_1723202296.aleo/KYC.record;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as stablecoin_1723202296.aleo/Token.record;
    input r6 as stablecoin_1723202296.aleo/Token.record;
    input r7 as stablecoin_1723202296.aleo/Token.record;
    input r8 as u64.private;
    input r9 as u64.private;
    call stablecoin_1723202296.aleo/join_tokens r4 r5 into r10;
    call stablecoin_1723202296.aleo/join_tokens r10 r6 into r11;
    call stablecoin_1723202296.aleo/join_tokens r11 r7 into r12;
    call stablecoin_1723202296.aleo/split_token r12 r8 r9 into r13 r14;
    call stablecoin_1723202296.aleo/redeem_private r0 r1 r2 r3 r13 into r15 r16 r17 r18;
    async join4_split_redeem_private r18 into r19;
    output r15 as aml_1723202296.aleo/AML.record;
    output r16 as kyc_1723202296.aleo/KYC.record;
    output r17 as logs_1723202296.aleo/Redeem.record;
    output r14 as stablecoin_1723202296.aleo/Token.record;
    output r19 as redeem_wrapper_1723202296.aleo/join4_split_redeem_private.future;

finalize join4_split_redeem_private:
    input r0 as stablecoin_1723202296.aleo/redeem_private.future;
    await r0;
