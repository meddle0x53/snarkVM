program emoducks_test_v0.aleo;

struct CoreData:
    metadata as [field; 4u32];
    uri as [field; 4u32];
    baby as field;

record NFT:
    owner as address.private;
    data as CoreData.private;
    edition as scalar.private;

record NFTView:
    owner as address.private;
    data as CoreData.private;
    edition as scalar.private;
    is_view as boolean.private;

struct Approval:
    approver as address;
    spender as address;

struct NftContent:
    data as CoreData;
    edition as scalar;

struct MutatableData:
    mania as field;
    sadness as field;
    counter as u8;

mapping for_all_approvals:
    key as field.public;
    value as boolean.public;

mapping general_settings:
    key as u8.public;
    value as field.public;

mapping nft_approvals:
    key as field.public;
    value as field.public;

mapping nft_commits:
    key as field.public;
    value as boolean.public;

mapping nft_contents:
    key as field.public;
    value as NftContent.public;

mapping nft_owners:
    key as field.public;
    value as address.public;

mapping nft_mutatable_data:
    key as field.public;
    value as MutatableData.public;

function transfer_private:
    input r0 as NFT.record;
    input r1 as address.private;
    cast r1 r0.data r0.edition into r2 as NFT.record;
    output r2 as NFT.record;

function transfer_public:
    input r0 as CoreData.private;
    input r1 as scalar.private;
    input r2 as address.public;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    cast r2 r0 r1 true into r5 as NFTView.record;
    async transfer_public r2 r4 self.caller into r6;
    output r5 as NFTView.record;
    output r6 as emoducks_test_v0.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    get nft_owners[r1] into r3;
    assert.eq r2 r3;
    remove nft_approvals[r1];
    set r0 into nft_owners[r1];

function transfer_public_as_signer:
    input r0 as CoreData.private;
    input r1 as scalar.private;
    input r2 as address.public;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    cast r2 r0 r1 true into r5 as NFTView.record;
    async transfer_public_as_signer r2 r4 self.signer into r6;
    output r5 as NFTView.record;
    output r6 as emoducks_test_v0.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    get nft_owners[r1] into r3;
    assert.eq r2 r3;
    remove nft_approvals[r1];
    set r0 into nft_owners[r1];

function transfer_private_to_public:
    input r0 as NFT.record;
    input r1 as address.public;
    hash.bhp256 r0.data into r2 as field;
    commit.bhp256 r2 r0.edition into r3 as field;
    cast r1 r0.data r0.edition true into r4 as NFTView.record;
    async transfer_private_to_public r1 r3 into r5;
    output r4 as NFTView.record;
    output r5 as emoducks_test_v0.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as field.public;
    set r0 into nft_owners[r1];

function transfer_public_to_private:
    input r0 as CoreData.private;
    input r1 as scalar.private;
    input r2 as address.private;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    async transfer_public_to_private self.caller r4 into r5;
    cast r2 r0 r1 into r6 as NFT.record;
    output r6 as NFT.record;
    output r5 as emoducks_test_v0.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as field.public;
    get nft_owners[r1] into r2;
    assert.eq r0 r2;
    remove nft_approvals[r1];
    remove nft_owners[r1];

function publish_nft_content:
    input r0 as CoreData.public;
    input r1 as scalar.public;
    hash.bhp256 r0 into r2 as field;
    commit.bhp256 r2 r1 into r3 as field;
    async publish_nft_content r3 r0 r1 into r4;
    output r4 as emoducks_test_v0.aleo/publish_nft_content.future;

finalize publish_nft_content:
    input r0 as field.public;
    input r1 as CoreData.public;
    input r2 as scalar.public;
    cast r1 r2 into r3 as NftContent;
    set r3 into nft_contents[r0];

function update_edition_private:
    input r0 as NFT.record;
    input r1 as scalar.private;
    cast r0.owner r0.data r1 into r2 as NFT.record;
    hash.bhp256 r0.data into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    async update_edition_private r4 into r5;
    output r2 as NFT.record;
    output r5 as emoducks_test_v0.aleo/update_edition_private.future;

finalize update_edition_private:
    input r0 as field.public;
    contains nft_commits[r0] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into nft_commits[r0];

function set_for_all_approval:
    input r0 as address.private;
    input r1 as boolean.public;
    cast self.caller r0 into r2 as Approval;
    hash.bhp256 r2 into r3 as field;
    async set_for_all_approval r3 r1 into r4;
    output r4 as emoducks_test_v0.aleo/set_for_all_approval.future;

finalize set_for_all_approval:
    input r0 as field.public;
    input r1 as boolean.public;
    set r1 into for_all_approvals[r0];

