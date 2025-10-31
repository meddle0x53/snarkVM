import credits.aleo;

program vlink_holding_cd_v2.aleo;

struct Holder:
    account as address;
    token_id as field;

mapping holdings:
    key as Holder.public;
    value as u64.public;

mapping owner_holding:
    key as boolean.public;
    value as address.public;

function initialize_holding:
    input r0 as address.public;
    assert.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px;
    async initialize_holding r0 into r1;
    output r1 as vlink_holding_cd_v2.aleo/initialize_holding.future;

finalize initialize_holding:
    input r0 as address.public;
    contains owner_holding[true] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into owner_holding[true];

function transfer_ownership_holding:
    input r0 as address.public;
    async transfer_ownership_holding self.caller r0 into r1;
    output r1 as vlink_holding_cd_v2.aleo/transfer_ownership_holding.future;

finalize transfer_ownership_holding:
    input r0 as address.public;
    input r1 as address.public;
    get owner_holding[true] into r2;
    assert.eq r0 r2;
    set r1 into owner_holding[true];

function hold_fund:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 3443843282313283355522573239085696902919850365217539366784739393210722344986field into r2 as Holder;
    async hold_fund self.caller r2 r1 into r3;
    output r3 as vlink_holding_cd_v2.aleo/hold_fund.future;

finalize hold_fund:
    input r0 as address.public;
    input r1 as Holder.public;
    input r2 as u64.public;
    get owner_holding[true] into r3;
    assert.eq r0 r3;
    get.or_use holdings[r1] 0u64 into r4;
    add r4 r2 into r5;
    set r5 into holdings[r1];

function release_fund:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public r0 r1 into r2;
    cast r0 3443843282313283355522573239085696902919850365217539366784739393210722344986field into r3 as Holder;
    async release_fund self.caller r3 r1 r2 into r4;
    output r4 as vlink_holding_cd_v2.aleo/release_fund.future;

finalize release_fund:
    input r0 as address.public;
    input r1 as Holder.public;
    input r2 as u64.public;
    input r3 as credits.aleo/transfer_public.future;
    await r3;
    get owner_holding[true] into r4;
    assert.eq r0 r4;
    get holdings[r1] into r5;
    sub r5 r2 into r6;
    set r6 into holdings[r1];
