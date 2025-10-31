program eclipse_oracle_feed.aleo;

struct FeedConfig:
    creator as address;
    min_stake as u64;
    slashing_threshold as u64;
    aggregation_window as u32;
    challenge_window as u32;
    paused as boolean;

mapping feeds:
    key as field.public;
    value as FeedConfig.public;

function create_feed:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u32.public;
    input r4 as u32.public;
    input r5 as address.public;
    async create_feed r0 r1 r2 r3 r4 r5 into r6;
    output r6 as eclipse_oracle_feed.aleo/create_feed.future;

finalize create_feed:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u32.public;
    input r4 as u32.public;
    input r5 as address.public;
    contains feeds[r0] into r6;
    not r6 into r7;
    assert.eq r7 true;
    cast r5 r1 r2 r3 r4 false into r8 as FeedConfig;
    set r8 into feeds[r0];

function pause_feed:
    input r0 as field.public;
    input r1 as address.public;
    async pause_feed r0 r1 into r2;
    output r2 as eclipse_oracle_feed.aleo/pause_feed.future;

finalize pause_feed:
    input r0 as field.public;
    input r1 as address.public;
    get feeds[r0] into r2;
    is.eq r1 r2.creator into r3;
    assert.eq r3 true;
    not r2.paused into r4;
    assert.eq r4 true;
    cast r2.creator r2.min_stake r2.slashing_threshold r2.aggregation_window r2.challenge_window true into r5 as FeedConfig;
    set r5 into feeds[r0];

function resume_feed:
    input r0 as field.public;
    input r1 as address.public;
    async resume_feed r0 r1 into r2;
    output r2 as eclipse_oracle_feed.aleo/resume_feed.future;

finalize resume_feed:
    input r0 as field.public;
    input r1 as address.public;
    get feeds[r0] into r2;
    is.eq r1 r2.creator into r3;
    assert.eq r3 true;
    assert.eq r2.paused true;
    cast r2.creator r2.min_stake r2.slashing_threshold r2.aggregation_window r2.challenge_window false into r4 as FeedConfig;
    set r4 into feeds[r0];
