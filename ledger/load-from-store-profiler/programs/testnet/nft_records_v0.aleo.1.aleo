program nft_records_v0.aleo;

struct Data:
    metadata as field;

record NFT:
    owner as address.private;
    collection_id as field.private;
    data as Data.private;
    edition as scalar.private;

record NFTView:
    owner as address.private;
    data as Data.private;
    edition as scalar.private;
    is_view as boolean.public;

function mint_nft:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as Data.private;
    input r3 as scalar.private;
    assert.eq self.caller nft_registry_v0.aleo;
    cast r0 r1 r2 r3 into r4 as NFT.record;
    output r4 as NFT.record;

function burn_nft:
    input r0 as NFT.record;
    assert.eq self.caller nft_registry_v0.aleo;

function transfer_nft:
    input r0 as NFT.record;
    input r1 as address.private;
    assert.eq self.caller nft_registry_v0.aleo;
    cast r1 r0.collection_id r0.data r0.edition into r2 as NFT.record;
    output r2 as NFT.record;

function update_nft_edition:
    input r0 as NFT.record;
    input r1 as scalar.private;
    assert.eq self.caller nft_registry_v0.aleo;
    cast r0.owner r0.collection_id r0.data r1 into r2 as NFT.record;
    output r2 as NFT.record;

function mint_nft_view:
    input r0 as address.private;
    input r1 as Data.private;
    input r2 as scalar.private;
    assert.eq self.caller nft_registry_v0.aleo;
    cast r0 r1 r2 true into r3 as NFTView.record;
    output r3 as NFTView.record;
