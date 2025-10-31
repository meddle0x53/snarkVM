import messenger.aleo;
import ans_utils_v2.aleo;
import aleo_name_service_registry_v4.aleo;
import ans_resolver_v4.aleo;

program ans_registrar_quest_2.aleo;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as field;

struct data:
    metadata as [field; 4u32];

function transfer_private_to_public:
    input r0 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r1 as address.private;
    input r2 as [field; 8u32].private;
    call aleo_name_service_registry_v4.aleo/transfer_private_to_public r0 r1 into r3 r4;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r2 into r5;
    async transfer_private_to_public r4 into r6;
    output r6 as ans_registrar_quest_2.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as aleo_name_service_registry_v4.aleo/transfer_private_to_public.future;
    await r0;

function set_primary_name:
    input r0 as field.private;
    input r1 as [field; 8u32].private;
    call aleo_name_service_registry_v4.aleo/set_primary_name r0 into r2;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r1 into r3;
    async set_primary_name r2 into r4;
    output r4 as ans_registrar_quest_2.aleo/set_primary_name.future;

finalize set_primary_name:
    input r0 as aleo_name_service_registry_v4.aleo/set_primary_name.future;
    await r0;

function set_resolver_record:
    input r0 as aleo_name_service_registry_v4.aleo/NFT.record;
    input r1 as u128.private;
    input r2 as [u128; 8u32].private;
    input r3 as [field; 8u32].private;
    call ans_resolver_v4.aleo/set_resolver_record r0 r1 r2 into r4;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r3 into r5;
    async set_resolver_record r4 into r6;
    output r6 as ans_registrar_quest_2.aleo/set_resolver_record.future;

finalize set_resolver_record:
    input r0 as ans_resolver_v4.aleo/set_resolver_record.future;
    await r0;

function set_resolver_record_public:
    input r0 as field.private;
    input r1 as u128.private;
    input r2 as [u128; 8u32].private;
    input r3 as [field; 8u32].private;
    call ans_resolver_v4.aleo/set_resolver_record_public r0 r1 r2 into r4;
    call messenger.aleo/send aleo1sr8d93usu395zc29qcl35ul2e7hl2538hl8pehe4ms88q4g70gxq3ffw0v r3 into r5;
    async set_resolver_record_public r4 into r6;
    output r6 as ans_registrar_quest_2.aleo/set_resolver_record_public.future;

finalize set_resolver_record_public:
    input r0 as ans_resolver_v4.aleo/set_resolver_record_public.future;
    await r0;
