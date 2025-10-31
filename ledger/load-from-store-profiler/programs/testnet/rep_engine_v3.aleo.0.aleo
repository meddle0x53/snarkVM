program rep_engine_v3.aleo;

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
    key as address.public;
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
    add r3 1u64 into r4;
    cast r1.winner r1.opponent r1.winner_choice r1.opponent_choice into r5 as Match.record;
    cast r0 r1.winner r1.opponent r1.winner_choice r1.opponent_choice into r6 as MatchAudit.record;
    gt r4 r2.ranking.p_1.points into r7;
    cast r1.winner r4 into r8 as RankingInfo;
    gt r4 r2.ranking.p_2.points into r9;
    cast r1.winner r4 into r10 as RankingInfo;
    gt r4 r2.ranking.p_3.points into r11;
    cast r1.winner r4 into r12 as RankingInfo;
    ternary r11 r12.player r2.ranking.p_3.player into r13;
    ternary r11 r12.points r2.ranking.p_3.points into r14;
    cast r13 r14 into r15 as RankingInfo;
    ternary r9 r2.ranking.p_2.player r15.player into r16;
    ternary r9 r2.ranking.p_2.points r15.points into r17;
    cast r16 r17 into r18 as RankingInfo;
    ternary r9 r10.player r2.ranking.p_2.player into r19;
    ternary r9 r10.points r2.ranking.p_2.points into r20;
    cast r19 r20 into r21 as RankingInfo;
    ternary r7 r2.ranking.p_2.player r18.player into r22;
    ternary r7 r2.ranking.p_2.points r18.points into r23;
    cast r22 r23 into r24 as RankingInfo;
    ternary r7 r2.ranking.p_1.player r21.player into r25;
    ternary r7 r2.ranking.p_1.points r21.points into r26;
    cast r25 r26 into r27 as RankingInfo;
    ternary r7 r8.player r2.ranking.p_1.player into r28;
    ternary r7 r8.points r2.ranking.p_1.points into r29;
    cast r28 r29 into r30 as RankingInfo;
    cast r30 r27 r24 into r31 as Ranking;
    cast r2.owner r31 r2.season into r32 as LeaderBoard.record;
    async update r1.winner 1u64 r3 into r33;
    output r5 as Match.record;
    output r6 as MatchAudit.record;
    output r32 as LeaderBoard.record;
    output r33 as rep_engine_v3.aleo/update.future;

finalize update:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    get.or_use balances[r0] 0u64 into r3;
    assert.eq r3 r2;
    add r3 r1 into r4;
    set r4 into balances[r0];
