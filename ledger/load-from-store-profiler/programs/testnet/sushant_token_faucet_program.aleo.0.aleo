import credits.aleo;
import token_registry.aleo;

program sushant_token_faucet_program.aleo;

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

mapping used_identifiers:
    key as field.public;
    value as boolean.public;

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
    async transfer_private r12 r15 into r16;
    output r9 as SpendLimit.record;
    output r10 as token_registry.aleo/Token.record;
    output r13 as token_registry.aleo/Token.record;
    output r14 as token_registry.aleo/Token.record;
    output r16 as sushant_token_faucet_program.aleo/transfer_private.future;

finalize transfer_private:
    input r0 as token_registry.aleo/prehook_private.future;
    input r1 as token_registry.aleo/transfer_private.future;
    await r0;
    await r1;

function initialize:
    assert.eq self.caller aleo1gxnumv92wz9jqn5awhzv0wer4mwanfnutnvrpcf9frf7m3qp0cpqj9jnrt;
    call token_registry.aleo/register_token 9141392167392299637368214875764field 9141392167392299637368214875764u128 9141392167392299637368214875764u128 6u8 10000000000000000u128 true sushant_token_faucet_program.aleo into r0;
    async initialize r0 into r1;
    output r1 as sushant_token_faucet_program.aleo/initialize.future;

finalize initialize:
    input r0 as token_registry.aleo/register_token.future;
    await r0;

function mint_private:
    assert.eq self.caller aleo1gxnumv92wz9jqn5awhzv0wer4mwanfnutnvrpcf9frf7m3qp0cpqj9jnrt;
    call token_registry.aleo/mint_private 9141392167392299637368214875764field aleo1gxnumv92wz9jqn5awhzv0wer4mwanfnutnvrpcf9frf7m3qp0cpqj9jnrt 1000000000000000u128 true 4294967295u32 into r0 r1;
    async mint_private r1 into r2;
    output r0 as token_registry.aleo/Token.record;
    output r2 as sushant_token_faucet_program.aleo/mint_private.future;

finalize mint_private:
    input r0 as token_registry.aleo/mint_private.future;
    await r0;
    contains has_minted[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into has_minted[0u8];

function get_funds:
    input r0 as field.public;
    call token_registry.aleo/mint_public 9141392167392299637368214875764field self.caller 100000000u128 4294967295u32 into r1;
    async get_funds r1 r0 into r2;
    output r2 as sushant_token_faucet_program.aleo/get_funds.future;

finalize get_funds:
    input r0 as token_registry.aleo/mint_public.future;
    input r1 as field.public;
    await r0;
    get.or_use used_identifiers[r1] false into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into used_identifiers[r1];

function issue_limit:
    input r0 as address.private;
    assert.eq self.caller aleo1gxnumv92wz9jqn5awhzv0wer4mwanfnutnvrpcf9frf7m3qp0cpqj9jnrt;
    cast r0 0u128 0u32 into r1 as SpendLimit.record;
    output r1 as SpendLimit.record;
