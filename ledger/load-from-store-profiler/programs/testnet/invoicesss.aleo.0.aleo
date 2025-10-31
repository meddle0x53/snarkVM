program invoicesss.aleo;

struct UserDigitalName:
    lens_id as field;
    twitter as field;
    telegram as field;
    gitcoin_passport_id as field;
    zkcat as field;

struct UserAddress:
    owner_key as address;

mapping key_to_userID:
    key as address.public;
    value as UserDigitalName.public;

function add_digital_ids:
    input r0 as UserDigitalName.private;
    cast self.caller into r1 as UserAddress;
    output r1 as UserAddress.private;

function update_digital_ids:
    input r0 as UserDigitalName.private;
    cast self.caller into r1 as UserAddress;
    output r1 as UserAddress.private;

function get_digital_ids_hash:
    input r0 as UserDigitalName.private;
    hash.bhp256 r0.lens_id into r1 as field;
    hash.bhp256 r0.twitter into r2 as field;
    hash.bhp256 r0.telegram into r3 as field;
    hash.bhp256 r0.gitcoin_passport_id into r4 as field;
    hash.bhp256 r0.zkcat into r5 as field;
    cast r1 r2 r3 r4 r5 into r6 as UserDigitalName;
    output r6 as UserDigitalName.private;

closure set_digital_id:
    input r0 as address;
    input r1 as UserDigitalName;
    assert.eq true true;
    output true as boolean;

closure get_digital_id:
    input r0 as address;
    cast 0field 0field 0field 0field 0field into r1 as UserDigitalName;
    output r1 as UserDigitalName;
