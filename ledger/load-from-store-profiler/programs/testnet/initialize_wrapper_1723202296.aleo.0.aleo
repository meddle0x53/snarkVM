import multisig_1723202296.aleo;
import aml_1723202296.aleo;
import kyc_1723202296.aleo;
import logs_1723202296.aleo;
import multisig_controller_1723202296.aleo;
import stablecoin_1723202296.aleo;

program initialize_wrapper_1723202296.aleo;

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

struct AddSigner:
    account as address;

struct RemoveSigner:
    account as address;

struct SetRequiredSigs:
    action as Action;
    required_sigs as u8;

struct MintArgs:
    to as address;
    amount as u64;
    iv as field;

closure add_signer_args:
    input r0 as address;
    cast r0 into r1 as AddSigner;
    output r1 as AddSigner;

closure add_signer_proposal:
    input r0 as AddSigner;
    input r1 as u64;
    cast aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u 0u8 into r2 as Action;
    hash.bhp256 r0 into r3 as field;
    cast r2 r3 r1 into r4 as Proposal;
    output r4 as Proposal;

function initialize_signers:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    call multisig_1723202296.aleo/initialize into r4;
    call add_signer_args r0 into r5;
    call add_signer_proposal r5 1u64 into r6;
    call multisig_1723202296.aleo/sign r6 into r7;
    call multisig_1723202296.aleo/issue_authorization self.signer r6 into r8 r9;
    call multisig_controller_1723202296.aleo/add_signer r8 r5 into r10;
    call add_signer_args r1 into r11;
    call add_signer_proposal r11 2u64 into r12;
    call multisig_1723202296.aleo/sign r12 into r13;
    call multisig_1723202296.aleo/issue_authorization self.signer r12 into r14 r15;
    call multisig_controller_1723202296.aleo/add_signer r14 r11 into r16;
    call add_signer_args r2 into r17;
    call add_signer_proposal r17 3u64 into r18;
    call multisig_1723202296.aleo/sign r18 into r19;
    call multisig_1723202296.aleo/issue_authorization self.signer r18 into r20 r21;
    call multisig_controller_1723202296.aleo/add_signer r20 r17 into r22;
    call add_signer_args r3 into r23;
    call add_signer_proposal r23 4u64 into r24;
    call multisig_1723202296.aleo/sign r24 into r25;
    call multisig_1723202296.aleo/issue_authorization self.signer r24 into r26 r27;
    call multisig_controller_1723202296.aleo/add_signer r26 r23 into r28;
    async initialize_signers r4 r7 r9 r10 r13 r15 r16 r19 r21 r22 r25 r27 r28 into r29;
    output r29 as initialize_wrapper_1723202296.aleo/initialize_signers.future;

finalize initialize_signers:
    input r0 as multisig_1723202296.aleo/initialize.future;
    input r1 as multisig_1723202296.aleo/sign.future;
    input r2 as multisig_1723202296.aleo/issue_authorization.future;
    input r3 as multisig_controller_1723202296.aleo/add_signer.future;
    input r4 as multisig_1723202296.aleo/sign.future;
    input r5 as multisig_1723202296.aleo/issue_authorization.future;
    input r6 as multisig_controller_1723202296.aleo/add_signer.future;
    input r7 as multisig_1723202296.aleo/sign.future;
    input r8 as multisig_1723202296.aleo/issue_authorization.future;
    input r9 as multisig_controller_1723202296.aleo/add_signer.future;
    input r10 as multisig_1723202296.aleo/sign.future;
    input r11 as multisig_1723202296.aleo/issue_authorization.future;
    input r12 as multisig_controller_1723202296.aleo/add_signer.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
    await r9;
    await r10;
    await r11;
    await r12;

closure set_required_sigs_args:
    input r0 as address;
    input r1 as u8;
    input r2 as u8;
    cast r0 r1 into r3 as Action;
    cast r3 r2 into r4 as SetRequiredSigs;
    output r4 as SetRequiredSigs;