function approve_public:
    input r0 as address.private;
    input r1 as CoreData.private;
    input r2 as scalar.private;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    cast self.caller r0 into r5 as Approval;
    hash.bhp256 r5 into r6 as field;
    async approve_public self.caller r6 r4 into r7;
    output r7 as emoducks_test_v0.aleo/approve_public.future;

finalize approve_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get nft_owners[r2] into r3;
    assert.eq r3 r0;
    set r1 into nft_approvals[r2];

closure initialize_core:
    input r0 as field;
    hash.bhp256 r0 into r1 as u32;
    cast 0field 0field 0field 0field into r2 as [field; 4u32];
    cast 0field 0field 0field 0field into r3 as [field; 4u32];
    rem r1 100u32 into r4;
    cast r4 into r5 as field;
    cast r2 r3 r5 into r6 as CoreData;
    output r6 as CoreData;

function mint_private:
    hash.bhp256 self.caller into r0 as field;
    call initialize_core r0 into r1;
    hash.bhp256 r0 into r2 as u32;
    cast r2 into r3 as u32;
    shr r3 2u32 into r4;
    rem r4 100u32 into r5;
    cast r5 into r6 as field;
    cast r2 into r7 as u32;
    shr r7 4u32 into r8;
    rem r8 100u32 into r9;
    cast r9 into r10 as field;
    cast r6 r10 0u8 into r11 as MutatableData;
    hash.bhp256 r1 into r12 as field;
    commit.bhp256 r12 1scalar into r13 as field;
    cast self.caller r1 1scalar into r14 as NFT.record;
    hash.bhp256 self.caller into r15 as field;
    async mint_private r15 r13 r11 into r16;
    output r14 as NFT.record;
    output r16 as emoducks_test_v0.aleo/mint_private.future;

finalize mint_private:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as MutatableData.public;
    contains nft_commits[r1] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set true into nft_commits[r1];
    set r2 into nft_mutatable_data[r1];

function mutate_emoduck:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as boolean.private;
    hash.bhp256 self.caller into r3 as field;
    async mutate_emoduck r0 r1 r3 r2 into r4;
    output r4 as emoducks_test_v0.aleo/mutate_emoduck.future;

finalize mutate_emoduck:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as boolean.public;
    not r3 into r4;
    branch.eq r4 false to end_then_0_0;
    get nft_owners[r1] into r5;
    hash.bhp256 r5 into r6 as field;
    assert.eq r6 r2;
    contains nft_contents[r1] into r7;
    assert.eq r7 true;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    contains nft_mutatable_data[r1] into r8;
    assert.eq r8 true;
    get nft_mutatable_data[r1] into r9;
    lt r9.counter 5u8 into r10;
    assert.eq r10 true;
    hash.bhp256 r0 into r11 as u32;
    rem r11 100u32 into r12;
    shr r11 2u32 into r13;
    rem r13 100u32 into r14;
    cast r12 into r15 as field;
    cast r14 into r16 as field;
    add r9.counter 1u8 into r17;
    cast r15 r16 r17 into r18 as MutatableData;
    remove nft_mutatable_data[r1];
    set r18 into nft_mutatable_data[r1];

function mint_public:
    hash.bhp256 self.caller into r0 as field;
    call initialize_core r0 into r1;
    hash.bhp256 r0 into r2 as u32;
    cast r2 into r3 as u32;
    shr r3 2u32 into r4;
    rem r4 100u32 into r5;
    cast r5 into r6 as field;
    cast r2 into r7 as u32;
    shr r7 4u32 into r8;
    rem r8 100u32 into r9;
    cast r9 into r10 as field;
    cast r6 r10 0u8 into r11 as MutatableData;
    hash.bhp256 r1 into r12 as field;
    commit.bhp256 r12 1scalar into r13 as field;
    async mint_public r13 r1 1scalar r11 self.caller into r14;
    output r1 as CoreData.private;
    output r14 as emoducks_test_v0.aleo/mint_public.future;

finalize mint_public:
    input r0 as field.public;
    input r1 as CoreData.public;
    input r2 as scalar.public;
    input r3 as MutatableData.public;
    input r4 as address.public;
    cast r1 r2 into r5 as NftContent;
    contains nft_contents[r0] into r6;
    not r6 into r7;
    assert.eq r7 true;
    contains nft_commits[r0] into r8;
    not r8 into r9;
    assert.eq r9 true;
    set r5 into nft_contents[r0];
    set r4 into nft_owners[r0];
    set true into nft_commits[r0];
    contains nft_mutatable_data[r0] into r10;
    not r10 into r11;
    assert.eq r11 true;
    set r3 into nft_mutatable_data[r0];
