program data_901275.aleo;

struct Foo:
    a as u32;
    b as u32;
    c as u32;

function main:
    cast 1u32 2u32 3u32 into r0 as Foo;
    output r0 as Foo.public;
