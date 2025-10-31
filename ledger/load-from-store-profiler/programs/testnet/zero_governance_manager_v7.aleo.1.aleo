import zero_wallet_manager_v7.aleo;

program zero_governance_manager_v7.aleo;

record ConfirmChangeGovernanceTicket:
    owner as address.private;
    request_id as field.private;
    wallet_address as address.private;
    sequence as u64.private;
    new_owners as [address; 8u32].private;
    new_threshold as u8.private;
    old_threshold as u8.private;

record ExecuteChangeGovernanceTicket:
    owner as address.private;
    request_id as field.private;
    wallet_address as address.private;
    sequence as u64.private;
    new_owners as [address; 8u32].private;
    new_threshold as u8.private;
    old_threshold as u8.private;

struct ChangeGovernanceStatus:
    confirmations as u8;

mapping has_pending_change_governance:
    key as field.public;
    value as boolean.public;

mapping change_governance_status:
    key as field.public;
    value as ChangeGovernanceStatus.public;

function change_governance:
    input r0 as zero_wallet_manager_v7.aleo/Wallet.record;
    input r1 as field.private;
    input r2 as [address; 8u32].private;
    input r3 as u8.private;
    is.neq r2 r0.owners into r4;
    is.neq r3 r0.threshold into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    is.neq r2[0u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r7;
    ternary r7 1u8 0u8 into r8;
    add 0u8 r8 into r9;
    is.neq r2[1u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r10;
    ternary r10 1u8 0u8 into r11;
    add r9 r11 into r12;
    is.neq r2[2u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r13;
    ternary r13 1u8 0u8 into r14;
    add r12 r14 into r15;
    is.neq r2[3u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r16;
    ternary r16 1u8 0u8 into r17;
    add r15 r17 into r18;
    is.neq r2[4u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r19;
    ternary r19 1u8 0u8 into r20;
    add r18 r20 into r21;
    is.neq r2[5u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r22;
    ternary r22 1u8 0u8 into r23;
    add r21 r23 into r24;
    is.neq r2[6u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r25;
    ternary r25 1u8 0u8 into r26;
    add r24 r26 into r27;
    is.neq r2[7u32] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r28;
    ternary r28 1u8 0u8 into r29;
    add r27 r29 into r30;
    lte r3 r30 into r31;
    gte r3 1u8 into r32;
    and r31 r32 into r33;
    assert.eq r33 true;
    hash.bhp256 r0.wallet_address into r34 as field;
    is.eq r0.owner r0.owners[0u32] into r35;
    ternary r35 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[0u32] into r36;
    cast r36 r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r37 as ConfirmChangeGovernanceTicket.record;
    is.eq r0.owner r0.owners[1u32] into r38;
    ternary r38 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[1u32] into r39;
    cast r39 r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r40 as ConfirmChangeGovernanceTicket.record;
    is.eq r0.owner r0.owners[2u32] into r41;
    ternary r41 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[2u32] into r42;
    cast r42 r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r43 as ConfirmChangeGovernanceTicket.record;
    is.eq r0.owner r0.owners[3u32] into r44;
    ternary r44 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[3u32] into r45;
    cast r45 r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r46 as ConfirmChangeGovernanceTicket.record;
    is.eq r0.owner r0.owners[4u32] into r47;
    ternary r47 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[4u32] into r48;
    cast r48 r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r49 as ConfirmChangeGovernanceTicket.record;
    is.eq r0.owner r0.owners[5u32] into r50;
    ternary r50 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[5u32] into r51;
    cast r51 r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r52 as ConfirmChangeGovernanceTicket.record;
    is.eq r0.owner r0.owners[6u32] into r53;
    ternary r53 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[6u32] into r54;
    cast r54 r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r55 as ConfirmChangeGovernanceTicket.record;
    is.eq r0.owner r0.owners[7u32] into r56;
    ternary r56 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r0.owners[7u32] into r57;
    cast r57 r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r58 as ConfirmChangeGovernanceTicket.record;
    cast r0.owner r1 r0.wallet_address r0.sequence r2 r3 r0.threshold into r59 as ExecuteChangeGovernanceTicket.record;
    call zero_wallet_manager_v7.aleo/refresh_wallet_record r0 into r60;
    hash.bhp256 r0.owner into r61 as field;
    async change_governance r34 r1 r61 r0.sequence into r62;
    output r60 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r59 as ExecuteChangeGovernanceTicket.record;
    output r37 as ConfirmChangeGovernanceTicket.record;
    output r40 as ConfirmChangeGovernanceTicket.record;
    output r43 as ConfirmChangeGovernanceTicket.record;
    output r46 as ConfirmChangeGovernanceTicket.record;
    output r49 as ConfirmChangeGovernanceTicket.record;
    output r52 as ConfirmChangeGovernanceTicket.record;
    output r55 as ConfirmChangeGovernanceTicket.record;
    output r58 as ConfirmChangeGovernanceTicket.record;
    output r62 as zero_governance_manager_v7.aleo/change_governance.future;

finalize change_governance:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as u64.public;
    contains has_pending_change_governance[r0] into r4;
    assert.eq r4 false;
    contains change_governance_status[r1] into r5;
    assert.eq r5 false;
    get zero_wallet_manager_v7.aleo/wallet_sequence[r0] into r6;
    is.eq r6 r3 into r7;
    assert.eq r7 true;
    get zero_wallet_manager_v7.aleo/admins[r0] into r8;
    get zero_wallet_manager_v7.aleo/managers[r0] into r9;
    is.eq r9[0u32] r2 into r10;
    is.eq r9[1u32] r2 into r11;
    is.eq r9[2u32] r2 into r12;
    is.eq r9[3u32] r2 into r13;
    is.eq r9[4u32] r2 into r14;
    is.eq r9[5u32] r2 into r15;
    is.eq r9[6u32] r2 into r16;
    is.eq r9[7u32] r2 into r17;
    ternary r17 true false into r18;
    ternary r16 true r18 into r19;
    ternary r15 true r19 into r20;
    ternary r14 true r20 into r21;
    ternary r13 true r21 into r22;
    ternary r12 true r22 into r23;
    ternary r11 true r23 into r24;
    ternary r10 true r24 into r25;
    is.eq r8 r2 into r26;
    or r25 r26 into r27;
    assert.eq r27 true;
    set true into has_pending_change_governance[r0];
    cast 1u8 into r28 as ChangeGovernanceStatus;
    set r28 into change_governance_status[r1];

function confirm_change_governance:
    input r0 as ConfirmChangeGovernanceTicket.record;
    cast r0.owner r0.request_id r0.wallet_address r0.sequence r0.new_owners r0.new_threshold r0.old_threshold into r1 as ExecuteChangeGovernanceTicket.record;
    async confirm_change_governance r0.request_id into r2;
    output r1 as ExecuteChangeGovernanceTicket.record;
    output r2 as zero_governance_manager_v7.aleo/confirm_change_governance.future;

finalize confirm_change_governance:
    input r0 as field.public;
    get change_governance_status[r0] into r1;
    add r1.confirmations 1u8 into r2;
    cast r2 into r3 as ChangeGovernanceStatus;
    set r3 into change_governance_status[r0];

function execute_change_governance:
    input r0 as ExecuteChangeGovernanceTicket.record;
    add r0.sequence 1u64 into r1;
    call zero_wallet_manager_v7.aleo/create_new_wallet_record r0.new_owners[0u32] r0.wallet_address r0.new_owners r0.new_threshold r1 into r2;
    add r0.sequence 1u64 into r3;
    call zero_wallet_manager_v7.aleo/create_new_wallet_record r0.new_owners[1u32] r0.wallet_address r0.new_owners r0.new_threshold r3 into r4;
    add r0.sequence 1u64 into r5;
    call zero_wallet_manager_v7.aleo/create_new_wallet_record r0.new_owners[2u32] r0.wallet_address r0.new_owners r0.new_threshold r5 into r6;
    add r0.sequence 1u64 into r7;
    call zero_wallet_manager_v7.aleo/create_new_wallet_record r0.new_owners[3u32] r0.wallet_address r0.new_owners r0.new_threshold r7 into r8;
    add r0.sequence 1u64 into r9;
    call zero_wallet_manager_v7.aleo/create_new_wallet_record r0.new_owners[4u32] r0.wallet_address r0.new_owners r0.new_threshold r9 into r10;
    add r0.sequence 1u64 into r11;
    call zero_wallet_manager_v7.aleo/create_new_wallet_record r0.new_owners[5u32] r0.wallet_address r0.new_owners r0.new_threshold r11 into r12;
    add r0.sequence 1u64 into r13;
    call zero_wallet_manager_v7.aleo/create_new_wallet_record r0.new_owners[6u32] r0.wallet_address r0.new_owners r0.new_threshold r13 into r14;
    add r0.sequence 1u64 into r15;
    call zero_wallet_manager_v7.aleo/create_new_wallet_record r0.new_owners[7u32] r0.wallet_address r0.new_owners r0.new_threshold r15 into r16;
    call zero_wallet_manager_v7.aleo/increase_sequence r0.wallet_address into r17;
    hash.bhp256 r0.wallet_address into r18 as field;
    async execute_change_governance r18 r0.request_id r0.sequence r0.old_threshold r17 into r19;
    output r2 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r4 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r6 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r8 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r10 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r12 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r14 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r16 as zero_wallet_manager_v7.aleo/Wallet.record;
    output r19 as zero_governance_manager_v7.aleo/execute_change_governance.future;

finalize execute_change_governance:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as u8.public;
    input r4 as zero_wallet_manager_v7.aleo/increase_sequence.future;
    get has_pending_change_governance[r0] into r5;
    assert.eq r5 true;
    get change_governance_status[r1] into r6;
    gte r6.confirmations r3 into r7;
    assert.eq r7 true;
    get zero_wallet_manager_v7.aleo/wallet_sequence[r0] into r8;
    is.eq r8 r2 into r9;
    assert.eq r9 true;
    remove change_governance_status[r1];
    remove has_pending_change_governance[r0];
    await r4;
