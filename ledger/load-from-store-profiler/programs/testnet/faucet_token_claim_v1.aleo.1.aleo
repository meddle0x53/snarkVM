import credits.aleo;
import token_registry.aleo;

program faucet_token_claim_v1.aleo;

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

record SpendLimit:
    owner as address.private;
    amount_spent as u128.private;
    epoch_spent as u32.private;

mapping has_minted:
    key as u8.public;
    value as boolean.public;

mapping has_spend_limit:
    key as field.public;
    value as boolean.public;

mapping claimed:
    key as address.public;
    value as u32.public;

function transfer_private:
    input r0 as token_registry.aleo/Token.record;
    input r1 as SpendLimit.record;
    input r2 as u128.private;
    input r3 as address.private;
    input r4 as u32.public;
    lt r1.epoch_spent r4 into r5;
    add r2 r1.amount_spent into r6;
    ternary r5 r2 r6 into r7;
    lte r7 10000000000u128 into r8;
    assert.eq r8 true;
    cast r1.owner r7 r4 into r9 as SpendLimit.record;
    call token_registry.aleo/prehook_private r0 r2 4294967295u32 into r10 r11 r12;
    call token_registry.aleo/transfer_private r3 r2 r11 into r13 r14 r15;
    async transfer_private r12 r15 r4 into r16;
    output r9 as SpendLimit.record;
    output r10 as token_registry.aleo/Token.record;
    output r13 as token_registry.aleo/Token.record;
    output r14 as token_registry.aleo/Token.record;
    output r16 as faucet_token_claim_v1.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    input r2 as u32.public;
    await r0;
    await r1;
    rem block.height 28800u32 into r3;
    assert.eq r2 r3;

function initialize:
    assert.eq self.caller aleo1wcnhz0qa90e8vqv98lxlv0z7rvm0a9c22g3edv9muwvf4qcgqczqrgl6e6;
    call token_registry.aleo/register_token 91413921673922996373682148757641field 9141392167392299637368214875764u128 9141392167392299637368214875764u128 6u8 10000000000000000u128 true faucet_token_claim_v1.aleo into r0;
    async initialize r0 into r1;
    output r1 as faucet_token_claim_v1.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo1wcnhz0qa90e8vqv98lxlv0z7rvm0a9c22g3edv9muwvf4qcgqczqrgl6e6;
    call token_registry.aleo/mint_private 91413921673922996373682148757641field aleo1wcnhz0qa90e8vqv98lxlv0z7rvm0a9c22g3edv9muwvf4qcgqczqrgl6e6 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as faucet_token_claim_v1.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function get_funds:
    call token_registry.aleo/mint_public 91413921673922996373682148757641field self.caller 100000000u128 4294967295u32 into r0;
    async get_funds r0 self.caller into r1;
    output r1 as faucet_token_claim_v1.aleo/get_funds.future;

finalize get_funds:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as address.public;
    await r0;
    get.or_use claimed[r1] 0u32 into r2;
    sub block.height r2 into r3;
    gt r3 1800u32 into r4;
    assert.eq r4 true;
    set block.height into claimed[r1];

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo1wcnhz0qa90e8vqv98lxlv0z7rvm0a9c22g3edv9muwvf4qcgqczqrgl6e6;
    cast r0 0u128 0u32 into r1 as SpendLimit.record;
    output r1 as SpendLimit.record;
