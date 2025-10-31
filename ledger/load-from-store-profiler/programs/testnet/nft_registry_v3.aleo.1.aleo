import nft_records_v3.aleo;

program nft_registry_v3.aleo;

struct Data:
    metadata as field;

struct Approval:
    collection_id as field;
    approver as address;
    spender as address;

struct NFTId:
    collection_id as field;
    nft_commit as field;

struct NFTContent:
    data as Data;
    edition as scalar;

mapping nft_ids:
    key as field.public;
    value as NFTId.public;

mapping nft_owners:
    key as field.public;
    value as address.public;

mapping for_all_approvals:
    key as field.public;
    value as boolean.public;

mapping nft_approvals:
    key as field.public;
    value as field.public;

mapping nft_contents:
    key as field.public;
    value as NFTContent.public;

function set_collection_admin:
    input r0 as field.private;
    input r1 as address.public;
    input r2 as boolean.public;
    assert.eq self.caller nft_collections_v3.aleo;
    cast r0 into r3 as Data;
    hash.bhp256 r3 into r4 as field;
    commit.bhp256 r4 0scalar into r5 as field;
    cast 0field r5 into r6 as NFTId;
    hash.bhp256 r6 into r7 as field;
    async set_collection_admin r7 r6 r1 r2 into r8;
    output r8 as nft_registry_v3.aleo/set_collection_admin.future;

