import credits.aleo;
import token_registry.aleo;

program airdrop_15_arc21.aleo;

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

function airdrop_15_addresses:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.private;
    input r2 as [address; 15u32].private;
    call token_registry.aleo/transfer_private r2[0u32] r1 r0 into r3 r4 r5;
    call token_registry.aleo/transfer_private r2[1u32] r1 r0 into r6 r7 r8;
    call token_registry.aleo/transfer_private r2[2u32] r1 r0 into r9 r10 r11;
    call token_registry.aleo/transfer_private r2[3u32] r1 r0 into r12 r13 r14;
    call token_registry.aleo/transfer_private r2[4u32] r1 r0 into r15 r16 r17;
    call token_registry.aleo/transfer_private r2[5u32] r1 r0 into r18 r19 r20;
    call token_registry.aleo/transfer_private r2[6u32] r1 r0 into r21 r22 r23;
    call token_registry.aleo/transfer_private r2[7u32] r1 r0 into r24 r25 r26;
    call token_registry.aleo/transfer_private r2[8u32] r1 r0 into r27 r28 r29;
    call token_registry.aleo/transfer_private r2[9u32] r1 r0 into r30 r31 r32;
    call token_registry.aleo/transfer_private r2[10u32] r1 r0 into r33 r34 r35;
    call token_registry.aleo/transfer_private r2[11u32] r1 r0 into r36 r37 r38;
    call token_registry.aleo/transfer_private r2[12u32] r1 r0 into r39 r40 r41;
    call token_registry.aleo/transfer_private r2[13u32] r1 r0 into r42 r43 r44;
    call token_registry.aleo/transfer_private r2[14u32] r1 r0 into r45 r46 r47;
    async airdrop_15_addresses r5 r8 r11 r14 r17 r20 r23 r26 r29 r32 r35 r38 r41 r44 r47 into r48;
    output r4 as token_registry.aleo/Token.record;
    output r48 as airdrop_15_arc21.aleo/airdrop_15_addresses.future;

finalize airdrop_15_addresses:
    input r0 as token_registry.aleo/transfer_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as token_registry.aleo/transfer_private.future;
    input r3 as token_registry.aleo/transfer_private.future;
    input r4 as token_registry.aleo/transfer_private.future;
    input r5 as token_registry.aleo/transfer_private.future;
    input r6 as token_registry.aleo/transfer_private.future;
    input r7 as token_registry.aleo/transfer_private.future;
    input r8 as token_registry.aleo/transfer_private.future;
    input r9 as token_registry.aleo/transfer_private.future;
    input r10 as token_registry.aleo/transfer_private.future;
    input r11 as token_registry.aleo/transfer_private.future;
    input r12 as token_registry.aleo/transfer_private.future;
    input r13 as token_registry.aleo/transfer_private.future;
    input r14 as token_registry.aleo/transfer_private.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
    await r9;
    await r10;
    await r11;
    await r12;
    await r13;
    await r14;
