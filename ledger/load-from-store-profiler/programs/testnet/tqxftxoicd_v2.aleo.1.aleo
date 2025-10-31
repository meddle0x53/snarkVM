import rediwsozfo_v2.aleo;
import credits.aleo;
import token_registry.aleo;

program tqxftxoicd_v2.aleo;

struct MerkleProof:
    siblings as [field; 16u32];
    leaf_index as u32;

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

record ComplianceRecord:
    owner as address.private;
    amount as u128.private;
    sender as address.private;
    recipient as address.private;

mapping freeze_list:
    key as address.public;
    value as boolean.public;

mapping freeze_list_index:
    key as u32.public;
    value as address.public;

mapping freeze_list_root:
    key as u8.public;
    value as field.public;

mapping roles:
    key as u8.public;
    value as address.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u128.public;
    cast self.caller 100667890849571067315045710field into r2 as TokenOwner;
    call token_registry.aleo/prehook_public r2 r1 4294967295u32 into r3;
    call token_registry.aleo/transfer_from_public 100667890849571067315045710field self.caller r0 r1 into r4;
    async transfer_public r3 r4 self.caller r0 into r5;
    output r5 as tqxftxoicd_v2.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as token_registry.aleo/prehook_public.future;
    input r1 as token_registry.aleo/transfer_from_public.future;
    input r2 as address.public;
    input r3 as address.public;
    get.or_use freeze_list[r2] false into r4;
    assert.eq r4 false;
    get.or_use freeze_list[r3] false into r5;
    assert.eq r5 false;
    await r0;
    await r1;

function transfer_public_as_signer:
    input r0 as address.public;
    input r1 as u128.public;
    cast self.signer 100667890849571067315045710field into r2 as TokenOwner;
    call token_registry.aleo/prehook_public r2 r1 4294967295u32 into r3;
    call token_registry.aleo/transfer_public_as_signer 100667890849571067315045710field r0 r1 into r4;
    async transfer_public_as_signer r3 r4 self.signer r0 into r5;
    output r5 as tqxftxoicd_v2.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as token_registry.aleo/prehook_public.future;
    input r1 as token_registry.aleo/transfer_public_as_signer.future;
    input r2 as address.public;
    input r3 as address.public;
    get.or_use freeze_list[r2] false into r4;
    assert.eq r4 false;
    get.or_use freeze_list[r3] false into r5;
    assert.eq r5 false;
    await r0;
    await r1;

function transfer_private:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as token_registry.aleo/Token.record;
    input r3 as [MerkleProof; 2u32].private;
    input r4 as [MerkleProof; 2u32].private;
    input r5 as address.private;
    call rediwsozfo_v2.aleo/verify_non_inclusion r2.owner r3 into r6;
    call rediwsozfo_v2.aleo/verify_non_inclusion r0 r4 into r7;
    assert.eq r6 r7;
    call token_registry.aleo/prehook_private r2 r1 4294967295u32 into r8 r9 r10;
    call token_registry.aleo/transfer_private r0 r1 r9 into r11 r12 r13;
    cast r5 r1 r2.owner r0 into r14 as ComplianceRecord.record;
    async transfer_private r10 r13 r6 r5 into r15;
    output r14 as ComplianceRecord.record;
    output r8 as token_registry.aleo/Token.record;
    output r12 as token_registry.aleo/Token.record;
    output r15 as tqxftxoicd_v2.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as field.public;
    input r3 as address.public;
    get freeze_list_root[0u8] into r4;
    assert.eq r2 r4;
    get roles[2u8] into r5;
    assert.eq r5 r3;
    await r0;
    await r1;

function update_freeze_list:
    input r0 as address.private;
    input r1 as boolean.private;
    input r2 as u32.private;
    input r3 as field.private;
    async update_freeze_list r0 r1 r2 self.caller r3 into r4;
    output r4 as tqxftxoicd_v2.aleo/update_freeze_list.future;

finalize update_freeze_list:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as u32.public;
    input r3 as address.public;
    input r4 as field.public;
    get roles[1u8] into r5;
    assert.eq r5 r3;
    set r1 into freeze_list[r0];
    ternary r1 r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r6;
    set r6 into freeze_list_index[r2];
    set r4 into freeze_list_root[0u8];

