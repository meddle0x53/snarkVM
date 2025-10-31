program bionft_dixacare_platform.aleo;

struct bionft:
    holder as address;
    id as field;
    bio_type as u8;
    data as field;
    data_hash as field;
    issued_by as address;
    issued_date as u64;
    expiry_date as u64;
    permissions as field;

mapping account:
    key as address.public;
    value as u64.public;

mapping doctors:
    key as field.public;
    value as address.public;

mapping health_data:
    key as field.public;
    value as bionft.public;

function mint_public_bionft:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u8.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as address.public;
    input r6 as u64.public;
    input r7 as u64.public;
    input r8 as field.public;
    async mint_public_bionft r0 r1 r2 r3 r4 r5 r6 r7 r8 into r9;
    output r9 as bionft_dixacare_platform.aleo/mint_public_bionft.future;

finalize mint_public_bionft:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u8.public;
    input r3 as field.public;
    input r4 as field.public;
    input r5 as address.public;
    input r6 as u64.public;
    input r7 as u64.public;
    input r8 as field.public;
    set r0 into doctors[r1];
    cast r0 r1 r2 r3 r4 r5 r6 r7 r8 into r9 as bionft;
    set r9 into health_data[r1];
    get.or_use account[r0] 0u64 into r10;
    add r10 1u64 into r11;
    set r11 into account[r0];

function transfer_public_bionft:
    input r0 as address.public;
    input r1 as field.public;
    async transfer_public_bionft self.caller r0 r1 into r2;
    output r2 as bionft_dixacare_platform.aleo/transfer_public_bionft.future;

finalize transfer_public_bionft:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as field.public;
    get.or_use account[r0] 0u64 into r3;
    gte r3 1u64 into r4;
    assert.eq r4 true;
    sub r3 1u64 into r5;
    set r5 into account[r0];
    get.or_use account[r1] 0u64 into r6;
    add r6 1u64 into r7;
    set r7 into account[r1];
