#ifndef _CHARTINDEX_H_
#define _CHARTINDEX_H_

///////////////////////////////////////////////////////////////////////////////////////////////////
// íƮ ��ǥ������ (ChartIndex) ( headtype=B )

#pragma pack( push, 1 )

#define NAME_CHARTINDEX     "ChartIndex"

// In(*EMPTY*)                    
typedef struct _ChartIndexInBlock
{
	char	indexid			    [  10];						// [long  ,   10] ��ǥID (ChartIndexOutBlock�� indexid)
	char	indexname			[  40];						// [string,   40] ��ǥ��
	char	indexparam			[  40];						// [string,   40] ���İ����� ȭ���� ��ǥ���Ǽ��� (�����̸� �⺻����, �Է°��� �������� ��� ',' �� ����) 
	char	market				[   1];						// [string,    1] ���屸��(�ֽ�:1 , ����:2, �����ɼ�:5 )
	char	period				[   1];						// [string,    1] �ֱⱸ��(ƽ:0,��:1,��:2,��:3,��:4)                       
    char    shcode              [   8];						// [string,    8] �����ڵ�													
    char    qrycnt              [   4];						// [long  ,    4] ��û�Ǽ�(�ִ� 500��)
    char    ncnt                [   4];						// [long  ,    4] ����(nƽ/n��)                   
	char    sdate               [   8];						// [string,    8] ��������(��/��/�� �ش�)  
    char    edate               [   8];						// [string,    8] ��������(��/��/�� �ش�)  
	char	Isamend				[   1];						// [string,    1] �����ְ� �ݿ�����(0:�ݿ�����, 1:�ݿ�)
	char	Isgab				[   1];						// [string,    1] ������ ����(0:��������, 1:����)
	char	IsReal				[   1];						// [string,    1] �ǽð� ������ �ڵ� ��� ���� (0:��ȸ��, 1:�ǽð� �ڵ� ���)
} ChartIndexInBlock, *LPChartIndexInBlock;
#define NAME_ChartIndexInBlock   "ChartIndexInBlock"

// Out(*EMPTY*)                    
typedef struct _ChartIndexOutBlock
{
	char	indexid			    [  10];						// [long  ,   10] ��ǥID (��ǥ�� �����ϰų� '��������-������ǥ'�� ��ȸ ���Ǹ� ����� ���)
    char    rec_cnt             [   5];						// [long  ,    5] ���ڵ尹��                      
    char    validdata_cnt       [   2];						// [long  ,    2] ��ȿ ������ �÷� �� (��ǥ�� ��� �÷� ��)
} ChartIndexOutBlock, *LPChartIndexOutBlock;
#define NAME_ChartIndexOutBlock     "ChartIndexOutBlock"

// Out1(*EMPTY*)                  , occurs
typedef struct _ChartIndexOutBlock1
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
	char	pos                 [   8];						// [int,       8] ��ġ
 } ChartIndexOutBlock1, *LPChartIndexOutBlock1;
#define NAME_ChartIndexOutBlock1     "ChartIndexOutBlock1"

#pragma pack( pop )
///////////////////////////////////////////////////////////////////////////////////////////////////

#endif // _ChartIndex_H_
