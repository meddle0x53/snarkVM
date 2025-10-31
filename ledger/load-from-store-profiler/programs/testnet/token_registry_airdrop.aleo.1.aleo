import credits.aleo;
import token_registry.aleo;

program token_registry_airdrop.aleo;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct Project:
    admin as address;
    token_id as field;
    merkle_root as field;

struct Airdrop:
    project_id as field;
    recipient as address;
    amount as u128;

mapping projects:
    key as field.public;
    value as Project.public;

mapping claimed:
    key as field.public;
    value as boolean.public;

function create_airdrop_project:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u128.public;
    call token_registry.aleo/transfer_public_as_signer r1 token_registry_airdrop.aleo r3 into r4;
    async create_airdrop_project r0 self.caller r1 r2 r4 into r5;
    output r5 as token_registry_airdrop.aleo/create_airdrop_project.future;

finalize create_airdrop_project:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as token_registry.aleo/transfer_public_as_signer.future;
    cast r1 r2 r3 into r5 as Project;
    contains projects[r0] into r6;
    not r6 into r7;
    assert.eq r7 true;
    set r5 into projects[r0];
    await r4;

function update_airdrop_project:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    async update_airdrop_project r0 self.caller r1 r2 into r3;
    output r3 as token_registry_airdrop.aleo/update_airdrop_project.future;

finalize update_airdrop_project:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as field.public;
    get projects[r0] into r4;
    assert.eq r1 r4.admin;
    cast r2 r4.token_id r3 into r5 as Project;
    set r5 into projects[r0];

function claim_airdrop:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as scalar.private;
    input r4 as u128.private;
    input r5 as [field; 9u32].public;
    cast r0 self.signer r4 into r6 as Airdrop;
    hash.bhp256 r6 into r7 as field;
    commit.bhp256 r7 r3 into r8 as field;
    cast r8 r5[0u32] into r9 as [field; 2u32];
    hash.bhp256 r9 into r10 as field;
    cast r10 r5[1u32] into r11 as [field; 2u32];
    hash.bhp256 r11 into r12 as field;
    cast r12 r5[2u32] into r13 as [field; 2u32];
    hash.bhp256 r13 into r14 as field;
    cast r14 r5[3u32] into r15 as [field; 2u32];
    hash.bhp256 r15 into r16 as field;
    cast r16 r5[4u32] into r17 as [field; 2u32];
    hash.bhp256 r17 into r18 as field;
    cast r18 r5[5u32] into r19 as [field; 2u32];
    hash.bhp256 r19 into r20 as field;
    cast r20 r5[6u32] into r21 as [field; 2u32];
    hash.bhp256 r21 into r22 as field;
    cast r22 r5[7u32] into r23 as [field; 2u32];
    hash.bhp256 r23 into r24 as field;
    cast r24 r5[8u32] into r25 as [field; 2u32];
    hash.bhp256 r25 into r26 as field;
    assert.eq r26 r2;
    call token_registry.aleo/transfer_public_to_private r1 self.signer r4 false into r27 r28;
    async claim_airdrop r8 r0 r2 r1 r28 into r29;
    output r27 as token_registry.aleo/Token.record;
    output r29 as token_registry_airdrop.aleo/claim_airdrop.future;

finalize claim_airdrop:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as token_registry.aleo/transfer_public_to_private.future;
    contains claimed[r0] into r5;
    not r5 into r6;
    assert.eq r6 true;
    set true into claimed[r0];
    get projects[r1] into r7;
    assert.eq r2 r7.merkle_root;
    assert.eq r3 r7.token_id;
    await r4;
