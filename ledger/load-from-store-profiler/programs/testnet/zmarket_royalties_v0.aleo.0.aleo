import nft_records_v0.aleo;
import nft_registry_v0.aleo;
import nft_collections_v0.aleo;

program zmarket_royalties_v0.aleo;

struct Data:
    metadata as field;

struct NFTId:
    collection_id as field;
    nft_commit as field;

struct NFTContent:
    data as Data;
    edition as scalar;

struct CollectionMetadata:
    collection_id as field;
    base_uri as [field; 4u32];
    metadata_uri as [field; 4u32];

mapping royalties:
    key as field.public;
    value as u16.public;

function initialize_marketplace:
    input r0 as u16.public;
    input r1 as u16.public;
    input r2 as [field; 4u32].public;
    input r3 as [field; 4u32].public;
    input r4 as [field; 4u32].public;
    input r5 as [field; 4u32].public;
    assert.eq self.caller aleo1wamjqlka7d0gazlxdys6n8e8zeee3ymedwvw8elvh7529kwd45rq0plgax;
    call nft_collections_v0.aleo/register_collection_public 1234field r2 r3 into r6 r7;
    call nft_collections_v0.aleo/register_collection_public 5678field r4 r5 into r8 r9;
    call nft_registry_v0.aleo/transfer_public 0field r6.data r6.edition self.caller into r10 r11;
    call nft_registry_v0.aleo/transfer_public 0field r8.data r8.edition self.caller into r12 r13;
    cast 1234field into r14 as Data;
    call nft_registry_v0.aleo/mint_public self.caller 1234field r14 0scalar into r15 r16;
    cast 5678field into r17 as Data;
    call nft_registry_v0.aleo/mint_public self.caller 1234field r17 0scalar into r18 r19;
    async initialize_marketplace r0 r1 r7 r9 r11 r13 r16 r19 into r20;
    output r20 as zmarket_royalties_v0.aleo/initialize_marketplace.future;

finalize initialize_marketplace:
    input r0 as u16.public;
    input r1 as u16.public;
    input r2 as nft_collections_v0.aleo/register_collection_public.future;
    input r3 as nft_collections_v0.aleo/register_collection_public.future;
    input r4 as nft_registry_v0.aleo/transfer_public.future;
    input r5 as nft_registry_v0.aleo/transfer_public.future;
    input r6 as nft_registry_v0.aleo/mint_public.future;
    input r7 as nft_registry_v0.aleo/mint_public.future;
    lte r0 10000u16 into r8;
    assert.eq r8 true;
    set r0 into royalties[5678field];
    lte r1 10000u16 into r9;
    assert.eq r9 true;
    set r1 into royalties[1234field];
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;

function list_collection_private:
    input r0 as nft_records_v0.aleo/NFT.record;
    input r1 as address.private;
    input r2 as u16.public;
    input r3 as field.public;
    is.eq r0.collection_id 5678field into r4;
    is.eq r0.collection_id 0field into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    ternary r4 r3 r0.data.metadata into r7;
    cast r7 into r8 as Data;
    call nft_registry_v0.aleo/mint_private_as_public r1 1234field r8 0scalar into r9 r10;
    async list_collection_private r7 r2 r10 into r11;
    output r9 as nft_records_v0.aleo/NFT.record;
    output r11 as zmarket_royalties_v0.aleo/list_collection_private.future;

finalize list_collection_private:
    input r0 as field.public;
    input r1 as u16.public;
    input r2 as nft_registry_v0.aleo/mint_private_as_public.future;
    contains royalties[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    lte r1 10000u16 into r5;
    assert.eq r5 true;
    set r1 into royalties[r0];
    await r2;

function list_collection_public:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u16.public;
    input r3 as boolean.public;
    cast r0 into r4 as Data;
    hash.bhp256 r4 into r5 as field;
    commit.bhp256 r5 0scalar into r6 as field;
    cast 0field r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    cast r0 into r9 as Data;
    call nft_registry_v0.aleo/mint_public r1 1234field r9 0scalar into r10 r11;
    async list_collection_public r3 r0 self.caller r2 r8 r11 into r12;
    output r12 as zmarket_royalties_v0.aleo/list_collection_public.future;

finalize list_collection_public:
    input r0 as boolean.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as u16.public;
    input r4 as field.public;
    input r5 as nft_registry_v0.aleo/mint_public.future;
    cast 5678field into r6 as Data;
    hash.bhp256 r6 into r7 as field;
    commit.bhp256 r7 0scalar into r8 as field;
    cast 0field r8 into r9 as NFTId;
    hash.bhp256 r9 into r10 as field;
    ternary r0 r10 r4 into r11;
    get nft_registry_v0.aleo/nft_owners[r11] into r12;
    assert.eq r12 r2;
    contains royalties[r1] into r13;
    not r13 into r14;
    assert.eq r14 true;
    lte r3 10000u16 into r15;
    assert.eq r15 true;
    set r3 into royalties[r1];
    await r5;

function update_royalty_private:
    input r0 as nft_records_v0.aleo/NFT.record;
    input r1 as u16.public;
    input r2 as field.public;
    is.eq r0.collection_id 5678field into r3;
    is.eq r0.collection_id 0field into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    ternary r3 r2 r0.data.metadata into r6;
    async update_royalty_private r6 r1 into r7;
    output r7 as zmarket_royalties_v0.aleo/update_royalty_private.future;

finalize update_royalty_private:
    input r0 as field.public;
    input r1 as u16.public;
    contains royalties[r0] into r2;
    assert.eq r2 true;
    lte r1 10000u16 into r3;
    assert.eq r3 true;
    set r1 into royalties[r0];

function update_royalty_public:
    input r0 as field.private;
    input r1 as u16.public;
    input r2 as boolean.public;
    cast r0 into r3 as Data;
    hash.bhp256 r3 into r4 as field;
    commit.bhp256 r4 0scalar into r5 as field;
    cast 0field r5 into r6 as NFTId;
    hash.bhp256 r6 into r7 as field;
    async update_royalty_public r2 r0 r1 r7 self.caller into r8;
    output r8 as zmarket_royalties_v0.aleo/update_royalty_public.future;

finalize update_royalty_public:
    input r0 as boolean.public;
    input r1 as field.public;
    input r2 as u16.public;
    input r3 as field.public;
    input r4 as address.public;
    cast 5678field into r5 as Data;
    hash.bhp256 r5 into r6 as field;
    commit.bhp256 r6 0scalar into r7 as field;
    cast 0field r7 into r8 as NFTId;
    hash.bhp256 r8 into r9 as field;
    ternary r0 r9 r3 into r10;
    get nft_registry_v0.aleo/nft_owners[r10] into r11;
    assert.eq r11 r4;
    contains royalties[r1] into r12;
    assert.eq r12 true;
    lte r2 10000u16 into r13;
    assert.eq r13 true;
    set r2 into royalties[r1];
