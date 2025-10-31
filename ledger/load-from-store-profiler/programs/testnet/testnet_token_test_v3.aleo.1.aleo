program testnet_token_test_v3.aleo;

mapping account:
    key as address.public;
    value as u64.public;

function mint:
    input r0 as address.public;
    input r1 as u64.private;
    input r2 as u64.private;
    add r1 r2 into r3;
    async mint r0 r3 into r4;
    output r4 as testnet_token_test_v3.aleo/mint.future;

finalize mint:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];

function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    async mint_public r0 r1 into r2;
    output r2 as testnet_token_test_v3.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];
