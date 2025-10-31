import credits.aleo;
import arcn_wiz_nft_v1.aleo;

program arcn_wiz_nft_helper_v1.aleo;

struct TokenId:
    data1 as u128;
    data2 as u128;

struct BaseURI:
    data0 as u128;
    data1 as u128;
    data2 as u128;
    data3 as u128;

struct NFTPriceTicket:
    minter as address;
    price as u64;

function claim_nft_pub_2:
    input r0 as TokenId.private;
    input r1 as TokenId.private;
    input r2 as NFTPriceTicket.private;
    input r3 as signature.private;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r0 r2 r3 into r4 r5;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r1 r2 r3 into r6 r7;
    async claim_nft_pub_2 r5 r7 into r8;
    output r4 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r6 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r8 as arcn_wiz_nft_helper_v1.aleo/claim_nft_pub_2.future;

finalize claim_nft_pub_2:
    input r0 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r1 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    await r0;
    await r1;

function claim_nft_pub_3:
    input r0 as TokenId.private;
    input r1 as TokenId.private;
    input r2 as TokenId.private;
    input r3 as NFTPriceTicket.private;
    input r4 as signature.private;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r0 r3 r4 into r5 r6;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r1 r3 r4 into r7 r8;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r2 r3 r4 into r9 r10;
    async claim_nft_pub_3 r6 r8 r10 into r11;
    output r5 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r7 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r9 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r11 as arcn_wiz_nft_helper_v1.aleo/claim_nft_pub_3.future;

finalize claim_nft_pub_3:
    input r0 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r1 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r2 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    await r0;
    await r1;
    await r2;

function claim_nft_pub_4:
    input r0 as TokenId.private;
    input r1 as TokenId.private;
    input r2 as TokenId.private;
    input r3 as TokenId.private;
    input r4 as NFTPriceTicket.private;
    input r5 as signature.private;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r0 r4 r5 into r6 r7;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r1 r4 r5 into r8 r9;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r2 r4 r5 into r10 r11;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r3 r4 r5 into r12 r13;
    async claim_nft_pub_4 r7 r9 r11 r13 into r14;
    output r6 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r8 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r10 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r12 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r14 as arcn_wiz_nft_helper_v1.aleo/claim_nft_pub_4.future;

finalize claim_nft_pub_4:
    input r0 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r1 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r2 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r3 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    await r0;
    await r1;
    await r2;
    await r3;

function claim_nft_pub_5:
    input r0 as TokenId.private;
    input r1 as TokenId.private;
    input r2 as TokenId.private;
    input r3 as TokenId.private;
    input r4 as TokenId.private;
    input r5 as NFTPriceTicket.private;
    input r6 as signature.private;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r0 r5 r6 into r7 r8;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r1 r5 r6 into r9 r10;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r2 r5 r6 into r11 r12;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r3 r5 r6 into r13 r14;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r4 r5 r6 into r15 r16;
    async claim_nft_pub_5 r8 r10 r12 r14 r16 into r17;
    output r7 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r9 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r11 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r13 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r15 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r17 as arcn_wiz_nft_helper_v1.aleo/claim_nft_pub_5.future;

finalize claim_nft_pub_5:
    input r0 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r1 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r2 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r3 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r4 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;

function claim_nft_pub_6:
    input r0 as TokenId.private;
    input r1 as TokenId.private;
    input r2 as TokenId.private;
    input r3 as TokenId.private;
    input r4 as TokenId.private;
    input r5 as TokenId.private;
    input r6 as NFTPriceTicket.private;
    input r7 as signature.private;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r0 r6 r7 into r8 r9;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r1 r6 r7 into r10 r11;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r2 r6 r7 into r12 r13;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r3 r6 r7 into r14 r15;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r4 r6 r7 into r16 r17;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r5 r6 r7 into r18 r19;
    async claim_nft_pub_6 r9 r11 r13 r15 r17 r19 into r20;
    output r8 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r10 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r12 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r14 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r16 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r18 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r20 as arcn_wiz_nft_helper_v1.aleo/claim_nft_pub_6.future;

