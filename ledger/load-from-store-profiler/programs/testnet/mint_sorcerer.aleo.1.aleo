import puzzle_arcade_ticket_testing.aleo;

program mint_sorcerer.aleo;

function mint_ticket:
    input r0 as address.public;
    assert.eq self.caller aleo1pkuty394j0000uedtqpazp4qejwmn2yshaac6qjr6wll25m9a5psuggt6d;
    call puzzle_arcade_ticket_testing.aleo/mint r0 1u64 into r1 r2;
    async mint_ticket r2 into r3;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r3 as mint_sorcerer.aleo/mint_ticket.future;

finalize mint_ticket:
    input r0 as puzzle_arcade_ticket_testing.aleo/mint.future;
    await r0;
