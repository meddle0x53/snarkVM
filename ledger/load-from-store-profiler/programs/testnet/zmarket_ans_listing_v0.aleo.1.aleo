import credits.aleo;
import nft_records_v0.aleo;
import nft_registry_v0.aleo;
import nft_collections_v0.aleo;
import zmarket_royalties_v0.aleo;
import zmarket_marketplace_v0.aleo;
import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;
import wrapped_ans_nft_v0.aleo;

program zmarket_ans_listing_v0.aleo;

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

function list_private:
    input r0 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r1 as field.public;
    input r2 as u64.public;
    call wrapped_ans_nft_v0.aleo/wrap_ans_private r0 self.signer into r3 r4;
    call zmarket_marketplace_v0.aleo/list_private r3 r1 r2 into r5 r6;
    async list_private r4 r6 into r7;
    output r5 as zmarket_marketplace_v0.aleo/PrivateListing.record;
    output r7 as zmarket_ans_listing_v0.aleo/list_private.future;

finalize list_private:
    input r0 as wrapped_ans_nft_v0.aleo/wrap_ans_private.future;
    input r1 as zmarket_marketplace_v0.aleo/list_private.future;
    await r0;
    await r1;

function unlist_private:
    input r0 as zmarket_marketplace_v0.aleo/PrivateListing.record;
    input r1 as field.public;
    cast r1 into r2 as Data;
    call zmarket_marketplace_v0.aleo/unlist_private r0 123829191909212120210201field r2 0scalar into r3 r4;
    call wrapped_ans_nft_v0.aleo/unwrap_ans_private r3 self.signer into r5 r6;
    async unlist_private r4 r6 into r7;
    output r5 as aleo_name_service_registry_v4.aleo/NFT.record;
    output r7 as zmarket_ans_listing_v0.aleo/unlist_private.future;

finalize unlist_private:
    input r0 as zmarket_marketplace_v0.aleo/unlist_private.future;
    input r1 as wrapped_ans_nft_v0.aleo/unwrap_ans_private.future;
    await r0;
    await r1;

function accept_private_listing:
    input r0 as field.public;
    input r1 as credits.aleo/credits.record;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as u64.public;
    cast r3 into r5 as Data;
    call zmarket_marketplace_v0.aleo/accept_withdraw_nft_pv_listing r0 r1 123829191909212120210201field r5 0scalar r4 into r6 r7;
    call wrapped_ans_nft_v0.aleo/unwrap_ans_private r6 self.signer into r8 r9;
    async accept_private_listing r7 r9 into r10;
    output r8 as aleo_name_service_registry_v4.aleo/NFT.record;
    output r10 as zmarket_ans_listing_v0.aleo/accept_private_listing.future;

finalize accept_private_listing:
    input r0 as zmarket_marketplace_v0.aleo/accept_withdraw_nft_pv_listing.future;
    input r1 as wrapped_ans_nft_v0.aleo/unwrap_ans_private.future;
    await r0;
    await r1;

function accept_private_offer:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as aleo_name_service_registry_v4.aleo/NFT.record;
    call wrapped_ans_nft_v0.aleo/wrap_ans_private r2 self.signer into r3 r4;
    call zmarket_marketplace_v0.aleo/accept_private_offer r0 r1 r3 into r5 r6;
    async accept_private_offer r4 r6 into r7;
    output r5 as credits.aleo/credits.record;
    output r7 as zmarket_ans_listing_v0.aleo/accept_private_offer.future;

finalize accept_private_offer:
    input r0 as wrapped_ans_nft_v0.aleo/wrap_ans_private.future;
    input r1 as zmarket_marketplace_v0.aleo/accept_private_offer.future;
    await r0;
    await r1;

function withdraw_nft_private_offer:
    input r0 as zmarket_marketplace_v0.aleo/PrivateOffer.record;
    input r1 as field.private;
    cast r1 into r2 as Data;
    call zmarket_marketplace_v0.aleo/withdraw_nft_private_offer r0 123829191909212120210201field r2 0scalar into r3 r4;
    call wrapped_ans_nft_v0.aleo/unwrap_ans_private r3 self.signer into r5 r6;
    async withdraw_nft_private_offer r4 r6 into r7;
    output r5 as aleo_name_service_registry_v4.aleo/NFT.record;
    output r7 as zmarket_ans_listing_v0.aleo/withdraw_nft_private_offer.future;

finalize withdraw_nft_private_offer:
    input r0 as zmarket_marketplace_v0.aleo/withdraw_nft_private_offer.future;
    input r1 as wrapped_ans_nft_v0.aleo/unwrap_ans_private.future;
    await r0;
    await r1;
