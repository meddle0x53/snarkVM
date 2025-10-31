import izar_protocol_v1.aleo;
import izar_token_v1.aleo;

program izar_proxy_v1.aleo;

struct Nonce:
    chain_id as u32;
    nonce as u128;

struct IzarRecvMsg:
    protocol_addr as address;
    nonce as u128;
    to_addr as address;
    from_chain_id as u32;
    from_asset_addr as field;
    token_id as field;
    amount as u128;

struct Account:
    holder as address;
    token_id as field;

struct IzarTokenMeta:
    from_chain_id as u32;
    from_asset_addr as field;

struct IzarCrossMsg:
    to_chain_id as u32;
    to_addr as field;
    to_asset_addr as field;
    token_id as field;
    amount as u128;
    fee as u128;

mapping pending_tx:
    key as field.public;
    value as u32.public;

mapping blacklist:
    key as address.public;
    value as boolean.public;

function receive_payload:
    input r0 as [signature; 20u32].private;
    input r1 as [address; 20u32].private;
    input r2 as IzarRecvMsg.private;
    call izar_token_v1.aleo/verify_token r2.token_id r2.from_chain_id r2.from_asset_addr into r3;
    call izar_protocol_v1.aleo/verify r0 r1 r2 into r4;
    call izar_token_v1.aleo/mint_public r2.to_addr r2.amount r2.token_id into r5;
    async receive_payload r3 r4 r5 into r6;
    output r6 as izar_proxy_v1.aleo/receive_payload.future;

finalize receive_payload:
    input r0 as izar_token_v1.aleo/verify_token.future;
    input r1 as izar_protocol_v1.aleo/verify.future;
    input r2 as izar_token_v1.aleo/mint_public.future;
    await r0;
    await r1;
    await r2;

function cross_public:
    input r0 as IzarCrossMsg.public;
    hash.bhp256 r0 into r1 as field;
    gte r0.amount 3000000000000000000u128 into r2;
    call izar_token_v1.aleo/verify_token r0.token_id r0.to_chain_id r0.to_asset_addr into r3;
    call izar_token_v1.aleo/burn_public self.caller r0.amount r0.token_id into r4;
    call izar_token_v1.aleo/mint_public aleo1fmf9tha3nduaz57yq5lt43d55h0d3kfzyhh0jlkpqumyds3ssvgqj9mtut r0.fee r0.token_id into r5;
    async cross_public r1 r2 self.caller r3 r4 r5 into r6;
    output r6 as izar_proxy_v1.aleo/cross_public.future;

finalize cross_public:
    input r0 as field.public;
    input r1 as boolean.public;
    input r2 as address.public;
    input r3 as izar_token_v1.aleo/verify_token.future;
    input r4 as izar_token_v1.aleo/burn_public.future;
    input r5 as izar_token_v1.aleo/mint_public.future;
    get.or_use blacklist[r2] true into r6;
    assert.eq r6 true;
    branch.eq r1 false to end_then_0_0;
    contains pending_tx[r0] into r7;
    assert.eq r7 true;
    get pending_tx[r0] into r8;
    gte block.height r8 into r9;
    assert.eq r9 true;
    remove pending_tx[r0];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    await r3;
    await r4;
    await r5;

function upgrade:
    input r0 as address.public;
    assert.eq self.caller aleo1fmf9tha3nduaz57yq5lt43d55h0d3kfzyhh0jlkpqumyds3ssvgqj9mtut;
    call izar_token_v1.aleo/transfer_ownership r0 into r1;
    async upgrade r1 into r2;
    output r2 as izar_proxy_v1.aleo/upgrade.future;

finalize upgrade:
    input r0 as izar_token_v1.aleo/transfer_ownership.future;
    await r0;

function proxy_regist_token:
    input r0 as IzarTokenMeta.private;
    assert.eq self.caller aleo1fmf9tha3nduaz57yq5lt43d55h0d3kfzyhh0jlkpqumyds3ssvgqj9mtut;
    call izar_token_v1.aleo/regist_token r0 into r1;
    async proxy_regist_token r1 into r2;
    output r2 as izar_proxy_v1.aleo/proxy_regist_token.future;

finalize proxy_regist_token:
    input r0 as izar_token_v1.aleo/regist_token.future;
    await r0;

function pending:
    input r0 as IzarCrossMsg.private;
    gte r0.amount 3000000000000000000u128 into r1;
    assert.eq r1 true;
    hash.bhp256 r0 into r2 as field;
    async pending r2 into r3;
    output r3 as izar_proxy_v1.aleo/pending.future;

finalize pending:
    input r0 as field.public;
    add block.height 8640u32 into r1;
    set r1 into pending_tx[r0];

function add_blacklist:
    input r0 as address.private;
    assert.eq self.caller aleo1fmf9tha3nduaz57yq5lt43d55h0d3kfzyhh0jlkpqumyds3ssvgqj9mtut;
    async add_blacklist r0 into r1;
    output r1 as izar_proxy_v1.aleo/add_blacklist.future;

finalize add_blacklist:
    input r0 as address.public;
    set false into blacklist[r0];
