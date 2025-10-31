program battleship_v0_2_0.aleo;

struct Metadata:
    player1 as address;
    player2 as address;
    nonce as field;

record Proposal:
    owner as address.private;
    metadata as Metadata.private;
    id as field.private;

record Board:
    owner as address.private;
    metadata as Metadata.private;
    id as field.private;
    positions as u64.private;
    attempts as u64.private;
    hits as u64.private;

record Move:
    owner as address.private;
    id as field.private;
    position as u64.private;
    previous_hit as u64.private;

record VictoryTicket:
    owner as address.private;
    metadata as Metadata.private;
    id as field.private;

struct Ships:
    carrier as u64;
    battleship as u64;
    cruiser as u64;
    destroyer as u64;

function propose_game:
    input r0 as Metadata.private;
    input r1 as Ships.private;
    is.neq r0.player1 r0.player2 into r2;
    assert.eq r2 true;
    is.eq r0.player1 self.caller into r3;
    is.eq r0.player2 self.caller into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    or r1.carrier r1.battleship into r6;
    or r6 r1.cruiser into r7;
    or r7 r1.destroyer into r8;
    div r8 2u64 into r9;
    div r8 4u64 into r10;
    div r8 8u64 into r11;
    and r9 8608480567731124087u64 into r12;
    and r10 3689348814741910323u64 into r13;
    and r11 1229782938247303441u64 into r14;
    sub r8 r12 into r15;
    sub r15 r13 into r16;
    sub r16 r14 into r17;
    div r17 16u64 into r18;
    add r17 r18 into r19;
    and r19 1085102592571150095u64 into r20;
    rem r20 255u64 into r21;
    assert.eq r21 14u64;
    hash.bhp256 r0 into r22 as field;
    is.eq self.caller r0.player1 into r23;
    ternary r23 r0.player2 r0.player1 into r24;
    cast r24 r0 r22 into r25 as Proposal.record;
    cast self.caller r0 r22 r8 0u64 0u64 into r26 as Board.record;
    output r25 as Proposal.record;
    output r26 as Board.record;

function accept_game:
    input r0 as Proposal.record;
    input r1 as Ships.private;
    or r1.carrier r1.battleship into r2;
    or r2 r1.cruiser into r3;
    or r3 r1.destroyer into r4;
    div r4 2u64 into r5;
    div r4 4u64 into r6;
    div r4 8u64 into r7;
    and r5 8608480567731124087u64 into r8;
    and r6 3689348814741910323u64 into r9;
    and r7 1229782938247303441u64 into r10;
    sub r4 r8 into r11;
    sub r11 r9 into r12;
    sub r12 r10 into r13;
    div r13 16u64 into r14;
    add r13 r14 into r15;
    and r15 1085102592571150095u64 into r16;
    rem r16 255u64 into r17;
    assert.eq r17 14u64;
    cast self.caller r0.metadata r0.id r4 0u64 0u64 into r18 as Board.record;
    output r18 as Board.record;

function start_game:
    input r0 as Board.record;
    input r1 as u64.private;
    is.eq r0.metadata.player1 self.caller into r2;
    assert.eq r2 true;
    is.eq r0.attempts 0u64 into r3;
    assert.eq r3 true;
    sub r1 1u64 into r4;
    and r1 r4 into r5;
    assert.eq r5 0u64;
    cast r0.owner r0.metadata r0.id r0.positions r1 r0.hits into r6 as Board.record;
    cast r0.metadata.player2 r0.id r1 0u64 into r7 as Move.record;
    output r6 as Board.record;
    output r7 as Move.record;

function make_move:
    input r0 as Board.record;
    input r1 as Move.record;
    input r2 as u64.private;
    is.eq r1.id r0.id into r3;
    assert.eq r3 true;
    sub r2 1u64 into r4;
    and r2 r4 into r5;
    assert.eq r5 0u64;
    and r2 r0.attempts into r6;
    assert.eq r6 0u64;
    or r0.attempts r2 into r7;
    or r0.hits r1.previous_hit into r8;
    cast r0.owner r0.metadata r0.id r0.positions r7 r8 into r9 as Board.record;
    and r1.position r0.positions into r10;
    is.eq self.caller r0.metadata.player1 into r11;
    ternary r11 r0.metadata.player2 r0.metadata.player1 into r12;
    cast r12 r0.id r2 r10 into r13 as Move.record;
    output r9 as Board.record;
    output r13 as Move.record;

function claim_victory:
    input r0 as Board.record;
    div r0.hits 2u64 into r1;
    div r0.hits 4u64 into r2;
    div r0.hits 8u64 into r3;
    and r1 8608480567731124087u64 into r4;
    and r2 3689348814741910323u64 into r5;
    and r3 1229782938247303441u64 into r6;
    sub r0.hits r4 into r7;
    sub r7 r5 into r8;
    sub r8 r6 into r9;
    div r9 16u64 into r10;
    add r9 r10 into r11;
    and r11 1085102592571150095u64 into r12;
    rem r12 255u64 into r13;
    is.eq r13 14u64 into r14;
    assert.eq r14 true;
    cast self.caller r0.metadata r0.id into r15 as VictoryTicket.record;
    output r15 as VictoryTicket.record;
