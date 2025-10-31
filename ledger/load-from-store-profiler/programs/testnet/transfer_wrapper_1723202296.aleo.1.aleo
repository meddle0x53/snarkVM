import multisig_1723202296.aleo;
import aml_1723202296.aleo;
import kyc_1723202296.aleo;
import logs_1723202296.aleo;
import stablecoin_1723202296.aleo;

program transfer_wrapper_1723202296.aleo;

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

function split_transfer_pri_to_pri:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as address.private;
    input r4 as u64.private;
    input r5 as u64.private;
    call stablecoin_1723202296.aleo/split_token r2 r4 r5 into r6 r7;
    call stablecoin_1723202296.aleo/transfer_private r0 r1 r7 r3 into r8 r9 r10 r11;
    async split_transfer_pri_to_pri r11 into r12;
    output r8 as aml_1723202296.aleo/AML.record;
    output r9 as logs_1723202296.aleo/Transfer.record;
    output r6 as stablecoin_1723202296.aleo/Token.record;
    output r10 as stablecoin_1723202296.aleo/Token.record;
    output r12 as transfer_wrapper_1723202296.aleo/split_transfer_pri_to_pri.future;

finalize split_transfer_pri_to_pri:
    input r0 as stablecoin_1723202296.aleo/transfer_private.future;
    await r0;

function join2_transfer_pri_to_pri:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as stablecoin_1723202296.aleo/Token.record;
    input r4 as address.private;
    call stablecoin_1723202296.aleo/join_tokens r2 r3 into r5;
    call stablecoin_1723202296.aleo/transfer_private r0 r1 r5 r4 into r6 r7 r8 r9;
    async join2_transfer_pri_to_pri r9 into r10;
    output r6 as aml_1723202296.aleo/AML.record;
    output r7 as logs_1723202296.aleo/Transfer.record;
    output r8 as stablecoin_1723202296.aleo/Token.record;
    output r10 as transfer_wrapper_1723202296.aleo/join2_transfer_pri_to_pri.future;

finalize join2_transfer_pri_to_pri:
    input r0 as stablecoin_1723202296.aleo/transfer_private.future;
    await r0;

function join3_transfer_pri_to_pri:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as stablecoin_1723202296.aleo/Token.record;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as address.private;
    call stablecoin_1723202296.aleo/join_tokens r2 r3 into r6;
    call stablecoin_1723202296.aleo/join_tokens r6 r4 into r7;
    call stablecoin_1723202296.aleo/transfer_private r0 r1 r7 r5 into r8 r9 r10 r11;
    async join3_transfer_pri_to_pri r11 into r12;
    output r8 as aml_1723202296.aleo/AML.record;
    output r9 as logs_1723202296.aleo/Transfer.record;
    output r10 as stablecoin_1723202296.aleo/Token.record;
    output r12 as transfer_wrapper_1723202296.aleo/join3_transfer_pri_to_pri.future;

finalize join3_transfer_pri_to_pri:
    input r0 as stablecoin_1723202296.aleo/transfer_private.future;
    await r0;

function join2_split_transfer_pri_to_pri:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as stablecoin_1723202296.aleo/Token.record;
    input r4 as address.private;
    input r5 as u64.private;
    input r6 as u64.private;
    call stablecoin_1723202296.aleo/join_tokens r2 r3 into r7;
    call stablecoin_1723202296.aleo/split_token r7 r5 r6 into r8 r9;
    call stablecoin_1723202296.aleo/transfer_private r0 r1 r9 r4 into r10 r11 r12 r13;
    async join2_split_transfer_pri_to_pri r13 into r14;
    output r10 as aml_1723202296.aleo/AML.record;
    output r11 as logs_1723202296.aleo/Transfer.record;
    output r8 as stablecoin_1723202296.aleo/Token.record;
    output r12 as stablecoin_1723202296.aleo/Token.record;
    output r14 as transfer_wrapper_1723202296.aleo/join2_split_transfer_pri_to_pri.future;

finalize join2_split_transfer_pri_to_pri:
    input r0 as stablecoin_1723202296.aleo/transfer_private.future;
    await r0;

function join3_split_transfer_pri_to_pri:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as stablecoin_1723202296.aleo/Token.record;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as address.private;
    input r6 as u64.private;
    input r7 as u64.private;
    call stablecoin_1723202296.aleo/join_tokens r2 r3 into r8;
    call stablecoin_1723202296.aleo/join_tokens r8 r4 into r9;
    call stablecoin_1723202296.aleo/split_token r9 r6 r7 into r10 r11;
    call stablecoin_1723202296.aleo/transfer_private r0 r1 r11 r5 into r12 r13 r14 r15;
    async join3_split_transfer_pri_to_pri r15 into r16;
    output r12 as aml_1723202296.aleo/AML.record;
    output r13 as logs_1723202296.aleo/Transfer.record;
    output r10 as stablecoin_1723202296.aleo/Token.record;
    output r14 as stablecoin_1723202296.aleo/Token.record;
    output r16 as transfer_wrapper_1723202296.aleo/join3_split_transfer_pri_to_pri.future;

