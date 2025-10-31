program store_value_v001.aleo;

record UserKey:
    owner as address.private;
    private_key as field.private;
    chainId as field.private;
    wallet_address as field.private;

function store_wallet:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    cast self.caller r0 r1 r2 into r3 as UserKey.record;
    async store_wallet into r4;
    output r3 as UserKey.record;
    output r4 as store_value_v001.aleo/store_wallet.future;

finalize store_wallet:
    assert.eq true true;

function update_wallet:
    input r0 as UserKey.record;
    input r1 as field.private;
    input r2 as field.private;
    cast self.caller r1 r0.chainId r2 into r3 as UserKey.record;
    async update_wallet into r4;
    output r3 as UserKey.record;
    output r4 as store_value_v001.aleo/update_wallet.future;

finalize update_wallet:
    assert.eq true true;
