import nft_records_v3.aleo;
import nft_registry_v3.aleo;
import nft_collections_v3.aleo;
import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;

program wrapped_ans_nft_v3.aleo;

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

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as field;

struct data:
    metadata as [field; 4u32];

function initialize_wrapped_ans:
    input r0 as [field; 4u32].public;
    input r1 as [field; 4u32].public;
    call nft_collections_v3.aleo/register_collection_public 123829191909212120210201field r0 r1 into r2 r3;
    async initialize_wrapped_ans r3 into r4;
    output r4 as wrapped_ans_nft_v3.aleo/initialize_wrapped_ans.future;

finalize initialize_wrapped_ans:
    input r0 as nft_collections_v3.aleo/register_collection_public.future;
    await r0;

function withdraw_ans_admin:
    input r0 as [field; 4u32].public;
    input r1 as [field; 4u32].public;
    cast 123829191909212120210201field into r2 as Data;
    call nft_registry_v3.aleo/transfer_public_to_private 0field r2 0scalar self.signer into r3 r4;
    cast self.signer into r5 as field;
    async withdraw_ans_admin r5 r4 into r6;
    output r3 as nft_records_v3.aleo/NFT.record;
    output r6 as wrapped_ans_nft_v3.aleo/withdraw_ans_admin.future;

finalize withdraw_ans_admin:
    input r0 as field.public;
    input r1 as nft_registry_v3.aleo/transfer_public_to_private.future;
    get aleo_name_service_registry_v4.aleo/general_settings[7u8] into r2;
    assert.eq r0 r2;
    await r1;

function wrap_ans_private:
    input r0 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r1 as address.private;
    call aleo_name_service_registry_v4.aleo/transfer_private_to_public r0 wrapped_ans_nft_v3.aleo into r2 r3;
    cast r0.data.metadata[0u32] into r4 as Data;
    call nft_registry_v3.aleo/mint_private_as_public r1 123829191909212120210201field r4 r0.edition into r5 r6;
    async wrap_ans_private r3 r6 into r7;
    output r5 as nft_records_v3.aleo/NFT.record;
    output r7 as wrapped_ans_nft_v3.aleo/wrap_ans_private.future;

finalize wrap_ans_private:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_private_to_public.future;
    input r1 as nft_registry_v3.aleo/mint_private_as_public.future;
    await r0;
    await r1;

function wrap_ans_private_to_public:
    input r0 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r1 as address.public;
    call aleo_name_service_registry_v4.aleo/transfer_private_to_public r0 wrapped_ans_nft_v3.aleo into r2 r3;
    cast r0.data.metadata[0u32] into r4 as Data;
    call nft_registry_v3.aleo/mint_public r1 123829191909212120210201field r4 r0.edition into r5 r6;
    async wrap_ans_private_to_public r3 r6 into r7;
    output r7 as wrapped_ans_nft_v3.aleo/wrap_ans_private_to_public.future;

finalize wrap_ans_private_to_public:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_private_to_public.future;
    input r1 as nft_registry_v3.aleo/mint_public.future;
    await r0;
    await r1;

function wrap_ans_public:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.public;
    call aleo_name_service_registry_v4.aleo/transfer_from_public self.caller wrapped_ans_nft_v3.aleo r0 r1 into r3 r4;
    cast r0.metadata[0u32] into r5 as Data;
    call nft_registry_v3.aleo/mint_public r2 123829191909212120210201field r5 r1 into r6 r7;
    async wrap_ans_public r4 r7 into r8;
    output r8 as wrapped_ans_nft_v3.aleo/wrap_ans_public.future;

finalize wrap_ans_public:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_from_public.future;
    input r1 as nft_registry_v3.aleo/mint_public.future;
    await r0;
    await r1;

function wrap_ans_public_to_private:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.public;
    call aleo_name_service_registry_v4.aleo/transfer_from_public self.caller wrapped_ans_nft_v3.aleo r0 r1 into r3 r4;
    cast r0.metadata[0u32] into r5 as Data;
    call nft_registry_v3.aleo/mint_private_as_public r2 123829191909212120210201field r5 r1 into r6 r7;
    async wrap_ans_public_to_private r4 r7 into r8;
    output r6 as nft_records_v3.aleo/NFT.record;
    output r8 as wrapped_ans_nft_v3.aleo/wrap_ans_public_to_private.future;

