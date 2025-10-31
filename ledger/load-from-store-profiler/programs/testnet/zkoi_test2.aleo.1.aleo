program zkoi_test2.aleo;

struct BaseURI:
    data0 as u128;
    data1 as u128;
    data2 as u128;
    data3 as u128;

struct TokenId:
    id0 as u128;
    id1 as u128;

struct NFT_mint:
    minter_address as address;
    amount as u8;

struct NFT_claim:
    claim_owner as address;
    claim as field;

struct PublicNFT:
    nft_owner as address;
    data as TokenId;
    edition as scalar;

struct approval:
    approver as address;
    spender as address;

struct data:
    metadata as [field; 4u32];

record NFT:
    owner as address.private;
    data as data.private;
    edition as scalar.private;

record NFTView:
    owner as address.private;
    data as data.private;
    edition as scalar.private;
    is_view as boolean.public;

struct nft_content:
    data as data;
    edition as scalar;

mapping toggle_settings:
    key as u8.public;
    value as u32.public;

mapping general_settings:
    key as u8.public;
    value as u128.public;

mapping nfts_to_mint:
    key as u128.public;
    value as field.public;

mapping claims_to_nfts:
    key as field.public;
    value as field.public;

mapping nft_commits:
    key as field.public;
    value as boolean.public;

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
    value as nft_content.public;

function transfer_private:
    input r0 as NFT.record;
    input r1 as address.private;
    cast r1 r0.data r0.edition into r2 as NFT.record;
    output r2 as NFT.record;

function transfer_priv_to_pub:
    input r0 as NFT.record;
    input r1 as address.public;
    hash.bhp256 r0.data into r2 as field;
    commit.bhp256 r2 r0.edition into r3 as field;
    cast r1 r0.data r0.edition true into r4 as NFTView.record;
    async transfer_priv_to_pub r1 r3 into r5;
    output r4 as NFTView.record;
    output r5 as zkoi_test2.aleo/transfer_priv_to_pub.future;

finalize transfer_priv_to_pub:
    input r0 as address.public;
    input r1 as field.public;
    set r0 into nft_owners[r1];

function transfer_public:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.public;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    cast r2 r0 r1 true into r5 as NFTView.record;
    async transfer_public r2 r4 self.caller into r6;
    output r5 as NFTView.record;
    output r6 as zkoi_test2.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    get nft_owners[r1] into r3;
    assert.eq r2 r3;
    remove nft_approvals[r1];
    set r0 into nft_owners[r1];

function transfer_pub_as_signer:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.public;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    cast r2 r0 r1 true into r5 as NFTView.record;
    async transfer_pub_as_signer r2 r4 self.signer into r6;
    output r5 as NFTView.record;
    output r6 as zkoi_test2.aleo/transfer_pub_as_signer.future;

finalize transfer_pub_as_signer:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    get nft_owners[r1] into r3;
    assert.eq r2 r3;
    remove nft_approvals[r1];
    set r0 into nft_owners[r1];

function transfer_pub_to_priv:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.private;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    async transfer_pub_to_priv self.caller r4 into r5;
    cast r2 r0 r1 into r6 as NFT.record;
    output r6 as NFT.record;
    output r5 as zkoi_test2.aleo/transfer_pub_to_priv.future;

finalize transfer_pub_to_priv:
    input r0 as address.public;
    input r1 as field.public;
    get nft_owners[r1] into r2;
    assert.eq r0 r2;
    remove nft_approvals[r1];
    remove nft_owners[r1];

function set_for_all_approval:
    input r0 as address.private;
    input r1 as boolean.public;
    cast self.caller r0 into r2 as approval;
    hash.bhp256 r2 into r3 as field;
    async set_for_all_approval r3 r1 into r4;
    output r4 as zkoi_test2.aleo/set_for_all_approval.future;

finalize set_for_all_approval:
    input r0 as field.public;
    input r1 as boolean.public;
    set r1 into for_all_approvals[r0];

