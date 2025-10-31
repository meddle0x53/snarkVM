import spectre_access_control_v1_001.aleo;

program spectre_acl_manager_v1_001.aleo;

function only_staking_admin:
    input r0 as address.public;
    call spectre_access_control_v1_001.aleo/check_role 1u8 r0 into r1;
    async only_staking_admin r1 into r2;
    output r2 as spectre_acl_manager_v1_001.aleo/only_staking_admin.future;

finalize only_staking_admin:
    input r0 as spectre_access_control_v1_001.aleo/check_role.future;
    await r0;

function only_staking_operator:
    input r0 as address.public;
    call spectre_access_control_v1_001.aleo/check_role 2u8 r0 into r1;
    async only_staking_operator r1 into r2;
    output r2 as spectre_acl_manager_v1_001.aleo/only_staking_operator.future;

finalize only_staking_operator:
    input r0 as spectre_access_control_v1_001.aleo/check_role.future;
    await r0;

function only_pool_admin:
    input r0 as address.public;
    call spectre_access_control_v1_001.aleo/check_role 3u8 r0 into r1;
    async only_pool_admin r1 into r2;
    output r2 as spectre_acl_manager_v1_001.aleo/only_pool_admin.future;

finalize only_pool_admin:
    input r0 as spectre_access_control_v1_001.aleo/check_role.future;
    await r0;

function only_emergency_admin:
    input r0 as address.public;
    call spectre_access_control_v1_001.aleo/check_role 4u8 r0 into r1;
    async only_emergency_admin r1 into r2;
    output r2 as spectre_acl_manager_v1_001.aleo/only_emergency_admin.future;

finalize only_emergency_admin:
    input r0 as spectre_access_control_v1_001.aleo/check_role.future;
    await r0;

function only_risk_admin:
    input r0 as address.public;
    call spectre_access_control_v1_001.aleo/check_role 5u8 r0 into r1;
    async only_risk_admin r1 into r2;
    output r2 as spectre_acl_manager_v1_001.aleo/only_risk_admin.future;

finalize only_risk_admin:
    input r0 as spectre_access_control_v1_001.aleo/check_role.future;
    await r0;

function only_asset_listing_admin:
    input r0 as address.public;
    call spectre_access_control_v1_001.aleo/check_role 6u8 r0 into r1;
    async only_asset_listing_admin r1 into r2;
    output r2 as spectre_acl_manager_v1_001.aleo/only_asset_listing_admin.future;

finalize only_asset_listing_admin:
    input r0 as spectre_access_control_v1_001.aleo/check_role.future;
    await r0;
