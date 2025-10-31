program zerosecure_wallet_manager_v7.aleo;

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
    is.eq r1[0u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r3;
    not r3 into r4;
    ternary r4 1u8 0u8 into r5;
    add 0u8 r5 into r6;
    is.eq r1[1u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r7;
    not r7 into r8;
    ternary r8 1u8 0u8 into r9;
    add r6 r9 into r10;
    is.eq r1[2u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r11;
    not r11 into r12;
    ternary r12 1u8 0u8 into r13;
    add r10 r13 into r14;
    is.eq r1[3u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r15;
    not r15 into r16;
    ternary r16 1u8 0u8 into r17;
    add r14 r17 into r18;
    is.eq r1[4u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r19;
    not r19 into r20;
    ternary r20 1u8 0u8 into r21;
    add r18 r21 into r22;
    is.eq r1[5u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r23;
    not r23 into r24;
    ternary r24 1u8 0u8 into r25;
    add r22 r25 into r26;
    is.eq r1[6u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r27;
    not r27 into r28;
    ternary r28 1u8 0u8 into r29;
    add r26 r29 into r30;
    is.eq r1[7u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r31;
    not r31 into r32;
    ternary r32 1u8 0u8 into r33;
    add r30 r33 into r34;
    lte r2 r34 into r35;
    gte r2 1u8 into r36;
    and r35 r36 into r37;
    assert.eq r37 true;
    cast r1[0u32] r0 r1 r2 0u64 into r38 as Wallet.record;
    cast r1[1u32] r0 r1 r2 0u64 into r39 as Wallet.record;
    cast r1[2u32] r0 r1 r2 0u64 into r40 as Wallet.record;
    cast r1[3u32] r0 r1 r2 0u64 into r41 as Wallet.record;
    cast r1[4u32] r0 r1 r2 0u64 into r42 as Wallet.record;
    cast r1[5u32] r0 r1 r2 0u64 into r43 as Wallet.record;
    cast r1[6u32] r0 r1 r2 0u64 into r44 as Wallet.record;
    cast r1[7u32] r0 r1 r2 0u64 into r45 as Wallet.record;
    hash.bhp256 r0 into r46 as field;
    hash.bhp256 self.caller into r47 as field;
    async create_wallet r46 r47 into r48;
    output r38 as Wallet.record;
    output r39 as Wallet.record;
    output r40 as Wallet.record;
    output r41 as Wallet.record;
    output r42 as Wallet.record;
    output r43 as Wallet.record;
    output r44 as Wallet.record;
    output r45 as Wallet.record;
    output r48 as zerosecure_wallet_manager_v7.aleo/create_wallet.future;

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
    output r14 as zerosecure_wallet_manager_v7.aleo/change_managers.future;

finalize change_managers:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as [field; 8u32].public;
    get admins[r0] into r3;
    assert.eq r3 r1;
    set r2 into managers[r0];

closure is_contains:
    input r0 as [address; 8u32];
    input r1 as address;
    is.eq r0[0u32] r1 into r2;
    is.eq r0[1u32] r1 into r3;
    is.eq r0[2u32] r1 into r4;
    is.eq r0[3u32] r1 into r5;
    is.eq r0[4u32] r1 into r6;
    is.eq r0[5u32] r1 into r7;
    is.eq r0[6u32] r1 into r8;
    is.eq r0[7u32] r1 into r9;
    ternary r9 true false into r10;
    ternary r8 true r10 into r11;
    ternary r7 true r11 into r12;
    ternary r6 true r12 into r13;
    ternary r5 true r13 into r14;
    ternary r4 true r14 into r15;
    ternary r3 true r15 into r16;
    ternary r2 true r16 into r17;
    output r17 as boolean;

function change_admin:
    input r0 as Wallet.record;
    input r1 as address.private;
    hash.bhp256 r0.wallet_address into r2 as field;
    hash.bhp256 r0.owner into r3 as field;
    hash.bhp256 r1 into r4 as field;
    call is_contains r0.owners r1 into r5;
    assert.eq r5 true;
    is.eq r1 r0.owner into r6;
    assert.eq r6 false;
    is.eq r1 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r7;
    assert.eq r7 false;
    cast r0.owner r0.wallet_address r0.owners r0.threshold r0.sequence into r8 as Wallet.record;
    async change_admin r2 r3 r4 into r9;
    output r8 as Wallet.record;
    output r9 as zerosecure_wallet_manager_v7.aleo/change_admin.future;

finalize change_admin:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    get admins[r0] into r3;
    assert.eq r3 r1;
    set r2 into admins[r0];

function increase_sequence:
    input r0 as address.private;
    assert.eq self.caller zerosecure_governance_managerv2.aleo;
    hash.bhp256 r0 into r1 as field;
    async increase_sequence r1 into r2;
    output r2 as zerosecure_wallet_manager_v7.aleo/increase_sequence.future;

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
    is.eq self.caller zerosecure_transfer_managerv2.aleo into r5;
    is.eq self.caller zerosecure_governance_managerv2.aleo into r6;
    or r5 r6 into r7;
    assert.eq r7 true;
    cast r0 r1 r2 r3 r4 into r8 as Wallet.record;
    output r8 as Wallet.record;
