#ifndef _CSPAT00600_H_
#define _CSPAT00600_H_

///////////////////////////////////////////////////////////////////////////////////////////////////
// ���� �����ֹ� ( SERVICE=CSPAT00600,ENCRYPT,SIGNATURE,HEADTYPE=B,CREATOR=�����,CREDATE=2011/12/07 09:23:39 )
#pragma pack( push, 1 )

#define NAME_CSPAT00600     "CSPAT00600"

// In(*EMPTY*)                    
typedef struct _CSPAT00600InBlock1
{
    char    AcntNo              [  20];    // [string,   20] ���¹�ȣ                        StartPos 0, Length 20
    char    InptPwd             [   8];    // [string,    8] �Էº�й�ȣ                    StartPos 20, Length 8
    char    IsuNo               [  12];    // [string,   12] �����ȣ                        StartPos 28, Length 12
    char    OrdQty              [  16];    // [long  ,   16] �ֹ�����                        StartPos 40, Length 16
    char    OrdPrc              [  13];    // [double, 13.2] �ֹ���                          StartPos 56, Length 13
    char    BnsTpCode           [   1];    // [string,    1] �Ÿű���                        StartPos 69, Length 1
    char    OrdprcPtnCode       [   2];    // [string,    2] ȣ�������ڵ�                    StartPos 70, Length 2
    char    MgntrnCode          [   3];    // [string,    3] �ſ�ŷ��ڵ�                    StartPos 72, Length 3
    char    LoanDt              [   8];    // [string,    8] ������                          StartPos 75, Length 8
    char    OrdCndiTpCode       [   1];    // [string,    1] �ֹ����Ǳ���                    StartPos 83, Length 1
} CSPAT00600InBlock1, *LPCSPAT00600InBlock1;
#define NAME_CSPAT00600InBlock1     "CSPAT00600InBlock1"

// In(*EMPTY*)                    
typedef struct _CSPAT00600OutBlock1
{
    char    RecCnt              [   5];    // [long  ,    5] ���ڵ尹��                      StartPos 0, Length 5
    char    AcntNo              [  20];    // [string,   20] ���¹�ȣ                        StartPos 5, Length 20
    char    InptPwd             [   8];    // [string,    8] �Էº�й�ȣ                    StartPos 25, Length 8
    char    IsuNo               [  12];    // [string,   12] �����ȣ                        StartPos 33, Length 12
    char    OrdQty              [  16];    // [long  ,   16] �ֹ�����                        StartPos 45, Length 16
    char    OrdPrc              [  13];    // [double, 13.2] �ֹ���                          StartPos 61, Length 13
    char    BnsTpCode           [   1];    // [string,    1] �Ÿű���                        StartPos 74, Length 1
    char    OrdprcPtnCode       [   2];    // [string,    2] ȣ�������ڵ�                    StartPos 75, Length 2
    char    PrgmOrdprcPtnCode   [   2];    // [string,    2] ���α׷�ȣ�������ڵ�            StartPos 77, Length 2
    char    StslAbleYn          [   1];    // [string,    1] ���ŵ����ɿ���                  StartPos 79, Length 1
    char    StslOrdprcTpCode    [   1];    // [string,    1] ���ŵ�ȣ������                  StartPos 80, Length 1
    char    CommdaCode          [   2];    // [string,    2] ��Ÿ�ü�ڵ�                    StartPos 81, Length 2
    char    MgntrnCode          [   3];    // [string,    3] �ſ�ŷ��ڵ�                    StartPos 83, Length 3
    char    LoanDt              [   8];    // [string,    8] ������                          StartPos 86, Length 8
    char    MbrNo               [   3];    // [string,    3] ȸ����ȣ                        StartPos 94, Length 3
    char    OrdCndiTpCode       [   1];    // [string,    1] �ֹ����Ǳ���                    StartPos 97, Length 1
    char    StrtgCode           [   6];    // [string,    6] �����ڵ�                        StartPos 98, Length 6
    char    GrpId               [  20];    // [string,   20] �׷�ID                          StartPos 104, Length 20
    char    OrdSeqNo            [  10];    // [long  ,   10] �ֹ�ȸ��                        StartPos 124, Length 10
    char    PtflNo              [  10];    // [long  ,   10] ��Ʈ��������ȣ                  StartPos 134, Length 10
    char    BskNo               [  10];    // [long  ,   10] �ٽ��Ϲ�ȣ                      StartPos 144, Length 10
    char    TrchNo              [  10];    // [long  ,   10] Ʈ��ġ��ȣ                      StartPos 154, Length 10
    char    ItemNo              [  10];    // [long  ,   10] �����۹�ȣ                      StartPos 164, Length 10
    char    OpDrtnNo            [  12];    // [string,   12] ������ù�ȣ                    StartPos 174, Length 12
    char    LpYn                [   1];    // [string,    1] �����������ڿ���                StartPos 186, Length 1
    char    CvrgTpCode          [   1];    // [string,    1] �ݴ�Ÿű���                    StartPos 187, Length 1
} CSPAT00600OutBlock1, *LPCSPAT00600OutBlock1;
#define NAME_CSPAT00600OutBlock1     "CSPAT00600OutBlock1"

