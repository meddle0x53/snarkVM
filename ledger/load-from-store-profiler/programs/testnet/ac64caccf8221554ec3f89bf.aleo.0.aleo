program ac64caccf8221554ec3f89bf.aleo;

struct ContractCall:
    caller as address;
    sender as address;
    destination_chain as [u128; 2u32];
    destination_address as [u128; 4u32];

mapping message_state:
    key as group.public;
    value as u8.public;

mapping signers:
    key as address.public;
    value as boolean.public;

function callContract:
    input r0 as [u128; 2u32].private;
    input r1 as [u128; 4u32].private;
    cast self.caller self.signer r0 r1 into r2 as ContractCall;
    output r2 as ContractCall.public;

function validate_message:
    input r0 as group.private;
    async validate_message r0 into r1;
    output r1 as ac64caccf8221554ec3f89bf.aleo/validate_message.future;

finalize validate_message:
    input r0 as group.public;
    get message_state[r0] into r1;
    is.eq r1 1u8 into r2;
    assert.eq r2 true;
    set 2u8 into message_state[r0];

function init_signers:
    async init_signers aleo145tj9hqrnv3hqylrem6p7zjyxc2kryyp3hdm4ht48ntj3e5ttuxs9xs9ak into r0;
    output r0 as ac64caccf8221554ec3f89bf.aleo/init_signers.future;

finalize init_signers:
    input r0 as address.public;
    set true into signers[r0];

function register_approve_message:
    input r0 as group.private;
    async register_approve_message r0 into r1;
    output r1 as ac64caccf8221554ec3f89bf.aleo/register_approve_message.future;

finalize register_approve_message:
    input r0 as group.public;
    contains message_state[r0] into r1;
    assert.eq r1 false;
    set 1u8 into message_state[r0];
