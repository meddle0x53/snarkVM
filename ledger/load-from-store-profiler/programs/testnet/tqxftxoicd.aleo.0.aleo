import rediwsozfo.aleo;
import credits.aleo;
import token_registry.aleo;

program tqxftxoicd.aleo;

struct MerkleProof:
    siblings as [field; 4u32];
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

mapping funded:
    key as address.public;
    value as boolean.public;

mapping merkle_root:
    key as u8.public;
    value as field.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u128.public;
    cast self.caller 100667890849571067315045710field into r2 as TokenOwner;
    call token_registry.aleo/prehook_public r2 r1 4294967295u32 into r3;
    call token_registry.aleo/transfer_from_public 100667890849571067315045710field self.caller r0 r1 into r4;
    async transfer_public r3 r4 self.caller r0 into r5;
    output r5 as tqxftxoicd.aleo/transfer_public.future;

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
    output r5 as tqxftxoicd.aleo/transfer_public_as_signer.future;

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
    call rediwsozfo.aleo/verify_non_inclusion r2.owner r3 into r5;
    call rediwsozfo.aleo/verify_non_inclusion r0 r4 into r6;
    assert.eq r5 r6;
    call token_registry.aleo/prehook_private r2 r1 4294967295u32 into r7 r8 r9;
    call token_registry.aleo/transfer_private r0 r1 r8 into r10 r11 r12;
    cast aleo1y3ftuud75cwspnsx9w85sw4z0pdcrxpgnsxtz2re4q0vupw9mg8szhm06m r1 r2.owner r0 into r13 as ComplianceRecord.record;
    async transfer_private r9 r12 r5 into r14;
    output r13 as ComplianceRecord.record;
    output r7 as token_registry.aleo/Token.record;
    output r11 as token_registry.aleo/Token.record;
    output r14 as tqxftxoicd.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as field.public;
    get merkle_root[0u8] into r3;
    assert.eq r2 r3;
    await r0;
    await r1;

function initialize:
    call token_registry.aleo/register_token 100667890849571067315045710field 100667890849571067315045710u128 1397047628u128 6u8 1000000000000000u128 true aleo10ha27yxrya7d7lf0eg5p3hqcafm8k6nj00pvgeuxuqmvhqpst5xsdh2ft4 into r0;
    async initialize r0 self.caller into r1;
    output r1 as tqxftxoicd.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as address.public;
    assert.eq r1 aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn;
    await r0;

function mint_public:
    input r0 as address.public;
    input r1 as u128.public;
    call token_registry.aleo/mint_public 100667890849571067315045710field r0 r1 4294967295u32 into r2;
    async mint_public r2 self.caller into r3;
    output r3 as tqxftxoicd.aleo/mint_public.future;

finalize mint_public:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as address.public;
    assert.eq aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn r1;
    await r0;

function mint_private:
    input r0 as address.private;
    input r1 as u128.public;
    call token_registry.aleo/mint_private 100667890849571067315045710field r0 r1 true 0u32 into r2 r3;
    cast aleo1y3ftuud75cwspnsx9w85sw4z0pdcrxpgnsxtz2re4q0vupw9mg8szhm06m r1 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0 into r4 as ComplianceRecord.record;
    async mint_private r3 self.caller into r5;
    output r4 as ComplianceRecord.record;
    output r2 as token_registry.aleo/Token.record;
    output r5 as tqxftxoicd.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    input r1 as address.public;
    assert.eq aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn r1;
    await r0;

function burn_public:
    input r0 as address.public;
    input r1 as u128.public;
    call token_registry.aleo/burn_public 100667890849571067315045710field r0 r1 into r2;
    async burn_public r2 self.caller into r3;
    output r3 as tqxftxoicd.aleo/burn_public.future;

finalize burn_public:
    input r0 as token_registry.aleo/burn_public.future;
    input r1 as address.public;
    assert.eq aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn r1;
    await r0;

function burn_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as u128.public;
    call token_registry.aleo/burn_private r0 r1 into r2 r3;
    cast aleo1y3ftuud75cwspnsx9w85sw4z0pdcrxpgnsxtz2re4q0vupw9mg8szhm06m r1 r0.owner aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r4 as ComplianceRecord.record;
    async burn_private r3 self.caller into r5;
    output r4 as ComplianceRecord.record;
    output r2 as token_registry.aleo/Token.record;
    output r5 as tqxftxoicd.aleo/burn_private.future;

finalize burn_private:
    input r0 as token_registry.aleo/burn_private.future;
    input r1 as address.public;
    assert.eq aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn r1;
    await r0;

