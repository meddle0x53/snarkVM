import ans_utils_v2.aleo;
import aleo_name_service_registry_v2.aleo;

program ans_resolver_v2.aleo;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as u128;

struct data:
    metadata as [field; 4u32];

struct ResolverIndex:
    name as field;
    category as u128;
    version as u64;

mapping resolvers:
    key as ResolverIndex.public;
    value as [u128; 8u32].public;

function set_resolver_record:
    input r0 as field.private;
    input r1 as u128.private;
    input r2 as [u128; 8u32].private;
    gt r1 0u128 into r3;
    assert.eq r3 true;
    gt r2[0u32] 0u128 into r4;
    assert.eq r4 true;
    async set_resolver_record r0 self.caller r1 r2 into r5;
    output r5 as ans_resolver_v2.aleo/set_resolver_record.future;

finalize set_resolver_record:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as [u128; 8u32].public;
    get aleo_name_service_registry_v2.aleo/nft_owners[r0] into r4;
    assert.eq r1 r4;
    get.or_use aleo_name_service_registry_v2.aleo/name_versions[r0] 1u64 into r5;
    cast r0 r2 r5 into r6 as ResolverIndex;
    set r3 into resolvers[r6];

function unset_resolver_record:
    input r0 as field.private;
    input r1 as u128.private;
    async unset_resolver_record r0 self.caller r1 into r2;
    output r2 as ans_resolver_v2.aleo/unset_resolver_record.future;

finalize unset_resolver_record:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    get aleo_name_service_registry_v2.aleo/nft_owners[r0] into r3;
    assert.eq r1 r3;
    get.or_use aleo_name_service_registry_v2.aleo/name_versions[r0] 1u64 into r4;
    cast r0 r2 r4 into r5 as ResolverIndex;
    remove resolvers[r5];
