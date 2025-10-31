import credits.aleo;
import aleodai_stablecoin_0_0_3.aleo;
import aleodai_oracle_contract_0_0_5.aleo;
import aleodai_fee_contract_0_0_4.aleo;

program aleodai_vault_contract_0_0_5.aleo;

struct PriceFeed:
    price as u64;
    max_price as u64;
    min_price as u64;
    block_height as u64;

struct Loan:
    owner_address as address;
    collateral_amount as u64;
    dai_amount as u64;
    create_height as u64;
    closed as boolean;
    closed_height as u64;

mapping loans:
    key as u128.public;
    value as Loan.public;

mapping next_loan_id:
    key as u128.public;
    value as u128.public;

mapping fee_rate:
    key as u8.public;
    value as u64.public;

mapping admins:
    key as address.public;
    value as boolean.public;

function add_admin:
    input r0 as address.public;
    is.eq aleo14kavrjcne70pac5jfkgms7g95njp78jc2cs62lddv4k02ggwauxqzj622q self.caller into r1;
    assert.eq r1 true;
    async add_admin self.caller r0 into r2;
    output r2 as aleodai_vault_contract_0_0_5.aleo/add_admin.future;

finalize add_admin:
    input r0 as address.public;
    input r1 as address.public;
    set true into admins[r1];

function initialize:
    async initialize self.caller into r0;
    output r0 as aleodai_vault_contract_0_0_5.aleo/initialize.future;

finalize initialize:
    input r0 as address.public;
    get.or_use admins[r0] false into r1;
    assert.eq r1 true;
    set 100u64 into fee_rate[1u8];
    set 15000u64 into fee_rate[2u8];
    set 12000u64 into fee_rate[3u8];
    set 8000u64 into fee_rate[4u8];
    set 1000u64 into fee_rate[5u8];

function set_fee_rate:
    input r0 as u64.public;
    input r1 as u8.public;
    async set_fee_rate r0 r1 self.caller into r2;
    output r2 as aleodai_vault_contract_0_0_5.aleo/set_fee_rate.future;

finalize set_fee_rate:
    input r0 as u64.public;
    input r1 as u8.public;
    input r2 as address.public;
    get.or_use admins[r2] false into r3;
    assert.eq r3 true;
    lte r0 20000u64 into r4;
    assert.eq r4 true;
    set r0 into fee_rate[r1];

function create_dai_public:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u64.public;
    gt r1 0u64 into r4;
    gt r0 0u64 into r5;
    and r4 r5 into r6;
    assert.eq r6 true;
    cast r0 into r7 as u128;
    cast r3 into r8 as u128;
    mul r7 r8 into r9;
    mul r9 10000u128 into r10;
    cast r1 into r11 as u128;
    cast r2 into r12 as u128;
    mul r11 r12 into r13;
    mul r13 1000000u128 into r14;
    gte r10 r14 into r15;
    assert.eq r15 true;
    call credits.aleo/transfer_public_as_signer aleodai_vault_contract_0_0_5.aleo r0 into r16;
    call aleodai_stablecoin_0_0_3.aleo/mint_public self.caller r1 into r17;
    async create_dai_public r0 r1 r3 r2 self.caller r16 r17 into r18;
    output r18 as aleodai_vault_contract_0_0_5.aleo/create_dai_public.future;

finalize create_dai_public:
    input r0 as u64.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as address.public;
    input r5 as credits.aleo/transfer_public_as_signer.future;
    input r6 as aleodai_stablecoin_0_0_3.aleo/mint_public.future;
    await r5;
    await r6;
    get aleodai_oracle_contract_0_0_5.aleo/price_feed_latest[1u8] into r7;
    gte r2 r7.min_price into r8;
    lte r2 r7.max_price into r9;
    and r8 r9 into r10;
    assert.eq r10 true;
    get.or_use fee_rate[2u8] 0u64 into r11;
    assert.eq r3 r11;
    get.or_use next_loan_id[0u128] 0u128 into r12;
    add r12 1u128 into r13;
    set r13 into next_loan_id[0u128];
    cast block.height into r14 as u64;
    cast r4 r0 r1 r14 false 0u64 into r15 as Loan;
    set r15 into loans[r13];

