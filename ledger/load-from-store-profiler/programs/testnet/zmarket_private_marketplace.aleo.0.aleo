import nft_records_v3.aleo;
import nft_registry_v3.aleo;
import nft_collections_v3.aleo;
import zmarket_royalties_v3.aleo;
import credits.aleo;

program zmarket_private_marketplace.aleo;

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

struct Trade:
    nft_id_hash as field;
    collection_id as field;
    price as u64;
    market_royalty as u16;
    creator_royalty as u16;
    is_accepted as boolean;
    is_removed as boolean;

record PrivateListing:
    owner as address.private;
    listing_id as field.private;

record AcceptedListing:
    owner as address.private;
    listing_id as field.private;

record PrivateOffer:
    owner as address.private;
    offer_id as field.private;

mapping listings:
    key as field.public;
    value as Trade.public;

mapping royalty_balances:
    key as field.public;
    value as u64.public;

mapping listing_balances:
    key as field.public;
    value as u64.public;

mapping offers:
    key as field.public;
    value as Trade.public;

function withdraw_royalty_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as u64.public;
    call credits.aleo/transfer_public_to_private self.signer r1 into r2 r3;
    assert.eq r0.collection_id 1234field;
    async withdraw_royalty_private r0.data.metadata r1 r3 into r4;
    output r2 as credits.aleo/credits.record;
    output r4 as zmarket_private_marketplace.aleo/withdraw_royalty_private.future;

finalize withdraw_royalty_private:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_to_private.future;
    get.or_use royalty_balances[r0] 0u64 into r3;
    sub r3 r1 into r4;
    set r4 into royalty_balances[r0];
    await r2;

function withdraw_royalty_public:
    input r0 as field.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public self.caller r1 into r2;
    cast r0 into r3 as Data;
    hash.bhp256 r3 into r4 as field;
    commit.bhp256 r4 0scalar into r5 as field;
    cast 1234field r5 into r6 as NFTId;
    hash.bhp256 r6 into r7 as field;
    async withdraw_royalty_public self.caller r0 r7 r1 r2 into r8;
    output r8 as zmarket_private_marketplace.aleo/withdraw_royalty_public.future;

finalize withdraw_royalty_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u64.public;
    input r4 as credits.aleo/transfer_public.future;
    get nft_registry_v3.aleo/nft_owners[r2] into r5;
    assert.eq r5 r0;
    get.or_use royalty_balances[r1] 0u64 into r6;
    sub r6 r3 into r7;
    set r7 into royalty_balances[r1];
    await r4;

function withdraw_listing_balance:
    input r0 as PrivateListing.record;
    input r1 as u64.public;
    call credits.aleo/transfer_public_to_private self.signer r1 into r2 r3;
    async withdraw_listing_balance r0.listing_id r1 r3 into r4;
    cast r0.owner r0.listing_id into r5 as PrivateListing.record;
    output r5 as PrivateListing.record;
    output r2 as credits.aleo/credits.record;
    output r4 as zmarket_private_marketplace.aleo/withdraw_listing_balance.future;

finalize withdraw_listing_balance:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_to_private.future;
    get listing_balances[r0] into r3;
    sub r3 r1 into r4;
    set r4 into listing_balances[r0];
    await r2;

function list_private:
    input r0 as nft_records_v3.aleo/NFT.record;
    input r1 as field.public;
    input r2 as u64.public;
    call nft_registry_v3.aleo/transfer_private_to_public r0 zmarket_private_marketplace.aleo into r3 r4;
    hash.bhp256 r0.data into r5 as field;
    commit.bhp256 r5 r0.edition into r6 as field;
    cast r0.collection_id r6 into r7 as NFTId;
    hash.bhp256 r7 into r8 as field;
    cast r0.owner r1 into r9 as PrivateListing.record;
    async list_private r1 r8 r2 r0.collection_id r4 into r10;
    output r9 as PrivateListing.record;
    output r10 as zmarket_private_marketplace.aleo/list_private.future;

