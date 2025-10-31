program arcn_access_manager.aleo;

record Access:
    owner as address.private;
    access_id as field.private;
    is_able_to_grant as boolean.private;
    is_able_to_revoke as boolean.private;

mapping public_access:
    key as address.public;
    value as boolean.public;

mapping grant_ability:
    key as address.public;
    value as boolean.public;

mapping revoke_ability:
    key as address.public;
    value as boolean.public;

mapping ban_list:
    key as field.public;
    value as boolean.public;

function check_access_private:
    input r0 as Access.record;
    cast r0.owner r0.access_id r0.is_able_to_grant r0.is_able_to_revoke into r1 as Access.record;
    async check_access_private r0.access_id into r2;
    output r1 as Access.record;
    output r2 as arcn_access_manager.aleo/check_access_private.future;

finalize check_access_private:
    input r0 as field.public;
    get.or_use ban_list[r0] false into r1;
    not r1 into r2;
    assert.eq r2 true;

function check_access_public:
    input r0 as address.public;
    async check_access_public r0 into r1;
    output r1 as arcn_access_manager.aleo/check_access_public.future;

finalize check_access_public:
    input r0 as address.public;
    is.neq r0 aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px into r1;
    branch.eq r1 false to end_then_0_0;
    get.or_use public_access[r0] false into r2;
    assert.eq r2 true;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    get.or_use public_access[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px] true into r3;
    assert.eq r3 true;
    position end_otherwise_0_1;

function grant_private:
    input r0 as Access.record;
    input r1 as address.private;
    input r2 as field.public;
    input r3 as boolean.private;
    input r4 as boolean.private;
    assert.eq r0.is_able_to_grant true;
    cast r0.owner r0.access_id r0.is_able_to_grant r0.is_able_to_revoke into r5 as Access.record;
    cast r1 r2 r3 r4 into r6 as Access.record;
    async grant_private r0.access_id r1 into r7;
    output r5 as Access.record;
    output r6 as Access.record;
    output r7 as arcn_access_manager.aleo/grant_private.future;

finalize grant_private:
    input r0 as field.public;
    input r1 as address.public;
    get.or_use ban_list[r0] false into r2;
    not r2 into r3;
    assert.eq r3 true;
    set true into public_access[r1];

function grant_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as boolean.public;
    input r3 as boolean.public;
    cast r0 r1 r2 r3 into r4 as Access.record;
    async grant_public self.caller r0 r2 r3 into r5;
    output r4 as Access.record;
    output r5 as arcn_access_manager.aleo/grant_public.future;

finalize grant_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as boolean.public;
    input r3 as boolean.public;
    is.eq r0 aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px into r4;
    not r4 into r5;
    branch.eq r5 false to end_then_0_2;
    get.or_use public_access[r0] false into r6;
    assert.eq r6 true;
    get.or_use grant_ability[r0] false into r7;
    assert.eq r7 true;
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    get.or_use public_access[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px] true into r8;
    assert.eq r8 true;
    get.or_use grant_ability[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px] true into r9;
    assert.eq r9 true;
    position end_otherwise_0_3;
    set true into public_access[r1];
    set r2 into grant_ability[r1];
    set r3 into revoke_ability[r1];

function revoke_private:
    input r0 as Access.record;
    input r1 as field.public;
    input r2 as address.public;
    assert.eq r0.is_able_to_revoke true;
    cast r0.owner r0.access_id r0.is_able_to_grant r0.is_able_to_revoke into r3 as Access.record;
    async revoke_private r0.access_id r1 r2 into r4;
    output r3 as Access.record;
    output r4 as arcn_access_manager.aleo/revoke_private.future;

finalize revoke_private:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as address.public;
    get.or_use ban_list[r0] false into r3;
    not r3 into r4;
    assert.eq r4 true;
    set false into public_access[r2];
    set true into ban_list[r1];
    set false into grant_ability[r2];
    set false into revoke_ability[r2];

function revoke_public:
    input r0 as field.public;
    input r1 as address.public;
    async revoke_public self.caller r0 r1 into r2;
    output r2 as arcn_access_manager.aleo/revoke_public.future;

finalize revoke_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    is.eq r0 aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px into r3;
    not r3 into r4;
    branch.eq r4 false to end_then_0_4;
    get.or_use public_access[r0] false into r5;
    assert.eq r5 true;
    get.or_use revoke_ability[r0] false into r6;
    assert.eq r6 true;
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    get.or_use public_access[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px] true into r7;
    assert.eq r7 true;
    get.or_use revoke_ability[aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px] true into r8;
    assert.eq r8 true;
    position end_otherwise_0_5;
    set false into public_access[r2];
    set true into ban_list[r1];
    set false into grant_ability[r2];
    set false into revoke_ability[r2];
