program prisonersdilemma.aleo;

record game:
    owner as address.private;
    winner as address.private;

record choice:
    owner as address.private;
    player as address.private;
    steal as boolean.private;

function make_choice:
    input r0 as boolean.private;
    cast aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj self.caller r0 into r1 as choice.record;
    output r1 as choice.record;

function finish:
    input r0 as choice.record;
    input r1 as choice.record;
    assert.eq self.caller aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj;
    is.eq r0.steal true into r2;
    is.eq r1.steal true into r3;
    and r2 r3 into r4;
    cast aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj into r5 as game.record;
    is.eq r0.steal false into r6;
    is.eq r1.steal false into r7;
    and r6 r7 into r8;
    cast aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj r0.player into r9 as game.record;
    is.eq r0.steal true into r10;
    is.eq r1.steal false into r11;
    and r10 r11 into r12;
    cast aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj r0.player into r13 as game.record;
    is.eq r0.steal false into r14;
    is.eq r1.steal true into r15;
    and r14 r15 into r16;
    cast aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj r1.player into r17 as game.record;
    cast aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj aleo1ew7v7s48ydr7fjnuy3w4tdmrqzemjpgd3j9n3uq7cwmsyrrfqufqeamrqj into r18 as game.record;
    not r4 into r19;
    not r8 into r20;
    and r19 r20 into r21;
    not r12 into r22;
    and r21 r22 into r23;
    and r23 r16 into r24;
    ternary r24 r17.owner r18.owner into r25;
    not r4 into r26;
    not r8 into r27;
    and r26 r27 into r28;
    not r12 into r29;
    and r28 r29 into r30;
    and r30 r16 into r31;
    ternary r31 r17.winner r18.winner into r32;
    cast r25 r32 into r33 as game.record;
    not r4 into r34;
    not r8 into r35;
    and r34 r35 into r36;
    and r36 r12 into r37;
    ternary r37 r13.owner r33.owner into r38;
    not r4 into r39;
    not r8 into r40;
    and r39 r40 into r41;
    and r41 r12 into r42;
    ternary r42 r13.winner r33.winner into r43;
    cast r38 r43 into r44 as game.record;
    not r4 into r45;
    and r45 r8 into r46;
    ternary r46 r9.owner r44.owner into r47;
    not r4 into r48;
    and r48 r8 into r49;
    ternary r49 r9.winner r44.winner into r50;
    cast r47 r50 into r51 as game.record;
    ternary r4 r5.owner r51.owner into r52;
    ternary r4 r5.winner r51.winner into r53;
    cast r52 r53 into r54 as game.record;
    output r54 as game.record;