finalize list_private:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as nft_registry_v3.aleo/transfer_private_to_public.future;
    await r4;
    contains listings[r0] into r5;
    not r5 into r6;
    assert.eq r6 true;
    get zmarket_royalties_v3.aleo/royalties[5678field] into r7;
    get.or_use zmarket_royalties_v3.aleo/royalties[r3] 0u16 into r8;
    cast r7 into r9 as u64;
    mul r9 r2 into r10;
    div r10 10000u64 into r11;
    cast r8 into r12 as u64;
    mul r12 r2 into r13;
    div r13 10000u64 into r14;
    add r11 r14 into r15;
    gte r2 r15 into r16;
    assert.eq r16 true;
    cast r1 r3 r2 r7 r8 false false into r17 as Trade;
    set r17 into listings[r0];

function unlist_private:
    input r0 as PrivateListing.record;
    input r1 as field.public;
    input r2 as Data.private;
    input r3 as scalar.private;
    call nft_registry_v3.aleo/transfer_public_to_private r1 r2 r3 r0.owner into r4 r5;
    hash.bhp256 r2 into r6 as field;
    commit.bhp256 r6 r3 into r7 as field;
    cast r1 r7 into r8 as NFTId;
    hash.bhp256 r8 into r9 as field;
    async unlist_private r0.listing_id r9 r5 into r10;
    output r4 as nft_records_v3.aleo/NFT.record;
    output r10 as zmarket_private_marketplace.aleo/unlist_private.future;

finalize unlist_private:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as nft_registry_v3.aleo/transfer_public_to_private.future;
    await r2;
    get listings[r0] into r3;
    not r3.is_removed into r4;
    assert.eq r4 true;
    not r3.is_accepted into r5;
    assert.eq r5 true;
    assert.eq r1 r3.nft_id_hash;
    cast r3.nft_id_hash r3.collection_id r3.price r3.market_royalty r3.creator_royalty false true into r6 as Trade;
    set r6 into listings[r0];

function update_private_listing:
    input r0 as PrivateListing.record;
    input r1 as u64.public;
    cast r0.owner r0.listing_id into r2 as PrivateListing.record;
    async update_private_listing r0.listing_id r1 into r3;
    output r2 as PrivateListing.record;
    output r3 as zmarket_private_marketplace.aleo/update_private_listing.future;

finalize update_private_listing:
    input r0 as field.public;
    input r1 as u64.public;
    get listings[r0] into r2;
    not r2.is_removed into r3;
    assert.eq r3 true;
    not r2.is_accepted into r4;
    assert.eq r4 true;
    get zmarket_royalties_v3.aleo/royalties[5678field] into r5;
    get.or_use zmarket_royalties_v3.aleo/royalties[r2.collection_id] 0u16 into r6;
    cast r5 into r7 as u64;
    mul r7 r1 into r8;
    div r8 10000u64 into r9;
    cast r6 into r10 as u64;
    mul r10 r1 into r11;
    div r11 10000u64 into r12;
    add r9 r12 into r13;
    gte r1 r13 into r14;
    assert.eq r14 true;
    cast r2.nft_id_hash r2.collection_id r1 r5 r6 false false into r15 as Trade;
    set r15 into listings[r0];

function accept_withdraw_nft_pv_listing:
    input r0 as field.public;
    input r1 as credits.aleo/credits.record;
    input r2 as field.public;
    input r3 as Data.private;
    input r4 as scalar.private;
    input r5 as u64.public;
    call credits.aleo/transfer_private_to_public r1 zmarket_private_marketplace.aleo r5 into r6 r7;
    call nft_registry_v3.aleo/transfer_public_to_private r2 r3 r4 self.signer into r8 r9;
    hash.bhp256 r3 into r10 as field;
    commit.bhp256 r10 r4 into r11 as field;
    cast r2 r11 into r12 as NFTId;
    hash.bhp256 r12 into r13 as field;
    async accept_withdraw_nft_pv_listing r0 r13 r5 r7 r9 into r14;
    output r8 as nft_records_v3.aleo/NFT.record;
    output r14 as zmarket_private_marketplace.aleo/accept_withdraw_nft_pv_listing.future;

