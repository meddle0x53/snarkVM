program mjd_new_auction.aleo;

record Bid:
    owner as address.private;
    bidder as address.private;
    amount as u64.private;
    is_winner as boolean.private;

function place_bid:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller r0;
    cast aleo18kg2c5wm6fygl5yka9n8yyllfxls2x535haklls44mu9t96crqqsdm5kk6 r0 r1 false into r2 as Bid.record;
    output r2 as Bid.record;

function resolve:
    input r0 as Bid.record;
    input r1 as Bid.record;
    assert.eq self.caller aleo18kg2c5wm6fygl5yka9n8yyllfxls2x535haklls44mu9t96crqqsdm5kk6;
    gte r0.amount r1.amount into r2;
    not r2 into r3;
    is.eq r0.amount r1.amount into r4;
    and r3 r4 into r5;
    not r4 into r6;
    and r3 r6 into r7;
    ternary r5 r0.owner r1.owner into r8;
    ternary r5 r0.bidder r1.bidder into r9;
    ternary r5 r0.amount r1.amount into r10;
    ternary r5 r0.is_winner r1.is_winner into r11;
    cast r8 r9 r10 r11 into r12 as Bid.record;
    ternary r2 r0.owner r12.owner into r13;
    ternary r2 r0.bidder r12.bidder into r14;
    ternary r2 r0.amount r12.amount into r15;
    ternary r2 r0.is_winner r12.is_winner into r16;
    cast r13 r14 r15 r16 into r17 as Bid.record;
    output r17 as Bid.record;

function finish:
    input r0 as Bid.record;
    assert.eq self.caller aleo18kg2c5wm6fygl5yka9n8yyllfxls2x535haklls44mu9t96crqqsdm5kk6;
    cast r0.bidder r0.bidder r0.amount true into r1 as Bid.record;
    output r1 as Bid.record;