closure set_required_sigs_proposal:
    input r0 as SetRequiredSigs;
    input r1 as u64;
    cast aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u 2u8 into r2 as Action;
    hash.bhp256 r0 into r3 as field;
    cast r2 r3 r1 into r4 as Proposal;
    output r4 as Proposal;

closure set_log_address_args:
    input r0 as address;
    cast r0 into r1 as SetLogAddress;
    output r1 as SetLogAddress;

closure set_log_address_proposal:
    input r0 as SetLogAddress;
    input r1 as u64;
    cast aleo1apxqy5z7sr5j3er465vkudd70s2m3qt70ez0l5r9aujnxy0w95ysn4eg59 0u8 into r2 as Action;
    hash.bhp256 r0 into r3 as field;
    cast r2 r3 r1 into r4 as Proposal;
    output r4 as Proposal;

function initialize_logs:
    input r0 as address.private;
    call set_required_sigs_args aleo1apxqy5z7sr5j3er465vkudd70s2m3qt70ez0l5r9aujnxy0w95ysn4eg59 0u8 1u8 into r1;
    call set_required_sigs_proposal r1 2u64 into r2;
    call multisig_1723202296.aleo/sign r2 into r3;
    call multisig_1723202296.aleo/issue_authorization self.signer r2 into r4 r5;
    call multisig_controller_1723202296.aleo/set_required_sigs r4 r1 into r6;
    call set_log_address_args r0 into r7;
    call set_log_address_proposal r7 0u64 into r8;
    call multisig_1723202296.aleo/sign r8 into r9;
    call multisig_1723202296.aleo/issue_authorization self.signer r8 into r10 r11;
    call logs_1723202296.aleo/set_log_address r10 r7 into r12;
    async initialize_logs r3 r5 r6 r9 r11 r12 into r13;
    output r13 as initialize_wrapper_1723202296.aleo/initialize_logs.future;

finalize initialize_logs:
    input r0 as multisig_1723202296.aleo/sign.future;
    input r1 as multisig_1723202296.aleo/issue_authorization.future;
    input r2 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    input r3 as multisig_1723202296.aleo/sign.future;
    input r4 as multisig_1723202296.aleo/issue_authorization.future;
    input r5 as logs_1723202296.aleo/set_log_address.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;

function initialize_stablecoin:
    call set_required_sigs_args aleo1whl59hcgjh4wateqnctm42mdtpahseelh7q8gye82a9akc8v0gqq465sqf 0u8 3u8 into r0;
    call set_required_sigs_proposal r0 3u64 into r1;
    call multisig_1723202296.aleo/sign r1 into r2;
    call multisig_1723202296.aleo/issue_authorization self.signer r1 into r3 r4;
    call multisig_controller_1723202296.aleo/set_required_sigs r3 r0 into r5;
    call set_required_sigs_args aleo1whl59hcgjh4wateqnctm42mdtpahseelh7q8gye82a9akc8v0gqq465sqf 1u8 3u8 into r6;
    call set_required_sigs_proposal r6 4u64 into r7;
    call multisig_1723202296.aleo/sign r7 into r8;
    call multisig_1723202296.aleo/issue_authorization self.signer r7 into r9 r10;
    call multisig_controller_1723202296.aleo/set_required_sigs r9 r6 into r11;
    call set_required_sigs_args aleo1sjwnzc7rh4z6zdgtu90mhand5umw7tg2ay47kqgl0lep5v3qksxqtcm5l9 0u8 1u8 into r12;
    call set_required_sigs_proposal r12 5u64 into r13;
    call multisig_1723202296.aleo/sign r13 into r14;
    call multisig_1723202296.aleo/issue_authorization self.signer r13 into r15 r16;
    call multisig_controller_1723202296.aleo/set_required_sigs r15 r12 into r17;
    call set_required_sigs_args aleo1apxqy5z7sr5j3er465vkudd70s2m3qt70ez0l5r9aujnxy0w95ysn4eg59 0u8 3u8 into r18;
    call set_required_sigs_proposal r18 6u64 into r19;
    call multisig_1723202296.aleo/sign r19 into r20;
    call multisig_1723202296.aleo/issue_authorization self.signer r19 into r21 r22;
    call multisig_controller_1723202296.aleo/set_required_sigs r21 r18 into r23;
    call set_required_sigs_args aleo169f47jgvzwcv5lnkuaujccqzq4s2rxusx85thhr33v27rk0d8cxs2f5p4q 0u8 2u8 into r24;
    call set_required_sigs_proposal r24 7u64 into r25;
    call multisig_1723202296.aleo/sign r25 into r26;
    call multisig_1723202296.aleo/issue_authorization self.signer r25 into r27 r28;
    call multisig_controller_1723202296.aleo/set_required_sigs r27 r24 into r29;
    async initialize_stablecoin r2 r4 r5 r8 r10 r11 r14 r16 r17 r20 r22 r23 r26 r28 r29 into r30;
    output r30 as initialize_wrapper_1723202296.aleo/initialize_stablecoin.future;

