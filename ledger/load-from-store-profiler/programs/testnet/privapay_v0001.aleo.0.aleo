import credits.aleo;
import token_registry.aleo;

program privapay_v0001.aleo;

record Employee:
    owner as address.private;
    company_id as field.private;
    employee_id as field.private;
    amount as u128.private;
    token_id as field.private;
    start_date as u32.private;
    end_date as u32.private;
    claimable_salary as u128.private;

record EmpRecForAdmin:
    owner as address.private;
    company_id as field.private;
    employee_id as field.private;
    employee_address as address.private;
    amount as u128.private;

struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;

struct EmployeeSignatureInfo:
    company_id as field;
    employee_id as field;
    employee_address as address;
    token_id as field;
    salary as u128;
    start_period as u32;
    end_period as u32;

struct EmployeeInfo:
    company_id as field;
    employee_id as field;
    employee_address as address;
    token_id as field;

struct CompanyMetadata:
    company_id as field;
    company_name as u128;
    admin as address;

mapping registered_company:
    key as field.public;
    value as CompanyMetadata.public;

mapping is_employee_registered:
    key as field.public;
    value as boolean.public;

mapping is_employee_active:
    key as field.public;
    value as boolean.public;

mapping total_claimed:
    key as field.public;
    value as u128.public;

mapping latest_claim:
    key as field.public;
    value as u32.public;

mapping admin_signature:
    key as field.public;
    value as signature.public;

function register_company:
    input r0 as field.public;
    input r1 as u128.public;
    cast r0 r1 self.caller into r2 as CompanyMetadata;
    async register_company r2 into r3;
    output r3 as privapay_v0001.aleo/register_company.future;

finalize register_company:
    input r0 as CompanyMetadata.public;
    contains registered_company[r0.company_id] into r1;
    assert.eq r1 false;
    set r0 into registered_company[r0.company_id];

function update_company:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    async update_company r0 r1 r2 self.caller into r3;
    output r3 as privapay_v0001.aleo/update_company.future;

finalize update_company:
    input r0 as field.public;
    input r1 as u128.public;
    input r2 as address.public;
    input r3 as address.public;
    get registered_company[r0] into r4;
    assert.eq r3 r4.admin;
    cast r4.company_id r1 r2 into r5 as CompanyMetadata;
    set r5 into registered_company[r0];

function add_employee:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as u128.private;
    input r4 as field.private;
    input r5 as u32.private;
    input r6 as u32.private;
    call token_registry.aleo/transfer_public_as_signer r4 privapay_v0001.aleo r3 into r7;
    gt r6 r5 into r8;
    assert.eq r8 true;
    cast r2 r0 r1 r3 r4 r5 r6 r3 into r9 as Employee.record;
    cast self.signer r0 r1 r2 r3 into r10 as EmpRecForAdmin.record;
    cast r0 r1 r2 r4 into r11 as EmployeeInfo;
    hash.bhp256 r11 into r12 as field;
    async add_employee r0 r12 r5 r6 self.signer r7 into r13;
    output r9 as Employee.record;
    output r10 as EmpRecForAdmin.record;
    output r13 as privapay_v0001.aleo/add_employee.future;

finalize add_employee:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u32.public;
    input r3 as u32.public;
    input r4 as address.public;
    input r5 as token_registry.aleo/transfer_public_as_signer.future;
    await r5;
    contains registered_company[r0] into r6;
    assert.eq r6 true;
    get registered_company[r0] into r7;
    assert.eq r7.admin r4;
    gte r2 block.height into r8;
    assert.eq r8 true;
    get.or_use is_employee_registered[r1] false into r9;
    assert.eq r9 false;
    set true into is_employee_registered[r1];
    get.or_use is_employee_active[r1] false into r10;
    assert.eq r10 false;
    set true into is_employee_active[r1];

function generate_signature:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as u128.private;
    input r4 as field.private;
    input r5 as u32.private;
    input r6 as u32.private;
    input r7 as signature.private;
    cast r0 r1 r2 r4 into r8 as EmployeeInfo;
    hash.bhp256 r8 into r9 as field;
    async generate_signature r7 r9 r0 self.signer into r10;
    output r10 as privapay_v0001.aleo/generate_signature.future;

finalize generate_signature:
    input r0 as signature.public;
    input r1 as field.public;
    input r2 as field.public;
    input r3 as address.public;
    contains registered_company[r2] into r4;
    assert.eq r4 true;
    get registered_company[r2] into r5;
    assert.eq r5.admin r3;
    set r0 into admin_signature[r1];

function update_employee:
    input r0 as u128.private;
    input r1 as field.private;
    input r2 as u32.private;
    input r3 as u32.private;
    input r4 as signature.private;
    input r5 as address.private;
    input r6 as Employee.record;
    add r0 r6.claimable_salary into r7;
    cast r6.owner r6.company_id r6.employee_id r0 r1 r2 r3 r7 into r8 as Employee.record;
    cast r5 r6.company_id r6.employee_id r5 r0 into r9 as EmpRecForAdmin.record;
    cast r6.company_id r6.employee_id r6.owner r1 r0 r2 r3 into r10 as EmployeeSignatureInfo;
    hash.bhp256 r10 into r11 as field;
    async update_employee r6.company_id self.caller r11 r5 r4 into r12;
    output r8 as Employee.record;
    output r9 as EmpRecForAdmin.record;
    output r12 as privapay_v0001.aleo/update_employee.future;

finalize update_employee:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as address.public;
    input r4 as signature.public;
    contains registered_company[r0] into r5;
    assert.eq r5 true;
    get registered_company[r0] into r6;
    assert.eq r6.admin r3;
    sign.verify r4 r6.admin r2 into r7;
    assert.eq r7 true;

function withdraw_salary:
    input r0 as Employee.record;
    input r1 as u128.private;
    cast r0.company_id r0.employee_id r0.owner r0.token_id into r2 as EmployeeInfo;
    hash.bhp256 r2 into r3 as field;
    sub r0.claimable_salary r1 into r4;
    cast r0.owner r0.company_id r0.employee_id r0.amount r0.token_id r0.start_date r0.end_date r4 into r5 as Employee.record;
    call token_registry.aleo/transfer_public_to_private r0.token_id r0.owner r1 false into r6 r7;
    lt r1 r0.amount into r8;
    assert.eq r8 true;
    async withdraw_salary r3 r0.company_id r0.start_date r0.end_date r0.amount r1 r7 into r9;
    output r6 as token_registry.aleo/Token.record;
    output r5 as Employee.record;
    output r9 as privapay_v0001.aleo/withdraw_salary.future;

finalize withdraw_salary:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as u32.public;
    input r3 as u32.public;
    input r4 as u128.public;
    input r5 as u128.public;
    input r6 as token_registry.aleo/transfer_public_to_private.future;
    await r6;
    contains registered_company[r1] into r7;
    assert.eq r7 true;
    get is_employee_registered[r0] into r8;
    assert.eq r8 true;
    get is_employee_active[r0] into r9;
    assert.eq r9 true;
    get.or_use latest_claim[r0] r2 into r10;
    get.or_use total_claimed[r0] 0u128 into r11;
    add r11 r5 into r12;
    set r12 into total_claimed[r0];
    sub block.height r10 into r13;
    sub r3 r2 into r14;
    div r13 r14 into r15;
    cast r15 into r16 as u128;
    mul r16 r4 into r17;
    gte r17 r5 into r18;
    assert.eq r18 true;
    set block.height into latest_claim[r0];
