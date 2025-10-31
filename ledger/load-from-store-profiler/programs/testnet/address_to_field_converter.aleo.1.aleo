program address_to_field_converter.aleo;

function main:
    input r0 as address.public;
    cast r0 into r1 as field;
    output r1 as field.private;
