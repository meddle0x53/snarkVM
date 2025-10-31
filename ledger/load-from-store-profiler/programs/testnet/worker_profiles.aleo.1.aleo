program worker_profiles.aleo;

struct Worker:
    is_pniw as boolean;
    country_of_origin as [u8; 3u32];
    industry_code as u8;
    has_dependents as boolean;
    state_of_residency as [u8; 2u32];
    subdao_affiliation as address;
    nonce as scalar;

mapping worker_data:
    key as address.public;
    value as Worker.public;

function register_worker:
    input r0 as address.private;
    input r1 as boolean.private;
    input r2 as [u8; 3u32].private;
    input r3 as u8.private;
    input r4 as boolean.private;
    input r5 as [u8; 2u32].private;
    input r6 as address.private;
    gte r3 1u8 into r7;
    lte r3 15u8 into r8;
    and r7 r8 into r9;
    assert.eq r9 true;
    not r1 into r10;
    cast 0u8 0u8 0u8 into r11 as [u8; 3u32];
    is.eq r2 r11 into r12;
    not r10 into r13;
    or r12 r13 into r14;
    assert.eq r14 true;
    async register_worker r0 r1 r2 r3 r4 r5 r6 into r15;
    output r15 as worker_profiles.aleo/register_worker.future;

finalize register_worker:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as [u8; 3u32].public;
    input r3 as u8.public;
    input r4 as boolean.public;
    input r5 as [u8; 2u32].public;
    input r6 as address.public;
    rand.chacha into r7 as scalar;
    cast r1 r2 r3 r4 r5 r6 r7 into r8 as Worker;
    set r8 into worker_data[r0];
