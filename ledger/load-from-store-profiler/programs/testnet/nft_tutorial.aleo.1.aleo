program nft_tutorial.aleo;

struct BaseURI:
    data0 as u128;
    data1 as u128;
    data2 as u128;
    data3 as u128;

record NFT:
    owner as address.private;
    tokenId as u128.private;

mapping general_settings:
    key as u8.public;
    value as u128.public;

function initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as BaseURI.public;
    assert.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px;
    async initialize_collection r0 r1 r2 into r3;
    output r3 as nft_tutorial.aleo/initialize_collection.future;

finalize initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as BaseURI.public;
    get.or_use general_settings[7u8] 0u128 into r3;
    and r3 1u128 into r4;
    assert.eq r4 0u128;
    set r0 into general_settings[1u8];
    set r1 into general_settings[2u8];
    set r2.data0 into general_settings[3u8];
    set r2.data1 into general_settings[4u8];
    set r2.data2 into general_settings[5u8];
    set r2.data3 into general_settings[6u8];
    or r3 1u128 into r5;
    set r5 into general_settings[7u8];

function update_toggle_settings:
    input r0 as u128.public;
    assert.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px;
    and r0 1u128 into r1;
    assert.eq r1 1u128;
    async update_toggle_settings r0 into r2;
    output r2 as nft_tutorial.aleo/update_toggle_settings.future;

finalize update_toggle_settings:
    input r0 as u128.public;
    set r0 into general_settings[7u8];

function set_mint_block:
    input r0 as u128.public;
    assert.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px;
    async set_mint_block r0 into r1;
    output r1 as nft_tutorial.aleo/set_mint_block.future;

finalize set_mint_block:
    input r0 as u128.public;
    get.or_use general_settings[7u8] 0u128 into r1;
    and r1 1u128 into r2;
    and r1 8u128 into r3;
    assert.eq r2 1u128;
    assert.eq r3 0u128;
    set r0 into general_settings[8u8];

function mint:
    input r0 as u128.private;
    cast self.caller r0 into r1 as NFT.record;
    async mint r0 into r2;
    output r1 as NFT.record;
    output r2 as nft_tutorial.aleo/mint.future;

finalize mint:
    input r0 as u128.public;
    get.or_use general_settings[7u8] 0u128 into r1;
    and r1 1u128 into r2;
    and r1 2u128 into r3;
    and r1 8u128 into r4;
    assert.eq r2 1u128;
    assert.eq r3 2u128;
    assert.eq r4 0u128;
    get.or_use general_settings[8u8] 0u128 into r5;
    cast r5 into r6 as u32;
    gt r6 block.height into r7;
    assert.eq r7 true;
    get.or_use general_settings[1u8] 0u128 into r8;
    lt r0 r8 into r9;
    assert.eq r9 true;
    get.or_use general_settings[0u8] 0u128 into r10;
    assert.eq r10 r0;
    add r10 1u128 into r11;
    set r11 into general_settings[0u8];

function transfer:
    input r0 as NFT.record;
    input r1 as address.private;
    cast r1 r0.tokenId into r2 as NFT.record;
    output r2 as NFT.record;
