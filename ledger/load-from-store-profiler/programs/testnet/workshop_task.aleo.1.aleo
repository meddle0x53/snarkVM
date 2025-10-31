program workshop_task.aleo;

record bid:
    owner as address.private;
    bidder as address.private;
    amount as u64.private;
    is_winner as boolean.private;

function place_bid:
    input r0 as u64.private;
    cast aleo1qwfefjx65qenhsemuhpp9vz9cmdhqvdlwr7fzpt069psu9hggggqvn2shl self.caller r0 false into r1 as bid.record;
    output r1 as bid.record;

function resolve:
    input r0 as bid.record;
    input r1 as bid.record;
    assert.eq self.caller aleo1qwfefjx65qenhsemuhpp9vz9cmdhqvdlwr7fzpt069psu9hggggqvn2shl;
    gte r0.amount r1.amount into r2;
    cast r0.owner r0.bidder r0.amount true into r3 as bid.record;
    not r2 into r4;
    cast r1.owner r1.bidder r1.amount true into r5 as bid.record;
    ternary r2 r3.owner r5.owner into r6;
    ternary r2 r3.bidder r5.bidder into r7;
    ternary r2 r3.amount r5.amount into r8;
    ternary r2 r3.is_winner r5.is_winner into r9;
    cast r6 r7 r8 r9 into r10 as bid.record;
    output r10 as bid.record;

function finish:
    input r0 as bid.record;
    assert.eq self.caller aleo1qwfefjx65qenhsemuhpp9vz9cmdhqvdlwr7fzpt069psu9hggggqvn2shl;
    cast r0.owner r0.bidder r0.amount true into r1 as bid.record;
    output r1 as bid.record;
