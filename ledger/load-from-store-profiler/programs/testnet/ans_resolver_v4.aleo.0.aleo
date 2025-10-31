import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;

program ans_resolver_v4.aleo;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as field;

struct data:
    metadata as [field; 4u32];

struct ResolverIndex:
    name as field;
    category as u128;
    version as u64;

mapping resolvers:
    key as ResolverIndex.public;
    value as [u128; 8u32].public;

closure calc_name_hash_for_data:
    input r0 as data;
    hash.bhp256 r0 into r1 as field;
    commit.bhp256 r1 0scalar into r2 as field;
    output r2 as field;

function set_resolver_record:
    input r0 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r1 as u128.private;
    input r2 as [u128; 8u32].private;
    gt r1 0u128 into r3;
    assert.eq r3 true;
    gt r2[0u32] 0u128 into r4;
    assert.eq r4 true;
    call calc_name_hash_for_data r0.data into r5;
    call aleo_name_service_registry_v4.aleo/check r0 into r6;
    async set_resolver_record r5 r1 r2 into r7;
    output r7 as ans_resolver_v4.aleo/set_resolver_record.future;

finalize set_resolver_record:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as [u128; 8u32].public;
    get.or_use aleo_name_service_registry_v4.aleo/name_versions[r0] 1u64 into r3;
    cast r0 r1 r3 into r4 as ResolverIndex;
    set r2 into resolvers[r4];

function unset_resolver_record:
    input r0 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r1 as u128.private;
    call calc_name_hash_for_data r0.data into r2;
    call aleo_name_service_registry_v4.aleo/check r0 into r3;
    async unset_resolver_record r2 r1 into r4;
    output r4 as ans_resolver_v4.aleo/unset_resolver_record.future;

finalize unset_resolver_record:
    input r0 as field.public;
    input r1 as u128.public;
    get.or_use aleo_name_service_registry_v4.aleo/name_versions[r0] 1u64 into r2;
    cast r0 r1 r2 into r3 as ResolverIndex;
    remove resolvers[r3];

function set_resolver_record_public:
    input r0 as field.private;
    input r1 as u128.private;
    input r2 as [u128; 8u32].private;
    gt r1 0u128 into r3;
    assert.eq r3 true;
    gt r2[0u32] 0u128 into r4;
    assert.eq r4 true;
    async set_resolver_record_public r0 r1 r2 self.caller into r5;
    output r5 as ans_resolver_v4.aleo/set_resolver_record_public.future;

finalize set_resolver_record_public:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as [u128; 8u32].public;
    input r3 as address.public;
    get aleo_name_service_registry_v4.aleo/nft_owners[r0] into r4;
    assert.eq r3 r4;
    get.or_use aleo_name_service_registry_v4.aleo/name_versions[r0] 1u64 into r5;
    cast r0 r1 r5 into r6 as ResolverIndex;
    set r2 into resolvers[r6];

function unset_resolver_record_public:
    input r0 as field.private;
    input r1 as u128.private;
    async unset_resolver_record_public r0 r1 self.caller into r2;
    output r2 as ans_resolver_v4.aleo/unset_resolver_record_public.future;

finalize unset_resolver_record_public:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    get aleo_name_service_registry_v4.aleo/nft_owners[r0] into r3;
    assert.eq r2 r3;
    get.or_use aleo_name_service_registry_v4.aleo/name_versions[r0] 1u64 into r4;
    cast r0 r1 r4 into r5 as ResolverIndex;
    remove resolvers[r5];