finalize set_collection_admin:
    input r0 as field.public;
    input r1 as NFTId.public;
    input r2 as address.public;
    input r3 as boolean.public;
    contains nft_ids[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    set r1 into nft_ids[r0];
    branch.eq r3 false to end_then_0_0;
    set r2 into nft_owners[r0];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function mint_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as address.private;
    input r2 as Data.private;
    input r3 as scalar.private;
    assert.eq r0.collection_id 0field;
    hash.bhp256 r2 into r4 as field;
    commit.bhp256 r4 r3 into r5 as field;
    cast r0.data.metadata r5 into r6 as NFTId;
    hash.bhp256 r6 into r7 as field;
    call nft_records_v3.aleo/mint_nft r1 r0.data.metadata r2 r3 into r8;
    async mint_private r7 r6 into r9;
    output r8 as nft_records_v3.aleo/NFT.record;
    output r9 as nft_registry_v3.aleo/mint_private.future;

finalize mint_private:
    input r0 as field.public;
    input r1 as NFTId.public;
    contains nft_ids[r0] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r1 into nft_ids[r0];

function mint_private_as_public:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as Data.private;
    input r3 as scalar.private;
    hash.bhp256 r2 into r4 as field;
    commit.bhp256 r4 r3 into r5 as field;
    cast r1 r5 into r6 as NFTId;
    hash.bhp256 r6 into r7 as field;
    call nft_records_v3.aleo/mint_nft r0 r1 r2 r3 into r8;
    cast r1 into r9 as Data;
    hash.bhp256 r9 into r10 as field;
    commit.bhp256 r10 0scalar into r11 as field;
    cast 0field r11 into r12 as NFTId;
    hash.bhp256 r12 into r13 as field;
    async mint_private_as_public r7 r6 r13 self.caller into r14;
    output r8 as nft_records_v3.aleo/NFT.record;
    output r14 as nft_registry_v3.aleo/mint_private_as_public.future;

finalize mint_private_as_public:
    input r0 as field.public;
    input r1 as NFTId.public;
    input r2 as field.public;
    input r3 as address.public;
    contains nft_ids[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    set r1 into nft_ids[r0];
    get nft_owners[r2] into r6;
    assert.eq r6 r3;

function mint_public_as_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as address.public;
    input r2 as Data.private;
    input r3 as scalar.private;
    assert.eq r0.collection_id 0field;
    call nft_records_v3.aleo/mint_nft_view r1 r2 r3 into r4;
    hash.bhp256 r2 into r5 as field;
    commit.bhp256 r5 r3 into r6 as field;
    cast r0.data.metadata r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    async mint_public_as_private r8 r7 r1 into r9;
    output r4 as nft_records_v3.aleo/NFTView.record;
    output r9 as nft_registry_v3.aleo/mint_public_as_private.future;

finalize mint_public_as_private:
    input r0 as field.public;
    input r1 as NFTId.public;
    input r2 as address.public;
    contains nft_ids[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into nft_ids[r0];
    set r2 into nft_owners[r0];

function mint_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as Data.private;
    input r3 as scalar.private;
    call nft_records_v3.aleo/mint_nft_view r0 r2 r3 into r4;
    hash.bhp256 r2 into r5 as field;
    commit.bhp256 r5 r3 into r6 as field;
    cast r1 r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    cast r1 into r9 as Data;
    hash.bhp256 r9 into r10 as field;
    commit.bhp256 r10 0scalar into r11 as field;
    cast 0field r11 into r12 as NFTId;
    hash.bhp256 r12 into r13 as field;
    async mint_public self.caller r8 r7 r0 r13 into r14;
    output r4 as nft_records_v3.aleo/NFTView.record;
    output r14 as nft_registry_v3.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as NFTId.public;
    input r3 as address.public;
    input r4 as field.public;
    get nft_owners[r4] into r5;
    assert.eq r5 r0;
    contains nft_ids[r1] into r6;
    not r6 into r7;
    assert.eq r7 true;
    set r2 into nft_ids[r1];
    set r3 into nft_owners[r1];

function burn_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as nft_records_v3.aleo/NFT.record;
    assert.eq r0.collection_id 0field;
    assert.eq r0.data.metadata r1.collection_id;
    call nft_records_v3.aleo/burn_nft r1;

function burn_private_as_public:
    input r0 as nft_records_v3.aleo/NFT.record;
    cast r0.collection_id into r1 as Data;
    hash.bhp256 r1 into r2 as field;
    commit.bhp256 r2 0scalar into r3 as field;
    cast 0field r3 into r4 as NFTId;
    hash.bhp256 r4 into r5 as field;
    call nft_records_v3.aleo/burn_nft r0;
    async burn_private_as_public self.caller r5 into r6;
    output r6 as nft_registry_v3.aleo/burn_private_as_public.future;

finalize burn_private_as_public:
    input r0 as address.public;
    input r1 as field.public;
    get nft_owners[r1] into r2;
    assert.eq r2 r0;

function burn_public_as_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as Data.private;
    input r2 as scalar.private;
    assert.eq r0.collection_id 0field;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    cast r0.data.metadata r4 into r5 as NFTId;
    hash.bhp256 r5 into r6 as field;
    async burn_public_as_private r0.data.metadata self.caller r6 into r7;
    output r7 as nft_registry_v3.aleo/burn_public_as_private.future;

finalize burn_public_as_private:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    get nft_owners[r2] into r3;
    assert.eq r1 r3;
    remove nft_approvals[r2];
    remove nft_owners[r2];

function burn_public:
    input r0 as field.private;
    input r1 as Data.private;
    input r2 as scalar.private;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    cast r0 r4 into r5 as NFTId;
    hash.bhp256 r5 into r6 as field;
    cast r0 into r7 as Data;
    hash.bhp256 r7 into r8 as field;
    commit.bhp256 r8 0scalar into r9 as field;
    cast 0field r9 into r10 as NFTId;
    hash.bhp256 r10 into r11 as field;
    async burn_public self.caller r6 r11 into r12;
    output r12 as nft_registry_v3.aleo/burn_public.future;

finalize burn_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get nft_owners[r2] into r3;
    assert.eq r3 r0;
    get nft_owners[r1] into r4;
    assert.eq r0 r4;
    remove nft_approvals[r1];
    remove nft_owners[r1];

function transfer_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as address.private;
    call nft_records_v3.aleo/transfer_nft r0 r1 into r2;
    output r2 as nft_records_v3.aleo/NFT.record;

function transfer_private_to_public:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as address.public;
    call nft_records_v3.aleo/burn_nft r0;
    call nft_records_v3.aleo/mint_nft_view r1 r0.data r0.edition into r2;
    hash.bhp256 r0.data into r3 as field;
    commit.bhp256 r3 r0.edition into r4 as field;
    cast r0.collection_id r4 into r5 as NFTId;
    hash.bhp256 r5 into r6 as field;
    async transfer_private_to_public r1 r6 into r7;
    output r2 as nft_records_v3.aleo/NFTView.record;
    output r7 as nft_registry_v3.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as field.public;
    set r0 into nft_owners[r1];

function transfer_public:
    input r0 as field.private;
    input r1 as Data.private;
    input r2 as scalar.private;
    input r3 as address.public;
    call nft_records_v3.aleo/mint_nft_view r3 r1 r2 into r4;
    hash.bhp256 r1 into r5 as field;
    commit.bhp256 r5 r2 into r6 as field;
    cast r0 r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    async transfer_public r3 r8 self.caller into r9;
    output r4 as nft_records_v3.aleo/NFTView.record;
    output r9 as nft_registry_v3.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    get nft_owners[r1] into r3;
    assert.eq r2 r3;
    remove nft_approvals[r1];
    set r0 into nft_owners[r1];

function transfer_public_as_signer:
    input r0 as field.private;
    input r1 as Data.private;
    input r2 as scalar.private;
    input r3 as address.public;
    call nft_records_v3.aleo/mint_nft_view r3 r1 r2 into r4;
    hash.bhp256 r1 into r5 as field;
    commit.bhp256 r5 r2 into r6 as field;
    cast r0 r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    async transfer_public_as_signer r3 r8 self.signer into r9;
    output r4 as nft_records_v3.aleo/NFTView.record;
    output r9 as nft_registry_v3.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    get nft_owners[r1] into r3;
    assert.eq r2 r3;
    remove nft_approvals[r1];
    set r0 into nft_owners[r1];

function transfer_public_to_private:
    input r0 as field.private;
    input r1 as Data.private;
    input r2 as scalar.private;
    input r3 as address.private;
    hash.bhp256 r1 into r4 as field;
    commit.bhp256 r4 r2 into r5 as field;
    cast r0 r5 into r6 as NFTId;
    hash.bhp256 r6 into r7 as field;
    call nft_records_v3.aleo/mint_nft r3 r0 r1 r2 into r8;
    async transfer_public_to_private self.caller r7 into r9;
    output r8 as nft_records_v3.aleo/NFT.record;
    output r9 as nft_registry_v3.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as field.public;
    get nft_owners[r1] into r2;
    assert.eq r0 r2;
    remove nft_approvals[r1];
    remove nft_owners[r1];

function set_for_all_approval:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as boolean.public;
    cast r0 self.caller r1 into r3 as Approval;
    hash.bhp256 r3 into r4 as field;
    async set_for_all_approval r4 r2 into r5;
    output r5 as nft_registry_v3.aleo/set_for_all_approval.future;

finalize set_for_all_approval:
    input r0 as field.public;
    input r1 as boolean.public;
    set r1 into for_all_approvals[r0];

function approve_public:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as Data.private;
    input r3 as scalar.private;
    hash.bhp256 r2 into r4 as field;
    commit.bhp256 r4 r3 into r5 as field;
    cast r0 r5 into r6 as NFTId;
    hash.bhp256 r6 into r7 as field;
    cast r0 self.caller r1 into r8 as Approval;
    hash.bhp256 r8 into r9 as field;
    async approve_public self.caller r9 r7 into r10;
    output r10 as nft_registry_v3.aleo/approve_public.future;

finalize approve_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get nft_owners[r2] into r3;
    assert.eq r3 r0;
    set r1 into nft_approvals[r2];

function unapprove_public:
    input r0 as field.private;
    input r1 as Data.private;
    input r2 as scalar.private;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    cast r0 r4 into r5 as NFTId;
    hash.bhp256 r5 into r6 as field;
    async unapprove_public self.caller r6 into r7;
    output r7 as nft_registry_v3.aleo/unapprove_public.future;

finalize unapprove_public:
    input r0 as address.public;
    input r1 as field.public;
    get nft_owners[r1] into r2;
    assert.eq r2 r0;
    remove nft_approvals[r1];

function transfer_from_public:
    input r0 as field.private;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as Data.private;
    input r4 as scalar.private;
    hash.bhp256 r3 into r5 as field;
    commit.bhp256 r5 r4 into r6 as field;
    cast r0 r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    cast r0 r1 self.caller into r9 as Approval;
    hash.bhp256 r9 into r10 as field;
    call nft_records_v3.aleo/mint_nft_view r2 r3 r4 into r11;
    async transfer_from_public r10 r1 r2 r8 into r12;
    output r11 as nft_records_v3.aleo/NFTView.record;
    output r12 as nft_registry_v3.aleo/transfer_from_public.future;

finalize transfer_from_public:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as field.public;
    contains nft_approvals[r3] into r4;
    get.or_use for_all_approvals[r0] false into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    get nft_owners[r3] into r7;
    assert.eq r1 r7;
    remove nft_approvals[r3];
    set r2 into nft_owners[r3];

function transfer_from_public_to_private:
    input r0 as field.private;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as Data.private;
    input r4 as scalar.private;
    hash.bhp256 r3 into r5 as field;
    commit.bhp256 r5 r4 into r6 as field;
    cast r0 r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    cast r0 r1 self.signer into r9 as Approval;
    hash.bhp256 r9 into r10 as field;
    call nft_records_v3.aleo/mint_nft r2 r0 r3 r4 into r11;
    async transfer_from_public_to_private r10 r1 r8 into r12;
    output r11 as nft_records_v3.aleo/NFT.record;
    output r12 as nft_registry_v3.aleo/transfer_from_public_to_private.future;

finalize transfer_from_public_to_private:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    contains nft_approvals[r2] into r3;
    get.or_use for_all_approvals[r0] false into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    get nft_owners[r2] into r6;
    assert.eq r1 r6;
    remove nft_approvals[r2];
    remove nft_owners[r2];

function update_edition_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as nft_records_v3.aleo/NFT.record;
    input r2 as scalar.private;
    assert.eq r0.collection_id 0field;
    assert.eq r1.collection_id r0.data.metadata;
    call nft_records_v3.aleo/update_nft_edition r1 r2 into r3;
    hash.bhp256 r1.data into r4 as field;
    commit.bhp256 r4 r2 into r5 as field;
    cast r1.collection_id r5 into r6 as NFTId;
    hash.bhp256 r6 into r7 as field;
    async update_edition_private r7 r6 into r8;
    output r3 as nft_records_v3.aleo/NFT.record;
    output r8 as nft_registry_v3.aleo/update_edition_private.future;

finalize update_edition_private:
    input r0 as field.public;
    input r1 as NFTId.public;
    contains nft_ids[r0] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r1 into nft_ids[r0];

function publish_nft_content:
    input r0 as Data.public;
    input r1 as scalar.public;
    hash.bhp256 r0 into r2 as field;
    commit.bhp256 r2 r1 into r3 as field;
    cast r0 r1 into r4 as NFTContent;
    async publish_nft_content r3 r4 into r5;
    output r5 as nft_registry_v3.aleo/publish_nft_content.future;

finalize publish_nft_content:
    input r0 as field.public;
    input r1 as NFTContent.public;
    set r1 into nft_contents[r0];
