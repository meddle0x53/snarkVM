import credits.aleo;
import multi_token_support_program.aleo;

program meme_coins_launcher_003.aleo;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct TokenData:
    token_id as field;
    virtualTokenReserve as u128;
    virtualAleoReserve as u128;
    actualAleoReserve as u128;
    K as u128;

mapping tokens:
    key as field.public;
    value as TokenData.public;

function create_token:
    input r0 as u128.private;
    input r1 as u128.private;
    cast r0 into r2 as field;
    cast r1 into r3 as field;
    add r2 276042930540560field into r4;
    add r4 r3 into r5;
    call multi_token_support_program.aleo/register_token r5 r0 r1 6u8 1000000000000000u128 false meme_coins_launcher_003.aleo into r6;
    call multi_token_support_program.aleo/mint_public r5 meme_coins_launcher_003.aleo 1000000000000000u128 4294967295u32 into r7;
    async create_token r6 r7 r5 into r8;
    output r8 as meme_coins_launcher_003.aleo/create_token.future;

finalize create_token:
    input r0 as multi_token_support_program.aleo/register_token.future;
    input r1 as multi_token_support_program.aleo/mint_public.future;
    input r2 as field.public;
    contains tokens[r2] into r3;
    assert.eq r3 false;
    cast r2 1050000000000000u128 450000000u128 0u128 472500000000000000000000u128 into r4 as TokenData;
    set r4 into tokens[r2];
    await r0;
    await r1;

function buy:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as u128.private;
    call credits.aleo/transfer_public_as_signer meme_coins_launcher_003.aleo r1 into r3;
    call multi_token_support_program.aleo/transfer_public r0 self.signer r2 into r4;
    async buy r3 r4 r0 r1 r2 into r5;
    output r5 as meme_coins_launcher_003.aleo/buy.future;

finalize buy:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as multi_token_support_program.aleo/transfer_public.future;
    input r2 as field.public;
    input r3 as u64.public;
    input r4 as u128.public;
    contains tokens[r2] into r5;
    assert.eq r5 true;
    get tokens[r2] into r6;
    cast r3 into r7 as u128;
    add r6.virtualAleoReserve r7 into r8;
    div 472500000000000000000000u128 r8 into r9;
    sub r6.virtualTokenReserve r9 into r10;
    assert.eq r10 r4;
    cast r3 into r11 as u128;
    add r6.actualAleoReserve r11 into r12;
    cast r2 r9 r8 r12 r6.K into r13 as TokenData;
    set r13 into tokens[r2];
    await r0;
    await r1;

function sell:
    input r0 as field.private;
    input r1 as u128.private;
    input r2 as u64.private;
    call credits.aleo/transfer_public self.signer r2 into r3;
    call multi_token_support_program.aleo/transfer_public_as_signer r0 meme_coins_launcher_003.aleo r1 into r4;
    async sell r3 r4 r0 r1 r2 into r5;
    output r5 as meme_coins_launcher_003.aleo/sell.future;

finalize sell:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as multi_token_support_program.aleo/transfer_public_as_signer.future;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as u64.public;
    contains tokens[r2] into r5;
    assert.eq r5 true;
    get tokens[r2] into r6;
    cast r3 into r7 as u128;
    add r6.virtualTokenReserve r7 into r8;
    div 472500000000000000000000u128 r8 into r9;
    sub r6.virtualAleoReserve r9 into r10;
    cast r4 into r11 as u128;
    assert.eq r10 r11;
    cast r4 into r12 as u128;
    sub r6.actualAleoReserve r12 into r13;
    cast r2 r8 r9 r13 r6.K into r14 as TokenData;
    set r14 into tokens[r2];
    await r0;
    await r1;