finalize wrap_ans_public_to_private:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_from_public.future;
    input r1 as nft_registry_v3.aleo/mint_private_as_public.future;
    await r0;
    await r1;

function unwrap_ans_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as address.private;
    cast r0.data.metadata 0field 0field 0field into r2 as [field; 4u32];
    cast r2 into r3 as data;
    call aleo_name_service_registry_v4.aleo/transfer_public_to_private r3 r0.edition r1 into r4 r5;
    call nft_registry_v3.aleo/burn_private_as_public r0 into r6;
    async unwrap_ans_private r5 r6 into r7;
    output r4 as aleo_name_service_registry_v4.aleo/NFT.record;
    output r7 as wrapped_ans_nft_v3.aleo/unwrap_ans_private.future;

finalize unwrap_ans_private:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_public_to_private.future;
    input r1 as nft_registry_v3.aleo/burn_private_as_public.future;
    await r0;
    await r1;

function unwrap_ans_private_to_public:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as address.private;
    cast r0.data.metadata 0field 0field 0field into r2 as [field; 4u32];
    cast r2 into r3 as data;
    call aleo_name_service_registry_v4.aleo/transfer_public r3 r0.edition r1 into r4 r5;
    call nft_registry_v3.aleo/burn_private_as_public r0 into r6;
    async unwrap_ans_private_to_public r5 r6 into r7;
    output r7 as wrapped_ans_nft_v3.aleo/unwrap_ans_private_to_public.future;

finalize unwrap_ans_private_to_public:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_public.future;
    input r1 as nft_registry_v3.aleo/burn_private_as_public.future;
    await r0;
    await r1;

function unwrap_ans_public:
    input r0 as Data.private;
    input r1 as scalar.private;
    input r2 as address.private;
    cast r0.metadata 0field 0field 0field into r3 as [field; 4u32];
    cast r3 into r4 as data;
    call aleo_name_service_registry_v4.aleo/transfer_public r4 r1 r2 into r5 r6;
    call nft_registry_v3.aleo/transfer_from_public 123829191909212120210201field self.caller wrapped_ans_nft_v3.aleo r0 r1 into r7 r8;
    call nft_registry_v3.aleo/burn_public 123829191909212120210201field r0 r1 into r9;
    async unwrap_ans_public r6 r8 r9 into r10;
    output r10 as wrapped_ans_nft_v3.aleo/unwrap_ans_public.future;

finalize unwrap_ans_public:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_public.future;
    input r1 as nft_registry_v3.aleo/transfer_from_public.future;
    input r2 as nft_registry_v3.aleo/burn_public.future;
    await r0;
    await r1;
    await r2;

function unwrap_ans_public_to_private:
    input r0 as Data.private;
    input r1 as scalar.private;
    input r2 as address.private;
    cast r0.metadata 0field 0field 0field into r3 as [field; 4u32];
    cast r3 into r4 as data;
    call aleo_name_service_registry_v4.aleo/transfer_public_to_private r4 r1 r2 into r5 r6;
    call nft_registry_v3.aleo/transfer_from_public 123829191909212120210201field self.caller wrapped_ans_nft_v3.aleo r0 r1 into r7 r8;
    call nft_registry_v3.aleo/burn_public 123829191909212120210201field r0 r1 into r9;
    async unwrap_ans_public_to_private r6 r8 r9 into r10;
    output r5 as aleo_name_service_registry_v4.aleo/NFT.record;
    output r10 as wrapped_ans_nft_v3.aleo/unwrap_ans_public_to_private.future;

finalize unwrap_ans_public_to_private:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_public_to_private.future;
    input r1 as nft_registry_v3.aleo/transfer_from_public.future;
    input r2 as nft_registry_v3.aleo/burn_public.future;
    await r0;
    await r1;
    await r2;

function update_base_uri:
    input r0 as [field; 4u32].public;
    input r1 as [field; 4u32].public;
    call nft_collections_v3.aleo/update_collection_public 123829191909212120210201field r0 r1 into r2;
    cast self.caller into r3 as field;
    async update_base_uri r3 r2 into r4;
    output r4 as wrapped_ans_nft_v3.aleo/update_base_uri.future;

finalize update_base_uri:
    input r0 as field.public;
    input r1 as nft_collections_v3.aleo/update_collection_public.future;
    get aleo_name_service_registry_v4.aleo/general_settings[7u8] into r2;
    assert.eq r0 r2;
    await r1;
