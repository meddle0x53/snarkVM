program exchange_ratesbat.aleo;

record OracleCredential:
    owner as address.private;
    is_valid as boolean.private;

record ExchangeRate:
    owner as address.private;
    source_currency as u8.private;
    destination_currency as u8.private;
    rate as u64.private;
    timestamp as u32.private;
    expiration as u32.private;

function initialize:
    input r0 as address.private;
    cast r0 true into r1 as OracleCredential.record;
    output r1 as OracleCredential.record;

function add_oracle:
    input r0 as OracleCredential.record;
    input r1 as address.private;
    is.eq r0.owner self.caller into r2;
    assert.eq r2 true;
    assert.eq r0.is_valid true;
    cast r1 true into r3 as OracleCredential.record;
    output r3 as OracleCredential.record;

function revoke_oracle:
    input r0 as OracleCredential.record;
    input r1 as OracleCredential.record;
    is.eq r0.owner self.caller into r2;
    assert.eq r2 true;
    assert.eq r0.is_valid true;
    cast r1.owner false into r3 as OracleCredential.record;
    output r3 as OracleCredential.record;

function update_rate:
    input r0 as OracleCredential.record;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as u64.private;
    input r4 as u32.private;
    input r5 as u32.private;
    is.eq r0.owner self.caller into r6;
    assert.eq r6 true;
    assert.eq r0.is_valid true;
    add r4 r5 into r7;
    cast self.caller r1 r2 r3 r4 r7 into r8 as ExchangeRate.record;
    output r8 as ExchangeRate.record;

function update_usd_eur:
    input r0 as OracleCredential.record;
    input r1 as u64.private;
    input r2 as u32.private;
    input r3 as u32.private;
    is.eq r0.owner self.caller into r4;
    assert.eq r4 true;
    assert.eq r0.is_valid true;
    add r2 r3 into r5;
    cast self.caller 1u8 2u8 r1 r2 r5 into r6 as ExchangeRate.record;
    output r6 as ExchangeRate.record;

function update_usd_jpy:
    input r0 as OracleCredential.record;
    input r1 as u64.private;
    input r2 as u32.private;
    input r3 as u32.private;
    is.eq r0.owner self.caller into r4;
    assert.eq r4 true;
    assert.eq r0.is_valid true;
    add r2 r3 into r5;
    cast self.caller 1u8 3u8 r1 r2 r5 into r6 as ExchangeRate.record;
    output r6 as ExchangeRate.record;

function update_usd_gbp:
    input r0 as OracleCredential.record;
    input r1 as u64.private;
    input r2 as u32.private;
    input r3 as u32.private;
    is.eq r0.owner self.caller into r4;
    assert.eq r4 true;
    assert.eq r0.is_valid true;
    add r2 r3 into r5;
    cast self.caller 1u8 4u8 r1 r2 r5 into r6 as ExchangeRate.record;
    output r6 as ExchangeRate.record;

function verify_rate:
    input r0 as ExchangeRate.record;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as u32.private;
    is.eq r0.source_currency r1 into r4;
    assert.eq r4 true;
    is.eq r0.destination_currency r2 into r5;
    assert.eq r5 true;
    lte r3 r0.expiration into r6;
    assert.eq r6 true;
    output true as boolean.private;

function get_inverse_rate:
    input r0 as ExchangeRate.record;
    div 1000000000000u64 r0.rate into r1;
    output r1 as u64.private;

function apply_rate:
    input r0 as ExchangeRate.record;
    input r1 as u64.private;
    mul r1 r0.rate into r2;
    div r2 1000000u64 into r3;
    output r3 as u64.private;
