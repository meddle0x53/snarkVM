program bigtianah_auct.aleo;

record Bid:
    owner as address.private;
    bidder as address.private;
    amount as u64.private;
    is_winner as boolean.private;

record Prize:
    owner as address.private;
    amount as u64.private;

function claim:
    input r0 as Bid.record;
    assert.eq r0.is_winner true;
    cast r0.owner r0.amount into r1 as Prize.record;
    output r1 as Prize.record;
