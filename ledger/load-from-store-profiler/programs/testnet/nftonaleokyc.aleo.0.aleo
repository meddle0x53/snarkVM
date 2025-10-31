program nftonaleokyc.aleo;

struct TokenId:
    data1 as field;
    data2 as field;
    data3 as field;
    data4 as field;

struct Attribute:
    trait_type as [field; 4u32];
    attr_value as [field; 4u32];

struct Metadata:
    name as [field; 4u32];
    description as [field; 4u32];
    kyc_status as u8;
    expiry_date as u64;
    risk_assessment as u8;
    attributes as [Attribute; 3u32];

record NFT:
    owner as address.private;
    data as TokenId.private;
    edition as scalar.private;
    metadata as Metadata.private;

record NFTView:
    owner as address.private;
    data as TokenId.private;
    edition as scalar.private;
    metadata as Metadata.private;
    is_view as boolean.private;

mapping nft_commits:
    key as field.public;
    value as boolean.public;

mapping nft_owners:
    key as field.public;
    value as address.public;

mapping nft_contents:
    key as field.public;
    value as TokenId.public;

mapping base_uri:
    key as u8.public;
    value as field.public;

mapping is_kyc_valid:
    key as field.public;
    value as boolean.public;

mapping deployer:
    key as u8.public;
    value as address.public;

function initialize:
    input r0 as address.public;
    async initialize r0 into r1;
    output r1 as nftonaleokyc.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    set r0 into deployer[0u8];

function mint:
    input r0 as address.private;
    input r1 as TokenId.private;
    input r2 as Metadata.private;
    input r3 as scalar.private;
    hash.bhp256 r1 into r4 as field;
    commit.bhp256 r4 r3 into r5 as field;
    cast r0 r1 r3 r2 into r6 as NFT.record;
    cast r0 r1 r3 r2 true into r7 as NFTView.record;
    async mint r5 self.caller into r8;
    output r6 as NFT.record;
    output r7 as NFTView.record;
    output r8 as nftonaleokyc.aleo/mint.future;

finalize mint:
    input r0 as field.public;
    input r1 as address.public;
    get deployer[0u8] into r2;
    assert.eq r1 r2;
    contains nft_commits[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set true into nft_commits[r0];
    set true into is_kyc_valid[r0];

function make_public:
    input r0 as NFT.record;
    hash.bhp256 r0.data into r1 as field;
    commit.bhp256 r1 r0.edition into r2 as field;
    assert.eq self.caller r0.owner;
    async make_public r2 r0.owner into r3;
    output r0 as NFT.record;
    output r3 as nftonaleokyc.aleo/make_public.future;

finalize make_public:
    input r0 as field.public;
    input r1 as address.public;
    contains nft_commits[r0] into r2;
    assert.eq r2 true;
    set r1 into nft_owners[r0];

function verify_kyc:
    input r0 as address.public;
    input r1 as TokenId.public;
    input r2 as scalar.public;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    async verify_kyc r4 r0 into r5;
    output true as boolean.private;
    output r5 as nftonaleokyc.aleo/verify_kyc.future;

finalize verify_kyc:
    input r0 as field.public;
    input r1 as address.public;
    contains nft_commits[r0] into r2;
    assert.eq r2 true;
    get is_kyc_valid[r0] into r3;
    assert.eq r3 true;
    contains nft_owners[r0] into r4;
    assert.eq r4 true;
    get nft_owners[r0] into r5;
    assert.eq r5 r1;

function update_kyc_status:
    input r0 as TokenId.private;
    input r1 as scalar.private;
    input r2 as boolean.private;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    async update_kyc_status r4 self.caller r2 into r5;
    output true as boolean.private;
    output r5 as nftonaleokyc.aleo/update_kyc_status.future;

finalize update_kyc_status:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as boolean.public;
    contains nft_commits[r0] into r3;
    assert.eq r3 true;
    get deployer[0u8] into r4;
    assert.eq r1 r4;
    set r2 into is_kyc_valid[r0];

function publish_nft_content:
    input r0 as TokenId.public;
    input r1 as scalar.public;
    hash.bhp256 r0 into r2 as field;
    commit.bhp256 r2 r1 into r3 as field;
    async publish_nft_content r3 r0 into r4;
    output true as boolean.private;
    output r4 as nftonaleokyc.aleo/publish_nft_content.future;

finalize publish_nft_content:
    input r0 as field.public;
    input r1 as TokenId.public;
    contains nft_commits[r0] into r2;
    assert.eq r2 true;
    set r1 into nft_contents[r0];
