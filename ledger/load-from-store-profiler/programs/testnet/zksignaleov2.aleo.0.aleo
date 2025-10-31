program zksignaleov2.aleo;

struct String64:
    part0 as u128;
    part1 as u128;
    part2 as u128;
    part3 as u128;

struct TokenId:
    token_number as u128;
    collection_number as u128;

record Document:
    owner as address.private;
    id as TokenId.private;
    metadata_uri as String64.private;
    view_key as field.private;

record SignStatus:
    owner as address.private;
    token_id as TokenId.private;
    status as u8.private;

function create_document:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as String64.private;
    input r3 as field.private;
    cast 0u128 r1 into r4 as TokenId;
    cast r0 r4 r2 r3 into r5 as Document.record;
    cast r0 r4 0u8 into r6 as SignStatus.record;
    output r5 as Document.record;
    output r6 as SignStatus.record;

function sign:
    input r0 as SignStatus.record;
    input r1 as u8.private;
    assert.eq r0.owner self.caller;
    is.eq r1 0u8 into r2;
    is.eq r1 1u8 into r3;
    or r2 r3 into r4;
    assert.eq r4 true;
    cast r0.owner r0.token_id r1 into r5 as SignStatus.record;
    output r5 as SignStatus.record;

function view_status:
    input r0 as SignStatus.record;
    output r0.status as u8.private;
