#ifndef _CHARTEXCEL_H_
#define _CHARTEXCEL_H_

///////////////////////////////////////////////////////////////////////////////////////////////////
// íƮ ���������� (ChartExcel) ( headtype=B )

#pragma pack( push, 1 )

#define NAME_CHARTEXCEL     "ChartExcel"

// In(*EMPTY*)                    
typedef struct _ChartExcelInBlock
{
	char	indexid			    [  10];						// [long  ,   10] ��ǥID (ChartExcelOutBlock indexid)
	char	indexname			[  40];						// [string,   40] ��ǥ��
	char	indexparam			[  40];						// [string,   40] ���İ����� ȭ���� ��ǥ���Ǽ��� (�����̸� �⺻����, �Է°��� �������� ��� ',' �� ����) 
	char	indexouttype		[   1];						// [string,    1] ��� ������ ����(1:��ǥ, 2:�ý���Ʈ���̵�)
	char	market				[   1];						// [string,    1] ���屸��                       
	char	period				[   1];						// [string,    1] �ֱⱸ��(ƽ:0,��:1,��:2,��:3,��:4)                       
	char    shcode				[   8];						// [string,    8] �����ڵ�													
	char	isexcelout			[   1];						// [string,    1] ������ ��ǥ�����͸� ������ ���� ��� ���� (1:���, 0:��¾���)
	char	excelfilename		[ 256];						// [string,  256] ���� ������ ��Ʈ ���ʵ����͸� ���� �������� ������ ���ϸ�
	char	IsReal				[   1];						// [string,    1] �ǽð� ������ �ڵ� ��� ���� (0:��ȸ��, 1:�ǽð� �ڵ� ���)
} ChartExcelInBlock, *LPChartExcelInBlock;
#define NAME_ChartExcelInBlock   "ChartExcelInBlock"

// Out(*EMPTY*)                    
typedef struct _ChartExcelOutBlock
{
    char	indexid				[  10];						// [long  ,   10] ��ǥID (��ǥ�� �����ϰų� '��������-������ǥ'�� ��ȸ ���Ǹ� ����� ���)
    char    rec_cnt				[   5];						// [long  ,    5] ���ڵ尹��                      
    char    validdata_cnt		[   2];						// [long  ,    2] ��ȿ ������ �÷� �� (��ǥ�� ��� �÷� ��)
} ChartExcelOutBlock, *LPChartExcelOutBlock;
#define NAME_ChartExcelOutBlock     "ChartExcelOutBlock"

// Out1(*EMPTY*)                  , occurs
typedef struct _ChartExcelOutBlock1
{
    char	date				[   8];						// [string,    8] ����
    char	time				[	6];						// [string,    6] �ð�
    char	open				[  10];						// [double,   10] �ð�              
    char	high				[  10];						// [double,   10] ��              
    char	low					[  10];						// [double,   10] ����				
    char	close				[  10];						// [double,   10] ����               
    char	volume				[  12];						// [double,   12] �ŷ���
	char	value1				[  10];						// [double,   10] ��ǥ��1
	char	value2				[  10];						// [double,   10] ��ǥ��2
	char	value3				[  10];						// [double,   10] ��ǥ��3
	char	value4				[  10];						// [double,   10] ��ǥ��4
	char	value5				[  10];						// [double,   10] ��ǥ��5
	char	pos                 [   8];						// [long,      8] ��ġ
 } ChartExcelOutBlock1, *LPChartExcelOutBlock1;
#define NAME_ChartExcelOutBlock1     "ChartExcelOutBlock1"

#pragma pack( pop )
///////////////////////////////////////////////////////////////////////////////////////////////////

#endif // _CHARTEXCEL_H_
