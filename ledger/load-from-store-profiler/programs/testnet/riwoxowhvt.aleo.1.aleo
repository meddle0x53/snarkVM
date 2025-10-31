import credits.aleo;
import token_registry.aleo;
import rediwsozfo_v2.aleo;
import uscrpnwqsx.aleo;

program riwoxowhvt.aleo;

record ComplianceRecord:
    owner as address.private;
    amount as u128.private;
    sender as address.private;
    recipient as address.private;

record TokenComplianceStateRecord:
    owner as address.private;
    cumulative_amount_per_epoch as u128.private;
    latest_block_height as u32.private;

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

struct MerkleProof:
    siblings as [field; 16u32];
    leaf_index as u32;

mapping freeze_registry_program_name:
    key as u8.public;
    value as u128.public;

mapping threshold:
    key as u8.public;
    value as u128.public;

mapping epoch:
    key as u8.public;
    value as u32.public;

mapping block_height_window:
    key as u8.public;
    value as u32.public;

mapping owned_state_record:
    key as address.public;
    value as boolean.public;

mapping roles:
    key as u8.public;
    value as address.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as TokenComplianceStateRecord.record;
    input r3 as u32.public;
    call uscrpnwqsx.aleo/verify_non_inclusion_pub self.caller into r4;
    call uscrpnwqsx.aleo/verify_non_inclusion_pub r0 into r5;
    cast self.caller 438271370123737563379885991741056366field into r6 as TokenOwner;
    call token_registry.aleo/prehook_public r6 r1 4294967295u32 into r7;
    call token_registry.aleo/transfer_from_public 438271370123737563379885991741056366field self.caller r0 r1 into r8;
    gte r3 r2.latest_block_height into r9;
    assert.eq r9 true;
    div r3 1800u32 into r10;
    div r2.latest_block_height 1800u32 into r11;
    is.eq r10 r11 into r12;
    add r1 r2.cumulative_amount_per_epoch into r13;
    ternary r12 r13 r1 into r14;
    cast r2.owner r14 r3 into r15 as TokenComplianceStateRecord.record;
    async transfer_public r7 r8 r4 r5 r3 into r16;
    output r15 as TokenComplianceStateRecord.record;
    output r16 as riwoxowhvt.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as token_registry.aleo/prehook_public.future;
    input r1 as token_registry.aleo/transfer_from_public.future;
    input r2 as uscrpnwqsx.aleo/verify_non_inclusion_pub.future;
    input r3 as uscrpnwqsx.aleo/verify_non_inclusion_pub.future;
    input r4 as u32.public;
    await r0;
    await r1;
    gte block.height r4 into r5;
    assert.eq r5 true;
    get block_height_window[0u8] into r6;
    gt block.height r6 into r7;
    ternary r7 r6 block.height into r8;
    sub block.height r8 into r9;
    gt r4 r9 into r10;
    assert.eq r10 true;
    await r2;
    await r3;

function transfer_public_as_signer:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as TokenComplianceStateRecord.record;
    input r3 as u32.public;
    call uscrpnwqsx.aleo/verify_non_inclusion_pub self.signer into r4;
    call uscrpnwqsx.aleo/verify_non_inclusion_pub r0 into r5;
    cast self.signer 438271370123737563379885991741056366field into r6 as TokenOwner;
    call token_registry.aleo/prehook_public r6 r1 4294967295u32 into r7;
    call token_registry.aleo/transfer_public_as_signer 438271370123737563379885991741056366field r0 r1 into r8;
    gte r3 r2.latest_block_height into r9;
    assert.eq r9 true;
    div r3 1800u32 into r10;
    div r2.latest_block_height 1800u32 into r11;
    is.eq r10 r11 into r12;
    add r1 r2.cumulative_amount_per_epoch into r13;
    ternary r12 r13 r1 into r14;
    cast r2.owner r14 r3 into r15 as TokenComplianceStateRecord.record;
    async transfer_public_as_signer r7 r8 r4 r5 r3 into r16;
    output r15 as TokenComplianceStateRecord.record;
    output r16 as riwoxowhvt.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as token_registry.aleo/prehook_public.future;
    input r1 as token_registry.aleo/transfer_public_as_signer.future;
    input r2 as uscrpnwqsx.aleo/verify_non_inclusion_pub.future;
    input r3 as uscrpnwqsx.aleo/verify_non_inclusion_pub.future;
    input r4 as u32.public;
    await r0;
    await r1;
    gte block.height r4 into r5;
    assert.eq r5 true;
    get block_height_window[0u8] into r6;
    gt block.height r6 into r7;
    ternary r7 r6 block.height into r8;
    sub block.height r8 into r9;
    gt r4 r9 into r10;
    assert.eq r10 true;
    await r2;
    await r3;

