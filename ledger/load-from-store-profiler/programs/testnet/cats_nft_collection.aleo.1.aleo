import credits.aleo;

program cats_nft_collection.aleo;

struct TokenId:
    data1 as u128;
    data2 as u128;

struct BaseURI:
    data0 as u128;
    data1 as u128;
    data2 as u128;
    data3 as u128;

record NFT:
    owner as address.private;
    data as TokenId.private;
    edition as scalar.private;

record NFT_mint:
    owner as address.private;

struct MintInfo:
    data as TokenId;
    randomness as u128;

struct NFTPriceTicket:
    minter as address;
    price as u64;

mapping mint_history:
    key as u128.public;
    value as MintInfo.public;

mapping minted_ids:
    key as field.public;
    value as boolean.public;

mapping mint_counter:
    key as u8.public;
    value as u128.public;

mapping general_settings:
    key as u8.public;
    value as u128.public;

mapping price_settings:
    key as u8.public;
    value as u64.public;

mapping status_settings:
    key as u8.public;
    value as boolean.public;

mapping nft_owners:
    key as field.public;
    value as address.public;

function transfer_public:
    input r0 as address.private;
    input r1 as TokenId.private;
    input r2 as scalar.private;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    async transfer_public r0 r4 self.caller into r5;
    output r5 as cats_nft_collection.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    get nft_owners[r1] into r3;
    assert.eq r2 r3;
    set r0 into nft_owners[r1];

function transfer_private:
    input r0 as NFT.record;
    input r1 as address.private;
    cast r1 r0.data r0.edition into r2 as NFT.record;
    output r2 as NFT.record;

function initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as BaseURI.public;
    assert.eq self.caller aleo1tazl2x72gu7alczpuffql8jhtmpvqq3uznac6zmtyyk7qae0vqyqq6slnx;
    async initialize_collection r0 r1 r2 r3 r4 into r5;
    output r5 as cats_nft_collection.aleo/initialize_collection.future;

finalize initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as BaseURI.public;
    get.or_use status_settings[0u8] false into r5;
    assert.eq r5 false;
    set r2 into price_settings[0u8];
    set r3 into price_settings[1u8];
    set 0u128 into mint_counter[0u8];
    set r0 into general_settings[0u8];
    set r0 into general_settings[1u8];
    set r1 into general_settings[2u8];
    set r4.data0 into general_settings[3u8];
    set r4.data1 into general_settings[4u8];
    set r4.data2 into general_settings[5u8];
    set r4.data3 into general_settings[6u8];
    set true into status_settings[0u8];
    set true into status_settings[1u8];

function update_base_uri:
    input r0 as BaseURI.public;
    assert.eq self.caller aleo1tazl2x72gu7alczpuffql8jhtmpvqq3uznac6zmtyyk7qae0vqyqq6slnx;
    async update_base_uri r0 into r1;
    output r1 as cats_nft_collection.aleo/update_base_uri.future;

finalize update_base_uri:
    input r0 as BaseURI.public;
    set r0.data0 into general_settings[3u8];
    set r0.data1 into general_settings[4u8];
    set r0.data2 into general_settings[5u8];
    set r0.data3 into general_settings[6u8];

function update_can_mint:
    input r0 as boolean.public;
    assert.eq self.caller aleo1tazl2x72gu7alczpuffql8jhtmpvqq3uznac6zmtyyk7qae0vqyqq6slnx;
    async update_can_mint r0 into r1;
    output r1 as cats_nft_collection.aleo/update_can_mint.future;

finalize update_can_mint:
    input r0 as boolean.public;
    get.or_use status_settings[0u8] false into r1;
    assert.eq r1 true;
    set r0 into status_settings[1u8];

function update_price:
    input r0 as u64.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1tazl2x72gu7alczpuffql8jhtmpvqq3uznac6zmtyyk7qae0vqyqq6slnx;
    async update_price r0 r1 into r2;
    output r2 as cats_nft_collection.aleo/update_price.future;

finalize update_price:
    input r0 as u64.public;
    input r1 as u64.public;
    set r0 into price_settings[0u8];
    set r1 into price_settings[1u8];

function add_nft:
    input r0 as TokenId.public;
    input r1 as scalar.public;
    async add_nft into r2;
    output r2 as cats_nft_collection.aleo/add_nft.future;

finalize add_nft:
    assert.eq 0u8 1u8;

function open_mint:
    input r0 as scalar.public;
    async open_mint into r1;
    output r1 as cats_nft_collection.aleo/open_mint.future;

finalize open_mint:
    assert.eq 0u8 1u8;

function mint:
    input r0 as NFT_mint.record;
    input r1 as scalar.public;
    async mint into r2;
    output r2 as cats_nft_collection.aleo/mint.future;

finalize mint:
    assert.eq 0u8 1u8;

function claim_nft_pub:
    input r0 as TokenId.private;
    input r1 as NFTPriceTicket.private;
    input r2 as signature.private;
    is.eq self.caller r1.minter into r3;
    is.eq self.signer r1.minter into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    sign.verify r2 aleo10eq9ur0r30884paxqmm85gy0e97ay264skpaqsnm0ye2glp5yvgswmrlqv r1 into r6;
    assert.eq r6 true;
    call credits.aleo/transfer_public_as_signer cats_nft_collection.aleo r1.price into r7;
    cast r1.minter r0 0scalar into r8 as NFT.record;
    async claim_nft_pub r7 r0 r1.price into r9;
    output r8 as NFT.record;
    output r9 as cats_nft_collection.aleo/claim_nft_pub.future;