function update_investigator_address:
    input r0 as address.private;
    async update_investigator_address r0 self.caller into r1;
    output r1 as tqxftxoicd_v2.aleo/update_investigator_address.future;

finalize update_investigator_address:
    input r0 as address.public;
    input r1 as address.public;
    get roles[1u8] into r2;
    assert.eq r2 r1;
    set r0 into roles[2u8];

function update_admin_address:
    input r0 as address.private;
    async update_admin_address r0 self.caller into r1;
    output r1 as tqxftxoicd_v2.aleo/update_admin_address.future;

finalize update_admin_address:
    input r0 as address.public;
    input r1 as address.public;
    get.or_use roles[1u8] r1 into r2;
    assert.eq r2 r1;
    set r0 into roles[1u8];

function transfer_public_to_priv:
    input r0 as address.private;
    input r1 as u128.public;
    input r2 as [MerkleProof; 2u32].private;
    input r3 as address.private;
    call rediwsozfo_v2.aleo/verify_non_inclusion r0 r2 into r4;
    cast self.caller 100667890849571067315045710field into r5 as TokenOwner;
    call token_registry.aleo/prehook_public r5 r1 4294967295u32 into r6;
    call token_registry.aleo/transfer_from_public 100667890849571067315045710field self.caller aleo1t6aat4vk4u7jq2zk5fjk2actdp64s7n6m4pmn3xnw4quxw2545qsmk2mlc r1 into r7;
    cast aleo1t6aat4vk4u7jq2zk5fjk2actdp64s7n6m4pmn3xnw4quxw2545qsmk2mlc 100667890849571067315045710field into r8 as TokenOwner;
    call token_registry.aleo/prehook_public r8 r1 4294967295u32 into r9;
    call token_registry.aleo/transfer_public_to_private 100667890849571067315045710field r0 r1 true into r10 r11;
    cast r3 r1 self.caller r0 into r12 as ComplianceRecord.record;
    async transfer_public_to_priv r6 r7 r9 r11 self.caller r4 r3 into r13;
    output r12 as ComplianceRecord.record;
    output r10 as token_registry.aleo/Token.record;
    output r13 as tqxftxoicd_v2.aleo/transfer_public_to_priv.future;

finalize transfer_public_to_priv:
    input r0 as token_registry.aleo/prehook_public.future;
    input r1 as token_registry.aleo/transfer_from_public.future;
    input r2 as token_registry.aleo/prehook_public.future;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    input r4 as address.public;
    input r5 as field.public;
    input r6 as address.public;
    get.or_use freeze_list[r4] false into r7;
    assert.eq r7 false;
    get freeze_list_root[0u8] into r8;
    assert.eq r5 r8;
    get roles[2u8] into r9;
    assert.eq r9 r6;
    await r0;
    await r1;
    await r2;
    await r3;

function transfer_priv_to_public:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as token_registry.aleo/Token.record;
    input r3 as [MerkleProof; 2u32].private;
    input r4 as address.private;
    call rediwsozfo_v2.aleo/verify_non_inclusion r2.owner r3 into r5;
    call token_registry.aleo/prehook_private r2 r1 4294967295u32 into r6 r7 r8;
    call token_registry.aleo/transfer_private_to_public r0 r1 r7 into r9 r10;
    cast r4 r1 r2.owner r0 into r11 as ComplianceRecord.record;
    async transfer_priv_to_public r8 r10 r0 r5 r4 into r12;
    output r11 as ComplianceRecord.record;
    output r6 as token_registry.aleo/Token.record;
    output r12 as tqxftxoicd_v2.aleo/transfer_priv_to_public.future;

finalize transfer_priv_to_public:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private_to_public.future;
    input r2 as address.public;
    input r3 as field.public;
    input r4 as address.public;
    get.or_use freeze_list[r2] false into r5;
    assert.eq r5 false;
    get freeze_list_root[0u8] into r6;
    assert.eq r3 r6;
    get roles[2u8] into r7;
    assert.eq r7 r4;
    await r0;
    await r1;
