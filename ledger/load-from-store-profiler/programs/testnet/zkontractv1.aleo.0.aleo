program zkontractv1.aleo;

mapping bounty_creator:
    key as u64.public;
    value as address.public;

mapping bounty_payment:
    key as u64.public;
    value as u64.public;

mapping bounty_status:
    key as u64.public;
    value as u8.public;

mapping proposal_bounty_id:
    key as u64.public;
    value as u64.public;

mapping proposal_proposer:
    key as u64.public;
    value as address.public;

mapping proposal_status:
    key as u64.public;
    value as u8.public;

mapping all_bounties:
    key as u64.public;
    value as boolean.public;

mapping bounty_output_payment:
    key as u64.public;
    value as u64.public;

mapping bounty_output_status:
    key as u64.public;
    value as u8.public;

function post_bounty:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as u64.private;
    assert.eq r0 r2;
    async post_bounty r1 r2 r3 into r4;
    output r4 as zkontractv1.aleo/post_bounty.future;

finalize post_bounty:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as u64.public;
    contains bounty_creator[r0] into r3;
    not r3 into r4;
    assert.eq r4 true;
    set r1 into bounty_creator[r0];
    set r2 into bounty_payment[r0];
    set 0u8 into bounty_status[r0];
    set true into all_bounties[r0];

function view_bounty_by_id:
    input r0 as u64.private;
    async view_bounty_by_id r0 into r1;
    output r1 as zkontractv1.aleo/view_bounty_by_id.future;

finalize view_bounty_by_id:
    input r0 as u64.public;
    contains bounty_creator[r0] into r1;
    assert.eq r1 true;
    get bounty_payment[r0] into r2;
    get bounty_status[r0] into r3;
    set r2 into bounty_output_payment[r0];
    set r3 into bounty_output_status[r0];

function submit_proposal:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as address.private;
    assert.eq r0 r3;
    mul r1 1000000u64 into r4;
    add r4 r2 into r5;
    async submit_proposal r5 r1 r3 into r6;
    output r6 as zkontractv1.aleo/submit_proposal.future;

finalize submit_proposal:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as address.public;
    contains bounty_creator[r1] into r3;
    assert.eq r3 true;
    contains proposal_bounty_id[r0] into r4;
    not r4 into r5;
    assert.eq r5 true;
    set r1 into proposal_bounty_id[r0];
    set r2 into proposal_proposer[r0];
    set 0u8 into proposal_status[r0];

function accept_proposal:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as address.private;
    mul r1 1000000u64 into r4;
    add r4 r2 into r5;
    async accept_proposal r1 r5 into r6;
    output r6 as zkontractv1.aleo/accept_proposal.future;

finalize accept_proposal:
    input r0 as u64.public;
    input r1 as u64.public;
    contains bounty_creator[r0] into r2;
    assert.eq r2 true;
    contains proposal_bounty_id[r1] into r3;
    assert.eq r3 true;
    set 1u8 into bounty_status[r0];
    set 1u8 into proposal_status[r1];

function delete_bounty:
    input r0 as address.private;
    input r1 as u64.private;
    async delete_bounty r1 into r2;
    output r2 as zkontractv1.aleo/delete_bounty.future;

finalize delete_bounty:
    input r0 as u64.public;
    contains bounty_creator[r0] into r1;
    assert.eq r1 true;
    remove bounty_creator[r0];
    remove bounty_payment[r0];
    remove bounty_status[r0];