finalize claim_nft_pub:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as TokenId.public;
    input r2 as u64.public;
    await r0;
    get.or_use status_settings[1u8] false into r3;
    assert.eq r3 true;
    get price_settings[0u8] into r4;
    gte r2 r4 into r5;
    assert.eq r5 true;
    get price_settings[1u8] into r6;
    lte r2 r6 into r7;
    assert.eq r7 true;
    hash.bhp256 r1 into r8 as field;
    get.or_use minted_ids[r8] false into r9;
    not r9 into r10;
    assert.eq r10 true;
    set true into minted_ids[r8];
    get.or_use general_settings[0u8] 0u128 into r11;
    gt r11 0u128 into r12;
    assert.eq r12 true;
    get.or_use mint_counter[0u8] 0u128 into r13;
    add 1u128 r13 into r14;
    set r14 into mint_counter[0u8];
    rand.chacha into r15 as u128;
    cast r1 r15 into r16 as MintInfo;
    set r16 into mint_history[r14];
    sub r11 1u128 into r17;
    set r17 into general_settings[0u8];
    set r17 into general_settings[1u8];

function claim_nft:
    input r0 as TokenId.private;
    input r1 as NFTPriceTicket.private;
    input r2 as signature.private;
    input r3 as credits.aleo/credits.record;
    is.eq self.caller r1.minter into r4;
    is.eq self.signer r1.minter into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    sign.verify r2 aleo10eq9ur0r30884paxqmm85gy0e97ay264skpaqsnm0ye2glp5yvgswmrlqv r1 into r7;
    assert.eq r7 true;
    call credits.aleo/transfer_private_to_public r3 cats_nft_collection.aleo r1.price into r8 r9;
    cast r1.minter r0 0scalar into r10 as NFT.record;
    async claim_nft r9 r0 r1.price into r11;
    output r10 as NFT.record;
    output r8 as credits.aleo/credits.record;
    output r11 as cats_nft_collection.aleo/claim_nft.future;

finalize claim_nft:
    input r0 as credits.aleo/transfer_private_to_public.future;
    input r1 as TokenId.public;
    input r2 as u64.public;
    await r0;
    get.or_use status_settings[1u8] false into r3;
    assert.eq r3 true;
    get price_settings[0u8] into r4;
    gte r2 r4 into r5;
    assert.eq r5 true;
    get price_settings[1u8] into r6;
    lte r2 r6 into r7;
    assert.eq r7 true;
    hash.bhp256 r1 into r8 as field;
    get.or_use minted_ids[r8] false into r9;
    not r9 into r10;
    assert.eq r10 true;
    set true into minted_ids[r8];
    get.or_use general_settings[0u8] 0u128 into r11;
    gt r11 0u128 into r12;
    assert.eq r12 true;
    get.or_use mint_counter[0u8] 0u128 into r13;
    add 1u128 r13 into r14;
    set r14 into mint_counter[0u8];
    rand.chacha into r15 as u128;
    cast r1 r15 into r16 as MintInfo;
    set r16 into mint_history[r14];
    sub r11 1u128 into r17;
    set r17 into general_settings[0u8];
    set r17 into general_settings[1u8];

function authorize:
    input r0 as NFT.record;
    input r1 as u64.public;
    async authorize into r2;
    output r2 as cats_nft_collection.aleo/authorize.future;

finalize authorize:
    assert.eq 0u8 1u8;

function convert_private_to_public:
    input r0 as NFT.record;
    hash.bhp256 r0.data into r1 as field;
    commit.bhp256 r1 r0.edition into r2 as field;
    async convert_private_to_public r0.owner r2 into r3;
    output r3 as cats_nft_collection.aleo/convert_private_to_public.future;

finalize convert_private_to_public:
    input r0 as address.public;
    input r1 as field.public;
    set r0 into nft_owners[r1];

function convert_public_to_private:
    input r0 as address.public;
    input r1 as TokenId.public;
    input r2 as scalar.public;
    cast self.caller r1 r2 into r3 as NFT.record;
    async convert_public_to_private self.caller r1 r2 into r4;
    output r3 as NFT.record;
    output r4 as cats_nft_collection.aleo/convert_public_to_private.future;

finalize convert_public_to_private:
    input r0 as address.public;
    input r1 as TokenId.public;
    input r2 as scalar.public;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    get nft_owners[r4] into r5;
    assert.eq r0 r5;
    set aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into nft_owners[r4];

function withdraw_credits:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1tazl2x72gu7alczpuffql8jhtmpvqq3uznac6zmtyyk7qae0vqyqq6slnx;
    call credits.aleo/transfer_public_to_private r0 r1 into r2 r3;
    async withdraw_credits r3 into r4;
    output r2 as credits.aleo/credits.record;
    output r4 as cats_nft_collection.aleo/withdraw_credits.future;

finalize withdraw_credits:
    input r0 as credits.aleo/transfer_public_to_private.future;
    await r0;
