import multi_token_support_program.aleo;
import holding_sg_v1.aleo;
import token_bridge_sg_v1.aleo;

program token_service_sg_v1.aleo;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct Holder:
    account as address;
    token_id as field;

struct WithdrawalLimit:
    percentage as u16;
    duration as u32;
    threshold_no_limit as u128;

struct ChainToken:
    chain_id as u128;
    token_id as field;

mapping owner_TS:
    key as boolean.public;
    value as address.public;

mapping total_supply:
    key as field.public;
    value as u128.public;

mapping added_tokens:
    key as field.public;
    value as boolean.public;

mapping min_transfers:
    key as field.public;
    value as u128.public;

mapping max_transfers:
    key as field.public;
    value as u128.public;

mapping token_withdrawal_limits:
    key as field.public;
    value as WithdrawalLimit.public;

mapping token_snapshot_withdrawal:
    key as field.public;
    value as u128.public;

mapping token_snapshot_height:
    key as field.public;
    value as u32.public;

mapping token_amount_withdrawn:
    key as field.public;
    value as u128.public;

mapping token_status:
    key as field.public;
    value as boolean.public;

mapping other_chain_token_service:
    key as ChainToken.public;
    value as [u8; 32u32].public;

mapping other_chain_token_address:
    key as ChainToken.public;
    value as [u8; 32u32].public;

function initialize_ts:
    input r0 as address.public;
    async initialize_ts r0 into r1;
    output r1 as token_service_sg_v1.aleo/initialize_ts.future;

finalize initialize_ts:
    input r0 as address.public;
    contains owner_TS[true] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into owner_TS[true];

function transfer_ownership_ts:
    input r0 as address.public;
    async transfer_ownership_ts self.caller r0 into r1;
    output r1 as token_service_sg_v1.aleo/transfer_ownership_ts.future;

finalize transfer_ownership_ts:
    input r0 as address.public;
    input r1 as address.public;
    get owner_TS[true] into r2;
    assert.eq r0 r2;
    set r1 into owner_TS[true];

function update_other_chain_ts:
    input r0 as u128.public;
    input r1 as field.public;
    input r2 as [u8; 20u32].private;
    async update_other_chain_ts self.caller r0 r1 r2 into r3;
    output r3 as token_service_sg_v1.aleo/update_other_chain_ts.future;

finalize update_other_chain_ts:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as field.public;
    input r3 as [u8; 20u32].public;
    get owner_TS[true] into r4;
    assert.eq r0 r4;
    cast r1 r2 into r5 as ChainToken;
    contains other_chain_token_service[r5] into r6;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r3[0u32] r3[1u32] r3[2u32] r3[3u32] r3[4u32] r3[5u32] r3[6u32] r3[7u32] r3[8u32] r3[9u32] r3[10u32] r3[11u32] r3[12u32] r3[13u32] r3[14u32] r3[15u32] r3[16u32] r3[17u32] r3[18u32] r3[19u32] into r7 as [u8; 32u32];
    set r7 into other_chain_token_service[r5];

function update_other_chain_ta:
    input r0 as u128.public;
    input r1 as field.public;
    input r2 as [u8; 20u32].private;
    async update_other_chain_ta self.caller r0 r1 r2 into r3;
    output r3 as token_service_sg_v1.aleo/update_other_chain_ta.future;

finalize update_other_chain_ta:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as field.public;
    input r3 as [u8; 20u32].public;
    get owner_TS[true] into r4;
    assert.eq r0 r4;
    cast r1 r2 into r5 as ChainToken;
    contains other_chain_token_address[r5] into r6;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r3[0u32] r3[1u32] r3[2u32] r3[3u32] r3[4u32] r3[5u32] r3[6u32] r3[7u32] r3[8u32] r3[9u32] r3[10u32] r3[11u32] r3[12u32] r3[13u32] r3[14u32] r3[15u32] r3[16u32] r3[17u32] r3[18u32] r3[19u32] into r7 as [u8; 32u32];
    set r7 into other_chain_token_address[r5];