finalize accept_withdraw_nft_pv_listing:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as credits.aleo/transfer_private_to_public.future;
    input r4 as nft_registry_v3.aleo/transfer_public_to_private.future;
    get listings[r0] into r5;
    not r5.is_accepted into r6;
    assert.eq r6 true;
    not r5.is_removed into r7;
    assert.eq r7 true;
    assert.eq r1 r5.nft_id_hash;
    assert.eq r2 r5.price;
    cast r5.market_royalty into r8 as u64;
    mul r8 r2 into r9;
    div r9 10000u64 into r10;
    cast r5.creator_royalty into r11 as u64;
    mul r11 r2 into r12;
    div r12 10000u64 into r13;
    sub r2 r10 into r14;
    sub r14 r13 into r15;
    get.or_use royalty_balances[5678field] 0u64 into r16;
    get.or_use royalty_balances[r5.collection_id] 0u64 into r17;
    add r16 r10 into r18;
    add r17 r13 into r19;
    set r18 into royalty_balances[5678field];
    set r19 into royalty_balances[r5.collection_id];
    set r15 into listing_balances[r0];
    cast r5.nft_id_hash r5.collection_id r5.price r5.market_royalty r5.creator_royalty true true into r20 as Trade;
    set r20 into listings[r0];
    await r3;
    await r4;

function accept_private_listing:
    input r0 as field.public;
    input r1 as credits.aleo/credits.record;
    input r2 as u64.public;
    call credits.aleo/transfer_private_to_public r1 zmarket_private_marketplace.aleo r2 into r3 r4;
    cast self.signer r0 into r5 as AcceptedListing.record;
    async accept_private_listing r0 r2 r4 into r6;
    output r5 as AcceptedListing.record;
    output r6 as zmarket_private_marketplace.aleo/accept_private_listing.future;

finalize accept_private_listing:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_private_to_public.future;
    get listings[r0] into r3;
    not r3.is_accepted into r4;
    assert.eq r4 true;
    not r3.is_removed into r5;
    assert.eq r5 true;
    assert.eq r1 r3.price;
    cast r3.market_royalty into r6 as u64;
    mul r6 r1 into r7;
    div r7 10000u64 into r8;
    cast r3.creator_royalty into r9 as u64;
    mul r9 r1 into r10;
    div r10 10000u64 into r11;
    sub r1 r8 into r12;
    sub r12 r11 into r13;
    get.or_use royalty_balances[5678field] 0u64 into r14;
    get.or_use royalty_balances[r3.collection_id] 0u64 into r15;
    add r14 r8 into r16;
    add r15 r11 into r17;
    set r16 into royalty_balances[5678field];
    set r17 into royalty_balances[r3.collection_id];
    set r13 into listing_balances[r0];
    cast r3.nft_id_hash r3.collection_id r3.price r3.market_royalty r3.creator_royalty true false into r18 as Trade;
    set r18 into listings[r0];
    await r2;

function withdraw_nft_private_listing:
    input r0 as AcceptedListing.record;
    input r1 as field.public;
    input r2 as Data.private;
    input r3 as scalar.private;
    call nft_registry_v3.aleo/transfer_public_to_private r1 r2 r3 self.signer into r4 r5;
    hash.bhp256 r2 into r6 as field;
    commit.bhp256 r6 r3 into r7 as field;
    cast r1 r7 into r8 as NFTId;
    hash.bhp256 r8 into r9 as field;
    async withdraw_nft_private_listing r0.listing_id r9 r5 into r10;
    output r4 as nft_records_v3.aleo/NFT.record;
    output r10 as zmarket_private_marketplace.aleo/withdraw_nft_private_listing.future;

