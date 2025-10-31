program privadao_core_v1.aleo;

struct DAOConfig:
    name as field;
    token_address as address;
    proposal_address as address;
    voting_address as address;
    reputation_address as address;
    treasury_address as address;
    staking_address as address;

struct DAOPermissions:
    admin as address;
    can_update_config as boolean;
    can_update_permissions as boolean;

mapping dao_config:
    key as field.public;
    value as DAOConfig.public;

mapping dao_permissions:
    key as field.public;
    value as DAOPermissions.public;

function initialize_dao:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    hash.bhp256 r0 into r7 as field;
    async initialize_dao r7 r0 r1 r2 r3 r4 r5 r6 self.caller into r8;
    output r8 as privadao_core_v1.aleo/initialize_dao.future;

finalize initialize_dao:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    cast r1 r2 r3 r4 r5 r6 r7 into r9 as DAOConfig;
    set r9 into dao_config[r0];
    cast r8 true true into r10 as DAOPermissions;
    set r10 into dao_permissions[r0];

function update_component_address:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as address.private;
    async update_component_address r0 r1 r2 self.caller into r3;
    output r3 as privadao_core_v1.aleo/update_component_address.future;

finalize update_component_address:
    input r0 as field.public;
    input r1 as u8.public;
    input r2 as address.public;
    input r3 as address.public;
    get dao_permissions[r0] into r4;
    is.eq r4.admin r3 into r5;
    and r5 r4.can_update_config into r6;
    assert.eq r6 true;
    get dao_config[r0] into r7;
    is.eq r1 1u8 into r8;
    branch.eq r8 false to end_then_0_0;
    cast r7.name r2 r7.proposal_address r7.voting_address r7.reputation_address r7.treasury_address r7.staking_address into r9 as DAOConfig;
    set r9 into dao_config[r0];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    is.eq r1 2u8 into r10;
    branch.eq r10 false to end_then_1_2;
    cast r7.name r7.token_address r2 r7.voting_address r7.reputation_address r7.treasury_address r7.staking_address into r11 as DAOConfig;
    set r11 into dao_config[r0];
    branch.eq true true to end_otherwise_1_3;
    position end_then_1_2;
    is.eq r1 3u8 into r12;
    branch.eq r12 false to end_then_2_4;
    cast r7.name r7.token_address r7.proposal_address r2 r7.reputation_address r7.treasury_address r7.staking_address into r13 as DAOConfig;
    set r13 into dao_config[r0];
    branch.eq true true to end_otherwise_2_5;
    position end_then_2_4;
    is.eq r1 4u8 into r14;
    branch.eq r14 false to end_then_3_6;
    cast r7.name r7.token_address r7.proposal_address r7.voting_address r2 r7.treasury_address r7.staking_address into r15 as DAOConfig;
    set r15 into dao_config[r0];
    branch.eq true true to end_otherwise_3_7;
    position end_then_3_6;
    is.eq r1 5u8 into r16;
    branch.eq r16 false to end_then_4_8;
    cast r7.name r7.token_address r7.proposal_address r7.voting_address r7.reputation_address r2 r7.staking_address into r17 as DAOConfig;
    set r17 into dao_config[r0];
    branch.eq true true to end_otherwise_4_9;
    position end_then_4_8;
    is.eq r1 6u8 into r18;
    branch.eq r18 false to end_then_5_10;
    cast r7.name r7.token_address r7.proposal_address r7.voting_address r7.reputation_address r7.treasury_address r2 into r19 as DAOConfig;
    set r19 into dao_config[r0];
    branch.eq true true to end_otherwise_5_11;
    position end_then_5_10;
    assert.eq false true;
    position end_otherwise_5_11;
    position end_otherwise_4_9;
    position end_otherwise_3_7;
    position end_otherwise_2_5;
    position end_otherwise_1_3;
    position end_otherwise_0_1;

function update_permissions:
    input r0 as field.private;
    input r1 as address.private;
    input r2 as boolean.private;
    input r3 as boolean.private;
    async update_permissions r0 r1 r2 r3 self.caller into r4;
    output r4 as privadao_core_v1.aleo/update_permissions.future;

finalize update_permissions:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as boolean.public;
    input r3 as boolean.public;
    input r4 as address.public;
    get dao_permissions[r0] into r5;
    is.eq r5.admin r4 into r6;
    and r6 r5.can_update_permissions into r7;
    assert.eq r7 true;
    cast r1 r2 r3 into r8 as DAOPermissions;
    set r8 into dao_permissions[r0];