function add_token_ts:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as u16.public;
    input r4 as u32.public;
    input r5 as u128.public;
    input r6 as [u8; 20u32].public;
    input r7 as [u8; 20u32].public;
    input r8 as u128.public;
    gte r2 r1 into r9;
    assert.eq r9 true;
    lte r3 10000u16 into r10;
    assert.eq r10 true;
    async add_token_ts self.caller r0 r1 r2 r3 r4 r5 r6 r7 r8 into r11;
    output r11 as token_service_sg_v1.aleo/add_token_ts.future;

finalize add_token_ts:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as u16.public;
    input r5 as u32.public;
    input r6 as u128.public;
    input r7 as [u8; 20u32].public;
    input r8 as [u8; 20u32].public;
    input r9 as u128.public;
    get owner_TS[true] into r10;
    assert.eq r0 r10;
    cast r4 r5 r6 into r11 as WithdrawalLimit;
    cast r9 r1 into r12 as ChainToken;
    contains added_tokens[r1] into r13;
    not r13 into r14;
    assert.eq r14 true;
    set true into added_tokens[r1];
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r7[0u32] r7[1u32] r7[2u32] r7[3u32] r7[4u32] r7[5u32] r7[6u32] r7[7u32] r7[8u32] r7[9u32] r7[10u32] r7[11u32] r7[12u32] r7[13u32] r7[14u32] r7[15u32] r7[16u32] r7[17u32] r7[18u32] r7[19u32] into r15 as [u8; 32u32];
    set r15 into other_chain_token_address[r12];
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r8[0u32] r8[1u32] r8[2u32] r8[3u32] r8[4u32] r8[5u32] r8[6u32] r8[7u32] r8[8u32] r8[9u32] r8[10u32] r8[11u32] r8[12u32] r8[13u32] r8[14u32] r8[15u32] r8[16u32] r8[17u32] r8[18u32] r8[19u32] into r16 as [u8; 32u32];
    set r16 into other_chain_token_service[r12];
    set r11 into token_withdrawal_limits[r1];
    set r2 into min_transfers[r1];
    set r3 into max_transfers[r1];
    set true into token_status[r1];

function remove_token_ts:
    input r0 as field.public;
    async remove_token_ts self.caller r0 into r1;
    output r1 as token_service_sg_v1.aleo/remove_token_ts.future;

finalize remove_token_ts:
    input r0 as address.public;
    input r1 as field.public;
    get owner_TS[true] into r2;
    assert.eq r0 r2;
    contains added_tokens[r1] into r3;
    assert.eq r3 true;
    remove added_tokens[r1];
    remove token_withdrawal_limits[r1];
    remove min_transfers[r1];
    remove max_transfers[r1];
    remove token_status[r1];

function pause_token_ts:
    input r0 as field.public;
    async pause_token_ts self.caller r0 into r1;
    output r1 as token_service_sg_v1.aleo/pause_token_ts.future;

finalize pause_token_ts:
    input r0 as address.public;
    input r1 as field.public;
    get owner_TS[true] into r2;
    assert.eq r0 r2;
    contains token_status[r1] into r3;
    assert.eq r3 true;
    set true into token_status[r1];

function unpause_token_ts:
    input r0 as field.public;
    async unpause_token_ts self.caller r0 into r1;
    output r1 as token_service_sg_v1.aleo/unpause_token_ts.future;

finalize unpause_token_ts:
    input r0 as address.public;
    input r1 as field.public;
    get owner_TS[true] into r2;
    assert.eq r0 r2;
    contains token_status[r1] into r3;
    assert.eq r3 true;
    set false into token_status[r1];

