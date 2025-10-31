import credits.aleo;

program bet_king_minimask.aleo;

struct DiceRolled:
    player as address;
    bet_amount as u64;
    chosen_number as u8;
    rolled_number as u8;
    payout as u64;

mapping balances:
    key as address.public;
    value as u64.public;

mapping round_counts:
    key as address.public;
    value as u64.public;

mapping dice_rolled:
    key as address.public;
    value as DiceRolled.public;

function roll_dice:
    input r0 as u64.private;
    input r1 as u8.private;
    async roll_dice self.caller r0 r1 into r2;
    output r2 as bet_king_minimask.aleo/roll_dice.future;

finalize roll_dice:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u8.public;
    gte r1 100000u64 into r3;
    lte r1 10000000u64 into r4;
    and r3 r4 into r5;
    assert.eq r5 true;
    gte r2 1u8 into r6;
    lte r2 6u8 into r7;
    and r6 r7 into r8;
    assert.eq r8 true;
    get.or_use balances[r0] 0u64 into r9;
    gte r9 r1 into r10;
    assert.eq r10 true;
    get.or_use round_counts[r0] 0u64 into r11;
    xor r11 11400714819323198485u64 into r12;
    mul r12 2685821657736338717u64 into r13;
    shr r13 12u32 into r14;
    xor r13 r14 into r15;
    shl r13 25u32 into r16;
    xor r15 r16 into r17;
    shr r13 27u32 into r18;
    xor r17 r18 into r19;
    rem r19 6u64 into r20;
    add r20 1u64 into r21;
    cast r21 into r22 as u8;
    add r11 1u64 into r23;
    set r23 into round_counts[r0];
    is.eq r22 r2 into r24;
    mul r1 6u64 into r25;
    sub 100u64 2u64 into r26;
    mul r25 r26 into r27;
    div r27 100u64 into r28;
    ternary r24 r28 0u64 into r29;
    cast r0 r1 r2 r22 r29 into r30 as DiceRolled;
    set r30 into dice_rolled[r0];
    sub r9 r1 into r31;
    add r31 r29 into r32;
    sub r9 r1 into r33;
    ternary r24 r32 r33 into r34;
    set r34 into balances[r0];

function deposit:
    input r0 as u64.private;
    input r1 as address.private;
    gt r0 0u64 into r2;
    assert.eq r2 true;
    call credits.aleo/transfer_public_as_signer r1 r0 into r3;
    async deposit self.caller r0 r3 into r4;
    output r4 as bet_king_minimask.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    await r2;
    get.or_use balances[r0] 0u64 into r3;
    add r3 r1 into r4;
    set r4 into balances[r0];

function withdraw:
    input r0 as u64.private;
    call credits.aleo/transfer_public self.caller r0 into r1;
    async withdraw r1 self.caller r0 into r2;
    output r2 as bet_king_minimask.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get.or_use balances[r1] 0u64 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    sub r3 r2 into r5;
    set r5 into balances[r1];

function get_balance:
    async get_balance self.caller into r0;
    output r0 as bet_king_minimask.aleo/get_balance.future;

finalize get_balance:
    input r0 as address.public;
    get.or_use balances[r0] 0u64 into r1;