finalize join3_split_transfer_pri_to_pri:
    input r0 as stablecoin_1723202296.aleo/transfer_private.future;
    await r0;

function split_transfer_pri_to_pub:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as address.private;
    input r4 as u64.private;
    input r5 as u64.private;
    call stablecoin_1723202296.aleo/split_token r2 r4 r5 into r6 r7;
    call stablecoin_1723202296.aleo/transfer_private_to_public r0 r1 r7 r3 into r8 r9 r10;
    async split_transfer_pri_to_pub r10 into r11;
    output r8 as aml_1723202296.aleo/AML.record;
    output r9 as logs_1723202296.aleo/Transfer.record;
    output r6 as stablecoin_1723202296.aleo/Token.record;
    output r11 as transfer_wrapper_1723202296.aleo/split_transfer_pri_to_pub.future;

finalize split_transfer_pri_to_pub:
    input r0 as stablecoin_1723202296.aleo/transfer_private_to_public.future;
    await r0;

function join2_transfer_pri_to_pub:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as stablecoin_1723202296.aleo/Token.record;
    input r4 as address.private;
    call stablecoin_1723202296.aleo/join_tokens r2 r3 into r5;
    call stablecoin_1723202296.aleo/transfer_private_to_public r0 r1 r5 r4 into r6 r7 r8;
    async join2_transfer_pri_to_pub r8 into r9;
    output r6 as aml_1723202296.aleo/AML.record;
    output r7 as logs_1723202296.aleo/Transfer.record;
    output r9 as transfer_wrapper_1723202296.aleo/join2_transfer_pri_to_pub.future;

finalize join2_transfer_pri_to_pub:
    input r0 as stablecoin_1723202296.aleo/transfer_private_to_public.future;
    await r0;

function join3_transfer_pri_to_pub:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as stablecoin_1723202296.aleo/Token.record;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as address.private;
    call stablecoin_1723202296.aleo/join_tokens r2 r3 into r6;
    call stablecoin_1723202296.aleo/join_tokens r6 r4 into r7;
    call stablecoin_1723202296.aleo/transfer_private_to_public r0 r1 r7 r5 into r8 r9 r10;
    async join3_transfer_pri_to_pub r10 into r11;
    output r8 as aml_1723202296.aleo/AML.record;
    output r9 as logs_1723202296.aleo/Transfer.record;
    output r11 as transfer_wrapper_1723202296.aleo/join3_transfer_pri_to_pub.future;

finalize join3_transfer_pri_to_pub:
    input r0 as stablecoin_1723202296.aleo/transfer_private_to_public.future;
    await r0;

function join2_split_transfer_pri_to_pub:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as stablecoin_1723202296.aleo/Token.record;
    input r4 as address.private;
    input r5 as u64.private;
    input r6 as u64.private;
    call stablecoin_1723202296.aleo/join_tokens r2 r3 into r7;
    call stablecoin_1723202296.aleo/split_token r7 r5 r6 into r8 r9;
    call stablecoin_1723202296.aleo/transfer_private_to_public r0 r1 r9 r4 into r10 r11 r12;
    async join2_split_transfer_pri_to_pub r12 into r13;
    output r10 as aml_1723202296.aleo/AML.record;
    output r11 as logs_1723202296.aleo/Transfer.record;
    output r8 as stablecoin_1723202296.aleo/Token.record;
    output r13 as transfer_wrapper_1723202296.aleo/join2_split_transfer_pri_to_pub.future;

finalize join2_split_transfer_pri_to_pub:
    input r0 as stablecoin_1723202296.aleo/transfer_private_to_public.future;
    await r0;

function join3_split_transfer_pri_to_pub:
    input r0 as aml_1723202296.aleo/AML.record;
    input r1 as address.private;
    input r2 as stablecoin_1723202296.aleo/Token.record;
    input r3 as stablecoin_1723202296.aleo/Token.record;
    input r4 as stablecoin_1723202296.aleo/Token.record;
    input r5 as address.private;
    input r6 as u64.private;
    input r7 as u64.private;
    call stablecoin_1723202296.aleo/join_tokens r2 r3 into r8;
    call stablecoin_1723202296.aleo/join_tokens r8 r4 into r9;
    call stablecoin_1723202296.aleo/split_token r9 r6 r7 into r10 r11;
    call stablecoin_1723202296.aleo/transfer_private_to_public r0 r1 r11 r5 into r12 r13 r14;
    async join3_split_transfer_pri_to_pub r14 into r15;
    output r12 as aml_1723202296.aleo/AML.record;
    output r13 as logs_1723202296.aleo/Transfer.record;
    output r10 as stablecoin_1723202296.aleo/Token.record;
    output r15 as transfer_wrapper_1723202296.aleo/join3_split_transfer_pri_to_pub.future;

finalize join3_split_transfer_pri_to_pub:
    input r0 as stablecoin_1723202296.aleo/transfer_private_to_public.future;
    await r0;