function transfer_private:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as token_registry.aleo/Token.record;
    input r3 as TokenComplianceStateRecord.record;
    input r4 as u32.public;
    input r5 as [MerkleProof; 2u32].private;
    input r6 as [MerkleProof; 2u32].private;
    input r7 as address.private;
    assert.eq r2.token_id 438271370123737563379885991741056366field;
    call uscrpnwqsx.aleo/verify_non_inclusion_priv r2.owner r5 into r8;
    call uscrpnwqsx.aleo/verify_non_inclusion_priv r0 r6 into r9;
    call token_registry.aleo/prehook_private r2 r1 4294967295u32 into r10 r11 r12;
    call token_registry.aleo/transfer_private r0 r1 r11 into r13 r14 r15;
    gte r4 r3.latest_block_height into r16;
    assert.eq r16 true;
    div r4 1800u32 into r17;
    div r3.latest_block_height 1800u32 into r18;
    is.eq r17 r18 into r19;
    add r1 r3.cumulative_amount_per_epoch into r20;
    ternary r19 r20 r1 into r21;
    cast r3.owner r21 r4 into r22 as TokenComplianceStateRecord.record;
    gt r21 1000000u128 into r23;
    ternary r23 r7 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r24;
    ternary r23 r1 0u128 into r25;
    ternary r23 r2.owner aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r26;
    ternary r23 r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r27;
    cast r24 r25 r26 r27 into r28 as ComplianceRecord.record;
    async transfer_private r8 r9 r12 r15 r7 r4 into r29;
    output r28 as ComplianceRecord.record;
    output r22 as TokenComplianceStateRecord.record;
    output r10 as token_registry.aleo/Token.record;
    output r14 as token_registry.aleo/Token.record;
    output r29 as riwoxowhvt.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as uscrpnwqsx.aleo/verify_non_inclusion_priv.future;
    input r1 as uscrpnwqsx.aleo/verify_non_inclusion_priv.future;
    input r2 as token_registry.aleo/prehook_private.future;
    input r3 as token_registry.aleo/transfer_private.future;
    input r4 as address.public;
    input r5 as u32.public;
    await r0;
    await r1;
    get roles[2u8] into r6;
    assert.eq r6 r4;
    gte block.height r5 into r7;
    assert.eq r7 true;
    get block_height_window[0u8] into r8;
    gt block.height r8 into r9;
    ternary r9 r8 block.height into r10;
    sub block.height r10 into r11;
    gt r5 r11 into r12;
    assert.eq r12 true;
    await r2;
    await r3;

function update_admin_address:
    input r0 as address.private;
    async update_admin_address r0 self.caller into r1;
    output r1 as riwoxowhvt.aleo/update_admin_address.future;

finalize update_admin_address:
    input r0 as address.public;
    input r1 as address.public;
    get.or_use roles[1u8] r1 into r2;
    assert.eq r2 r1;
    set r0 into roles[1u8];

function signup:
    cast self.caller 0u128 0u32 into r0 as TokenComplianceStateRecord.record;
    async signup self.caller into r1;
    output r0 as TokenComplianceStateRecord.record;
    output r1 as riwoxowhvt.aleo/signup.future;

finalize signup:
    input r0 as address.public;
    get.or_use owned_state_record[r0] false into r1;
    assert.eq r1 false;
    set true into owned_state_record[r0];

function update_block_height_window:
    input r0 as u32.private;
    async update_block_height_window r0 self.caller into r1;
    output r1 as riwoxowhvt.aleo/update_block_height_window.future;

finalize update_block_height_window:
    input r0 as u32.public;
    input r1 as address.public;
    get roles[1u8] into r2;
    assert.eq r2 r1;
    set r0 into block_height_window[0u8];

function init_mappings:
    async init_mappings into r0;
    output r0 as riwoxowhvt.aleo/init_mappings.future;

finalize init_mappings:
    set 531934507715736310883939492834865785u128 into freeze_registry_program_name[0u8];
    set 1000000u128 into threshold[0u8];
    set 1800u32 into epoch[0u8];

function update_investigator_address:
    input r0 as address.private;
    async update_investigator_address r0 self.caller into r1;
    output r1 as riwoxowhvt.aleo/update_investigator_address.future;

finalize update_investigator_address:
    input r0 as address.public;
    input r1 as address.public;
    get roles[1u8] into r2;
    assert.eq r2 r1;
    set r0 into roles[2u8];

