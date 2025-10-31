program libby_auctions_the_bids.aleo;

record Bid:
    owner as address.private;
    bidder as address.private;
    amount as u64.private;
    is_winner as boolean.private;

record Prize:
    owner as address.private;
    amount as u64.private;

function place_bid:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller r0;
    cast aleo1h0tr2z6q8xxvpqghdsqch7gd6chqnn9zh5ftj8sgdn9jvxk32sfq5lz9fh r0 r1 false into r2 as Bid.record;
    output r2 as Bid.record;

function resolve:
    input r0 as Bid.record;
    input r1 as Bid.record;
    assert.eq self.caller aleo1h0tr2z6q8xxvpqghdsqch7gd6chqnn9zh5ftj8sgdn9jvxk32sfq5lz9fh;
    gte r0.amount r1.amount into r2;
    ternary r2 r0.owner r1.owner into r3;
    ternary r2 r0.bidder r1.bidder into r4;
    ternary r2 r0.amount r1.amount into r5;
    ternary r2 r0.is_winner r1.is_winner into r6;
    cast r3 r4 r5 r6 into r7 as Bid.record;
    output r7 as Bid.record;

function finish:
    input r0 as Bid.record;
    assert.eq self.caller aleo1h0tr2z6q8xxvpqghdsqch7gd6chqnn9zh5ftj8sgdn9jvxk32sfq5lz9fh;
    cast r0.bidder r0.bidder r0.amount true into r1 as Bid.record;
    output r1 as Bid.record;

function claim:
    input r0 as Bid.record;
    assert.eq self.caller aleo1h0tr2z6q8xxvpqghdsqch7gd6chqnn9zh5ftj8sgdn9jvxk32sfq5lz9fh;
    assert.eq r0.is_winner true;
    cast r0.bidder 200u64 into r1 as Prize.record;
    output r1 as Prize.record;
