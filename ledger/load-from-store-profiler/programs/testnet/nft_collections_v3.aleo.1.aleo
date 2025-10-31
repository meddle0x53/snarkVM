import nft_records_v3.aleo;
import nft_registry_v3.aleo;

program nft_collections_v3.aleo;

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

mapping registered_collections:
    key as field.public;
    value as CollectionMetadata.public;

function initialize:
    call nft_registry_v3.aleo/set_collection_admin 0field nft_registry_v3.aleo true into r0;
    async initialize r0 into r1;
    output r1 as nft_collections_v3.aleo/initialize.future;

finalize initialize:
    input r0 as nft_registry_v3.aleo/set_collection_admin.future;
    cast 0field 0field 0field 0field into r1 as [field; 4u32];
    cast 0field 0field 0field 0field into r2 as [field; 4u32];
    cast 0field r1 r2 into r3 as CollectionMetadata;
    contains registered_collections[0field] into r4;
    not r4 into r5;
    assert.eq r5 true;
    set r3 into registered_collections[0field];
    await r0;

function register_collection_public:
    input r0 as field.public;
    input r1 as [field; 4u32].public;
    input r2 as [field; 4u32].public;
    is.neq r0 0field into r3;
    assert.eq r3 true;
    cast r0 r1 r2 into r4 as CollectionMetadata;
    cast r0 into r5 as Data;
    call nft_records_v3.aleo/mint_nft_view self.caller r5 0scalar into r6;
    call nft_registry_v3.aleo/set_collection_admin r0 self.caller true into r7;
    async register_collection_public r4 r7 into r8;
    output r6 as nft_records_v3.aleo/NFTView.record;
    output r8 as nft_collections_v3.aleo/register_collection_public.future;

finalize register_collection_public:
    input r0 as CollectionMetadata.public;
    input r1 as nft_registry_v3.aleo/set_collection_admin.future;
    contains registered_collections[r0.collection_id] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r0 into registered_collections[r0.collection_id];
    await r1;

function register_collection_private:
    input r0 as field.public;
    input r1 as [field; 4u32].public;
    input r2 as [field; 4u32].public;
    is.neq r0 0field into r3;
    assert.eq r3 true;
    cast r0 r1 r2 into r4 as CollectionMetadata;
    cast r0 into r5 as Data;
    call nft_records_v3.aleo/mint_nft self.signer 0field r5 0scalar into r6;
    call nft_registry_v3.aleo/set_collection_admin r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc false into r7;
    async register_collection_private r4 r7 into r8;
    output r6 as nft_records_v3.aleo/NFT.record;
    output r8 as nft_collections_v3.aleo/register_collection_private.future;

finalize register_collection_private:
    input r0 as CollectionMetadata.public;
    input r1 as nft_registry_v3.aleo/set_collection_admin.future;
    contains registered_collections[r0.collection_id] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set r0 into registered_collections[r0.collection_id];
    await r1;

function update_collection_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as [field; 4u32].public;
    input r2 as [field; 4u32].public;
    assert.eq r0.collection_id 0field;
    cast r0.data.metadata r1 r2 into r3 as CollectionMetadata;
    async update_collection_private r3 into r4;
    output r4 as nft_collections_v3.aleo/update_collection_private.future;

finalize update_collection_private:
    input r0 as CollectionMetadata.public;
    set r0 into registered_collections[r0.collection_id];

function update_collection_public:
    input r0 as field.public;
    input r1 as [field; 4u32].public;
    input r2 as [field; 4u32].public;
    cast r0 r1 r2 into r3 as CollectionMetadata;
    cast r0 into r4 as Data;
    hash.bhp256 r4 into r5 as field;
    commit.bhp256 r5 0scalar into r6 as field;
    cast 0field r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    async update_collection_public r0 self.caller r8 r3 into r9;
    output r9 as nft_collections_v3.aleo/update_collection_public.future;

finalize update_collection_public:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as CollectionMetadata.public;
    get nft_registry_v3.aleo/nft_owners[r2] into r4;
    assert.eq r4 r1;
    set r3 into registered_collections[r0];
