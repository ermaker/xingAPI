BEGIN_FUNCTION_MAP
	.Func,íƮ��ǥ��������ȸ,CHARTINDEX,headtype=B;
	BEGIN_DATA_MAP
	ChartIndexInBlock,In(*EMPTY*),input;
	begin
		��ǥID, indexid, indexid, long, 10
		��ǥ��, indexname, indexname, char, 40;
		��ǥ���Ǽ���, indexparam, indexparam, char, 40;
		���屸��, market, market, char, 1;
		�ֱⱸ��, period, period, char, 1;
		�����ڵ�, shcode, shcode, char, 8;
		��û�Ǽ�(�ִ� 500��), qrycnt, qrycnt, long, 4;
		����(nƽ/n��), ncnt, ncnt, long, 4;
		��������, sdate, sdate, char, 8;
		��������, edate, edate, char, 8;
		�����ְ� �ݿ� ����, Isamend, Isamend, char, 1;
		������ ����, Isgab, Isgab, char, 1;
		�ǽð� �����ͼ��� �ڵ���� ����, IsReal, IsReal, char, 1;
	end
	ChartIndexOutBlock,Out(*EMPTY*),output;
	begin
		��ǥID, indexid, indexid, long, 10;
		���ڵ尹��, rec_cnt, rec_cnt, long, 5;
		��ȿ ������ �÷� ����, validdata_cnt, validdata_cnt, long, 2;
	end
	ChartIndexOutBlock1,Out(*EMPTY*),output,occurs;
	begin
		����, date, date, char, 8;
		�ð�, time, time, char, 6;
		�ð�, open, open, float, 10;
		��, high, high, float, 10;
		����, low, low, float, 10;
		����, close, close, float, 10;
		�ŷ���, volume, volume, float, 12;
		��ǥ��1, value1, value1, float, 10;
		��ǥ��2, value2, value2, float, 10;
		��ǥ��3, value3, value3, float, 10;
		��ǥ��4, value4, value4, float, 10;
		��ǥ��5, value5, value5, float, 10;
		��ġ, pos, pos, long, 8;
	end
	END_DATA_MAP
END_FUNCTION_MAP