function update_min_transfer_ts:
    input r0 as field.public;
    input r1 as u128.public;
    async update_min_transfer_ts self.caller r0 r1 into r2;
    output r2 as token_service_sg_v1.aleo/update_min_transfer_ts.future;

finalize update_min_transfer_ts:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get owner_TS[true] into r3;
    assert.eq r0 r3;
    get max_transfers[r1] into r4;
    lte r2 r4 into r5;
    assert.eq r5 true;
    contains min_transfers[r1] into r6;
    assert.eq r6 true;
    set r2 into min_transfers[r1];

function update_max_transfer_ts:
    input r0 as field.public;
    input r1 as u128.public;
    async update_max_transfer_ts self.caller r0 r1 into r2;
    output r2 as token_service_sg_v1.aleo/update_max_transfer_ts.future;

finalize update_max_transfer_ts:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get owner_TS[true] into r3;
    assert.eq r0 r3;
    get min_transfers[r1] into r4;
    gte r2 r4 into r5;
    assert.eq r5 true;
    contains max_transfers[r1] into r6;
    assert.eq r6 true;
    set r2 into max_transfers[r1];

function update_withdrawal_limit:
    input r0 as field.public;
    input r1 as u16.public;
    input r2 as u32.public;
    input r3 as u128.public;
    lte r1 10000u16 into r4;
    assert.eq r4 true;
    async update_withdrawal_limit self.caller r0 r1 r2 r3 into r5;
    output r5 as token_service_sg_v1.aleo/update_withdrawal_limit.future;

finalize update_withdrawal_limit:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u16.public;
    input r3 as u32.public;
    input r4 as u128.public;
    get owner_TS[true] into r5;
    assert.eq r0 r5;
    contains token_withdrawal_limits[r1] into r6;
    assert.eq r6 true;
    cast r2 r3 r4 into r7 as WithdrawalLimit;
    set r7 into token_withdrawal_limits[r1];

function token_send:
    input r0 as field.public;
    input r1 as [u8; 20u32].public;
    input r2 as u128.public;
    input r3 as u128.public;
    input r4 as [u8; 20u32].public;
    input r5 as [u8; 20u32].public;
    call multi_token_support_program.aleo/burn_public r0 self.caller r2 into r6;
    cast r3 r0 into r7 as ChainToken;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r4[0u32] r4[1u32] r4[2u32] r4[3u32] r4[4u32] r4[5u32] r4[6u32] r4[7u32] r4[8u32] r4[9u32] r4[10u32] r4[11u32] r4[12u32] r4[13u32] r4[14u32] r4[15u32] r4[16u32] r4[17u32] r4[18u32] r4[19u32] into r8 as [u8; 32u32];
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r5[0u32] r5[1u32] r5[2u32] r5[3u32] r5[4u32] r5[5u32] r5[6u32] r5[7u32] r5[8u32] r5[9u32] r5[10u32] r5[11u32] r5[12u32] r5[13u32] r5[14u32] r5[15u32] r5[16u32] r5[17u32] r5[18u32] r5[19u32] into r9 as [u8; 32u32];
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r1[0u32] r1[1u32] r1[2u32] r1[3u32] r1[4u32] r1[5u32] r1[6u32] r1[7u32] r1[8u32] r1[9u32] r1[10u32] r1[11u32] r1[12u32] r1[13u32] r1[14u32] r1[15u32] r1[16u32] r1[17u32] r1[18u32] r1[19u32] into r10 as [u8; 32u32];
    call token_bridge_sg_v1.aleo/publish r3 r8 r9 self.caller r10 r2 into r11;
    async token_send r6 r11 self.caller r0 r2 r7 r5 r4 into r12;
    output r12 as token_service_sg_v1.aleo/token_send.future;

