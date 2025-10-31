program i3d7k5b1m8q8.aleo;

record PriceRecord:
    owner as address.private;
    price as u128.private;
    pair as field.private;
    timestamp as u64.private;

struct PriceData:
    price as u128;
    timestamp as u64;
    provider as address;

mapping prices:
    key as field.public;
    value as PriceData.public;

function submit_price:
    input r0 as PriceRecord.record;
    cast r0.price r0.timestamp r0.owner into r1 as PriceData;
    async submit_price r0.pair r1 into r2;
    cast r0.owner r0.price r0.pair r0.timestamp into r3 as PriceRecord.record;
    output r3 as PriceRecord.record;
    output r2 as i3d7k5b1m8q8.aleo/submit_price.future;

finalize submit_price:
    input r0 as field.public;
    input r1 as PriceData.public;
    set r1 into prices[r0];
