program nftonaleokyc_v3.aleo;

record KYCRecord:
    owner as address.private;
    kyc_level as u8.private;
    expiry_date as u64.private;
    is_verified as boolean.private;
    risk_score as u8.private;

mapping kyc_verification:
    key as address.public;
    value as boolean.public;

mapping kyc_expiry_date:
    key as address.public;
    value as u64.public;

mapping kyc_level_status:
    key as address.public;
    value as u8.public;

function initialize:
    input r0 as address.public;
    assert.eq self.caller r0;
    async initialize into r1;
    output r1 as nftonaleokyc_v3.aleo/initialize.future;

finalize initialize:
    assert.eq true true;

function mint:
    input r0 as address.public;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as u8.private;
    cast r0 r1 r2 true r3 into r4 as KYCRecord.record;
    async mint r0 r1 r2 into r5;
    output r4 as KYCRecord.record;
    output true as boolean.private;
    output r5 as nftonaleokyc_v3.aleo/mint.future;

finalize mint:
    input r0 as address.public;
    input r1 as u8.public;
    input r2 as u64.public;
    lte r1 3u8 into r3;
    assert.eq r3 true;
    cast block.height into r4 as u64;
    gt r2 r4 into r5;
    assert.eq r5 true;
    set true into kyc_verification[r0];
    set r2 into kyc_expiry_date[r0];
    set r1 into kyc_level_status[r0];

function update_kyc_status:
    input r0 as KYCRecord.record;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as u8.private;
    assert.eq r0.owner self.caller;
    cast r0.owner r1 r2 true r3 into r4 as KYCRecord.record;
    async update_kyc_status r0.owner r1 r2 into r5;
    output r4 as KYCRecord.record;
    output true as boolean.private;
    output r5 as nftonaleokyc_v3.aleo/update_kyc_status.future;

finalize update_kyc_status:
    input r0 as address.public;
    input r1 as u8.public;
    input r2 as u64.public;
    lte r1 3u8 into r3;
    assert.eq r3 true;
    cast block.height into r4 as u64;
    gt r2 r4 into r5;
    assert.eq r5 true;
    set r1 into kyc_level_status[r0];
    set r2 into kyc_expiry_date[r0];

function verify_kyc:
    input r0 as KYCRecord.record;
    async verify_kyc r0.owner r0.expiry_date into r1;
    output true as boolean.private;
    output r1 as nftonaleokyc_v3.aleo/verify_kyc.future;

finalize verify_kyc:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use kyc_expiry_date[r0] 0u64 into r2;
    get.or_use kyc_verification[r0] false into r3;
    cast block.height into r4 as u64;
    gt r1 r4 into r5;
    assert.eq r5 true;
    is.eq r2 r1 into r6;
    assert.eq r6 true;
    assert.eq r3 true;

function verify_kyc_by_address:
    input r0 as address.public;
    async verify_kyc_by_address r0 into r1;
    output true as boolean.private;
    output r1 as nftonaleokyc_v3.aleo/verify_kyc_by_address.future;

finalize verify_kyc_by_address:
    input r0 as address.public;
    get.or_use kyc_expiry_date[r0] 0u64 into r1;
    get.or_use kyc_verification[r0] false into r2;
    get.or_use kyc_level_status[r0] 0u8 into r3;
    cast block.height into r4 as u64;
    assert.eq r2 true;
    gt r1 r4 into r5;
    assert.eq r5 true;
    gt r3 0u8 into r6;
    assert.eq r6 true;
    lte r3 3u8 into r7;
    assert.eq r7 true;
