import credits.aleo;

program testing_assumptions.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;

mapping track_bonded:
    key as u64.public;
    value as u64.public;

function bonded_credits:
    input r0 as address.public;
    input r1 as u64.private;
    async bonded_credits r0 r1 into r2;
    output r2 as testing_assumptions.aleo/bonded_credits.future;

finalize bonded_credits:
    input r0 as address.public;
    input r1 as u64.public;
    get credits.aleo/bonded[r0] into r2;
    set r2.microcredits into track_bonded[r1];
