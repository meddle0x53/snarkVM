program official_oracle.aleo;

struct DataChunk:
    f0 as u128;
    f1 as u128;
    f2 as u128;
    f3 as u128;
    f4 as u128;
    f5 as u128;
    f6 as u128;
    f7 as u128;
    f8 as u128;
    f9 as u128;
    f10 as u128;
    f11 as u128;
    f12 as u128;
    f13 as u128;
    f14 as u128;
    f15 as u128;
    f16 as u128;
    f17 as u128;
    f18 as u128;
    f19 as u128;
    f20 as u128;
    f21 as u128;
    f22 as u128;
    f23 as u128;
    f24 as u128;
    f25 as u128;
    f26 as u128;
    f27 as u128;
    f28 as u128;
    f29 as u128;
    f30 as u128;
    f31 as u128;

struct Report:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;
    c8 as DataChunk;
    c9 as DataChunk;

struct ReportData:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;

mapping unique_id:
    key as u8.public;
    value as u128.public;

mapping allowed_keys:
    key as address.public;
    value as boolean.public;

mapping attested_data:
    key as u128.public;
    value as u128.public;

mapping last_update_timestamp:
    key as u128.public;
    value as u128.public;

closure verify_report:
    input r0 as ReportData;
    input r1 as Report;
    input r2 as signature;
    input r3 as address;
    hash.psd8 r0 into r4 as u128;
    and r1.c0.f7 1u128 into r5;
    assert.eq r5 1u128;
    and r1.c0.f7 2u128 into r6;
    assert.eq r6 0u128;
    and r1.c0.f7 4u128 into r7;
    assert.eq r7 4u128;
    assert.eq r4 r1.c0.f24;
    assert.eq 0u128 r1.c0.f25;
    assert.eq 0u128 r1.c0.f26;
    assert.eq 0u128 r1.c0.f27;
    hash.psd8 r1 into r8 as u128;
    sign.verify r2 r3 r8 into r9;
    output r9 as boolean;

function set_key:
    input r0 as address.public;
    assert.eq aleo1urxgwwfph8243x68r2sh772vl55ln0cvzvru4j9nm9er7x40lgyqkrthfe self.caller;
    async set_key r0 into r1;
    output r1 as official_oracle.aleo/set_key.future;

finalize set_key:
    input r0 as address.public;
    get.or_use allowed_keys[r0] false into r1;
    ternary r1 false true into r2;
    set r2 into allowed_keys[r0];

function set_unique_id:
    input r0 as u128.public;
    input r1 as u128.public;
    assert.eq aleo1urxgwwfph8243x68r2sh772vl55ln0cvzvru4j9nm9er7x40lgyqkrthfe self.caller;
    async set_unique_id r0 r1 into r2;
    output r2 as official_oracle.aleo/set_unique_id.future;

finalize set_unique_id:
    input r0 as u128.public;
    input r1 as u128.public;
    set r0 into unique_id[1u8];
    set r1 into unique_id[2u8];

function set_data:
    input r0 as ReportData.public;
    input r1 as Report.public;
    input r2 as signature.public;
    input r3 as address.public;
    call verify_report r0 r1 r2 r3 into r4;
    assert.eq r4 true;
    cast r0.c0.f0 r0.c0.f1 0u128 0u128 r0.c0.f4 r0.c0.f5 r0.c0.f6 r0.c0.f7 r0.c0.f8 r0.c0.f9 r0.c0.f10 r0.c0.f11 r0.c0.f12 r0.c0.f13 r0.c0.f14 r0.c0.f15 r0.c0.f16 r0.c0.f17 r0.c0.f18 r0.c0.f19 r0.c0.f20 r0.c0.f21 r0.c0.f22 r0.c0.f23 r0.c0.f24 r0.c0.f25 r0.c0.f26 r0.c0.f27 r0.c0.f28 r0.c0.f29 r0.c0.f30 r0.c0.f31 into r5 as DataChunk;
    cast r5 r0.c1 r0.c2 r0.c3 r0.c4 r0.c5 r0.c6 r0.c7 into r6 as ReportData;
    hash.psd8 r6 into r7 as u128;
    async set_data r7 r0.c0.f2 r0.c0.f3 r3 r1.c0.f8 r1.c0.f9 into r8;
    output r8 as official_oracle.aleo/set_data.future;

finalize set_data:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as address.public;
    input r4 as u128.public;
    input r5 as u128.public;
    get.or_use allowed_keys[r3] false into r6;
    assert.eq r6 true;
    get unique_id[1u8] into r7;
    get unique_id[2u8] into r8;
    assert.eq r7 r4;
    assert.eq r8 r5;
    get.or_use last_update_timestamp[r0] 0u128 into r9;
    gt r2 r9 into r10;
    assert.eq r10 true;
    set r1 into attested_data[r0];
    set r2 into last_update_timestamp[r0];
