program nft_battle_4214.aleo;

record RandomIndex:
    owner as address.private;
    index as u128.private;

record NFT:
    owner as address.private;
    strength as u8.private;
    speed as u8.private;
    stamina as u8.private;

record MatchNFT:
    owner as address.private;
    match_id as u128.private;
    original_owner as address.private;
    strength as u8.private;
    speed as u8.private;
    stamina as u8.private;

struct Random:
    rand1 as u128;
    rand2 as u128;
    rand3 as u128;

struct MatchData:
    game_finished as boolean;
    player1 as address;
    player2 as address;
    attr_to_battle as u8;
    winner as address;

mapping random_index:
    key as u128.public;
    value as u128.public;

mapping randomness:
    key as u128.public;
    value as Random.public;

mapping current_match_id:
    key as u128.public;
    value as u128.public;

mapping match_data:
    key as u128.public;
    value as MatchData.public;

function get_random_number:
    input r0 as u128.private;
    cast self.caller r0 into r1 as RandomIndex.record;
    async get_random_number r0 into r2;
    output r1 as RandomIndex.record;
    output r2 as nft_battle_4214.aleo/get_random_number.future;

finalize get_random_number:
    input r0 as u128.public;
    get.or_use random_index[0u128] 0u128 into r1;
    assert.eq r0 r1;
    rand.chacha into r2 as u128;
    rand.chacha into r3 as u128;
    rand.chacha into r4 as u128;
    cast r2 r3 r4 into r5 as Random;
    set r5 into randomness[r1];
    add r1 1u128 into r6;
    set r6 into random_index[0u128];

function mint_nft:
    input r0 as RandomIndex.record;
    input r1 as u128.private;
    input r2 as u128.private;
    input r3 as u128.private;
    mod r1 11u128 into r4;
    cast r4 into r5 as u8;
    mod r2 11u128 into r6;
    cast r6 into r7 as u8;
    mod r3 11u128 into r8;
    cast r8 into r9 as u8;
    cast self.caller r5 r7 r9 into r10 as NFT.record;
    async mint_nft r0.index r1 r2 r3 into r11;
    output r10 as NFT.record;
    output r11 as nft_battle_4214.aleo/mint_nft.future;

finalize mint_nft:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u128.public;
    get randomness[r0] into r4;
    assert.eq r4.rand1 r1;
    assert.eq r4.rand2 r2;
    assert.eq r4.rand3 r3;

function find_battle:
    input r0 as NFT.record;
    input r1 as address.private;
    input r2 as u128.private;
    cast r1 r2 r0.owner r0.strength r0.speed r0.stamina into r3 as MatchNFT.record;
    async find_battle r2 self.caller into r4;
    output r3 as MatchNFT.record;
    output r4 as nft_battle_4214.aleo/find_battle.future;

finalize find_battle:
    input r0 as u128.public;
    input r1 as address.public;
    get.or_use current_match_id[0u128] 0u128 into r2;
    assert.eq r0 r2;
    cast false nft_battle.aleo nft_battle.aleo 4u8 nft_battle.aleo into r3 as MatchData;
    get.or_use match_data[r0] r3 into r4;
    is.eq r4.player1 nft_battle.aleo into r5;
    branch.eq r5 false to end_then_0_0;
    rand.chacha into r6 as u128;
    mod r6 3u128 into r7;
    cast r7 into r8 as u8;
    cast false r1 nft_battle.aleo r8 nft_battle.aleo into r9 as MatchData;
    set r9 into match_data[r0];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    assert.neq r1 r4.player1;
    cast false r4.player1 r1 r4.attr_to_battle nft_battle.aleo into r10 as MatchData;
    set r10 into match_data[r0];
    position end_otherwise_0_1;

function finish_game:
    input r0 as MatchNFT.record;
    input r1 as MatchNFT.record;
    input r2 as u8.private;
    cast r0.original_owner r0.strength r0.speed r0.stamina into r3 as NFT.record;
    cast r1.original_owner r1.strength r1.speed r1.stamina into r4 as NFT.record;
    is.eq r2 0u8 into r5;
    gt r0.strength r1.strength into r6;
    ternary r6 r0.original_owner r1.original_owner into r7;
    not r5 into r8;
    is.eq r2 1u8 into r9;
    gt r0.strength r1.strength into r10;
    ternary r10 r0.original_owner r1.original_owner into r11;
    not r9 into r12;
    is.eq r2 2u8 into r13;
    gt r0.strength r1.strength into r14;
    ternary r14 r0.original_owner r1.original_owner into r15;
    ternary r13 r15 nft_battle.aleo into r16;
    ternary r9 r11 r16 into r17;
    ternary r5 r7 r17 into r18;
    async finish_game r0.match_id r18 r2 into r19;
    output r3 as NFT.record;
    output r4 as NFT.record;
    output r19 as nft_battle_4214.aleo/finish_game.future;

finalize finish_game:
    input r0 as u128.public;
    input r1 as address.public;
    input r2 as u8.public;
    get match_data[r0] into r3;
    assert.eq r3.attr_to_battle r2;
    cast true r3.player1 r3.player2 r2 r1 into r4 as MatchData;
    set r4 into match_data[0u128];
    get current_match_id[0u128] into r5;
    add r5 1u128 into r6;
    set r6 into current_match_id[0u128];
