program spectre_access_control_v1_001.aleo;

struct grant:
    account as address;
    role as u8;

mapping grants:
    key as field.public;
    value as boolean.public;

mapping role_admins:
    key as u8.public;
    value as u8.public;

mapping initialized:
    key as u8.public;
    value as boolean.public;

function initialize:
    assert.eq self.caller aleo1d2wn78575d4wlw5zk9yk09nsuy9nlq773tphmlrx8ghy2ah5zvrqae9umn;
    async initialize self.caller into r0;
    output r0 as spectre_access_control_v1_001.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    contains initialized[0u8] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set true into initialized[0u8];
    cast r0 0u8 into r3 as grant;
    hash.bhp256 r3 into r4 as field;
    set true into grants[r4];

function only_role:
    input r0 as u8.public;
    async only_role r0 self.caller into r1;
    output r1 as spectre_access_control_v1_001.aleo/only_role.future;

finalize only_role:
    input r0 as u8.public;
    input r1 as address.public;
    cast r1 r0 into r2 as grant;
    hash.bhp256 r2 into r3 as field;
    contains grants[r3] into r4;
    assert.eq r4 true;

function check_role:
    input r0 as u8.public;
    input r1 as address.public;
    async check_role r0 r1 into r2;
    output r2 as spectre_access_control_v1_001.aleo/check_role.future;

finalize check_role:
    input r0 as u8.public;
    input r1 as address.public;
    cast r1 r0 into r2 as grant;
    hash.bhp256 r2 into r3 as field;
    contains grants[r3] into r4;
    assert.eq r4 true;

function check_role_admin:
    input r0 as u8.public;
    input r1 as address.public;
    async check_role_admin r0 r1 into r2;
    output r2 as spectre_access_control_v1_001.aleo/check_role_admin.future;

finalize check_role_admin:
    input r0 as u8.public;
    input r1 as address.public;
    get.or_use role_admins[r0] 0u8 into r2;
    cast r1 r2 into r3 as grant;
    hash.bhp256 r3 into r4 as field;
    contains grants[r4] into r5;
    assert.eq r5 true;

function set_role_admin:
    input r0 as u8.public;
    input r1 as u8.public;
    async set_role_admin r0 r1 self.caller into r2;
    output r2 as spectre_access_control_v1_001.aleo/set_role_admin.future;

finalize set_role_admin:
    input r0 as u8.public;
    input r1 as u8.public;
    input r2 as address.public;
    cast r2 0u8 into r3 as grant;
    hash.bhp256 r3 into r4 as field;
    contains grants[r4] into r5;
    assert.eq r5 true;
    get.or_use role_admins[r0] 0u8 into r6;
    is.neq r6 r1 into r7;
    branch.eq r7 false to end_then_0_0;
    set r1 into role_admins[r0];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function grant_role:
    input r0 as u8.public;
    input r1 as address.public;
    async grant_role r0 r1 self.caller into r2;
    output r2 as spectre_access_control_v1_001.aleo/grant_role.future;

finalize grant_role:
    input r0 as u8.public;
    input r1 as address.public;
    input r2 as address.public;
    get.or_use role_admins[r0] 0u8 into r3;
    cast r2 r3 into r4 as grant;
    hash.bhp256 r4 into r5 as field;
    contains grants[r5] into r6;
    assert.eq r6 true;
    cast r1 r0 into r7 as grant;
    hash.bhp256 r7 into r8 as field;
    contains grants[r8] into r9;
    not r9 into r10;
    branch.eq r10 false to end_then_0_2;
    set true into grants[r8];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;

function revoke_role:
    input r0 as u8.public;
    input r1 as address.public;
    async revoke_role r0 r1 self.caller into r2;
    output r2 as spectre_access_control_v1_001.aleo/revoke_role.future;

finalize revoke_role:
    input r0 as u8.public;
    input r1 as address.public;
    input r2 as address.public;
    get.or_use role_admins[r0] 0u8 into r3;
    cast r2 r3 into r4 as grant;
    hash.bhp256 r4 into r5 as field;
    contains grants[r5] into r6;
    assert.eq r6 true;
    cast r1 r0 into r7 as grant;
    hash.bhp256 r7 into r8 as field;
    contains grants[r8] into r9;
    branch.eq r9 false to end_then_0_4;
    remove grants[r8];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    position end_otherwise_0_5;

function renounce_role:
    input r0 as u8.public;
    input r1 as address.public;
    assert.eq r1 self.caller;
    async renounce_role r0 r1 into r2;
    output r2 as spectre_access_control_v1_001.aleo/renounce_role.future;

finalize renounce_role:
    input r0 as u8.public;
    input r1 as address.public;
    cast r1 r0 into r2 as grant;
    hash.bhp256 r2 into r3 as field;
    contains grants[r3] into r4;
    branch.eq r4 false to end_then_0_6;
    remove grants[r3];
    branch.eq true true to end_otherwise_0_7;
    position end_then_0_6;
    position end_otherwise_0_7;
