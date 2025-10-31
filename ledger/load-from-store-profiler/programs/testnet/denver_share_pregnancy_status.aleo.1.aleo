program denver_share_pregnancy_status.aleo;

struct HealthInfo:
    age as u8;
    weight as u8;
    height as u8;
    is_pregnant as boolean;

function share_status:
    input r0 as HealthInfo.private;
    output r0.is_pregnant as boolean.private;