finalize token_send:
    input r0 as multi_token_support_program.aleo/burn_public.future;
    input r1 as token_bridge_sg_v1.aleo/publish.future;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as u128.public;
    input r5 as ChainToken.public;
    input r6 as [u8; 20u32].public;
    input r7 as [u8; 20u32].public;
    await r0;
    await r1;
    get min_transfers[r3] into r8;
    gte r4 r8 into r9;
    assert.eq r9 true;
    contains other_chain_token_address[r5] into r10;
    assert.eq r10 true;
    get other_chain_token_address[r5] into r11;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r6[0u32] r6[1u32] r6[2u32] r6[3u32] r6[4u32] r6[5u32] r6[6u32] r6[7u32] r6[8u32] r6[9u32] r6[10u32] r6[11u32] r6[12u32] r6[13u32] r6[14u32] r6[15u32] r6[16u32] r6[17u32] r6[18u32] r6[19u32] into r12 as [u8; 32u32];
    assert.eq r11 r12;
    contains other_chain_token_service[r5] into r13;
    assert.eq r13 true;
    get other_chain_token_service[r5] into r14;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r7[0u32] r7[1u32] r7[2u32] r7[3u32] r7[4u32] r7[5u32] r7[6u32] r7[7u32] r7[8u32] r7[9u32] r7[10u32] r7[11u32] r7[12u32] r7[13u32] r7[14u32] r7[15u32] r7[16u32] r7[17u32] r7[18u32] r7[19u32] into r15 as [u8; 32u32];
    assert.eq r14 r15;
    get max_transfers[r3] into r16;
    lte r4 r16 into r17;
    assert.eq r17 true;
    get token_status[r3] into r18;
    assert.eq r18 false;
    get token_withdrawal_limits[r3] into r19;
    get total_supply[r3] into r20;
    lte r19.percentage 10000u16 into r21;
    assert.eq r21 true;
    cast r19.percentage into r22 as u128;
    mul r20 r22 into r23;
    cast 10000u16 into r24 as u128;
    div r23 r24 into r25;
    get.or_use token_snapshot_withdrawal[r3] r25 into r26;
    get.or_use token_snapshot_height[r3] 0u32 into r27;
    get.or_use token_amount_withdrawn[r3] 0u128 into r28;
    sub block.height r27 into r29;
    gt r29 r19.duration into r30;
    set r25 into token_snapshot_withdrawal[r3];
    set block.height into token_snapshot_height[r3];
    set r4 into token_amount_withdrawn[r3];
    add r28 r4 into r31;
    set r31 into token_amount_withdrawn[r3];
    gte r20 r19.threshold_no_limit into r32;
    get token_amount_withdrawn[r3] into r33;
    get token_snapshot_withdrawal[r3] into r34;
    lte r33 r34 into r35;
    not r32 into r36;
    or r36 r35 into r37;
    assert.eq r37 true;
    sub r20 r4 into r38;
    set r38 into total_supply[r3];

function token_receive:
    input r0 as [u8; 20u32].public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as u128.public;
    input r4 as u64.public;
    input r5 as u64.public;
    input r6 as [address; 5u32].public;
    input r7 as [signature; 5u32].public;
    input r8 as u128.public;
    input r9 as [u8; 20u32].public;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r9[0u32] r9[1u32] r9[2u32] r9[3u32] r9[4u32] r9[5u32] r9[6u32] r9[7u32] r9[8u32] r9[9u32] r9[10u32] r9[11u32] r9[12u32] r9[13u32] r9[14u32] r9[15u32] r9[16u32] r9[17u32] r9[18u32] r9[19u32] into r10 as [u8; 32u32];
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r0[0u32] r0[1u32] r0[2u32] r0[3u32] r0[4u32] r0[5u32] r0[6u32] r0[7u32] r0[8u32] r0[9u32] r0[10u32] r0[11u32] r0[12u32] r0[13u32] r0[14u32] r0[15u32] r0[16u32] r0[17u32] r0[18u32] r0[19u32] into r11 as [u8; 32u32];
    call token_bridge_sg_v1.aleo/consume r8 r10 r1 r11 r2 r3 r4 r5 r6 r7 into r12 r13;
    cast r8 r1 into r14 as ChainToken;
    not r12 into r15;
    ternary r15 aleo1f4xc78ykumx4pac8hlnle66nxptux3pwm2q24fslvhns3wh4tqgsj8f7yu r2 into r16;
    ternary r15 r3 0u128 into r17;
    cast r16 r1 into r18 as TokenOwner;
    call multi_token_support_program.aleo/mint_public r1 r16 r3 4294967295u32 into r19;
    call holding_sg_v1.aleo/hold_fund r2 r1 r17 into r20;
    async token_receive r13 r19 r20 r1 r3 r14 r9 into r21;
    output r12 as boolean.public;
    output r21 as token_service_sg_v1.aleo/token_receive.future;

