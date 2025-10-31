program zerosecure_wallet_manager_v5.aleo;

record Wallet:
    owner as address.private;
    wallet_address as address.private;
    owners as [address; 8u32].private;
    threshold as u8.private;
    sequence as u64.private;

mapping wallet_sequence:
    key as field.public;
    value as u64.public;

mapping managers:
    key as field.public;
    value as [field; 8u32].public;

mapping admins:
    key as field.public;
    value as field.public;

function create_wallet:
    input r0 as address.private;
    input r1 as [address; 8u32].private;
    input r2 as u8.private;
    is.neq r1[0u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r3;
    ternary r3 1u8 0u8 into r4;
    add 0u8 r4 into r5;
    is.neq r1[1u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r6;
    ternary r6 1u8 0u8 into r7;
    add r5 r7 into r8;
    is.neq r1[2u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r9;
    ternary r9 1u8 0u8 into r10;
    add r8 r10 into r11;
    is.neq r1[3u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r12;
    ternary r12 1u8 0u8 into r13;
    add r11 r13 into r14;
    is.neq r1[4u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r15;
    ternary r15 1u8 0u8 into r16;
    add r14 r16 into r17;
    is.neq r1[5u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r18;
    ternary r18 1u8 0u8 into r19;
    add r17 r19 into r20;
    is.neq r1[6u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r21;
    ternary r21 1u8 0u8 into r22;
    add r20 r22 into r23;
    is.neq r1[7u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r24;
    ternary r24 1u8 0u8 into r25;
    add r23 r25 into r26;
    lte r2 r26 into r27;
    gte r2 1u8 into r28;
    and r27 r28 into r29;
    assert.eq r29 true;
    cast r1[0u32] r0 r1 r2 0u64 into r30 as Wallet.record;
    cast r1[1u32] r0 r1 r2 0u64 into r31 as Wallet.record;
    cast r1[2u32] r0 r1 r2 0u64 into r32 as Wallet.record;
    cast r1[3u32] r0 r1 r2 0u64 into r33 as Wallet.record;
    cast r1[4u32] r0 r1 r2 0u64 into r34 as Wallet.record;
    cast r1[5u32] r0 r1 r2 0u64 into r35 as Wallet.record;
    cast r1[6u32] r0 r1 r2 0u64 into r36 as Wallet.record;
    cast r1[7u32] r0 r1 r2 0u64 into r37 as Wallet.record;
    hash.bhp256 r0 into r38 as field;
    hash.bhp256 self.caller into r39 as field;
    async create_wallet r38 r39 into r40;
    output r30 as Wallet.record;
    output r31 as Wallet.record;
    output r32 as Wallet.record;
    output r33 as Wallet.record;
    output r34 as Wallet.record;
    output r35 as Wallet.record;
    output r36 as Wallet.record;
    output r37 as Wallet.record;
    output r40 as zerosecure_wallet_manager_v5.aleo/create_wallet.future;

finalize create_wallet:
    input r0 as field.public;
    input r1 as field.public;
    contains wallet_sequence[r0] into r2;
    assert.eq r2 false;
    set 0u64 into wallet_sequence[r0];
    set r1 into admins[r0];
    cast 7833185298839889869212594806745334335817950658667461917749505843801426271110field 7833185298839889869212594806745334335817950658667461917749505843801426271110field 7833185298839889869212594806745334335817950658667461917749505843801426271110field 7833185298839889869212594806745334335817950658667461917749505843801426271110field 7833185298839889869212594806745334335817950658667461917749505843801426271110field 7833185298839889869212594806745334335817950658667461917749505843801426271110field 7833185298839889869212594806745334335817950658667461917749505843801426271110field 7833185298839889869212594806745334335817950658667461917749505843801426271110field into r3 as [field; 8u32];
    set r3 into managers[r0];

function change_managers:
    input r0 as Wallet.record;
    input r1 as [address; 8u32].private;
    hash.bhp256 r0.wallet_address into r2 as field;
    hash.bhp256 r0.owner into r3 as field;
    hash.bhp256 r1[0u32] into r4 as field;
    hash.bhp256 r1[1u32] into r5 as field;
    hash.bhp256 r1[2u32] into r6 as field;
    hash.bhp256 r1[3u32] into r7 as field;
    hash.bhp256 r1[4u32] into r8 as field;
    hash.bhp256 r1[5u32] into r9 as field;
    hash.bhp256 r1[6u32] into r10 as field;
    hash.bhp256 r1[7u32] into r11 as field;
    cast r4 r5 r6 r7 r8 r9 r10 r11 into r12 as [field; 8u32];
    cast r0.owner r0.wallet_address r0.owners r0.threshold r0.sequence into r13 as Wallet.record;
    async change_managers r2 r3 r12 into r14;
    output r13 as Wallet.record;
    output r14 as zerosecure_wallet_manager_v5.aleo/change_managers.future;

finalize change_managers:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as [field; 8u32].public;
    get admins[r0] into r3;
    assert.eq r3 r1;
    set r2 into managers[r0];

function change_admin:
    input r0 as Wallet.record;
    input r1 as address.private;
    hash.bhp256 r0.wallet_address into r2 as field;
    hash.bhp256 r0.owner into r3 as field;
    hash.bhp256 r1 into r4 as field;
    is.eq r0.owners[0u32] r1 into r5;
    is.eq r0.owners[1u32] r1 into r6;
    is.eq r0.owners[2u32] r1 into r7;
    is.eq r0.owners[3u32] r1 into r8;
    is.eq r0.owners[4u32] r1 into r9;
    is.eq r0.owners[5u32] r1 into r10;
    is.eq r0.owners[6u32] r1 into r11;
    is.eq r0.owners[7u32] r1 into r12;
    ternary r12 true false into r13;
    ternary r11 true r13 into r14;
    ternary r10 true r14 into r15;
    ternary r9 true r15 into r16;
    ternary r8 true r16 into r17;
    ternary r7 true r17 into r18;
    ternary r6 true r18 into r19;
    ternary r5 true r19 into r20;
    assert.eq r20 true;
    is.neq r1 r0.owner into r21;
    assert.eq r21 true;
    is.neq r1 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r22;
    assert.eq r22 true;
    cast r0.owner r0.wallet_address r0.owners r0.threshold r0.sequence into r23 as Wallet.record;
    async change_admin r2 r3 r4 into r24;
    output r23 as Wallet.record;
    output r24 as zerosecure_wallet_manager_v5.aleo/change_admin.future;

finalize change_admin:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    get admins[r0] into r3;
    assert.eq r3 r1;
    set r2 into admins[r0];

function increase_sequence:
    input r0 as address.private;
    assert.eq self.caller zerosecure_governance_managerv5.aleo;
    hash.bhp256 r0 into r1 as field;
    async increase_sequence r1 into r2;
    output r2 as zerosecure_wallet_manager_v5.aleo/increase_sequence.future;

finalize increase_sequence:
    input r0 as field.public;
    get wallet_sequence[r0] into r1;
    add r1 1u64 into r2;
    set r2 into wallet_sequence[r0];

function refresh_wallet_record:
    input r0 as Wallet.record;
    cast r0.owner r0.wallet_address r0.owners r0.threshold r0.sequence into r1 as Wallet.record;
    output r1 as Wallet.record;

function create_new_wallet_record:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as [address; 8u32].private;
    input r3 as u8.private;
    input r4 as u64.private;
    is.eq self.caller zerosecure_transfer_managerv5.aleo into r5;
    is.eq self.caller zerosecure_governance_managerv5.aleo into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    cast r0 r1 r2 r3 r4 into r8 as Wallet.record;
    output r8 as Wallet.record;
