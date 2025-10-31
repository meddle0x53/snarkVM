import credits.aleo;
import token_registry.aleo;

program coinflip_faucet_v1.aleo;

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

function free_mint:
    input r0 as field.private;
    input r1 as address.private;
    call token_registry.aleo/transfer_public r0 r1 5u128 into r2;
    async free_mint r2 into r3;
    output r3 as coinflip_faucet_v1.aleo/free_mint.future;

finalize free_mint:
    input r0 as token_registry.aleo/transfer_public.future;
    await r0;

function withdraw:
    input r0 as field.private;
    input r1 as u128.private;
    call token_registry.aleo/transfer_public r0 aleo1fg8y0ax9g0yhahrknngzwxkpcf7ejy3mm6cent4mmtwew5ueps8s6jzl27 r1 into r2;
    async withdraw r2 self.caller into r3;
    output r3 as coinflip_faucet_v1.aleo/withdraw.future;

finalize withdraw:
    input r0 as token_registry.aleo/transfer_public.future;
    input r1 as address.public;
    await r0;
    assert.eq r1 aleo1fg8y0ax9g0yhahrknngzwxkpcf7ejy3mm6cent4mmtwew5ueps8s6jzl27;