finalize token_receive:
    input r0 as token_bridge_sg_v1.aleo/consume.future;
    input r1 as multi_token_support_program.aleo/mint_public.future;
    input r2 as holding_sg_v1.aleo/hold_fund.future;
    input r3 as field.public;
    input r4 as u128.public;
    input r5 as ChainToken.public;
    input r6 as [u8; 20u32].public;
    await r0;
    await r1;
    await r2;
    get token_status[r3] into r7;
    assert.eq r7 false;
    contains other_chain_token_service[r5] into r8;
    assert.eq r8 true;
    get other_chain_token_service[r5] into r9;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r6[0u32] r6[1u32] r6[2u32] r6[3u32] r6[4u32] r6[5u32] r6[6u32] r6[7u32] r6[8u32] r6[9u32] r6[10u32] r6[11u32] r6[12u32] r6[13u32] r6[14u32] r6[15u32] r6[16u32] r6[17u32] r6[18u32] r6[19u32] into r10 as [u8; 32u32];
    assert.eq r9 r10;
    get.or_use total_supply[r3] 0u128 into r11;
    add r11 r4 into r12;
    set r12 into total_supply[r3];

function add_chain_to_existing_token:
    input r0 as u128.public;
    input r1 as field.public;
    input r2 as [u8; 20u32].public;
    input r3 as [u8; 20u32].public;
    cast r0 r1 into r4 as ChainToken;
    async add_chain_to_existing_token self.caller r4 r2 r3 into r5;
    output r5 as token_service_sg_v1.aleo/add_chain_to_existing_token.future;

finalize add_chain_to_existing_token:
    input r0 as address.public;
    input r1 as ChainToken.public;
    input r2 as [u8; 20u32].public;
    input r3 as [u8; 20u32].public;
    get added_tokens[r1.token_id] into r4;
    assert.eq r4 true;
    get owner_TS[true] into r5;
    assert.eq r0 r5;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r2[0u32] r2[1u32] r2[2u32] r2[3u32] r2[4u32] r2[5u32] r2[6u32] r2[7u32] r2[8u32] r2[9u32] r2[10u32] r2[11u32] r2[12u32] r2[13u32] r2[14u32] r2[15u32] r2[16u32] r2[17u32] r2[18u32] r2[19u32] into r6 as [u8; 32u32];
    set r6 into other_chain_token_service[r1];
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 r3[0u32] r3[1u32] r3[2u32] r3[3u32] r3[4u32] r3[5u32] r3[6u32] r3[7u32] r3[8u32] r3[9u32] r3[10u32] r3[11u32] r3[12u32] r3[13u32] r3[14u32] r3[15u32] r3[16u32] r3[17u32] r3[18u32] r3[19u32] into r7 as [u8; 32u32];
    set r7 into other_chain_token_address[r1];

function holding_release:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    call holding_sg_v1.aleo/release_fund r1 r0 r2 into r3;
    async holding_release r3 into r4;
    output r4 as token_service_sg_v1.aleo/holding_release.future;

finalize holding_release:
    input r0 as holding_sg_v1.aleo/release_fund.future;
    await r0;
