program qudus_private_auction.aleo;

record Bid:
    owner as address.private;
    bidder as address.private;
    amount as u64.private;
    is_winner as boolean.private;

record Auction:
    owner as address.private;
    min_bid as u64.private;
    end_time as u64.private;
    highest_bid as u64.private;
    highest_bidder as address.private;

closure get_highest_bid:
    input r0 as u64;
    input r1 as u64;
    gt r0 r1 into r2;
    ternary r2 r0 r1 into r3;
    output r3 as u64;

closure get_highest_bidder:
    input r0 as u64;
    input r1 as u64;
    input r2 as address;
    input r3 as address;
    gt r0 r1 into r4;
    ternary r4 r2 r3 into r5;
    output r5 as address;

function place_bid:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as address.private;
    input r4 as u64.private;
    input r5 as u64.private;
    input r6 as u64.private;
    input r7 as address.private;
    assert.eq self.caller r0;
    gte r1 r4 into r8;
    assert.eq r8 true;
    lt r2 r5 into r9;
    assert.eq r9 true;
    cast r3 r0 r1 false into r10 as Bid.record;
    call get_highest_bid r1 r6 into r11;
    call get_highest_bidder r1 r6 r0 r7 into r12;
    cast r3 r4 r5 r11 r12 into r13 as Auction.record;
    output r10 as Bid.record;
    output r13 as Auction.record;

function resolve:
    input r0 as Auction.record;
    input r1 as u64.private;
    assert.eq self.caller r0.owner;
    gte r1 r0.end_time into r2;
    assert.eq r2 true;
    cast r0.owner r0.highest_bidder r0.highest_bid true into r3 as Bid.record;
    output r3 as Bid.record;
