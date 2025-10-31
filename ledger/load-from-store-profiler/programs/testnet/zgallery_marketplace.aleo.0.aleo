import zgallery_nft.aleo;
import credits.aleo;

program zgallery_marketplace.aleo;

record ReceiptSeller:
    owner as address.private;
    listing_id as field.private;
    listing_private_key as scalar.private;

record ReceiptBuyer:
    owner as address.private;
    listing_id as field.private;
    seller as address.private;

record DataLog:
    owner as address.private;
    nft_commit as field.private;
    price as u64.private;
    form_answer as field.private;
    buyer as address.private;
    seller as address.private;

struct data:
    metadata as field;
    brand as address;
    form as field;

struct Listing:
    nft_commit as field;
    listing_public_key as group;
    price as u64;
    purchased as boolean;
    buyer_c as field;
    purchase_N as group;
    approved as boolean;

mapping listings:
    key as field.public;
    value as Listing.public;

function list:
    input r0 as zgallery_nft.aleo/NFT.record;
    input r1 as u64.private;
    input r2 as scalar.private;
    hash.bhp256 r0.data into r3 as field;
    commit.bhp256 r3 r0.edition into r4 as field;
    call zgallery_nft.aleo/transfer_private_to_public r0 zgallery_marketplace.aleo into r5 r6;
    mul r2 1540945439182663264862696551825005342995406165131907382295858612069623286213group into r7;
    cast r4 r7 r1 false 0field 0group false into r8 as Listing;
    async list r8 r6 into r9;
    cast self.signer r4 r2 into r10 as ReceiptSeller.record;
    output r10 as ReceiptSeller.record;
    output r9 as zgallery_marketplace.aleo/list.future;

finalize list:
    input r0 as Listing.public;
    input r1 as zgallery_nft.aleo/transfer_private_to_public.future;
    await r1;
    set r0 into listings[r0.nft_commit];

function cancel:
    input r0 as ReceiptSeller.record;
    input r1 as zgallery_nft.aleo/NftView.record;
    call zgallery_nft.aleo/transfer_public_to_private r1 self.signer into r2 r3;
    async cancel r0.listing_id r3 into r4;
    output r2 as zgallery_nft.aleo/NFT.record;
    output r4 as zgallery_marketplace.aleo/cancel.future;

finalize cancel:
    input r0 as field.public;
    input r1 as zgallery_nft.aleo/transfer_public_to_private.future;
    get listings[r0] into r2;
    assert.eq r2.purchased false;
    await r1;
    remove listings[r0];

function purchase:
    input r0 as credits.aleo/credits.record;
    input r1 as field.private;
    input r2 as u64.private;
    input r3 as scalar.private;
    call credits.aleo/transfer_private_to_public r0 zgallery_marketplace.aleo r2 into r4 r5;
    cast self.signer into r6 as field;
    async purchase r6 r1 r2 r3 r5 into r7;
    output r4 as credits.aleo/credits.record;
    output r7 as zgallery_marketplace.aleo/purchase.future;

finalize purchase:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as scalar.public;
    input r4 as credits.aleo/transfer_private_to_public.future;
    get listings[r1] into r5;
    assert.eq r2 r5.price;
    await r4;
    assert.eq r5.purchased false;
    mul r3 1540945439182663264862696551825005342995406165131907382295858612069623286213group into r6;
    mul r3 r5.listing_public_key into r7;
    hash.bhp256 r7 into r8 as field;
    add r0 r8 into r9;
    cast r1 r5.listing_public_key r5.price true r9 r6 false into r10 as Listing;
    set r10 into listings[r1];

function approve:
    input r0 as ReceiptSeller.record;
    input r1 as zgallery_nft.aleo/NftView.record;
    input r2 as field.private;
    input r3 as group.private;
    mul r0.listing_private_key r3 into r4;
    hash.bhp256 r4 into r5 as field;
    sub r2 r5 into r6;
    cast r6 into r7 as address;
    call zgallery_nft.aleo/transfer_nft_view r1 r7 into r8;
    async approve r0.listing_id into r9;
    cast r7 r0.listing_id self.signer into r10 as ReceiptBuyer.record;
    output r10 as ReceiptBuyer.record;
    output r8 as zgallery_nft.aleo/NftView.record;
    output r9 as zgallery_marketplace.aleo/approve.future;

finalize approve:
    input r0 as field.public;
    get listings[r0] into r1;
    assert.eq r1.purchased true;
    assert.eq r1.approved false;
    cast r1.nft_commit r1.listing_public_key r1.price r1.purchased r1.buyer_c r1.purchase_N true into r2 as Listing;
    set r2 into listings[r0];

function reject:
    input r0 as ReceiptSeller.record;
    input r1 as u64.private;
    input r2 as field.private;
    input r3 as group.private;
    mul r0.listing_private_key r3 into r4;
    hash.bhp256 r4 into r5 as field;
    sub r2 r5 into r6;
    cast r6 into r7 as address;
    call credits.aleo/transfer_public_to_private r7 r1 into r8 r9;
    async reject r0.listing_id r1 r9 into r10;
    cast r0.owner r0.listing_id r0.listing_private_key into r11 as ReceiptSeller.record;
    output r11 as ReceiptSeller.record;
    output r8 as credits.aleo/credits.record;
    output r10 as zgallery_marketplace.aleo/reject.future;

finalize reject:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_to_private.future;
    get listings[r0] into r3;
    assert.eq r1 r3.price;
    assert.eq r3.purchased true;
    assert.eq r3.approved false;
    cast r3.nft_commit r3.listing_public_key r3.price false r3.buyer_c r3.purchase_N r3.approved into r4 as Listing;
    set r4 into listings[r0];
    await r2;

function validate:
    input r0 as ReceiptBuyer.record;
    input r1 as zgallery_nft.aleo/NftView.record;
    input r2 as u64.private;
    input r3 as field.private;
    hash.bhp256 r1.data into r4 as field;
    commit.bhp256 r4 r1.edition into r5 as field;
    call zgallery_nft.aleo/transfer_public_to_private r1 self.signer into r6 r7;
    call credits.aleo/transfer_public_to_private r0.seller r2 into r8 r9;
    cast r1.data.brand r5 r2 r3 r0.owner r0.seller into r10 as DataLog.record;
    async validate r5 r2 r7 r9 into r11;
    output r6 as zgallery_nft.aleo/NFT.record;
    output r8 as credits.aleo/credits.record;
    output r10 as DataLog.record;
    output r11 as zgallery_marketplace.aleo/validate.future;

finalize validate:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as zgallery_nft.aleo/transfer_public_to_private.future;
    input r3 as credits.aleo/transfer_public_to_private.future;
    get listings[r0] into r4;
    assert.eq r1 r4.price;
    assert.eq r4.approved true;
    assert.eq r4.purchased true;
    await r2;
    await r3;