// Out(*EMPTY*)                   
typedef struct _CSPAT00600OutBlock2
{
    char    RecCnt              [   5];    // [long  ,    5] ���ڵ尹��                      StartPos 0, Length 5
    char    OrdNo               [  10];    // [long  ,   10] �ֹ���ȣ                        StartPos 5, Length 10
    char    OrdTime             [   9];    // [string,    9] �ֹ��ð�                        StartPos 15, Length 9
    char    OrdMktCode          [   2];    // [string,    2] �ֹ������ڵ�                    StartPos 24, Length 2
    char    OrdPtnCode          [   2];    // [string,    2] �ֹ������ڵ�                    StartPos 26, Length 2
    char    ShtnIsuNo           [   9];    // [string,    9] ���������ȣ                    StartPos 28, Length 9
    char    MgempNo             [   9];    // [string,    9] ���������ȣ                    StartPos 37, Length 9
    char    OrdAmt              [  16];    // [long  ,   16] �ֹ��ݾ�                        StartPos 46, Length 16
    char    SpareOrdNo          [  10];    // [long  ,   10] �����ֹ���ȣ                    StartPos 62, Length 10
    char    CvrgSeqno           [  10];    // [long  ,   10] �ݴ�Ÿ��Ϸù�ȣ                StartPos 72, Length 10
    char    RsvOrdNo            [  10];    // [long  ,   10] �����ֹ���ȣ                    StartPos 82, Length 10
    char    SpotOrdQty          [  16];    // [long  ,   16] �ǹ��ֹ�����                    StartPos 92, Length 16
    char    RuseOrdQty          [  16];    // [long  ,   16] �����ֹ�����                  StartPos 108, Length 16
    char    MnyOrdAmt           [  16];    // [long  ,   16] �����ֹ��ݾ�                    StartPos 124, Length 16
    char    SubstOrdAmt         [  16];    // [long  ,   16] ����ֹ��ݾ�                    StartPos 140, Length 16
    char    RuseOrdAmt          [  16];    // [long  ,   16] �����ֹ��ݾ�                  StartPos 156, Length 16
    char    AcntNm              [  40];    // [string,   40] ���¸�                          StartPos 172, Length 40
    char    IsuNm               [  40];    // [string,   40] �����                          StartPos 212, Length 40
} CSPAT00600OutBlock2, *LPCSPAT00600OutBlock2;
#define NAME_CSPAT00600OutBlock2     "CSPAT00600OutBlock2"

#pragma pack( pop )
///////////////////////////////////////////////////////////////////////////////////////////////////

#endif // _CSPAT00600_H_
