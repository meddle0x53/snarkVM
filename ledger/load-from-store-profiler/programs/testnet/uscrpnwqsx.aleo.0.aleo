import rediwsozfo_v2.aleo;

program uscrpnwqsx.aleo;

struct MerkleProof:
    siblings as [field; 16u32];
    leaf_index as u32;

mapping freeze_list:
    key as address.public;
    value as boolean.public;

mapping freeze_list_index:
    key as u32.public;
    value as address.public;

mapping freeze_list_root:
    key as u8.public;
    value as field.public;

mapping admin:
    key as u8.public;
    value as address.public;

function update_admin_address:
    input r0 as address.private;
    async update_admin_address r0 self.caller into r1;
    output r1 as uscrpnwqsx.aleo/update_admin_address.future;

finalize update_admin_address:
    input r0 as address.public;
    input r1 as address.public;
    get.or_use admin[0u8] r1 into r2;
    assert.eq r2 r1;
    set r0 into admin[0u8];

function update_freeze_list:
    input r0 as address.private;
    input r1 as boolean.private;
    input r2 as u32.private;
    input r3 as field.private;
    async update_freeze_list r0 r1 r2 self.caller r3 into r4;
    output r4 as uscrpnwqsx.aleo/update_freeze_list.future;

finalize update_freeze_list:
    input r0 as address.public;
    input r1 as boolean.public;
    input r2 as u32.public;
    input r3 as address.public;
    input r4 as field.public;
    get admin[0u8] into r5;
    assert.eq r5 r3;
    set r1 into freeze_list[r0];
    ternary r1 r0 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r6;
    set r6 into freeze_list_index[r2];
    set r4 into freeze_list_root[0u8];

function verify_non_inclusion_pub:
    input r0 as address.private;
    async verify_non_inclusion_pub r0 into r1;
    output r1 as uscrpnwqsx.aleo/verify_non_inclusion_pub.future;

finalize verify_non_inclusion_pub:
    input r0 as address.public;
    get.or_use freeze_list[r0] false into r1;
    assert.eq r1 false;

function verify_non_inclusion_priv:
    input r0 as address.private;
    input r1 as [MerkleProof; 2u32].private;
    call rediwsozfo_v2.aleo/verify_non_inclusion r0 r1 into r2;
    async verify_non_inclusion_priv r2 into r3;
    output r3 as uscrpnwqsx.aleo/verify_non_inclusion_priv.future;

finalize verify_non_inclusion_priv:
    input r0 as field.public;
    get freeze_list_root[0u8] into r1;
    assert.eq r1 r0;