finalize withdraw_nft_private_listing:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as nft_registry_v3.aleo/transfer_public_to_private.future;
    get listings[r0] into r3;
    assert.eq r3.is_accepted true;
    not r3.is_removed into r4;
    assert.eq r4 true;
    assert.eq r1 r3.nft_id_hash;
    cast r3.nft_id_hash r3.collection_id r3.price r3.market_royalty r3.creator_royalty true true into r5 as Trade;
    set r5 into listings[r0];
    await r2;

function offer_private:
    input r0 as credits.aleo/credits.record;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as field.public;
    call credits.aleo/transfer_private_to_public r0 zmarket_private_marketplace.aleo r2 into r5 r6;
    cast self.signer r1 into r7 as PrivateOffer.record;
    async offer_private r1 r4 r2 r3 r6 into r8;
    output r7 as PrivateOffer.record;
    output r8 as zmarket_private_marketplace.aleo/offer_private.future;

finalize offer_private:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as field.public;
    input r4 as credits.aleo/transfer_private_to_public.future;
    await r4;
    contains offers[r0] into r5;
    not r5 into r6;
    assert.eq r6 true;
    get zmarket_royalties_v3.aleo/royalties[5678field] into r7;
    get.or_use zmarket_royalties_v3.aleo/royalties[r3] 0u16 into r8;
    cast r7 into r9 as u64;
    mul r9 r2 into r10;
    div r10 10000u64 into r11;
    cast r8 into r12 as u64;
    mul r12 r2 into r13;
    div r13 10000u64 into r14;
    add r11 r14 into r15;
    gte r2 r15 into r16;
    assert.eq r16 true;
    cast r1 r3 r2 r7 r8 false false into r17 as Trade;
    set r17 into offers[r0];

function unoffer_private:
    input r0 as PrivateOffer.record;
    input r1 as u64.public;
    call credits.aleo/transfer_public_to_private r0.owner r1 into r2 r3;
    async unoffer_private r0.offer_id r1 r3 into r4;
    output r2 as credits.aleo/credits.record;
    output r4 as zmarket_private_marketplace.aleo/unoffer_private.future;

finalize unoffer_private:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_to_private.future;
    await r2;
    get offers[r0] into r3;
    not r3.is_removed into r4;
    assert.eq r4 true;
    not r3.is_accepted into r5;
    assert.eq r5 true;
    assert.eq r1 r3.price;
    cast r3.nft_id_hash r3.collection_id r3.price r3.market_royalty r3.creator_royalty false true into r6 as Trade;
    set r6 into offers[r0];

function update_private_offer:
    input r0 as PrivateOffer.record;
    input r1 as credits.aleo/credits.record;
    input r2 as u64.public;
    input r3 as u64.public;
    call credits.aleo/transfer_public_to_private r0.owner r2 into r4 r5;
    call credits.aleo/join r1 r4 into r6;
    call credits.aleo/transfer_private_to_public r6 zmarket_private_marketplace.aleo r3 into r7 r8;
    cast self.signer r0.offer_id into r9 as PrivateOffer.record;
    async update_private_offer r0.offer_id r2 r3 r5 r8 into r10;
    output r7 as credits.aleo/credits.record;
    output r9 as PrivateOffer.record;
    output r10 as zmarket_private_marketplace.aleo/update_private_offer.future;

finalize update_private_offer:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as credits.aleo/transfer_public_to_private.future;
    input r4 as credits.aleo/transfer_private_to_public.future;
    await r3;
    await r4;
    get offers[r0] into r5;
    not r5.is_removed into r6;
    assert.eq r6 true;
    not r5.is_accepted into r7;
    assert.eq r7 true;
    assert.eq r1 r5.price;
    get zmarket_royalties_v3.aleo/royalties[5678field] into r8;
    get.or_use zmarket_royalties_v3.aleo/royalties[r5.collection_id] 0u16 into r9;
    cast r8 into r10 as u64;
    mul r10 r2 into r11;
    div r11 10000u64 into r12;
    cast r9 into r13 as u64;
    mul r13 r2 into r14;
    div r14 10000u64 into r15;
    add r12 r15 into r16;
    gte r2 r16 into r17;
    assert.eq r17 true;
    cast r5.nft_id_hash r5.collection_id r2 r8 r9 false true into r18 as Trade;
    set r18 into offers[r0];

