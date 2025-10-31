program salary_compare.aleo;

struct SalaryData:
    industry as u32;
    experience as u32;
    salary as u64;

function add_salary:
    input r0 as u32.private;
    input r1 as u32.private;
    input r2 as u64.private;
    cast r0 r1 r2 into r3 as SalaryData;
    output r3 as SalaryData.private;

function compare_salary:
    input r0 as SalaryData.private;
    input r1 as u64.private;
    lte r0.salary r1 into r2;
    ternary r2 1u8 0u8 into r3;
    output r3 as u8.private;
