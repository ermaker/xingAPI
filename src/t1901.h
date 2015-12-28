#ifndef _t1901_H_
#define _t1901_H_

///////////////////////////////////////////////////////////////////////////////////////////////////
// ETF ���簡(�ü�) ��ȸ ( ATTR,BLOCK,HEADTYPE=A )
#pragma pack( push, 1 )

#define NAME_t1901     "t1901"

// �⺻�Է�                       
typedef struct _t1901InBlock
{
    char    shcode              [   6];    char    _shcode              ;    // [string,    6] �����ڵ�                        StartPos 0, Length 6
} t1901InBlock, *LPt1901InBlock;
#define NAME_t1901InBlock     "t1901InBlock"

// ���                           
typedef struct _t1901OutBlock
{
    char    hname               [  20];    char    _hname               ;    // [string,   20] �ѱ۸�                          StartPos 0, Length 20
    char    price               [   8];    char    _price               ;    // [long  ,    8] ���簡                          StartPos 21, Length 8
    char    sign                [   1];    char    _sign                ;    // [string,    1] ���ϴ�񱸺�                    StartPos 30, Length 1
    char    change              [   8];    char    _change              ;    // [long  ,    8] ���ϴ��                        StartPos 32, Length 8
    char    diff                [   6];    char    _diff                ;    // [float ,  6.2] �����                          StartPos 41, Length 6
    char    volume              [  12];    char    _volume              ;    // [float ,   12] �����ŷ���                      StartPos 48, Length 12
    char    recprice            [   8];    char    _recprice            ;    // [long  ,    8] ���ذ�                          StartPos 61, Length 8
    char    avg                 [   8];    char    _avg                 ;    // [long  ,    8] �������                        StartPos 70, Length 8
    char    uplmtprice          [   8];    char    _uplmtprice          ;    // [long  ,    8] ���Ѱ�                          StartPos 79, Length 8
    char    dnlmtprice          [   8];    char    _dnlmtprice          ;    // [long  ,    8] ���Ѱ�                          StartPos 88, Length 8
    char    jnilvolume          [  12];    char    _jnilvolume          ;    // [float ,   12] ���ϰŷ���                      StartPos 97, Length 12
    char    volumediff          [  12];    char    _volumediff          ;    // [long  ,   12] �ŷ�����                        StartPos 110, Length 12
    char    open                [   8];    char    _open                ;    // [long  ,    8] �ð�                            StartPos 123, Length 8
    char    opentime            [   6];    char    _opentime            ;    // [string,    6] �ð��ð�                        StartPos 132, Length 6
    char    high                [   8];    char    _high                ;    // [long  ,    8] ��                            StartPos 139, Length 8
    char    hightime            [   6];    char    _hightime            ;    // [string,    6] ���ð�                        StartPos 148, Length 6
    char    low                 [   8];    char    _low                 ;    // [long  ,    8] ����                            StartPos 155, Length 8
    char    lowtime             [   6];    char    _lowtime             ;    // [string,    6] �����ð�                        StartPos 164, Length 6
    char    high52w             [   8];    char    _high52w             ;    // [long  ,    8] 52�ְ�                        StartPos 171, Length 8
    char    high52wdate         [   8];    char    _high52wdate         ;    // [string,    8] 52�ְ���                      StartPos 180, Length 8
    char    low52w              [   8];    char    _low52w              ;    // [long  ,    8] 52������                        StartPos 189, Length 8
    char    low52wdate          [   8];    char    _low52wdate          ;    // [string,    8] 52��������                      StartPos 198, Length 8
    char    exhratio            [   6];    char    _exhratio            ;    // [float ,  6.2] ������                          StartPos 207, Length 6
    char    flmtvol             [  12];    char    _flmtvol             ;    // [float ,   12] �ܱ��κ�������                  StartPos 214, Length 12
    char    per                 [   6];    char    _per                 ;    // [float ,  6.2] PER                             StartPos 227, Length 6
    char    listing             [  12];    char    _listing             ;    // [long  ,   12] �����ֽļ�(õ)                  StartPos 234, Length 12
    char    jkrate              [   8];    char    _jkrate              ;    // [long  ,    8] ���ű���                        StartPos 247, Length 8
    char    vol                 [   6];    char    _vol                 ;    // [float ,  6.2] ȸ����                          StartPos 256, Length 6
    char    shcode              [   6];    char    _shcode              ;    // [string,    6] �����ڵ�                        StartPos 263, Length 6
    char    value               [  12];    char    _value               ;    // [long  ,   12] �����ŷ����                    StartPos 270, Length 12
    char    highyear            [   8];    char    _highyear            ;    // [long  ,    8] �����ְ�                      StartPos 283, Length 8
    char    highyeardate        [   8];    char    _highyeardate        ;    // [string,    8] �����ְ�����                    StartPos 292, Length 8
    char    lowyear             [   8];    char    _lowyear             ;    // [long  ,    8] ����������                      StartPos 301, Length 8
    char    lowyeardate         [   8];    char    _lowyeardate         ;    // [string,    8] ������������                    StartPos 310, Length 8
    char    upname              [  20];    char    _upname              ;    // [string,   20] ������                          StartPos 319, Length 20
    char    upcode              [   3];    char    _upcode              ;    // [string,    3] �����ڵ�                        StartPos 340, Length 3
    char    upprice             [   7];    char    _upprice             ;    // [float ,  7.2] �������簡                      StartPos 344, Length 7
    char    upsign              [   1];    char    _upsign              ;    // [string,    1] �������Ϻ񱸺�                  StartPos 352, Length 1
    char    upchange            [   6];    char    _upchange            ;    // [float ,  6.2] �������ϴ��                    StartPos 354, Length 6
    char    updiff              [   6];    char    _updiff              ;    // [float ,  6.2] ���������                      StartPos 361, Length 6
    char    futname             [  20];    char    _futname             ;    // [string,   20] �����ֱٿ�����                  StartPos 368, Length 20
    char    futcode             [   8];    char    _futcode             ;    // [string,    8] �����ֱٿ����ڵ�                StartPos 389, Length 8
    char    futprice            [   6];    char    _futprice            ;    // [float ,  6.2] �������簡                      StartPos 398, Length 6
    char    futsign             [   1];    char    _futsign             ;    // [string,    1] �������Ϻ񱸺�                  StartPos 405, Length 1
    char    futchange           [   6];    char    _futchange           ;    // [float ,  6.2] �������ϴ��                    StartPos 407, Length 6
    char    futdiff             [   6];    char    _futdiff             ;    // [float ,  6.2] ���������                      StartPos 414, Length 6
    char    nav                 [   8];    char    _nav                 ;    // [float ,  8.2] NAV                             StartPos 421, Length 8
    char    navsign             [   1];    char    _navsign             ;    // [string,    1] NAV���ϴ�񱸺�                 StartPos 430, Length 1
    char    navchange           [   8];    char    _navchange           ;    // [float ,  8.2] NAV���ϴ��                     StartPos 432, Length 8
    char    navdiff             [   6];    char    _navdiff             ;    // [float ,  6.2] NAV�����                       StartPos 441, Length 6
    char    cocrate             [   6];    char    _cocrate             ;    // [float ,  6.2] ����������                      StartPos 448, Length 6
    char    kasis               [   6];    char    _kasis               ;    // [float ,  6.2] ������                          StartPos 455, Length 6
    char    subprice            [  10];    char    _subprice            ;    // [long  ,   10] ��밡                          StartPos 462, Length 10
    char    offerno1            [   6];    char    _offerno1            ;    // [string,    6] �ŵ����ǻ��ڵ�1                 StartPos 473, Length 6
    char    bidno1              [   6];    char    _bidno1              ;    // [string,    6] �ż����ǻ��ڵ�1                 StartPos 480, Length 6
    char    dvol1               [   8];    char    _dvol1               ;    // [long  ,    8] �Ѹŵ�����1                     StartPos 487, Length 8
    char    svol1               [   8];    char    _svol1               ;    // [long  ,    8] �Ѹż�����1                     StartPos 496, Length 8
    char    dcha1               [   8];    char    _dcha1               ;    // [long  ,    8] �ŵ�����1                       StartPos 505, Length 8
    char    scha1               [   8];    char    _scha1               ;    // [long  ,    8] �ż�����1                       StartPos 514, Length 8
    char    ddiff1              [   6];    char    _ddiff1              ;    // [float ,  6.2] �ŵ�����1                       StartPos 523, Length 6
    char    sdiff1              [   6];    char    _sdiff1              ;    // [float ,  6.2] �ż�����1                       StartPos 530, Length 6
    char    offerno2            [   6];    char    _offerno2            ;    // [string,    6] �ŵ����ǻ��ڵ�2                 StartPos 537, Length 6
    char    bidno2              [   6];    char    _bidno2              ;    // [string,    6] �ż����ǻ��ڵ�2                 StartPos 544, Length 6
    char    dvol2               [   8];    char    _dvol2               ;    // [long  ,    8] �Ѹŵ�����2                     StartPos 551, Length 8
    char    svol2               [   8];    char    _svol2               ;    // [long  ,    8] �Ѹż�����2                     StartPos 560, Length 8
    char    dcha2               [   8];    char    _dcha2               ;    // [long  ,    8] �ŵ�����2                       StartPos 569, Length 8
    char    scha2               [   8];    char    _scha2               ;    // [long  ,    8] �ż�����2                       StartPos 578, Length 8
    char    ddiff2              [   6];    char    _ddiff2              ;    // [float ,  6.2] �ŵ�����2                       StartPos 587, Length 6
    char    sdiff2              [   6];    char    _sdiff2              ;    // [float ,  6.2] �ż�����2                       StartPos 594, Length 6
    char    offerno3            [   6];    char    _offerno3            ;    // [string,    6] �ŵ����ǻ��ڵ�3                 StartPos 601, Length 6
    char    bidno3              [   6];    char    _bidno3              ;    // [string,    6] �ż����ǻ��ڵ�3                 StartPos 608, Length 6
    char    dvol3               [   8];    char    _dvol3               ;    // [long  ,    8] �Ѹŵ�����3                     StartPos 615, Length 8
    char    svol3               [   8];    char    _svol3               ;    // [long  ,    8] �Ѹż�����3                     StartPos 624, Length 8
    char    dcha3               [   8];    char    _dcha3               ;    // [long  ,    8] �ŵ�����3                       StartPos 633, Length 8
    char    scha3               [   8];    char    _scha3               ;    // [long  ,    8] �ż�����3                       StartPos 642, Length 8
    char    ddiff3              [   6];    char    _ddiff3              ;    // [float ,  6.2] �ŵ�����3                       StartPos 651, Length 6
    char    sdiff3              [   6];    char    _sdiff3              ;    // [float ,  6.2] �ż�����3                       StartPos 658, Length 6
    char    offerno4            [   6];    char    _offerno4            ;    // [string,    6] �ŵ����ǻ��ڵ�4                 StartPos 665, Length 6
    char    bidno4              [   6];    char    _bidno4              ;    // [string,    6] �ż����ǻ��ڵ�4                 StartPos 672, Length 6
    char    dvol4               [   8];    char    _dvol4               ;    // [long  ,    8] �Ѹŵ�����4                     StartPos 679, Length 8
    char    svol4               [   8];    char    _svol4               ;    // [long  ,    8] �Ѹż�����4                     StartPos 688, Length 8
    char    dcha4               [   8];    char    _dcha4               ;    // [long  ,    8] �ŵ�����4                       StartPos 697, Length 8
    char    scha4               [   8];    char    _scha4               ;    // [long  ,    8] �ż�����4                       StartPos 706, Length 8
    char    ddiff4              [   6];    char    _ddiff4              ;    // [float ,  6.2] �ŵ�����4                       StartPos 715, Length 6
    char    sdiff4              [   6];    char    _sdiff4              ;    // [float ,  6.2] �ż�����4                       StartPos 722, Length 6
    char    offerno5            [   6];    char    _offerno5            ;    // [string,    6] �ŵ����ǻ��ڵ�5                 StartPos 729, Length 6
    char    bidno5              [   6];    char    _bidno5              ;    // [string,    6] �ż����ǻ��ڵ�5                 StartPos 736, Length 6
    char    dvol5               [   8];    char    _dvol5               ;    // [long  ,    8] �Ѹŵ�����5                     StartPos 743, Length 8
    char    svol5               [   8];    char    _svol5               ;    // [long  ,    8] �Ѹż�����5                     StartPos 752, Length 8
    char    dcha5               [   8];    char    _dcha5               ;    // [long  ,    8] �ŵ�����5                       StartPos 761, Length 8
    char    scha5               [   8];    char    _scha5               ;    // [long  ,    8] �ż�����5                       StartPos 770, Length 8
    char    ddiff5              [   6];    char    _ddiff5              ;    // [float ,  6.2] �ŵ�����5                       StartPos 779, Length 6
    char    sdiff5              [   6];    char    _sdiff5              ;    // [float ,  6.2] �ż�����5                       StartPos 786, Length 6
    char    fwdvl               [  12];    char    _fwdvl               ;    // [long  ,   12] �ܱ���ŵ��հ����              StartPos 793, Length 12
    char    ftradmdcha          [  12];    char    _ftradmdcha          ;    // [long  ,   12] �ܱ���ŵ��������              StartPos 806, Length 12
    char    ftradmddiff         [   6];    char    _ftradmddiff         ;    // [float ,  6.2] �ܱ���ŵ�����                  StartPos 819, Length 6
    char    fwsvl               [  12];    char    _fwsvl               ;    // [long  ,   12] �ܱ���ż��հ����              StartPos 826, Length 12
    char    ftradmscha          [  12];    char    _ftradmscha          ;    // [long  ,   12] �ܱ���ż��������              StartPos 839, Length 12
    char    ftradmsdiff         [   6];    char    _ftradmsdiff         ;    // [float ,  6.2] �ܱ���ż�����                  StartPos 852, Length 6
    char    upname2             [  20];    char    _upname2             ;    // [string,   20] ����������                      StartPos 859, Length 20
    char    upcode2             [   3];    char    _upcode2             ;    // [string,    3] ���������ڵ�                    StartPos 880, Length 3
    char    upprice2            [   7];    char    _upprice2            ;    // [float ,  7.2] �����������簡                  StartPos 884, Length 7
    char    jnilnav             [   8];    char    _jnilnav             ;    // [float ,  8.2] ����NAV                         StartPos 892, Length 8
    char    jnilnavsign         [   1];    char    _jnilnavsign         ;    // [string,    1] ����NAV���ϴ�񱸺�             StartPos 901, Length 1
    char    jnilnavchange       [   8];    char    _jnilnavchange       ;    // [float ,  8.2] ����NAV���ϴ��                 StartPos 903, Length 8
    char    jnilnavdiff         [   6];    char    _jnilnavdiff         ;    // [float ,  6.2] ����NAV�����                   StartPos 912, Length 6
    char    etftotcap           [  12];    char    _etftotcap           ;    // [long  ,   12] ���ڻ��Ѿ�(���)                StartPos 919, Length 12
    char    spread              [   6];    char    _spread              ;    // [float ,  6.2] ��������                        StartPos 932, Length 6
    char    leverage            [   2];    char    _leverage            ;    // [long  ,    2] ��������                        StartPos 939, Length 2
    char    taxgubun            [   1];    char    _taxgubun            ;    // [string,    1] ��������                        StartPos 942, Length 1
    char    opcom_nmk           [  20];    char    _opcom_nmk           ;    // [string,   20] ����                          StartPos 944, Length 20
    char    lp_nm1              [  20];    char    _lp_nm1              ;    // [string,   20] LP1                             StartPos 965, Length 20
    char    lp_nm2              [  20];    char    _lp_nm2              ;    // [string,   20] LP2                             StartPos 986, Length 20
    char    lp_nm3              [  20];    char    _lp_nm3              ;    // [string,   20] LP3                             StartPos 1007, Length 20
    char    lp_nm4              [  20];    char    _lp_nm4              ;    // [string,   20] LP4                             StartPos 1028, Length 20
    char    lp_nm5              [  20];    char    _lp_nm5              ;    // [string,   20] LP5                             StartPos 1049, Length 20
    char    etf_cp              [  10];    char    _etf_cp              ;    // [string,   10] �������                        StartPos 1070, Length 10
    char    etf_kind            [  10];    char    _etf_kind            ;    // [string,   10] ��ǰ����                        StartPos 1081, Length 10
    char    vi_gubun            [  10];    char    _vi_gubun            ;    // [string,   10] VI�ߵ�����                      StartPos 1092, Length 10
    char    etn_kind_cd         [  20];    char    _etn_kind_cd         ;    // [string,   20] ETN��ǰ�з�                     StartPos 1103, Length 20
    char    lastymd             [   8];    char    _lastymd             ;    // [string,    8] ETN������                       StartPos 1124, Length 8
    char    payday              [   8];    char    _payday              ;    // [string,    8] ETN������                       StartPos 1133, Length 8
    char    lastdate            [   8];    char    _lastdate            ;    // [string,    8] ETN�����ŷ���                   StartPos 1142, Length 8
    char    issuernmk           [  20];    char    _issuernmk           ;    // [string,   20] ETN�������������               StartPos 1151, Length 20
    char    last_sdate          [   8];    char    _last_sdate          ;    // [string,    8] ETN�����ȯ���ݰ���������       StartPos 1172, Length 8
    char    last_edate          [   8];    char    _last_edate          ;    // [string,    8] ETN�����ȯ���ݰ���������       StartPos 1181, Length 8
    char    lp_holdvol          [  12];    char    _lp_holdvol          ;    // [string,   12] ETNLP��������                   StartPos 1190, Length 12
} t1901OutBlock, *LPt1901OutBlock;
#define NAME_t1901OutBlock     "t1901OutBlock"

#pragma pack( pop )
///////////////////////////////////////////////////////////////////////////////////////////////////

#endif // _t1901_H_
