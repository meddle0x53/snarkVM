import official_oracle.aleo;
import perp_oracle_v0_1.aleo;
import config_perps_v2.aleo;
import pool_perps_v2.aleo;
import btc_perps_v2.aleo;

program btc_wrapper_perps_v2.aleo;

struct DataChunk:
    f0 as u128;
    f1 as u128;
    f2 as u128;
    f3 as u128;
    f4 as u128;
    f5 as u128;
    f6 as u128;
    f7 as u128;
    f8 as u128;
    f9 as u128;
    f10 as u128;
    f11 as u128;
    f12 as u128;
    f13 as u128;
    f14 as u128;
    f15 as u128;
    f16 as u128;
    f17 as u128;
    f18 as u128;
    f19 as u128;
    f20 as u128;
    f21 as u128;
    f22 as u128;
    f23 as u128;
    f24 as u128;
    f25 as u128;
    f26 as u128;
    f27 as u128;
    f28 as u128;
    f29 as u128;
    f30 as u128;
    f31 as u128;

struct Report:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;
    c8 as DataChunk;
    c9 as DataChunk;

struct ReportData:
    c0 as DataChunk;
    c1 as DataChunk;
    c2 as DataChunk;
    c3 as DataChunk;
    c4 as DataChunk;
    c5 as DataChunk;
    c6 as DataChunk;
    c7 as DataChunk;

struct TokenId:
    base as address;
    creator as address;
    salt as u128;

function init_wrapper:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u8.public;
    call pool_perps_v2.aleo/create_token r0 r1 r2 0u128 btc_wrapper_perps_v2.aleo 1u128 into r3;
    async init_wrapper r3 into r4;
    output r4 as btc_wrapper_perps_v2.aleo/init_wrapper.future;

finalize init_wrapper:
    input r0 as pool_perps_v2.aleo/create_token.future;
    await r0;

function wrap_public:
    input r0 as u128.public;
    input r1 as address.public;
    call btc_perps_v2.aleo/transfer_from_public self.caller btc_wrapper_perps_v2.aleo r0 into r2;
    cast pool_perps_v2.aleo btc_wrapper_perps_v2.aleo 1u128 into r3 as TokenId;
    hash.bhp256 r3 into r4 as field;
    call pool_perps_v2.aleo/mint r4 r1 r0 into r5;
    async wrap_public r2 r5 into r6;
    output r6 as btc_wrapper_perps_v2.aleo/wrap_public.future;

finalize wrap_public:
    input r0 as btc_perps_v2.aleo/transfer_from_public.future;
    input r1 as pool_perps_v2.aleo/mint.future;
    await r0;
    await r1;

function unwrap_public:
    input r0 as u128.public;
    input r1 as address.public;
    cast pool_perps_v2.aleo btc_wrapper_perps_v2.aleo 1u128 into r2 as TokenId;
    hash.bhp256 r2 into r3 as field;
    call pool_perps_v2.aleo/burn_from r3 self.caller r0 into r4;
    call btc_perps_v2.aleo/transfer_public r1 r0 into r5;
    async unwrap_public r4 r5 into r6;
    output r6 as btc_wrapper_perps_v2.aleo/unwrap_public.future;

finalize unwrap_public:
    input r0 as pool_perps_v2.aleo/burn_from.future;
    input r1 as btc_perps_v2.aleo/transfer_public.future;
    await r0;
    await r1;