function repay_loan:
    input r0 as u128.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    input r5 as u64.public;
    sub r5 r4 into r6;
    mul r1 r3 into r7;
    mul r7 r6 into r8;
    div.w r8 432000000u64 into r9;
    lte r9 r1 into r10;
    assert.eq r10 true;
    call aleodai_stablecoin_0_0_3.aleo/burn_public self.caller r2 into r11;
    sub r1 r9 into r12;
    call credits.aleo/transfer_public self.caller r12 into r13;
    call credits.aleo/transfer_public aleodai_fee_contract_0_0_4.aleo r9 into r14;
    call aleodai_fee_contract_0_0_4.aleo/deposit r9 into r15;
    async repay_loan r0 r1 r2 r3 r4 r5 self.caller r11 r13 r14 r15 into r16;
    output r16 as aleodai_vault_contract_0_0_5.aleo/repay_loan.future;

finalize repay_loan:
    input r0 as u128.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    input r5 as u64.public;
    input r6 as address.public;
    input r7 as aleodai_stablecoin_0_0_3.aleo/burn_public.future;
    input r8 as credits.aleo/transfer_public.future;
    input r9 as credits.aleo/transfer_public.future;
    input r10 as aleodai_fee_contract_0_0_4.aleo/deposit.future;
    await r7;
    await r8;
    await r9;
    await r10;
    add r5 100u64 into r11;
    cast block.height into r12 as u64;
    gt r11 r12 into r13;
    assert.eq r13 true;
    cast r6 0u64 0u64 0u64 true 0u64 into r14 as Loan;
    get.or_use loans[r0] r14 into r15;
    not r15.closed into r16;
    assert.eq r16 true;
    assert.eq r15.owner_address r6;
    assert.eq r15.collateral_amount r1;
    assert.eq r15.dai_amount r2;
    assert.eq r15.create_height r4;
    get.or_use fee_rate[1u8] 0u64 into r17;
    assert.eq r3 r17;
    cast block.height into r18 as u64;
    cast r15.owner_address r15.collateral_amount r15.dai_amount r15.create_height true r18 into r19 as Loan;
    set r19 into loans[r0];

function liquidate_loan:
    input r0 as u128.public;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    input r5 as u64.public;
    input r6 as u64.public;
    mul r1 r4 into r7;
    mul r7 10000u64 into r8;
    div r8 r2 into r9;
    lt r9 r3 into r10;
    assert.eq r10 true;
    mul r1 r5 into r11;
    div r11 10000u64 into r12;
    mul r1 r6 into r13;
    div r13 10000u64 into r14;
    gt r12 r14 into r15;
    assert.eq r15 true;
    call aleodai_fee_contract_0_0_4.aleo/deposit r14 into r16;
    call credits.aleo/transfer_public aleodai_fee_contract_0_0_4.aleo r14 into r17;
    sub r12 r14 into r18;
    call credits.aleo/transfer_public self.caller r18 into r19;
    call aleodai_stablecoin_0_0_3.aleo/burn_public self.caller r2 into r20;
    async liquidate_loan r0 self.caller r1 r2 r4 r5 r6 r3 r20 r19 r17 r16 into r21;
    output r21 as aleodai_vault_contract_0_0_5.aleo/liquidate_loan.future;

finalize liquidate_loan:
    input r0 as u128.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    input r4 as u64.public;
    input r5 as u64.public;
    input r6 as u64.public;
    input r7 as u64.public;
    input r8 as aleodai_stablecoin_0_0_3.aleo/burn_public.future;
    input r9 as credits.aleo/transfer_public.future;
    input r10 as credits.aleo/transfer_public.future;
    input r11 as aleodai_fee_contract_0_0_4.aleo/deposit.future;
    await r8;
    await r9;
    await r11;
    await r10;
    get.or_use fee_rate[4u8] 0u64 into r12;
    assert.eq r5 r12;
    get.or_use fee_rate[5u8] 0u64 into r13;
    assert.eq r6 r13;
    get.or_use fee_rate[3u8] 0u64 into r14;
    assert.eq r7 r14;
    get aleodai_oracle_contract_0_0_5.aleo/price_feed_latest[1u8] into r15;
    gte r4 r15.min_price into r16;
    lte r4 r15.max_price into r17;
    and r16 r17 into r18;
    assert.eq r18 true;
    cast r1 0u64 0u64 0u64 true 0u64 into r19 as Loan;
    get.or_use loans[r0] r19 into r20;
    not r20.closed into r21;
    assert.eq r21 true;
    assert.eq r20.dai_amount r3;
    assert.eq r20.collateral_amount r2;
    cast block.height into r22 as u64;
    cast r20.owner_address r20.collateral_amount r20.dai_amount r20.create_height true r22 into r23 as Loan;
    set r23 into loans[r0];
