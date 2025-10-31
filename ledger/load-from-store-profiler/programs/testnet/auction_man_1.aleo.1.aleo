program auction_man_1.aleo;

record Bid:
    owner as address.private;
    bidder as address.private;
    amount as u64.private;
    is_winner as boolean.private;

function place_bid:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller r0;
    cast aleo1fgk6vppuffanv5l5h9xpkl9g8vuun4lv24x9nrcq7k020mf4wyzs37mjer r0 r1 false into r2 as Bid.record;
    output r2 as Bid.record;

function resolve:
    input r0 as Bid.record;
    input r1 as Bid.record;
    assert.eq self.caller aleo1fgk6vppuffanv5l5h9xpkl9g8vuun4lv24x9nrcq7k020mf4wyzs37mjer;
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
    assert.eq self.caller aleo1fgk6vppuffanv5l5h9xpkl9g8vuun4lv24x9nrcq7k020mf4wyzs37mjer;
    cast r0.bidder r0.bidder r0.amount true into r1 as Bid.record;
    output r1 as Bid.record;
