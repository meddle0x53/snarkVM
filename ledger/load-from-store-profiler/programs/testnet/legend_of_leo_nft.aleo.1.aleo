program legend_of_leo_nft.aleo;

struct TokenData:
    name as field;
    image as field;
    creator as address;

record Token:
    owner as address.private;
    data as TokenData.private;
    edition as scalar.private;

mapping collection_info:
    key as field.public;
    value as field.public;

mapping token_owners:
    key as field.public;
    value as address.public;

mapping minted_tokens:
    key as field.public;
    value as boolean.public;

function initialize:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u64.private;
    gt r2 0u64 into r3;
    assert.eq r3 true;
    output true as boolean.private;

function mint:
    input r0 as address.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as scalar.private;
    cast r1 r2 self.caller into r4 as TokenData;
    cast r0 r4 r3 into r5 as Token.record;
    output r5 as Token.record;

function self_mint:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as scalar.private;
    cast r0 r1 self.caller into r3 as TokenData;
    cast self.caller r3 r2 into r4 as Token.record;
    output r4 as Token.record;

function transfer:
    input r0 as Token.record;
    input r1 as address.private;
    cast r1 r0.data r0.edition into r2 as Token.record;
    output r2 as Token.record;

function test_mint:
    input r0 as address.private;
    cast 123field 456field self.caller into r1 as TokenData;
    cast r0 r1 1scalar into r2 as Token.record;
    output r2 as Token.record;

function simple_test:
    input r0 as u64.private;
    input r1 as u64.private;
    add r0 r1 into r2;
    output r2 as u64.private;