finalize initialize_stablecoin:
    input r0 as multisig_1723202296.aleo/sign.future;
    input r1 as multisig_1723202296.aleo/issue_authorization.future;
    input r2 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    input r3 as multisig_1723202296.aleo/sign.future;
    input r4 as multisig_1723202296.aleo/issue_authorization.future;
    input r5 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    input r6 as multisig_1723202296.aleo/sign.future;
    input r7 as multisig_1723202296.aleo/issue_authorization.future;
    input r8 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    input r9 as multisig_1723202296.aleo/sign.future;
    input r10 as multisig_1723202296.aleo/issue_authorization.future;
    input r11 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    input r12 as multisig_1723202296.aleo/sign.future;
    input r13 as multisig_1723202296.aleo/issue_authorization.future;
    input r14 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
    await r9;
    await r10;
    await r11;
    await r12;
    await r13;
    await r14;

function initialize_multisig_controller:
    call set_required_sigs_args aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u 0u8 3u8 into r0;
    call set_required_sigs_proposal r0 8u64 into r1;
    call multisig_1723202296.aleo/sign r1 into r2;
    call multisig_1723202296.aleo/issue_authorization self.signer r1 into r3 r4;
    call multisig_controller_1723202296.aleo/set_required_sigs r3 r0 into r5;
    call set_required_sigs_args aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u 1u8 3u8 into r6;
    call set_required_sigs_proposal r6 9u64 into r7;
    call multisig_1723202296.aleo/sign r7 into r8;
    call multisig_1723202296.aleo/issue_authorization self.signer r7 into r9 r10;
    call multisig_controller_1723202296.aleo/set_required_sigs r9 r6 into r11;
    call set_required_sigs_args aleo1szqveu4f8frjqfpnwyd4xdqkma09npxkv3r0qej82msd726y4y9q8zk86u 2u8 3u8 into r12;
    call set_required_sigs_proposal r12 10u64 into r13;
    call multisig_1723202296.aleo/sign r13 into r14;
    call multisig_1723202296.aleo/issue_authorization self.signer r13 into r15 r16;
    call multisig_controller_1723202296.aleo/set_required_sigs r15 r12 into r17;
    async initialize_multisig_controller r2 r4 r5 r8 r10 r11 r14 r16 r17 into r18;
    output r18 as initialize_wrapper_1723202296.aleo/initialize_multisig_controller.future;

finalize initialize_multisig_controller:
    input r0 as multisig_1723202296.aleo/sign.future;
    input r1 as multisig_1723202296.aleo/issue_authorization.future;
    input r2 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    input r3 as multisig_1723202296.aleo/sign.future;
    input r4 as multisig_1723202296.aleo/issue_authorization.future;
    input r5 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    input r6 as multisig_1723202296.aleo/sign.future;
    input r7 as multisig_1723202296.aleo/issue_authorization.future;
    input r8 as multisig_controller_1723202296.aleo/set_required_sigs.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
