import credits.aleo;

program snarkcollective_program.aleo;

struct Round:
    round_id as u32;
    is_active as boolean;
    approved_projects as u16;
    submitted_projects as u16;

struct ProjectKey:
    round_id as u32;
    project_index as u16;

struct ProjectDetails:
    title as field;
    img as field;
    description as field;

struct ProjectInfo:
    project_owner as address;
    collected_amount as u64;
    joined_round as u32;
    num_supporters as u32;
    is_approved as boolean;
    is_claimed as boolean;
    project_details as ProjectDetails;

mapping rounds:
    key as u8.public;
    value as Round.public;

mapping project_details_submitted:
    key as field.public;
    value as ProjectInfo.public;

mapping project_details_approved:
    key as field.public;
    value as ProjectInfo.public;

mapping project_amount_approved:
    key as u32.public;
    value as u16.public;

mapping project_amount_submitted:
    key as u32.public;
    value as u16.public;

function init_round:
    assert.eq self.caller aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu;
    async init_round into r0;
    output r0 as snarkcollective_program.aleo/init_round.future;

finalize init_round:
    cast 0u32 false 0u16 0u16 into r0 as Round;
    set r0 into rounds[1u8];

function start_round:
    assert.eq self.caller aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu;
    async start_round into r0;
    output r0 as snarkcollective_program.aleo/start_round.future;

finalize start_round:
    get rounds[1u8] into r0;
    assert.eq false r0.is_active;
    cast r0.round_id true r0.submitted_projects r0.submitted_projects into r1 as Round;
    set r1 into rounds[1u8];

function finish_round:
    assert.eq self.caller aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu;
    async finish_round into r0;
    output r0 as snarkcollective_program.aleo/finish_round.future;

finalize finish_round:
    get rounds[1u8] into r0;
    assert.eq false r0.is_active;
    add r0.round_id 1u32 into r1;
    cast r1 false 0u16 0u16 into r2 as Round;
    set r2 into rounds[1u8];

function submit_project:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as u32.private;
    input r4 as u16.private;
    cast r3 r4 into r5 as ProjectKey;
    hash.bhp256 r5 into r6 as field;
    cast r0 r1 r2 into r7 as ProjectDetails;
    cast self.caller 0u64 r3 0u32 false false r7 into r8 as ProjectInfo;
    async submit_project self.caller r6 r3 r4 r8 into r9;
    output r9 as snarkcollective_program.aleo/submit_project.future;

finalize submit_project:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as u32.public;
    input r3 as u16.public;
    input r4 as ProjectInfo.public;
    get rounds[1u8] into r5;
    assert.eq false r5.is_active;
    add r5.submitted_projects 1u16 into r6;
    assert.eq r3 r6;
    assert.eq r2 r5.round_id;
    add r5.submitted_projects 1u16 into r7;
    cast r2 false r5.approved_projects r7 into r8 as Round;
    set r8 into rounds[1u8];
    add r5.submitted_projects 1u16 into r9;
    set r9 into project_amount_submitted[r2];
    set r4 into project_details_submitted[r1];

function approve_project:
    input r0 as field.private;
    input r1 as ProjectInfo.private;
    assert.eq self.caller aleo1pqcumqvf0vjqq800uuyaqqt6s2q6dxcgglywhf6dpzac2cmjgu8q2876eu;
    async approve_project r0 into r2;
    output r2 as snarkcollective_program.aleo/approve_project.future;

finalize approve_project:
    input r0 as field.public;
    get project_details_submitted[r0] into r1;
    get rounds[1u8] into r2;
    assert.eq r1.joined_round r2.round_id;
    assert.eq false r2.is_active;
    add r2.approved_projects 1u16 into r3;
    cast r2.round_id false r3 r2.submitted_projects into r4 as Round;
    set r4 into rounds[1u8];
    add r2.approved_projects 1u16 into r5;
    set r5 into project_amount_approved[r2.round_id];
    cast r1.project_owner r1.collected_amount r1.joined_round r1.num_supporters true false r1.project_details into r6 as ProjectInfo;
    set r6 into project_details_approved[r0];

function donate_public:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as address.private;
    assert.eq self.signer r2;
    call credits.aleo/transfer_public_as_signer snarkcollective_program.aleo r1 into r3;
    async donate_public r3 r0 r1 into r4;
    output r4 as snarkcollective_program.aleo/donate_public.future;

finalize donate_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as field.public;
    input r2 as u64.public;
    await r0;
    get project_details_approved[r1] into r3;
    get rounds[1u8] into r4;
    assert.eq r3.joined_round r4.round_id;
    assert.eq true r4.is_active;
    assert.eq true r3.is_approved;
    add r3.collected_amount r2 into r5;
    cast r3.project_owner r5 r3.joined_round r3.num_supporters true false r3.project_details into r6 as ProjectInfo;
    set r6 into project_details_approved[r1];

function donate_private:
    input r0 as credits.aleo/credits.record;
    input r1 as u64.private;
    input r2 as field.private;
    input r3 as address.private;
    assert.eq self.signer r3;
    call credits.aleo/transfer_private r0 snarkcollective_program.aleo r1 into r4 r5;
    async donate_private r2 r1 into r6;
    output r4 as credits.aleo/credits.record;
    output r5 as credits.aleo/credits.record;
    output r6 as snarkcollective_program.aleo/donate_private.future;

finalize donate_private:
    input r0 as field.public;
    input r1 as u64.public;
    get project_details_approved[r0] into r2;
    get rounds[1u8] into r3;
    assert.eq r2.joined_round r3.round_id;
    assert.eq true r3.is_active;
    assert.eq true r2.is_approved;
    add r2.collected_amount r1 into r4;
    cast r2.project_owner r4 r2.joined_round r2.num_supporters true false r2.project_details into r5 as ProjectInfo;
    set r5 into project_details_approved[r0];

function claim_public:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as address.private;
    assert.eq self.signer r2;
    call credits.aleo/transfer_public r2 r1 into r3;
    async claim_public r3 r0 r1 self.signer into r4;
    output r4 as snarkcollective_program.aleo/claim_public.future;

finalize claim_public:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as field.public;
    input r2 as u64.public;
    input r3 as address.public;
    get project_details_approved[r1] into r4;
    get rounds[1u8] into r5;
    add r5.round_id 1u32 into r6;
    assert.eq r4.joined_round r6;
    assert.eq false r5.is_active;
    assert.eq true r4.is_approved;
    assert.eq false r4.is_claimed;
    assert.eq r3 r4.project_owner;
    assert.eq r2 r4.collected_amount;
    await r0;
    cast r4.project_owner r4.collected_amount r4.joined_round r4.num_supporters true true r4.project_details into r7 as ProjectInfo;
    set r7 into project_details_approved[r1];