function approve_public:
    input r0 as address.private;
    input r1 as data.private;
    input r2 as scalar.private;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    cast self.caller r0 into r5 as approval;
    hash.bhp256 r5 into r6 as field;
    async approve_public self.caller r6 r4 into r7;
    output r7 as zkoi_test2.aleo/approve_public.future;

finalize approve_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get nft_owners[r2] into r3;
    assert.eq r3 r0;
    set r1 into nft_approvals[r2];

function transfer_from_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as data.private;
    input r3 as scalar.private;
    hash.bhp256 r2 into r4 as field;
    commit.bhp256 r4 r3 into r5 as field;
    cast r1 r2 r3 true into r6 as NFTView.record;
    cast r0 self.caller into r7 as approval;
    hash.bhp256 r7 into r8 as field;
    async transfer_from_public r8 r0 r1 r5 into r9;
    output r6 as NFTView.record;
    output r9 as zkoi_test2.aleo/transfer_from_public.future;

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

function update_edition_private:
    input r0 as NFT.record;
    input r1 as scalar.private;
    cast r0.owner r0.data r1 into r2 as NFT.record;
    hash.bhp256 r0.data into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    async update_edition_private r4 into r5;
    output r2 as NFT.record;
    output r5 as zkoi_test2.aleo/update_edition_private.future;

finalize update_edition_private:
    input r0 as field.public;
    contains nft_commits[r0] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into nft_commits[r0];

function publish_nft_content:
    input r0 as data.public;
    input r1 as scalar.public;
    hash.bhp256 r0 into r2 as field;
    commit.bhp256 r2 r1 into r3 as field;
    async publish_nft_content r3 r0 r1 into r4;
    output r4 as zkoi_test2.aleo/publish_nft_content.future;

finalize publish_nft_content:
    input r0 as field.public;
    input r1 as data.public;
    input r2 as scalar.public;
    cast r1 r2 into r3 as nft_content;
    set r3 into nft_contents[r0];

function mint:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.private;
    hash.bhp256 r0 into r3 as field;
    commit.bhp256 r3 r1 into r4 as field;
    async mint r4 r2 into r5;
    cast r2 r0 r1 into r6 as NFT.record;
    output r6 as NFT.record;
    output r5 as zkoi_test2.aleo/mint.future;

finalize mint:
    input r0 as field.public;
    input r1 as address.public;
    contains nft_commits[r0] into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into nft_commits[r0];
    set r1 into nft_owners[r0];

function initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as BaseURI.public;
    assert.eq self.caller aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec;
    async initialize_collection r0 r1 r2 into r3;
    output r3 as zkoi_test2.aleo/initialize_collection.future;

finalize initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as BaseURI.public;
    get.or_use toggle_settings[0u8] 0u32 into r3;
    and r3 1u32 into r4;
    assert.eq r4 0u32;
    set 0u128 into general_settings[0u8];
    set r0 into general_settings[1u8];
    set r1 into general_settings[2u8];
    set r2.data0 into general_settings[3u8];
    set r2.data1 into general_settings[4u8];
    set r2.data2 into general_settings[5u8];
    set r2.data3 into general_settings[6u8];
    set 5u32 into toggle_settings[0u8];
    set 0u32 into toggle_settings[1u8];

function add_nft:
    input r0 as TokenId.public;
    input r1 as scalar.public;
    assert.eq self.caller aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec;
    hash.bhp256 r0 into r2 as field;
    commit.bhp256 r2 r1 into r3 as field;
    async add_nft r3 into r4;
    output r4 as zkoi_test2.aleo/add_nft.future;

finalize add_nft:
    input r0 as field.public;
    get toggle_settings[0u8] into r1;
    and r1 9u32 into r2;
    assert.eq r2 1u32;
    get general_settings[1u8] into r3;
    sub r3 1u128 into r4;
    set r4 into general_settings[1u8];
    get general_settings[0u8] into r5;
    set r0 into nfts_to_mint[r5];
    add r5 1u128 into r6;
    set r6 into general_settings[0u8];

