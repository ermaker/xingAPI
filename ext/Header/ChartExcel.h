#ifndef _CHARTEXCEL_H_
#define _CHARTEXCEL_H_

///////////////////////////////////////////////////////////////////////////////////////////////////
// 챠트 엑셀데이터 (ChartExcel) ( headtype=B )

#pragma pack( push, 1 )

#define NAME_CHARTEXCEL     "ChartExcel"

// In(*EMPTY*)                    
typedef struct _ChartExcelInBlock
{
	char	indexid			    [  10];						// [long  ,   10] 지표ID (ChartExcelOutBlock indexid)
	char	indexname			[  40];						// [string,   40] 지표명
	char	indexparam			[  40];						// [string,   40] 수식관리자 화면의 지표조건설정 (공백이면 기본조건, 입력값이 여러개인 경우 ',' 로 연결) 
	char	indexouttype		[   1];						// [string,    1] 결과 데이터 구분(1:지표, 2:시스템트레이딩)
	char	market				[   1];						// [string,    1] 시장구분                       
	char	period				[   1];						// [string,    1] 주기구분(틱:0,분:1,일:2,주:3,월:4)                       
	char    shcode				[   8];						// [string,    8] 단축코드													
	char	isexcelout			[   1];						// [string,    1] 가공한 지표데이터를 엑셀에 동시 출력 여부 (1:출력, 0:출력안함)
	char	excelfilename		[ 256];						// [string,  256] 직접 저장한 차트 기초데이터를 엑셀 포맷으로 변경한 파일명
	char	IsReal				[   1];						// [string,    1] 실시간 데이터 자동 등록 여부 (0:조회만, 1:실시간 자동 등록)
} ChartExcelInBlock, *LPChartExcelInBlock;
#define NAME_ChartExcelInBlock   "ChartExcelInBlock"

// Out(*EMPTY*)                    
typedef struct _ChartExcelOutBlock
{
    char	indexid				[  10];						// [long  ,   10] 지표ID (지표를 해제하거나 '동일종목-동일지표'의 조회 조건만 변경시 사용)
    char    rec_cnt				[   5];						// [long  ,    5] 레코드갯수                      
    char    validdata_cnt		[   2];						// [long  ,    2] 유효 데이터 컬럼 수 (지표별 출력 컬럼 수)
} ChartExcelOutBlock, *LPChartExcelOutBlock;
#define NAME_ChartExcelOutBlock     "ChartExcelOutBlock"

// Out1(*EMPTY*)                  , occurs
typedef struct _ChartExcelOutBlock1
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
	char	pos                 [   8];						// [long,      8] 위치
 } ChartExcelOutBlock1, *LPChartExcelOutBlock1;
#define NAME_ChartExcelOutBlock1     "ChartExcelOutBlock1"

#pragma pack( pop )
///////////////////////////////////////////////////////////////////////////////////////////////////

#endif // _CHARTEXCEL_H_
