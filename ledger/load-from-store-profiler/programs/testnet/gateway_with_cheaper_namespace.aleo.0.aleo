program gateway_with_cheaper_namespace.aleo;

struct Payload:
    num as u128;

struct DestinationAddress:
    aaddress as [u8; 20u32];

struct ChainName:
    name as [u8; 32u32];

struct ContractCall:
    caller as address;
    sender as address;
    destinationChain as ChainName;
    destinationContractAddress as DestinationAddress;
    payload as Payload;

record ContractCallRecord:
    owner as address.private;
    contract_call as ContractCall.private;

function callContract:
    input r0 as ChainName.private;
    input r1 as [u8; 20u32].private;
    input r2 as u128.private;
    cast r1 into r3 as DestinationAddress;
    cast r2 into r4 as Payload;
    cast self.caller self.signer r0 r3 r4 into r5 as ContractCall;
    cast aleo1ejcm4cpwcjtenxlg37utj8dn7s88xs5asvl5u25w4udkd7e7dcpqvaeyaz r5 into r6 as ContractCallRecord.record;
    output r6 as ContractCallRecord.record;
