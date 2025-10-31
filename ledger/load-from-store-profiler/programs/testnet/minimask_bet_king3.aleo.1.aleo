import credits.aleo;

program minimask_bet_king3.aleo;

struct FootballMatch:
    match_id as u64;
    home_team as field;
    away_team as field;
    start_time as u32;
    end_time as u32;
    winner as u8;

struct BetSlip:
    player as address;
    match_id as u64;
    bet_amount as u64;
    predicted_winner as u8;
    payout as u64;
    settled as boolean;

mapping balances:
    key as address.public;
    value as u64.public;

mapping matches:
    key as u64.public;
    value as FootballMatch.public;

mapping bets:
    key as address.public;
    value as BetSlip.public;

function create_match:
    input r0 as u64.private;
    input r1 as field.private;
    input r2 as field.private;
    is.eq self.caller aleo1fhwz4w7jg0sq0pd0xk5h0t5jf2taueaf8zdcflpjszc0mjrrtqyqchmjpq into r3;
    assert.eq r3 true;
    async create_match r0 r1 r2 into r4;
    output r4 as minimask_bet_king3.aleo/create_match.future;

finalize create_match:
    input r0 as u64.public;
    input r1 as field.public;
    input r2 as field.public;
    cast r0 r1 r2 block.height 540u32 0u8 into r3 as FootballMatch;
    set r3 into matches[r0];

function place_bet:
    input r0 as u64.private;
    input r1 as u64.private;
    input r2 as u8.private;
    async place_bet self.caller r0 r1 r2 into r3;
    output r3 as minimask_bet_king3.aleo/place_bet.future;

finalize place_bet:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u8.public;
    gte r2 100000u64 into r4;
    lte r2 10000000u64 into r5;
    and r4 r5 into r6;
    assert.eq r6 true;
    is.eq r3 1u8 into r7;
    is.eq r3 2u8 into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    cast r1 123field 123field 0u32 0u32 0u8 into r10 as FootballMatch;
    get.or_use matches[r1] r10 into r11;
    lt block.height r11.start_time into r12;
    assert.eq r12 true;
    get.or_use balances[r0] 0u64 into r13;
    gte r13 r2 into r14;
    assert.eq r14 true;
    cast r0 r1 r2 r3 0u64 false into r15 as BetSlip;
    set r15 into bets[r0];
    sub r13 r2 into r16;
    set r16 into balances[r0];

function set_match_result:
    input r0 as u64.private;
    input r1 as u8.private;
    is.eq self.caller aleo1fhwz4w7jg0sq0pd0xk5h0t5jf2taueaf8zdcflpjszc0mjrrtqyqchmjpq into r2;
    assert.eq r2 true;
    async set_match_result r0 r1 into r3;
    output r3 as minimask_bet_king3.aleo/set_match_result.future;

finalize set_match_result:
    input r0 as u64.public;
    input r1 as u8.public;
    cast r0 123field 123field 0u32 0u32 0u8 into r2 as FootballMatch;
    get.or_use matches[r0] r2 into r3;
    gt block.height r3.end_time into r4;
    assert.eq r4 true;
    cast r3.match_id r3.home_team r3.away_team r3.start_time r3.end_time r1 into r5 as FootballMatch;
    set r5 into matches[r0];

function claim_winnings:
    input r0 as u64.private;
    async claim_winnings self.caller r0 into r1;
    output r1 as minimask_bet_king3.aleo/claim_winnings.future;

finalize claim_winnings:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 0u64 0u8 0u64 false into r2 as BetSlip;
    get.or_use bets[r0] r2 into r3;
    is.eq r3.match_id r1 into r4;
    assert.eq r4 true;
    is.eq r3.settled false into r5;
    assert.eq r5 true;
    cast r1 123field 123field 0u32 0u32 0u8 into r6 as FootballMatch;
    get.or_use matches[r1] r6 into r7;
    is.neq r7.winner 0u8 into r8;
    assert.eq r8 true;
    get.or_use balances[r0] 0u64 into r9;
    is.eq r3.predicted_winner r7.winner into r10;
    mul r3.bet_amount 2u64 into r11;
    sub 100u64 5u64 into r12;
    mul r11 r12 into r13;
    div r13 100u64 into r14;
    ternary r10 r14 0u64 into r15;
    cast r0 r1 0u64 0u8 r15 true into r16 as BetSlip;
    set r16 into bets[r0];
    add r9 r15 into r17;
    set r17 into balances[r0];

function deposit:
    input r0 as u64.private;
    input r1 as address.private;
    gt r0 0u64 into r2;
    assert.eq r2 true;
    call credits.aleo/transfer_public_as_signer r1 r0 into r3;
    async deposit self.caller r0 r3 into r4;
    output r4 as minimask_bet_king3.aleo/deposit.future;

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
    output r2 as minimask_bet_king3.aleo/withdraw.future;

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
    output r0 as minimask_bet_king3.aleo/get_balance.future;

finalize get_balance:
    input r0 as address.public;
    get.or_use balances[r0] 0u64 into r1;
