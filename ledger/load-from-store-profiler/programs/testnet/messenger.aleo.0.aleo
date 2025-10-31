program messenger.aleo;

record Message:
    owner as address.private;
    msg as [field; 8u32].private;
    sender as address.private;

function send:
    input r0 as address.private;
    input r1 as [field; 8u32].private;
    cast r0 r1 self.caller into r2 as Message.record;
    output r2 as Message.record;
