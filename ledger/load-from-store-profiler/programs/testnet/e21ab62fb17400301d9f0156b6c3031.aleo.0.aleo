import ac64caccf8221554ec3f89bf.aleo;

program e21ab62fb17400301d9f0156b6c3031.aleo;

struct ContractCall:
    caller as address;
    sender as address;
    destination_chain as [u128; 2u32];
    destination_address as [u128; 4u32];

struct Payload:
    domain_separator as [u128; 2u32];
    signer as address;
    data_hash as group;

struct Proof:
    weighted_signer as address;
    signaturee as signature;
    nonce as [u128; 2u32];

struct Message:
    source_chain as [u128; 2u32];
    message_id as [u128; 8u32];
    source_address as [u128; 4u32];
    contract_address as [u128; 4u32];
    payload_hash as group;

function approve_message:
    input r0 as Proof.private;
    input r1 as Message.private;
    hash.keccak256 r1 into r2 as group;
    cast 77458889505116476800238291525522912105u128 212654606198768313326909807475703735288u128 into r3 as [u128; 2u32];
    cast r3 r0.weighted_signer r2 into r4 as Payload;
    hash.keccak256 r4 into r5 as group;
    sign.verify r0.signaturee r0.weighted_signer r5 into r6;
    assert.eq r6 true;
    call ac64caccf8221554ec3f89bf.aleo/register_approve_message r2 into r7;
    async approve_message r0.weighted_signer r7 into r8;
    output r2 as group.public;
    output r8 as e21ab62fb17400301d9f0156b6c3031.aleo/approve_message.future;

finalize approve_message:
    input r0 as address.public;
    input r1 as ac64caccf8221554ec3f89bf.aleo/register_approve_message.future;
    get ac64caccf8221554ec3f89bf.aleo/signers[r0] into r2;
    assert.eq r2 true;
    await r1;