function accept_private_offer:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as nft_records_v3.aleo/NFT.record;
    call nft_registry_v3.aleo/transfer_private_to_public r2 zmarket_private_marketplace.aleo into r3 r4;
    call credits.aleo/transfer_public_to_private self.signer r1 into r5 r6;
    hash.bhp256 r2.data into r7 as field;
    commit.bhp256 r7 r2.edition into r8 as field;
    cast r2.collection_id r8 into r9 as NFTId;
    hash.bhp256 r9 into r10 as field;
    async accept_private_offer r1 r0 r2.collection_id r10 r4 r6 into r11;
    output r5 as credits.aleo/credits.record;
    output r11 as zmarket_private_marketplace.aleo/accept_private_offer.future;

finalize accept_private_offer:
    input r0 as u64.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as field.public;
    input r4 as nft_registry_v3.aleo/transfer_private_to_public.future;
    input r5 as credits.aleo/transfer_public_to_private.future;
    get offers[r1] into r6;
    not r6.is_accepted into r7;
    assert.eq r7 true;
    not r6.is_removed into r8;
    assert.eq r8 true;
    is.eq r3 r6.nft_id_hash into r9;
    is.eq r6.nft_id_hash 0field into r10;
    or r9 r10 into r11;
    assert.eq r11 true;
    assert.eq r2 r6.collection_id;
    cast r6.market_royalty into r12 as u64;
    mul r12 r6.price into r13;
    div r13 10000u64 into r14;
    cast r6.creator_royalty into r15 as u64;
    mul r15 r6.price into r16;
    div r16 10000u64 into r17;
    sub r6.price r14 into r18;
    sub r18 r17 into r19;
    assert.eq r19 r0;
    get.or_use royalty_balances[5678field] 0u64 into r20;
    get.or_use royalty_balances[r6.collection_id] 0u64 into r21;
    add r20 r14 into r22;
    add r21 r17 into r23;
    set r22 into royalty_balances[5678field];
    set r23 into royalty_balances[r6.collection_id];
    cast r3 r6.collection_id r6.price r6.market_royalty r6.creator_royalty true false into r24 as Trade;
    set r24 into offers[r1];
    await r4;
    await r5;

function withdraw_nft_private_offer:
    input r0 as PrivateOffer.record;
    input r1 as field.public;
    input r2 as Data.private;
    input r3 as scalar.private;
    call nft_registry_v3.aleo/transfer_public_to_private r1 r2 r3 self.signer into r4 r5;
    hash.bhp256 r2 into r6 as field;
    commit.bhp256 r6 r3 into r7 as field;
    cast r1 r7 into r8 as NFTId;
    hash.bhp256 r8 into r9 as field;
    async withdraw_nft_private_offer r0.offer_id r9 r5 into r10;
    output r4 as nft_records_v3.aleo/NFT.record;
    output r10 as zmarket_private_marketplace.aleo/withdraw_nft_private_offer.future;

finalize withdraw_nft_private_offer:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as nft_registry_v3.aleo/transfer_public_to_private.future;
    get offers[r0] into r3;
    assert.eq r3.is_accepted true;
    not r3.is_removed into r4;
    assert.eq r4 true;
    assert.eq r1 r3.nft_id_hash;
    cast r3.nft_id_hash r3.collection_id r3.price r3.market_royalty r3.creator_royalty true true into r5 as Trade;
    set r5 into offers[r0];
    await r2;