finalize claim_nft_pub_6:
    input r0 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r1 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r2 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r3 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r4 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r5 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;

function claim_nft_pub_7:
    input r0 as TokenId.private;
    input r1 as TokenId.private;
    input r2 as TokenId.private;
    input r3 as TokenId.private;
    input r4 as TokenId.private;
    input r5 as TokenId.private;
    input r6 as TokenId.private;
    input r7 as NFTPriceTicket.private;
    input r8 as signature.private;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r0 r7 r8 into r9 r10;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r1 r7 r8 into r11 r12;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r2 r7 r8 into r13 r14;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r3 r7 r8 into r15 r16;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r4 r7 r8 into r17 r18;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r5 r7 r8 into r19 r20;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r6 r7 r8 into r21 r22;
    async claim_nft_pub_7 r10 r12 r14 r16 r18 r20 r22 into r23;
    output r9 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r11 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r13 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r15 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r17 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r19 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r21 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r23 as arcn_wiz_nft_helper_v1.aleo/claim_nft_pub_7.future;

finalize claim_nft_pub_7:
    input r0 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r1 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r2 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r3 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r4 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r5 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r6 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;

function claim_nft_pub_8:
    input r0 as TokenId.private;
    input r1 as TokenId.private;
    input r2 as TokenId.private;
    input r3 as TokenId.private;
    input r4 as TokenId.private;
    input r5 as TokenId.private;
    input r6 as TokenId.private;
    input r7 as TokenId.private;
    input r8 as NFTPriceTicket.private;
    input r9 as signature.private;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r0 r8 r9 into r10 r11;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r1 r8 r9 into r12 r13;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r2 r8 r9 into r14 r15;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r3 r8 r9 into r16 r17;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r4 r8 r9 into r18 r19;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r5 r8 r9 into r20 r21;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r6 r8 r9 into r22 r23;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r7 r8 r9 into r24 r25;
    async claim_nft_pub_8 r11 r13 r15 r17 r19 r21 r23 r25 into r26;
    output r10 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r12 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r14 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r16 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r18 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r20 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r22 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r24 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r26 as arcn_wiz_nft_helper_v1.aleo/claim_nft_pub_8.future;

finalize claim_nft_pub_8:
    input r0 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r1 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r2 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r3 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r4 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r5 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r6 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r7 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;

function claim_nft_pub_9:
    input r0 as TokenId.private;
    input r1 as TokenId.private;
    input r2 as TokenId.private;
    input r3 as TokenId.private;
    input r4 as TokenId.private;
    input r5 as TokenId.private;
    input r6 as TokenId.private;
    input r7 as TokenId.private;
    input r8 as TokenId.private;
    input r9 as NFTPriceTicket.private;
    input r10 as signature.private;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r0 r9 r10 into r11 r12;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r1 r9 r10 into r13 r14;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r2 r9 r10 into r15 r16;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r3 r9 r10 into r17 r18;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r4 r9 r10 into r19 r20;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r5 r9 r10 into r21 r22;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r6 r9 r10 into r23 r24;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r7 r9 r10 into r25 r26;
    call arcn_wiz_nft_v1.aleo/claim_nft_pub r8 r9 r10 into r27 r28;
    async claim_nft_pub_9 r12 r14 r16 r18 r20 r22 r24 r26 r28 into r29;
    output r11 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r13 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r15 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r17 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r19 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r21 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r23 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r25 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r27 as arcn_wiz_nft_v1.aleo/NFT.record;
    output r29 as arcn_wiz_nft_helper_v1.aleo/claim_nft_pub_9.future;

finalize claim_nft_pub_9:
    input r0 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r1 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r2 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r3 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r4 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r5 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r6 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r7 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    input r8 as arcn_wiz_nft_v1.aleo/claim_nft_pub.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
