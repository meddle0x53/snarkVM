program rep_engine_v1.aleo;

struct RankingInfo:
    player as address;
    points as u64;

struct Ranking:
    p_1 as RankingInfo;
    p_2 as RankingInfo;
    p_3 as RankingInfo;

record LeaderBoard:
    owner as address.private;
    ranking as Ranking.public;
    season as u64.public;

record Match:
    owner as address.private;
    opponent as address.private;
    winner_choice as u64.private;
    opponent_choice as u64.private;

record MatchAudit:
    owner as address.private;
    winner as address.private;
    opponent as address.private;
    winner_choice as u64.private;
    opponent_choice as u64.private;

struct MatchInfo:
    winner as address;
    opponent as address;
    winner_choice as u64;
    opponent_choice as u64;

mapping balances:
    key as field.public;
    value as u64.public;

function new_leaderboard:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 0u64 into r2 as RankingInfo;
    cast r0 0u64 into r3 as RankingInfo;
    cast r0 0u64 into r4 as RankingInfo;
    cast r2 r3 r4 into r5 as Ranking;
    cast r0 r5 r1 into r6 as LeaderBoard.record;
    output r6 as LeaderBoard.record;

function update:
    input r0 as address.private;
    input r1 as MatchInfo.private;
    input r2 as LeaderBoard.record;
    input r3 as u64.private;
    hash.bhp256 r1.winner into r4 as field;
    add r3 1u64 into r5;
    cast r1.winner r1.opponent r1.winner_choice r1.opponent_choice into r6 as Match.record;
    cast r0 r1.winner r1.opponent r1.winner_choice r1.opponent_choice into r7 as MatchAudit.record;
    gt r5 r2.ranking.p_1.points into r8;
    cast r1.winner r5 into r9 as RankingInfo;
    ternary r8 r2.ranking.p_2.player r2.ranking.p_3.player into r10;
    ternary r8 r2.ranking.p_2.points r2.ranking.p_3.points into r11;
    cast r10 r11 into r12 as RankingInfo;
    ternary r8 r2.ranking.p_1.player r2.ranking.p_2.player into r13;
    ternary r8 r2.ranking.p_1.points r2.ranking.p_2.points into r14;
    cast r13 r14 into r15 as RankingInfo;
    ternary r8 r9.player r2.ranking.p_1.player into r16;
    ternary r8 r9.points r2.ranking.p_1.points into r17;
    cast r16 r17 into r18 as RankingInfo;
    gt r5 r15.points into r19;
    cast r1.winner r5 into r20 as RankingInfo;
    ternary r19 r15.player r12.player into r21;
    ternary r19 r15.points r12.points into r22;
    cast r21 r22 into r23 as RankingInfo;
    ternary r19 r20.player r15.player into r24;
    ternary r19 r20.points r15.points into r25;
    cast r24 r25 into r26 as RankingInfo;
    gt r5 r23.points into r27;
    cast r1.winner r5 into r28 as RankingInfo;
    ternary r27 r28.player r23.player into r29;
    ternary r27 r28.points r23.points into r30;
    cast r29 r30 into r31 as RankingInfo;
    cast r18 r26 r31 into r32 as Ranking;
    cast r2.owner r32 r2.season into r33 as LeaderBoard.record;
    async update r4 1u64 r3 into r34;
    output r6 as Match.record;
    output r7 as MatchAudit.record;
    output r33 as LeaderBoard.record;
    output r34 as rep_engine_v1.aleo/update.future;

finalize update:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balances[r0] 0u64 into r3;
    assert.eq r3 r2;
    add r3 r1 into r4;
    set r4 into balances[r0];