function update_freeze_list:
    input r0 as address.private;
    input r1 as boolean.private;
    input r2 as field.private;
    async update_freeze_list r0 r1 self.caller r2 into r3;
    output r3 as tqxftxoicd.aleo/update_freeze_list.future;

finalize update_freeze_list:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as address.public;
    input r3 as field.public;
    assert.eq aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn r2;
    set r1 into freeze_list[r0];
    set r3 into merkle_root[0u8];

function demo_faucet:
    call token_registry.aleo/mint_public 100667890849571067315045710field self.caller 100000u128 4294967295u32 into r0;
    call token_registry.aleo/mint_private 100667890849571067315045710field self.caller 100000u128 true 0u32 into r1 r2;
    cast aleo1y3ftuud75cwspnsx9w85sw4z0pdcrxpgnsxtz2re4q0vupw9mg8szhm06m 100000u128 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc self.caller into r3 as ComplianceRecord.record;
    async demo_faucet r0 r2 self.caller into r4;
    output r3 as ComplianceRecord.record;
    output r1 as token_registry.aleo/Token.record;
    output r4 as tqxftxoicd.aleo/demo_faucet.future;

finalize demo_faucet:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as token_registry.aleo/mint_private.future;
    input r2 as address.public;
    get.or_use funded[r2] false into r3;
    assert.eq r3 false;
    set true into funded[r2];
    await r0;
    await r1;

function transfer_public_to_priv:
    input r0 as address.private;
    input r1 as u128.public;
    input r2 as [MerkleProof; 2u32].private;
    call rediwsozfo.aleo/verify_non_inclusion r0 r2 into r3;
    cast self.caller 100667890849571067315045710field into r4 as TokenOwner;
    call token_registry.aleo/prehook_public r4 r1 4294967295u32 into r5;
    call token_registry.aleo/transfer_from_public 100667890849571067315045710field self.caller aleo10ha27yxrya7d7lf0eg5p3hqcafm8k6nj00pvgeuxuqmvhqpst5xsdh2ft4 r1 into r6;
    cast aleo10ha27yxrya7d7lf0eg5p3hqcafm8k6nj00pvgeuxuqmvhqpst5xsdh2ft4 100667890849571067315045710field into r7 as TokenOwner;
    call token_registry.aleo/prehook_public r7 r1 4294967295u32 into r8;
    call token_registry.aleo/transfer_public_to_private 100667890849571067315045710field r0 r1 true into r9 r10;
    cast aleo1y3ftuud75cwspnsx9w85sw4z0pdcrxpgnsxtz2re4q0vupw9mg8szhm06m r1 self.caller r0 into r11 as ComplianceRecord.record;
    async transfer_public_to_priv r5 r6 r8 r10 self.caller r3 into r12;
    output r11 as ComplianceRecord.record;
    output r9 as token_registry.aleo/Token.record;
    output r12 as tqxftxoicd.aleo/transfer_public_to_priv.future;

finalize transfer_public_to_priv:
    input r0 as token_registry.aleo/prehook_public.future;
    input r1 as token_registry.aleo/transfer_from_public.future;
    input r2 as token_registry.aleo/prehook_public.future;
    input r3 as token_registry.aleo/transfer_public_to_private.future;
    input r4 as address.public;
    input r5 as field.public;
    get.or_use freeze_list[r4] false into r6;
    assert.eq r6 false;
    get merkle_root[0u8] into r7;
    assert.eq r5 r7;
    await r0;
    await r1;
    await r2;
    await r3;

function transfer_priv_to_public:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as token_registry.aleo/Token.record;
    input r3 as [MerkleProof; 2u32].private;
    call rediwsozfo.aleo/verify_non_inclusion r2.owner r3 into r4;
    call token_registry.aleo/prehook_private r2 r1 4294967295u32 into r5 r6 r7;
    call token_registry.aleo/transfer_private_to_public r0 r1 r6 into r8 r9;
    cast aleo1y3ftuud75cwspnsx9w85sw4z0pdcrxpgnsxtz2re4q0vupw9mg8szhm06m r1 r2.owner r0 into r10 as ComplianceRecord.record;
    async transfer_priv_to_public r7 r9 r0 r4 into r11;
    output r10 as ComplianceRecord.record;
    output r5 as token_registry.aleo/Token.record;
    output r11 as tqxftxoicd.aleo/transfer_priv_to_public.future;

finalize transfer_priv_to_public:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private_to_public.future;
    input r2 as address.public;
    input r3 as field.public;
    get.or_use freeze_list[r2] false into r4;
    assert.eq r4 false;
    get merkle_root[0u8] into r5;
    assert.eq r3 r5;
    await r0;
    await r1;
