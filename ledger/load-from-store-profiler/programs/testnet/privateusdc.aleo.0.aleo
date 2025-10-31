program privateusdc.aleo;

record Stablecoin:
    owner as address.private;
    amount as u64.private;
    compliance_tag as u8.private;

function mint:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as u64.public;
    assert.eq r0 aleo1uc6jphye8y9gfqtezrz240ak963sdgugd7s96qpuw6k7jz9axs8q2qnhxc;
    cast r1 r2 0u8 into r3 as Stablecoin.record;
    output r3 as Stablecoin.record;

function burn:
    input r0 as Stablecoin.record;
    output r0.amount as u64.public;

function transfer:
    input r0 as Stablecoin.record;
    input r1 as address.private;
    input r2 as u64.private;
    gte r0.amount r2 into r3;
    assert.eq r3 true;
    sub r0.amount r2 into r4;
    cast r0.owner r4 r0.compliance_tag into r5 as Stablecoin.record;
    cast r1 r2 0u8 into r6 as Stablecoin.record;
    output r5 as Stablecoin.record;
    output r6 as Stablecoin.record;

function flag_compliance:
    input r0 as address.public;
    input r1 as Stablecoin.record;
    assert.eq r0 aleo1uc6jphye8y9gfqtezrz240ak963sdgugd7s96qpuw6k7jz9axs8q2qnhxc;
    cast r1.owner r1.amount 1u8 into r2 as Stablecoin.record;
    output r2 as Stablecoin.record;
