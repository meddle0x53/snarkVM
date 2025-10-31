program driving_status.aleo;

struct PersonalInfo:
    name as field;
    gender as field;
    age as u8;
    has_license as boolean;
    license_expiry as u32;
    infractions as u8;

function can_drive_legally:
    input r0 as PersonalInfo.private;
    gt r0.license_expiry 1698710400u32 into r1;
    and r0.has_license r1 into r2;
    gte r0.age 16u8 into r3;
    lt r0.infractions 3u8 into r4;
    and r2 r3 into r5;
    and r5 r4 into r6;
    output r6 as boolean.private;
