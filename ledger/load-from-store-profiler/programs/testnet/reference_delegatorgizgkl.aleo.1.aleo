import credits.aleo;
import pondo_oraclev1.aleo;

program reference_delegatorgizgkl.aleo;

struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;

mapping initialized:
    key as u8.public;
    value as u8.public;

function initialize:
    assert.eq self.caller aleo1mgjcqhnar38zvschjwxr830pwk57ywnce8rp7smf8c3yp2xexvgq40d4fx;
    call credits.aleo/transfer_public_as_signer reference_delegatorgizgkl.aleo 10000000000u64 into r0;
    call credits.aleo/bond_public aleo1l2a3lakq9pz9w9hyre7rk9zmk64wzr62z0q26wglr8tmf8w5cyqqxtt364 reference_delegatorgizgkl.aleo 10000000000u64 into r1;
    call pondo_oraclev1.aleo/propose_delegator aleo1l2a3lakq9pz9w9hyre7rk9zmk64wzr62z0q26wglr8tmf8w5cyqqxtt364 into r2;
    async initialize r0 r1 r2 into r3;
    output r3 as reference_delegatorgizgkl.aleo/initialize.future;

finalize initialize:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as pondo_oraclev1.aleo/propose_delegator.future;
    await r0;
    await r1;
    await r2;
    contains initialized[0u8] into r3;
    assert.eq r3 false;
    set 8u8 into initialized[0u8];

function remove:
    input r0 as u64.public;
    assert.eq self.caller aleo1mgjcqhnar38zvschjwxr830pwk57ywnce8rp7smf8c3yp2xexvgq40d4fx;
    call credits.aleo/unbond_public reference_delegatorgizgkl.aleo r0 into r1;
    call pondo_oraclev1.aleo/remove_delegator into r2;
    async remove r1 r2 into r3;
    output r3 as reference_delegatorgizgkl.aleo/remove.future;

finalize remove:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as pondo_oraclev1.aleo/remove_delegator.future;
    await r0;
    await r1;
    contains credits.aleo/bonded[reference_delegatorgizgkl.aleo] into r2;
    assert.eq r2 false;

function withdraw:
    input r0 as u64.private;
    call credits.aleo/transfer_public aleo1mgjcqhnar38zvschjwxr830pwk57ywnce8rp7smf8c3yp2xexvgq40d4fx r0 into r1;
    async withdraw r1 into r2;
    output r2 as reference_delegatorgizgkl.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
    get.or_use credits.aleo/account[reference_delegatorgizgkl.aleo] 0u64 into r1;
    assert.eq r1 0u64;
