import arcn_access_manager_v1.aleo;

program arcn_whitelist.aleo;

mapping whitelist:
    key as address.public;
    value as boolean.public;

mapping settings:
    key as field.public;
    value as field.public;

function initialize:
    async initialize into r0;
    output r0 as arcn_whitelist.aleo/initialize.future;

finalize initialize:
    get.or_use settings[0field] 0field into r0;
    is.neq r0 1field into r1;
    branch.eq r1 false to end_then_0_0;
    set 1field into settings[1field];
    set true into whitelist[arcn_pub_v2_2_1.aleo];
    set true into whitelist[arcn_priv_v2_2_1.aleo];
    set true into whitelist[arcn_credits_in_helper_v2_2_1.aleo];
    set true into whitelist[arcn_credits_out_helper_v2_2_1.aleo];
    set 1field into settings[0field];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function whitelist_caller:
    input r0 as address.private;
    input r1 as boolean.private;
    cast 0field into r2 as address;
    assert.neq r0 r2;
    call arcn_access_manager_v1.aleo/check_access_public self.caller into r3;
    async whitelist_caller r3 r0 r1 into r4;
    output r4 as arcn_whitelist.aleo/whitelist_caller.future;

finalize whitelist_caller:
    input r0 as arcn_access_manager_v1.aleo/check_access_public.future;
    input r1 as address.public;
    input r2 as boolean.public;
    await r0;
    set r2 into whitelist[r1];

function toggle_whitelist:
    input r0 as boolean.private;
    call arcn_access_manager_v1.aleo/check_access_public self.caller into r1;
    async toggle_whitelist r1 r0 into r2;
    output r2 as arcn_whitelist.aleo/toggle_whitelist.future;

finalize toggle_whitelist:
    input r0 as arcn_access_manager_v1.aleo/check_access_public.future;
    input r1 as boolean.public;
    await r0;
    ternary r1 1field 0field into r2;
    set r2 into settings[1field];

function is_caller_eligible:
    input r0 as address.public;
    async is_caller_eligible r0 into r1;
    output r1 as arcn_whitelist.aleo/is_caller_eligible.future;

finalize is_caller_eligible:
    input r0 as address.public;
    get settings[1field] into r1;
    is.eq r1 1field into r2;
    branch.eq r2 false to end_then_0_2;
    get.or_use whitelist[r0] false into r3;
    assert.eq r3 true;
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
