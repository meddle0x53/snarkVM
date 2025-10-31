program zksignaleov5.aleo;

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
    document_id as field.private;

record SignStatus:
    owner as address.private;
    token_id as TokenId.private;
    status as u8.private;

struct SignDocument:
    view_key as field;
    document_id as field;
    status as u8;

function create_document:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as String64.private;
    input r3 as field.private;
    cast 0u128 r1 into r4 as TokenId;
    cast r0 r4 r2 r3 r3 into r5 as Document.record;
    cast r0 r4 0u8 into r6 as SignStatus.record;
    output r5 as Document.record;
    output r6 as SignStatus.record;

function sign:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as u8.private;
    is.eq r2 0u8 into r3;
    is.eq r2 1u8 into r4;
    or r3 r4 into r5;
    assert.eq r5 true;
    cast r1 r0 r2 into r6 as SignDocument;
    output r2 as u8.private;

function view_status:
    input r0 as SignStatus.record;
    output r0.status as u8.private;
