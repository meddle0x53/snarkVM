program auction_test_1532.aleo;

record Bid:
    owner as address.private;
    bidder as address.private;
    amount as u64.private;
    is_winner as boolean.private;

function place_bid:
    input r0 as u64.private;
    cast aleo14vhr2wuvyx2wtfa8pxm5cu5xp5nv5upw9rw20q86l6f9grn3rvqspt8fm7 self.caller r0 false into r1 as Bid.record;
    output r1 as Bid.record;

function resolve:
    input r0 as Bid.record;
    input r1 as Bid.record;
    assert.eq self.caller aleo14vhr2wuvyx2wtfa8pxm5cu5xp5nv5upw9rw20q86l6f9grn3rvqspt8fm7;
    gte r0.amount r1.amount into r2;
    not r2 into r3;
    ternary r2 r0.owner r1.owner into r4;
    ternary r2 r0.bidder r1.bidder into r5;
    ternary r2 r0.amount r1.amount into r6;
    ternary r2 r0.is_winner r1.is_winner into r7;
    cast r4 r5 r6 r7 into r8 as Bid.record;
    output r8 as Bid.record;

function finish:
    input r0 as Bid.record;
    assert.eq self.caller aleo14vhr2wuvyx2wtfa8pxm5cu5xp5nv5upw9rw20q86l6f9grn3rvqspt8fm7;
    cast r0.bidder r0.bidder r0.amount true into r1 as Bid.record;
    output r1 as Bid.record;
