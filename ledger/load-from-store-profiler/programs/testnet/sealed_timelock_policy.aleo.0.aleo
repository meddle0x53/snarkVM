import merkle_tree.aleo;
import sealance_freezelist_registry.aleo;
import credits.aleo;
import token_registry.aleo;

program sealed_timelock_policy.aleo;

record CompliantToken:
    owner as address.private;
    amount as u128.private;
    locked_until as u32.private;

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

mapping freeze_registry_program_name:
    key as u8.public;
    value as u128.public;

mapping roles:
    key as address.public;
    value as u8.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as CompliantToken.record;
    input r3 as u32.private;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_pub self.caller into r4;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_pub r0 into r5;
    cast self.caller 31155203188273609789785737924444174490841009372087129field into r6 as TokenOwner;
    call token_registry.aleo/prehook_public r6 r1 4294967295u32 into r7;
    call token_registry.aleo/transfer_from_public 31155203188273609789785737924444174490841009372087129field self.caller r0 r1 into r8;
    sub r2.amount r1 into r9;
    cast r2.owner r9 r2.locked_until into r10 as CompliantToken.record;
    cast r0 r1 r3 into r11 as CompliantToken.record;
    async transfer_public r2.locked_until r7 r8 r4 r5 into r12;
    output r10 as CompliantToken.record;
    output r11 as CompliantToken.record;
    output r12 as sealed_timelock_policy.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as u32.public;
    input r1 as token_registry.aleo/prehook_public.future;
    input r2 as token_registry.aleo/transfer_from_public.future;
    input r3 as sealance_freezelist_registry.aleo/verify_non_inclusion_pub.future;
    input r4 as sealance_freezelist_registry.aleo/verify_non_inclusion_pub.future;
    await r1;
    await r2;
    await r3;
    await r4;
    lte r0 block.height into r5;
    assert.eq r5 true;

function transfer_public_as_signer:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as CompliantToken.record;
    input r3 as u32.private;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_pub self.signer into r4;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_pub r0 into r5;
    cast self.signer 31155203188273609789785737924444174490841009372087129field into r6 as TokenOwner;
    call token_registry.aleo/prehook_public r6 r1 4294967295u32 into r7;
    call token_registry.aleo/transfer_public_as_signer 31155203188273609789785737924444174490841009372087129field r0 r1 into r8;
    sub r2.amount r1 into r9;
    cast r2.owner r9 r2.locked_until into r10 as CompliantToken.record;
    cast r0 r1 r3 into r11 as CompliantToken.record;
    async transfer_public_as_signer r2.locked_until r7 r8 r4 r5 into r12;
    output r10 as CompliantToken.record;
    output r11 as CompliantToken.record;
    output r12 as sealed_timelock_policy.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as u32.public;
    input r1 as token_registry.aleo/prehook_public.future;
    input r2 as token_registry.aleo/transfer_public_as_signer.future;
    input r3 as sealance_freezelist_registry.aleo/verify_non_inclusion_pub.future;
    input r4 as sealance_freezelist_registry.aleo/verify_non_inclusion_pub.future;
    await r1;
    await r2;
    await r3;
    await r4;
    lte r0 block.height into r5;
    assert.eq r5 true;

function transfer_private:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as CompliantToken.record;
    input r3 as token_registry.aleo/Token.record;
    input r4 as [MerkleProof; 2u32].private;
    input r5 as [MerkleProof; 2u32].private;
    input r6 as u32.private;
    assert.eq r3.token_id 31155203188273609789785737924444174490841009372087129field;
    assert.eq r3.amount r2.amount;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_priv r3.owner r4 into r7;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_priv r0 r5 into r8;
    call token_registry.aleo/prehook_private r3 r1 4294967295u32 into r9 r10 r11;
    call token_registry.aleo/transfer_private r0 r1 r10 into r12 r13 r14;
    sub r2.amount r1 into r15;
    cast r2.owner r15 r2.locked_until into r16 as CompliantToken.record;
    cast r0 r1 r6 into r17 as CompliantToken.record;
    async transfer_private r2.locked_until r7 r8 r11 r14 into r18;
    output r16 as CompliantToken.record;
    output r17 as CompliantToken.record;
    output r9 as token_registry.aleo/Token.record;
    output r13 as token_registry.aleo/Token.record;
    output r18 as sealed_timelock_policy.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as u32.public;
    input r1 as sealance_freezelist_registry.aleo/verify_non_inclusion_priv.future;
    input r2 as sealance_freezelist_registry.aleo/verify_non_inclusion_priv.future;
    input r3 as token_registry.aleo/prehook_private.future;
    input r4 as token_registry.aleo/transfer_private.future;
    await r1;
    await r2;
    await r3;
    await r4;
    lte r0 block.height into r5;
    assert.eq r5 true;

function initialize:
    call token_registry.aleo/register_token 31155203188273609789785737924444174490841009372087129field 1709529976692281403789758276781390u128 6073470532514169675u128 6u8 1000000000000000u128 true aleo1q40dlwxfgka53c3wt5ef5k0yvf06dksgcrkdc0r20xpky0ezwqrqpzggeq into r0;
    async initialize r0 self.caller into r1;
    output r1 as sealed_timelock_policy.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    input r1 as address.public;
    set 531934507715736310883939492834865785u128 into freeze_registry_program_name[0u8];
    set 1u8 into roles[r1];
    await r0;