function transfer_public_to_priv:
    input r0 as address.private;
    input r1 as u128.public;
    input r2 as TokenComplianceStateRecord.record;
    input r3 as u32.public;
    input r4 as [MerkleProof; 2u32].private;
    input r5 as address.private;
    call uscrpnwqsx.aleo/verify_non_inclusion_pub self.caller into r6;
    call uscrpnwqsx.aleo/verify_non_inclusion_priv r0 r4 into r7;
    cast self.caller 438271370123737563379885991741056366field into r8 as TokenOwner;
    call token_registry.aleo/prehook_public r8 r1 4294967295u32 into r9;
    call token_registry.aleo/transfer_from_public 438271370123737563379885991741056366field self.caller aleo1f03a508uvg5fskrmzqfqyvvzd58989m2fhd02ef99qnkt85whs8q3kfjev r1 into r10;
    cast aleo1f03a508uvg5fskrmzqfqyvvzd58989m2fhd02ef99qnkt85whs8q3kfjev 438271370123737563379885991741056366field into r11 as TokenOwner;
    call token_registry.aleo/prehook_public r11 r1 4294967295u32 into r12;
    call token_registry.aleo/transfer_public_to_private 438271370123737563379885991741056366field r0 r1 true into r13 r14;
    gte r3 r2.latest_block_height into r15;
    assert.eq r15 true;
    div r3 1800u32 into r16;
    div r2.latest_block_height 1800u32 into r17;
    is.eq r16 r17 into r18;
    add r1 r2.cumulative_amount_per_epoch into r19;
    ternary r18 r19 r1 into r20;
    cast r2.owner r20 r3 into r21 as TokenComplianceStateRecord.record;
    gt r20 1000000u128 into r22;
    ternary r22 r5 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r23;
    ternary r22 r1 0u128 into r24;
    ternary r22 self.caller aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r25;
    ternary r22 r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r26;
    cast r23 r24 r25 r26 into r27 as ComplianceRecord.record;
    async transfer_public_to_priv r6 r7 r9 r10 r12 r14 r5 r3 into r28;
    output r27 as ComplianceRecord.record;
    output r21 as TokenComplianceStateRecord.record;
    output r13 as token_registry.aleo/Token.record;
    output r28 as riwoxowhvt.aleo/transfer_public_to_priv.future;

finalize transfer_public_to_priv:
    input r0 as uscrpnwqsx.aleo/verify_non_inclusion_pub.future;
    input r1 as uscrpnwqsx.aleo/verify_non_inclusion_priv.future;
    input r2 as token_registry.aleo/prehook_public.future;
    input r3 as token_registry.aleo/transfer_from_public.future;
    input r4 as token_registry.aleo/prehook_public.future;
    input r5 as token_registry.aleo/transfer_public_to_private.future;
    input r6 as address.public;
    input r7 as u32.public;
    await r0;
    await r1;
    get roles[2u8] into r8;
    assert.eq r8 r6;
    gte block.height r7 into r9;
    assert.eq r9 true;
    get block_height_window[0u8] into r10;
    gt block.height r10 into r11;
    ternary r11 r10 block.height into r12;
    sub block.height r12 into r13;
    gt r7 r13 into r14;
    assert.eq r14 true;
    await r2;
    await r3;
    await r4;
    await r5;

function transfer_priv_to_public:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as token_registry.aleo/Token.record;
    input r3 as TokenComplianceStateRecord.record;
    input r4 as u32.public;
    input r5 as [MerkleProof; 2u32].private;
    input r6 as address.private;
    assert.eq r2.token_id 438271370123737563379885991741056366field;
    call uscrpnwqsx.aleo/verify_non_inclusion_priv r2.owner r5 into r7;
    call uscrpnwqsx.aleo/verify_non_inclusion_pub r0 into r8;
    call token_registry.aleo/prehook_private r2 r1 4294967295u32 into r9 r10 r11;
    call token_registry.aleo/transfer_private_to_public r0 r1 r10 into r12 r13;
    gte r4 r3.latest_block_height into r14;
    assert.eq r14 true;
    div r4 1800u32 into r15;
    div r3.latest_block_height 1800u32 into r16;
    is.eq r15 r16 into r17;
    add r1 r3.cumulative_amount_per_epoch into r18;
    ternary r17 r18 r1 into r19;
    cast r3.owner r19 r4 into r20 as TokenComplianceStateRecord.record;
    gt r19 1000000u128 into r21;
    ternary r21 r6 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r22;
    ternary r21 r1 0u128 into r23;
    ternary r21 r2.owner aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r24;
    ternary r21 r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r25;
    cast r22 r23 r24 r25 into r26 as ComplianceRecord.record;
    async transfer_priv_to_public r11 r13 r7 r8 r6 r4 into r27;
    output r26 as ComplianceRecord.record;
    output r20 as TokenComplianceStateRecord.record;
    output r9 as token_registry.aleo/Token.record;
    output r27 as riwoxowhvt.aleo/transfer_priv_to_public.future;

finalize transfer_priv_to_public:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private_to_public.future;
    input r2 as uscrpnwqsx.aleo/verify_non_inclusion_priv.future;
    input r3 as uscrpnwqsx.aleo/verify_non_inclusion_pub.future;
    input r4 as address.public;
    input r5 as u32.public;
    await r0;
    await r1;
    get roles[2u8] into r6;
    assert.eq r6 r4;
    gte block.height r5 into r7;
    assert.eq r7 true;
    get block_height_window[0u8] into r8;
    gt block.height r8 into r9;
    ternary r9 r8 block.height into r10;
    sub block.height r10 into r11;
    gt r5 r11 into r12;
    assert.eq r12 true;
    await r2;
    await r3;
