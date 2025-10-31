program hello_hello336sdfsd.aleo;

function hello:
    input r0 as u32.public;
    input r1 as u32.private;
    add r0 r1 into r2;
    output r2 as u32.private;

struct Company:
    name as field;
    manager as address;
    finance_department as address;
    qc as address;

struct Product:
    product_id as field;
    name as field;
    comment as field;
    price as u64;
    supplier_address as address;

struct OrderInfo:
    order_id as field;
    product as Product;
    qty as u64;
    status as u8;
    order_timestamp as u32;
    produce_timestamp as u32;
    complete_timestamp as u32;
    total_price as u64;

struct QCInfo:
    order_id as field;
    product_id as field;
    qc_status as u8;
    qc_signature as signature;

record QC_Record:
    owner as address.private;
    supplier as address.private;
    company as address.private;
    qc as address.private;
    order_id as field.private;
    qc_result as QCInfo.private;

record Order_Record:
    owner as address.private;
    supplier as address.private;
    company as address.private;
    qc as address.private;
    order_id as field.private;
    qc_info as QCInfo.private;
    order_info as OrderInfo.private;

record Finance_Record:
    owner as address.private;
    supplier as address.private;
    company as address.private;
    payment_amount as u64.private;
    order_id as field.private;
    sign as signature.private;