function mint_public:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as u32.private;
    call token_registry.aleo/mint_public 31155203188273609789785737924444174490841009372087129field r0 r1 0u32 into r3;
    cast r0 r1 r2 into r4 as CompliantToken.record;
    async mint_public r3 self.caller into r5;
    output r4 as CompliantToken.record;
    output r5 as sealed_timelock_policy.aleo/mint_public.future;

finalize mint_public:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as address.public;
    get roles[r1] into r2;
    is.eq r2 2u8 into r3;
    is.eq r2 1u8 into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    await r0;

function mint_private:
    input r0 as address.private;
    input r1 as u128.public;
    input r2 as u32.private;
    call token_registry.aleo/mint_private 31155203188273609789785737924444174490841009372087129field r0 r1 true 0u32 into r3 r4;
    cast r0 r1 r2 into r5 as CompliantToken.record;
    async mint_private r4 self.caller into r6;
    output r5 as CompliantToken.record;
    output r3 as token_registry.aleo/Token.record;
    output r6 as sealed_timelock_policy.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    input r1 as address.public;
    get roles[r1] into r2;
    is.eq r2 2u8 into r3;
    is.eq r2 1u8 into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    await r0;

function update_roles:
    input r0 as address.public;
    input r1 as u8.public;
    async update_roles r0 self.caller r1 into r2;
    output r2 as sealed_timelock_policy.aleo/update_roles.future;

finalize update_roles:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u8.public;
    get roles[r1] into r3;
    assert.eq r3 1u8;
    set r2 into roles[r0];

function transfer_public_to_priv:
    input r0 as address.private;
    input r1 as u128.public;
    input r2 as [MerkleProof; 2u32].private;
    input r3 as CompliantToken.record;
    input r4 as u32.private;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_pub self.caller into r5;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_priv r0 r2 into r6;
    cast self.caller 31155203188273609789785737924444174490841009372087129field into r7 as TokenOwner;
    call token_registry.aleo/prehook_public r7 r1 4294967295u32 into r8;
    call token_registry.aleo/transfer_from_public 31155203188273609789785737924444174490841009372087129field self.caller aleo1q40dlwxfgka53c3wt5ef5k0yvf06dksgcrkdc0r20xpky0ezwqrqpzggeq r1 into r9;
    cast aleo1q40dlwxfgka53c3wt5ef5k0yvf06dksgcrkdc0r20xpky0ezwqrqpzggeq 31155203188273609789785737924444174490841009372087129field into r10 as TokenOwner;
    call token_registry.aleo/prehook_public r10 r1 4294967295u32 into r11;
    call token_registry.aleo/transfer_public_to_private 31155203188273609789785737924444174490841009372087129field r0 r1 true into r12 r13;
    sub r3.amount r1 into r14;
    cast r3.owner r14 r3.locked_until into r15 as CompliantToken.record;
    cast r0 r1 r4 into r16 as CompliantToken.record;
    async transfer_public_to_priv r3.locked_until r5 r6 r8 r9 r11 r13 into r17;
    output r15 as CompliantToken.record;
    output r16 as CompliantToken.record;
    output r12 as token_registry.aleo/Token.record;
    output r17 as sealed_timelock_policy.aleo/transfer_public_to_priv.future;

finalize transfer_public_to_priv:
    input r0 as u32.public;
    input r1 as sealance_freezelist_registry.aleo/verify_non_inclusion_pub.future;
    input r2 as sealance_freezelist_registry.aleo/verify_non_inclusion_priv.future;
    input r3 as token_registry.aleo/prehook_public.future;
    input r4 as token_registry.aleo/transfer_from_public.future;
    input r5 as token_registry.aleo/prehook_public.future;
    input r6 as token_registry.aleo/transfer_public_to_private.future;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    lte r0 block.height into r7;
    assert.eq r7 true;

function transfer_priv_to_public:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as CompliantToken.record;
    input r3 as token_registry.aleo/Token.record;
    input r4 as [MerkleProof; 2u32].private;
    input r5 as u32.private;
    assert.eq r3.token_id 31155203188273609789785737924444174490841009372087129field;
    assert.eq r3.amount r2.amount;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_priv r3.owner r4 into r6;
    call sealance_freezelist_registry.aleo/verify_non_inclusion_pub r0 into r7;
    call token_registry.aleo/prehook_private r3 r1 4294967295u32 into r8 r9 r10;
    call token_registry.aleo/transfer_private_to_public r0 r1 r9 into r11 r12;
    sub r2.amount r1 into r13;
    cast r2.owner r13 r2.locked_until into r14 as CompliantToken.record;
    cast r0 r1 r5 into r15 as CompliantToken.record;
    async transfer_priv_to_public r2.locked_until r10 r12 r6 r7 into r16;
    output r14 as CompliantToken.record;
    output r15 as CompliantToken.record;
    output r8 as token_registry.aleo/Token.record;
    output r16 as sealed_timelock_policy.aleo/transfer_priv_to_public.future;

finalize transfer_priv_to_public:
    input r0 as u32.public;
    input r1 as token_registry.aleo/prehook_private.future;
    input r2 as token_registry.aleo/transfer_private_to_public.future;
    input r3 as sealance_freezelist_registry.aleo/verify_non_inclusion_priv.future;
    input r4 as sealance_freezelist_registry.aleo/verify_non_inclusion_pub.future;
    await r1;
    await r2;
    await r3;
    await r4;
    lte r0 block.height into r5;
    assert.eq r5 true;
