program nftonaleokyc_v6.aleo;

record KYCRecord:
    owner as address.private;
    kyc_level as u8.private;
    expiry_date as u64.private;
    is_verified as boolean.private;
    risk_score as u8.private;

struct VerificationInfo:
    is_verified as boolean;
    expiry_date as u64;
    block_height as u64;
    kyc_level as u8;
    mint_height as u64;
    risk_score as u8;

mapping kyc_verification:
    key as address.public;
    value as boolean.public;

mapping kyc_expiry_date:
    key as address.public;
    value as u64.public;

mapping kyc_level_status:
    key as address.public;
    value as u8.public;

mapping kyc_block_height:
    key as address.public;
    value as u64.public;

mapping debug_info:
    key as field.public;
    value as field.public;

function initialize:
    input r0 as address.public;
    assert.eq self.caller r0;
    async initialize r0 into r1;
    output r1 as nftonaleokyc_v6.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    cast block.height into r1 as u64;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    cast r1 into r3 as field;
    set r3 into debug_info[0field];
    cast r0 into r4 as field;
    set r4 into debug_info[1field];

function mint:
    input r0 as address.public;
    input r1 as u8.private;
    input r2 as u64.private;
    input r3 as u8.private;
    cast r0 r1 r2 true r3 into r4 as KYCRecord.record;
    async mint r0 r1 r2 into r5;
    output r4 as KYCRecord.record;
    output true as boolean.private;
    output r5 as nftonaleokyc_v6.aleo/mint.future;

finalize mint:
    input r0 as address.public;
    input r1 as u8.public;
    input r2 as u64.public;
    cast block.height into r3 as u64;
    lte r1 3u8 into r4;
    assert.eq r4 true;
    gt r2 r3 into r5;
    assert.eq r5 true;
    set true into kyc_verification[r0];
    set r2 into kyc_expiry_date[r0];
    set r1 into kyc_level_status[r0];
    set r3 into kyc_block_height[r0];
    cast r3 into r6 as field;
    set r6 into debug_info[2field];
    cast r0 into r7 as field;
    set r7 into debug_info[3field];
    cast r2 into r8 as field;
    set r8 into debug_info[4field];

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
    output r5 as nftonaleokyc_v6.aleo/update_kyc_status.future;

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
    output r1 as nftonaleokyc_v6.aleo/verify_kyc.future;

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
    cast false 0u64 0u64 0u8 0u64 0u8 into r1 as VerificationInfo;
    async verify_kyc_by_address r0 into r2;
    output r1 as VerificationInfo.private;
    output r2 as nftonaleokyc_v6.aleo/verify_kyc_by_address.future;

finalize verify_kyc_by_address:
    input r0 as address.public;
    cast block.height into r1 as u64;
    get.or_use kyc_verification[r0] false into r2;
    get.or_use kyc_expiry_date[r0] 0u64 into r3;
    get.or_use kyc_level_status[r0] 0u8 into r4;
    get.or_use kyc_block_height[r0] 0u64 into r5;
    cast r1 into r6 as field;
    set r6 into debug_info[5field];
    cast r0 into r7 as field;
    set r7 into debug_info[6field];
    cast r3 into r8 as field;
    set r8 into debug_info[7field];
    cast r5 into r9 as field;
    set r9 into debug_info[8field];
    cast r2 into r10 as field;
    set r10 into debug_info[9field];
    cast r4 into r11 as field;
    set r11 into debug_info[10field];
    gt r3 0u64 into r12;
    and r2 r12 into r13;
    gt r3 r1 into r14;
    and r13 r14 into r15;
    gt r4 0u8 into r16;
    and r15 r16 into r17;
    lte r4 3u8 into r18;
    and r17 r18 into r19;
    gt r5 0u64 into r20;
    and r19 r20 into r21;
    lte r5 r1 into r22;
    and r21 r22 into r23;
    cast r23 into r24 as field;
    set r24 into debug_info[11field];
    assert.eq r23 true;
