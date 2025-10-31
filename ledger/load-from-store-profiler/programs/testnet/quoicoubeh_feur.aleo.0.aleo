program quoicoubeh_feur.aleo;

record Market:
    owner as address.private;
    question as field.private;
    bidder as address.private;
    end_time as u64.private;
    yes_pool as u64.private;
    no_pool as u64.private;
    is_resolved as boolean.private;
    outcome as boolean.private;

function create_market:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as u64.private;
    assert.eq self.caller r0;
    cast aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg r1 r0 r2 1000u64 1000u64 false false into r3 as Market.record;
    output r3 as Market.record;
