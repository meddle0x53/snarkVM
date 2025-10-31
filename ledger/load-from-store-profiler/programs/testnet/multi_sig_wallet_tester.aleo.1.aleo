import credits.aleo;
import token_registry.aleo;

program multi_sig_wallet_tester.aleo;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct transfer_operation:
    recipient as address;
    amount as u64;

struct transfer2_operation:
    token_id as field;
    recipient as address;
    amount as u128;

struct bond_operation:
    validator as address;
    withdraw as address;
    amount as u64;

struct unbond_operation:
    staker as address;
    amount as u64;

struct claim_unbond_operation:
    staker as address;

struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;
    program_id as address;

mapping admin_operations:
    key as u64.public;
    value as admin_operation.public;

mapping admins:
    key as address.public;
    value as boolean.public;

mapping initialized:
    key as u8.public;
    value as boolean.public;

mapping nonce:
    key as u8.public;
    value as u64.public;

function initialize:
    async initialize into r0;
    output r0 as multi_sig_wallet_tester.aleo/initialize.future;

finalize initialize:
    contains initialized[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    set true into initialized[0u8];
    set true into admins[aleo1csgkqstenz9hgf7r6pxaglfgg2uh0nqzpfahly8m982thwwvkcxs0mr646];
    set true into admins[aleo1ys7c3pl70g7zn57k6m6zzd8mz87yass4ssrrmjdgeyjmlfjfkvqsdjvc3r];
    set true into admins[aleo1tgctqylml97ljhxcvfc0frkfza3kmqhr4hhewkkg20mtzesq3yyqyd68w3];
    set 0u64 into nonce[0u8];

function transfer:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    call credits.aleo/transfer_public r0 r1 into r6;
    async transfer r6 r0 r1 r2 r3 r4 r5 into r7;
    output r7 as multi_sig_wallet_tester.aleo/transfer.future;

finalize transfer:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    get.or_use nonce[0u8] 0u64 into r7;
    add r7 1u64 into r8;
    set r8 into nonce[0u8];
    cast r1 r2 into r9 as transfer_operation;
    hash.bhp256 r9 into r10 as field;
    cast r10 0u8 r7 multi_sig_wallet_tester.aleo into r11 as admin_operation;
    hash.bhp256 r11 into r12 as field;
    sign.verify r3 r4 r12 into r13;
    assert.eq r13 true;
    sign.verify r5 r6 r12 into r14;
    assert.eq r14 true;
    assert.neq r4 r6;
    get admins[r4] into r15;
    get admins[r6] into r16;
    and r15 r16 into r17;
    assert.eq r17 true;
    contains admin_operations[r7] into r18;
    not r18 into r19;
    assert.eq r19 true;
    await r0;
    set r11 into admin_operations[r7];

function transfer2:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    input r7 as u64.public;
    call token_registry.aleo/transfer_public r0 r1 r2 into r8;
    cast r0 r1 r2 into r9 as transfer2_operation;
    hash.bhp256 r9 into r10 as field;
    cast r10 0u8 r7 multi_sig_wallet_tester.aleo into r11 as admin_operation;
    hash.bhp256 r11 into r12 as field;
    sign.verify r3 r4 r12 into r13;
    assert.eq r13 true;
    sign.verify r5 r6 r12 into r14;
    assert.eq r14 true;
    assert.neq r4 r6;
    async transfer2 r8 r11 r4 r6 into r15;
    output r15 as multi_sig_wallet_tester.aleo/transfer2.future;

finalize transfer2:
    input r0 as token_registry.aleo/transfer_public.future;
    input r1 as admin_operation.public;
    input r2 as address.public;
    input r3 as address.public;
    get.or_use nonce[0u8] 0u64 into r4;
    add r4 1u64 into r5;
    set r5 into nonce[0u8];
    await r0;
    get admins[r2] into r6;
    get admins[r3] into r7;
    and r6 r7 into r8;
    assert.eq r8 true;
    contains admin_operations[r1.request_id] into r9;
    not r9 into r10;
    assert.eq r10 true;
    set r1 into admin_operations[r1.request_id];

function bond:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    call credits.aleo/bond_public r0 r1 r2 into r7;
    async bond r7 r0 r1 r2 r3 r4 r5 r6 into r8;
    output r8 as multi_sig_wallet_tester.aleo/bond.future;

finalize bond:
    input r0 as credits.aleo/bond_public.future;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as u64.public;
    input r4 as signature.public;
    input r5 as address.public;
    input r6 as signature.public;
    input r7 as address.public;
    get.or_use nonce[0u8] 0u64 into r8;
    add r8 1u64 into r9;
    set r9 into nonce[0u8];
    cast r1 r2 r3 into r10 as bond_operation;
    hash.bhp256 r10 into r11 as field;
    cast r11 2u8 r8 multi_sig_wallet_tester.aleo into r12 as admin_operation;
    hash.bhp256 r12 into r13 as field;
    sign.verify r4 r5 r13 into r14;
    assert.eq r14 true;
    sign.verify r6 r7 r13 into r15;
    assert.eq r15 true;
    assert.neq r5 r7;
    get admins[r5] into r16;
    get admins[r7] into r17;
    and r16 r17 into r18;
    assert.eq r18 true;
    contains admin_operations[r8] into r19;
    not r19 into r20;
    assert.eq r20 true;
    await r0;
    set r12 into admin_operations[r8];

function unbond:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    call credits.aleo/unbond_public r0 r1 into r6;
    async unbond r6 r0 r1 r2 r3 r4 r5 into r7;
    output r7 as multi_sig_wallet_tester.aleo/unbond.future;

finalize unbond:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as signature.public;
    input r4 as address.public;
    input r5 as signature.public;
    input r6 as address.public;
    get.or_use nonce[0u8] 0u64 into r7;
    add r7 1u64 into r8;
    set r8 into nonce[0u8];
    cast r1 r2 into r9 as unbond_operation;
    hash.bhp256 r9 into r10 as field;
    cast r10 3u8 r7 multi_sig_wallet_tester.aleo into r11 as admin_operation;
    hash.bhp256 r11 into r12 as field;
    sign.verify r3 r4 r12 into r13;
    assert.eq r13 true;
    sign.verify r5 r6 r12 into r14;
    assert.eq r14 true;
    assert.neq r4 r6;
    get admins[r4] into r15;
    get admins[r6] into r16;
    and r15 r16 into r17;
    assert.eq r17 true;
    contains admin_operations[r7] into r18;
    not r18 into r19;
    assert.eq r19 true;
    await r0;
    set r11 into admin_operations[r7];

function claim_unbond:
    input r0 as address.public;
    input r1 as signature.public;
    input r2 as address.public;
    input r3 as signature.public;
    input r4 as address.public;
    call credits.aleo/claim_unbond_public r0 into r5;
    async claim_unbond r5 r0 r1 r2 r3 r4 into r6;
    output r6 as multi_sig_wallet_tester.aleo/claim_unbond.future;

finalize claim_unbond:
    input r0 as credits.aleo/claim_unbond_public.future;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    get.or_use nonce[0u8] 0u64 into r6;
    add r6 1u64 into r7;
    set r7 into nonce[0u8];
    cast r1 into r8 as claim_unbond_operation;
    hash.bhp256 r8 into r9 as field;
    cast r9 4u8 r6 multi_sig_wallet_tester.aleo into r10 as admin_operation;
    hash.bhp256 r10 into r11 as field;
    sign.verify r2 r3 r11 into r12;
    assert.eq r12 true;
    sign.verify r4 r5 r11 into r13;
    assert.eq r13 true;
    assert.neq r3 r5;
    get admins[r3] into r14;
    get admins[r5] into r15;
    and r14 r15 into r16;
    assert.eq r16 true;
    contains admin_operations[r6] into r17;
    not r17 into r18;
    assert.eq r18 true;
    await r0;
    set r10 into admin_operations[r6];

function update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    async update_admin r0 r1 r2 r3 r4 r5 into r6;
    output r6 as multi_sig_wallet_tester.aleo/update_admin.future;

finalize update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as signature.public;
    input r5 as address.public;
    get.or_use nonce[0u8] 0u64 into r6;
    add r6 1u64 into r7;
    set r7 into nonce[0u8];
    cast r0 r1 into r8 as [address; 2u32];
    hash.bhp256 r8 into r9 as field;
    cast r9 1u8 r6 multi_sig_wallet_tester.aleo into r10 as admin_operation;
    hash.bhp256 r10 into r11 as field;
    sign.verify r2 r3 r11 into r12;
    assert.eq r12 true;
    sign.verify r4 r5 r11 into r13;
    assert.eq r13 true;
    assert.neq r3 r5;
    get admins[r3] into r14;
    get admins[r5] into r15;
    and r14 r15 into r16;
    assert.eq r16 true;
    contains admin_operations[r6] into r17;
    not r17 into r18;
    assert.eq r18 true;
    set r10 into admin_operations[r6];
    get admins[r0] into r19;
    get admins[r1] into r20;
    not r20 into r21;
    and r19 r21 into r22;
    assert.eq r22 true;
    remove admins[r0];
    set true into admins[r1];

function build_hash:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    cast r0 r1 into r3 as transfer_operation;
    hash.bhp256 r3 into r4 as field;
    cast r4 0u8 r2 multi_sig_wallet_tester.aleo into r5 as admin_operation;
    hash.bhp256 r5 into r6 as field;
    output r6 as field.private;

function build_hash2:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as u64.public;
    cast r0 r1 r2 into r4 as transfer2_operation;
    hash.bhp256 r4 into r5 as field;
    cast r5 0u8 r3 multi_sig_wallet_tester.aleo into r6 as admin_operation;
    hash.bhp256 r6 into r7 as field;
    output r7 as field.private;

function build_bond:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    cast r0 r1 r2 into r4 as bond_operation;
    hash.bhp256 r4 into r5 as field;
    cast r5 2u8 r3 multi_sig_wallet_tester.aleo into r6 as admin_operation;
    hash.bhp256 r6 into r7 as field;
    output r7 as field.private;

function build_unbond:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    cast r0 r1 into r3 as unbond_operation;
    hash.bhp256 r3 into r4 as field;
    cast r4 3u8 r2 multi_sig_wallet_tester.aleo into r5 as admin_operation;
    hash.bhp256 r5 into r6 as field;
    output r6 as field.private;

function build_claim_unbond:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 into r2 as claim_unbond_operation;
    hash.bhp256 r2 into r3 as field;
    cast r3 4u8 r1 multi_sig_wallet_tester.aleo into r4 as admin_operation;
    hash.bhp256 r4 into r5 as field;
    output r5 as field.private;

function build_admin_hash:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    cast r0 r1 into r3 as [address; 2u32];
    hash.bhp256 r3 into r4 as field;
    cast r4 1u8 r2 multi_sig_wallet_tester.aleo into r5 as admin_operation;
    hash.bhp256 r5 into r6 as field;
    output r6 as field.private;
