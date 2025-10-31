import puzzle_arcade_ticket_testing.aleo;

program mint_sorcerer_v1.aleo;

function mint_ticket:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller aleo1pkuty394j0000uedtqpazp4qejwmn2yshaac6qjr6wll25m9a5psuggt6d;
    call puzzle_arcade_ticket_testing.aleo/mint r0 r1 into r2 r3;
    async mint_ticket r3 into r4;
    output r2 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r4 as mint_sorcerer_v1.aleo/mint_ticket.future;

finalize mint_ticket:
    input r0 as puzzle_arcade_ticket_testing.aleo/mint.future;
    await r0;
