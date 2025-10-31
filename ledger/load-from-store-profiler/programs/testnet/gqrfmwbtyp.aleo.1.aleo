import credits.aleo;
import merkle_tree.aleo;
import sealance_freezelist_registry.aleo;
import token_registry.aleo;
import sealed_timelock_policy.aleo;

program gqrfmwbtyp.aleo;

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

mapping token_rates:
    key as field.public;
    value as u128.public;

mapping admin:
    key as u8.public;
    value as address.public;

function update_admin:
    input r0 as address.public;
    async update_admin self.caller r0 into r1;
    output r1 as gqrfmwbtyp.aleo/update_admin.future;

finalize update_admin:
    input r0 as address.public;
    input r1 as address.public;
    get.or_use admin[0u8] r0 into r2;
    assert.eq r2 r0;
    set r1 into admin[0u8];

function update_rate:
    input r0 as field.public;
    input r1 as u128.public;
    async update_rate self.caller r0 r1 into r2;
    output r2 as gqrfmwbtyp.aleo/update_rate.future;

finalize update_rate:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u128.public;
    get admin[0u8] into r3;
    assert.eq r0 r3;
    set r2 into token_rates[r1];

function exchange_token:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u128.public;
    call credits.aleo/transfer_public_as_signer aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn r1 into r3;
    cast r1 into r4 as u128;
    mul r2 r4 into r5;
    call token_registry.aleo/mint_private r0 self.caller r5 true 0u32 into r6 r7;
    async exchange_token r0 r2 r3 r7 into r8;
    output r6 as token_registry.aleo/Token.record;
    output r8 as gqrfmwbtyp.aleo/exchange_token.future;

finalize exchange_token:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    input r3 as token_registry.aleo/mint_private.future;
    get.or_use token_rates[r0] 10u128 into r4;
    assert.eq r1 r4;
    await r2;
    await r3;

function exchange_timelock_token:
    input r0 as u64.public;
    input r1 as u128.public;
    call credits.aleo/transfer_public_as_signer aleo1lwa86hr7qx99d7e3dcyv2s7wt9g8rmd6qxzm5zprad0c4ejynsqqvaxysn r0 into r2;
    cast r0 into r3 as u128;
    mul r1 r3 into r4;
    call sealed_timelock_policy.aleo/mint_private self.caller r4 0u32 into r5 r6 r7;
    async exchange_timelock_token 31155203188273609789785737924444174490841009372087129field r1 r2 r7 into r8;
    output r5 as sealed_timelock_policy.aleo/CompliantToken.record;
    output r6 as token_registry.aleo/Token.record;
    output r8 as gqrfmwbtyp.aleo/exchange_timelock_token.future;

finalize exchange_timelock_token:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as credits.aleo/transfer_public_as_signer.future;
    input r3 as sealed_timelock_policy.aleo/mint_private.future;
    get.or_use token_rates[r0] 10u128 into r4;
    assert.eq r1 r4;
    await r2;
    await r3;
