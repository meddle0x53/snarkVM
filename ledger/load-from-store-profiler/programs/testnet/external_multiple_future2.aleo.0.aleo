program external_multiple_future2.aleo;

record r1:
    owner as address.private;
    is_r1 as boolean.private;

record r2:
    owner as address.private;
    is_r2 as boolean.private;

mapping m1:
    key as boolean.public;
    value as boolean.public;

mapping m2:
    key as boolean.public;
    value as boolean.public;

function set1:
    input r0 as r1.record;
    async set1 into r1;
    output r1 as external_multiple_future2.aleo/set1.future;

finalize set1:
    set true into m1[true];

function set2:
    input r0 as r2.record;
    async set2 into r1;
    output r1 as external_multiple_future2.aleo/set2.future;

finalize set2:
    set true into m2[true];

function mint_r1:
    cast self.signer true into r0 as r1.record;
    output r0 as r1.record;

function mint_r2:
    cast self.signer true into r0 as r2.record;
    output r0 as r2.record;
