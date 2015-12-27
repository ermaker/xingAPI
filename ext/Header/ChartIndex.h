#ifndef _CHARTINDEX_H_
#define _CHARTINDEX_H_

///////////////////////////////////////////////////////////////////////////////////////////////////
// 챠트 지표데이터 (ChartIndex) ( headtype=B )

#pragma pack( push, 1 )

#define NAME_CHARTINDEX     "ChartIndex"

// In(*EMPTY*)                    
typedef struct _ChartIndexInBlock
{
	char	indexid			    [  10];						// [long  ,   10] 지표ID (ChartIndexOutBlock의 indexid)
	char	indexname			[  40];						// [string,   40] 지표명
	char	indexparam			[  40];						// [string,   40] 수식관리자 화면의 지표조건설정 (공백이면 기본조건, 입력값이 여러개인 경우 ',' 로 연결) 
	char	market				[   1];						// [string,    1] 시장구분(주식:1 , 업종:2, 선물옵션:5 )
	char	period				[   1];						// [string,    1] 주기구분(틱:0,분:1,일:2,주:3,월:4)                       
    char    shcode              [   8];						// [string,    8] 단축코드													
    char    qrycnt              [   4];						// [long  ,    4] 요청건수(최대 500개)
    char    ncnt                [   4];						// [long  ,    4] 단위(n틱/n분)                   
	char    sdate               [   8];						// [string,    8] 시작일자(일/주/월 해당)  
    char    edate               [   8];						// [string,    8] 종료일자(일/주/월 해당)  
	char	Isamend				[   1];						// [string,    1] 수정주가 반영여부(0:반영안함, 1:반영)
	char	Isgab				[   1];						// [string,    1] 갭보정 여부(0:보정안함, 1:보정)
	char	IsReal				[   1];						// [string,    1] 실시간 데이터 자동 등록 여부 (0:조회만, 1:실시간 자동 등록)
} ChartIndexInBlock, *LPChartIndexInBlock;
#define NAME_ChartIndexInBlock   "ChartIndexInBlock"

// Out(*EMPTY*)                    
typedef struct _ChartIndexOutBlock
{
	char	indexid			    [  10];						// [long  ,   10] 지표ID (지표를 해제하거나 '동일종목-동일지표'의 조회 조건만 변경시 사용)
    char    rec_cnt             [   5];						// [long  ,    5] 레코드갯수                      
    char    validdata_cnt       [   2];						// [long  ,    2] 유효 데이터 컬럼 수 (지표별 출력 컬럼 수)
} ChartIndexOutBlock, *LPChartIndexOutBlock;
#define NAME_ChartIndexOutBlock     "ChartIndexOutBlock"

// Out1(*EMPTY*)                  , occurs
typedef struct _ChartIndexOutBlock1
{
    char	date				[   8];						// [string,    8] 일자
    char	time				[	6];						// [string,    6] 시간
    char	open				[  10];						// [double,   10] 시가              
    char	high				[  10];						// [double,   10] 고가              
    char	low					[  10];						// [double,   10] 저가				
    char	close				[  10];						// [double,   10] 종가               
    char	volume				[  12];						// [double,   12] 거래량
	char	value1				[  10];						// [double,   10] 지표값1
	char	value2				[  10];						// [double,   10] 지표값2
	char	value3				[  10];						// [double,   10] 지표값3
	char	value4				[  10];						// [double,   10] 지표값4
	char	value5				[  10];						// [double,   10] 지표값5
	char	pos                 [   8];						// [int,       8] 위치
 } ChartIndexOutBlock1, *LPChartIndexOutBlock1;
#define NAME_ChartIndexOutBlock1     "ChartIndexOutBlock1"

#pragma pack( pop )
///////////////////////////////////////////////////////////////////////////////////////////////////

#endif // _ChartIndex_H_