function add_minter:
    input r0 as address.private;
    input r1 as u8.public;
    assert.eq self.caller aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec;
    cast r0 r1 into r2 as NFT_mint;
    async add_minter into r3;
    output r2 as NFT_mint.private;
    output r3 as zkoi_test2.aleo/add_minter.future;

finalize add_minter:
    get toggle_settings[0u8] into r0;
    and r0 9u32 into r1;
    assert.eq r1 1u32;

function update_toggle_settings:
    input r0 as u32.public;
    assert.eq self.caller aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec;
    async update_toggle_settings r0 into r1;
    output r1 as zkoi_test2.aleo/update_toggle_settings.future;

finalize update_toggle_settings:
    input r0 as u32.public;
    get toggle_settings[0u8] into r1;
    and r1 9u32 into r2;
    assert.eq r2 1u32;
    and r0 1u32 into r3;
    assert.eq r3 1u32;
    set r0 into toggle_settings[0u8];

function set_mint_block:
    input r0 as u32.public;
    assert.eq self.caller aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec;
    async set_mint_block r0 into r1;
    output r1 as zkoi_test2.aleo/set_mint_block.future;

finalize set_mint_block:
    input r0 as u32.public;
    get toggle_settings[0u8] into r1;
    and r1 9u32 into r2;
    assert.eq r2 1u32;
    set r0 into toggle_settings[1u8];

function update_symbol:
    input r0 as u128.public;
    assert.eq self.caller aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec;
    async update_symbol r0 into r1;
    output r1 as zkoi_test2.aleo/update_symbol.future;

finalize update_symbol:
    input r0 as u128.public;
    get toggle_settings[0u8] into r1;
    and r1 9u32 into r2;
    assert.eq r2 1u32;
    set r0 into general_settings[2u8];

function update_base_uri:
    input r0 as BaseURI.public;
    assert.eq self.caller aleo1xh0ncflwkfzga983lwujsha729c8nwu7phfn8aw7h3gahhj0ms8qytrxec;
    async update_base_uri r0 into r1;
    output r1 as zkoi_test2.aleo/update_base_uri.future;

finalize update_base_uri:
    input r0 as BaseURI.public;
    get toggle_settings[0u8] into r1;
    and r1 9u32 into r2;
    assert.eq r2 1u32;
    set r0.data0 into general_settings[3u8];
    set r0.data1 into general_settings[4u8];
    set r0.data2 into general_settings[5u8];
    set r0.data3 into general_settings[6u8];

function open_mint:
    input r0 as scalar.private;
    hash.bhp256 self.caller into r1 as field;
    commit.bhp256 r1 r0 into r2 as field;
    cast self.caller r2 into r3 as NFT_claim;
    async open_mint r2 into r4;
    output r3 as NFT_claim.private;
    output r4 as zkoi_test2.aleo/open_mint.future;

finalize open_mint:
    input r0 as field.public;
    get toggle_settings[1u8] into r1;
    lte r1 block.height into r2;
    assert.eq r2 true;
    get toggle_settings[0u8] into r3;
    and r3 15u32 into r4;
    assert.eq r4 3u32;
    get.or_use claims_to_nfts[r0] 0field into r5;
    assert.eq r5 0field;
    rand.chacha into r6 as u128;
    get.or_use general_settings[0u8] 0u128 into r7;
    rem r6 r7 into r8;
    get nfts_to_mint[r8] into r9;
    set r9 into claims_to_nfts[r0];
    sub r7 1u128 into r10;
    set r10 into general_settings[0u8];
    get nfts_to_mint[r10] into r11;
    set r11 into nfts_to_mint[r8];

function claim_nft:
    input r0 as NFT_claim.private;
    input r1 as TokenId.private;
    input r2 as scalar.private;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    cast r0.claim_owner r1 r2 into r5 as PublicNFT;
    async claim_nft r0.claim r4 into r6;
    output r5 as PublicNFT.private;
    output r6 as zkoi_test2.aleo/claim_nft.future;

finalize claim_nft:
    input r0 as field.public;
    input r1 as field.public;
    get claims_to_nfts[r0] into r2;
    assert.eq r2 r1;
    set 0field into claims_to_nfts[r0];
