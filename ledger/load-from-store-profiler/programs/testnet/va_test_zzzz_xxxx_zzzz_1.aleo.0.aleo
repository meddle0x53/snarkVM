import credits.aleo;
import token_test_zzz_xxx_1.aleo;

program va_test_zzzz_xxxx_zzzz_1.aleo;

mapping current_nonce:
    key as address.public;
    value as u128.public;

function create_dai_public:
    input r0 as u64.public;
    input r1 as u128.public;
    call credits.aleo/transfer_public_as_signer va_test_zzzz_xxxx_zzzz_1.aleo r0 into r2;
    async create_dai_public r2 into r3;
    output r3 as va_test_zzzz_xxxx_zzzz_1.aleo/create_dai_public.future;

finalize create_dai_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    await r0;
