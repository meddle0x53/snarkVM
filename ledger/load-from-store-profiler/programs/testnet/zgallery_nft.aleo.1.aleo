program zgallery_nft.aleo;

struct data:
    metadata as field;
    brand as address;
    form as field;

record NFT:
    owner as address.private;
    data as data.private;
    edition as scalar.private;

record NftView:
    owner as address.private;
    data as data.private;
    edition as scalar.private;
    is_view as boolean.public;

mapping nft_commits:
    key as field.public;
    value as boolean.public;

mapping nft_owners:
    key as field.public;
    value as address.public;

function mint_private:
    input r0 as data.private;
    input r1 as scalar.private;
    cast self.signer r0 r1 into r2 as NFT.record;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    async mint_private r4 into r5;
    output r2 as NFT.record;
    output r5 as zgallery_nft.aleo/mint_private.future;

finalize mint_private:
    input r0 as field.public;
    contains nft_commits[r0] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into nft_commits[r0];

function transfer_private:
    input r0 as NFT.record;
    input r1 as address.private;
    cast r1 r0.data r0.edition into r2 as NFT.record;
    output r2 as NFT.record;

function transfer_private_to_public:
    input r0 as NFT.record;
    input r1 as address.public;
    cast r1 r0.data r0.edition true into r2 as NftView.record;
    hash.bhp256 r0.data into r3 as field;
    commit.bhp256 r3 r0.edition into r4 as field;
    async transfer_private_to_public r4 r1 into r5;
    output r2 as NftView.record;
    output r5 as zgallery_nft.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as field.public;
    input r1 as address.public;
    set r1 into nft_owners[r0];

function transfer_private_to_sc:
    input r0 as NFT.record;
    input r1 as address.public;
    cast self.signer r0.data r0.edition true into r2 as NftView.record;
    hash.bhp256 r0.data into r3 as field;
    commit.bhp256 r3 r0.edition into r4 as field;
    async transfer_private_to_sc r4 r1 into r5;
    output r2 as NftView.record;
    output r5 as zgallery_nft.aleo/transfer_private_to_sc.future;

finalize transfer_private_to_sc:
    input r0 as field.public;
    input r1 as address.public;
    set r1 into nft_owners[r0];

function transfer_public:
    input r0 as NftView.record;
    input r1 as address.public;
    cast r1 r0.data r0.edition true into r2 as NftView.record;
    hash.bhp256 r0.data into r3 as field;
    commit.bhp256 r3 r0.edition into r4 as field;
    async transfer_public r4 r0.owner r1 into r5;
    output r2 as NftView.record;
    output r5 as zgallery_nft.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    get nft_owners[r0] into r3;
    assert.eq r3 r1;
    set r2 into nft_owners[r0];

function transfer_public_to_private:
    input r0 as NftView.record;
    input r1 as address.private;
    hash.bhp256 r0.data into r2 as field;
    commit.bhp256 r2 r0.edition into r3 as field;
    cast r1 r0.data r0.edition into r4 as NFT.record;
    async transfer_public_to_private r3 self.caller into r5;
    output r4 as NFT.record;
    output r5 as zgallery_nft.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as field.public;
    input r1 as address.public;
    get nft_owners[r0] into r2;
    assert.eq r2 r1;
    remove nft_owners[r0];

function transfer_nft_view:
    input r0 as NftView.record;
    input r1 as address.private;
    cast r1 r0.data r0.edition true into r2 as NftView.record;
    output r2 as NftView.record;
