BEGIN_FUNCTION_MAP
	.Func,�����ֹ�,CSPAT00600,SERVICE=CSPAT00600,ENCRYPT,SIGNATURE,headtype=B,CREATOR=�����,CREDATE=2011/12/07 09:23:39;
	BEGIN_DATA_MAP
	CSPAT00600InBlock1,In(*EMPTY*),input;
	begin
		���¹�ȣ, AcntNo, AcntNo, char, 20;
		�Էº�й�ȣ, InptPwd, InptPwd, char, 8;
		�����ȣ, IsuNo, IsuNo, char, 12;
		�ֹ�����, OrdQty, OrdQty, long, 16;
		�ֹ���, OrdPrc, OrdPrc, double, 13.2;
		�Ÿű���, BnsTpCode, BnsTpCode, char, 1;
		ȣ�������ڵ�, OrdprcPtnCode, OrdprcPtnCode, char, 2;
		�ſ�ŷ��ڵ�, MgntrnCode, MgntrnCode, char, 3;
		������, LoanDt, LoanDt, char, 8;
		�ֹ����Ǳ���, OrdCndiTpCode, OrdCndiTpCode, char, 1;
	end
	CSPAT00600OutBlock1,In(*EMPTY*),output;
	begin
		���ڵ尹��, RecCnt, RecCnt, long, 5
		���¹�ȣ, AcntNo, AcntNo, char, 20;
		�Էº�й�ȣ, InptPwd, InptPwd, char, 8;
		�����ȣ, IsuNo, IsuNo, char, 12;
		�ֹ�����, OrdQty, OrdQty, long, 16;
		�ֹ���, OrdPrc, OrdPrc, double, 13.2;
		�Ÿű���, BnsTpCode, BnsTpCode, char, 1;
		ȣ�������ڵ�, OrdprcPtnCode, OrdprcPtnCode, char, 2;
		���α׷�ȣ�������ڵ�, PrgmOrdprcPtnCode, PrgmOrdprcPtnCode, char, 2;
		���ŵ����ɿ���, StslAbleYn, StslAbleYn, char, 1;
		���ŵ�ȣ������, StslOrdprcTpCode, StslOrdprcTpCode, char, 1;
		��Ÿ�ü�ڵ�, CommdaCode, CommdaCode, char, 2;
		�ſ�ŷ��ڵ�, MgntrnCode, MgntrnCode, char, 3;
		������, LoanDt, LoanDt, char, 8;
		ȸ����ȣ, MbrNo, MbrNo, char, 3;
		�ֹ����Ǳ���, OrdCndiTpCode, OrdCndiTpCode, char, 1;
		�����ڵ�, StrtgCode, StrtgCode, char, 6;
		�׷�ID, GrpId, GrpId, char, 20;
		�ֹ�ȸ��, OrdSeqNo, OrdSeqNo, long, 10;
		��Ʈ��������ȣ, PtflNo, PtflNo, long, 10;
		�ٽ��Ϲ�ȣ, BskNo, BskNo, long, 10;
		Ʈ��ġ��ȣ, TrchNo, TrchNo, long, 10;
		�����۹�ȣ, ItemNo, ItemNo, long, 10;
		������ù�ȣ, OpDrtnNo, OpDrtnNo, char, 12;
		�����������ڿ���, LpYn, LpYn, char, 1;
		�ݴ�Ÿű���, CvrgTpCode, CvrgTpCode, char, 1;
	end
	CSPAT00600OutBlock2,Out(*EMPTY*),output;
	begin
		���ڵ尹��, RecCnt, RecCnt, long, 5
		�ֹ���ȣ, OrdNo, OrdNo, long, 10;
		�ֹ��ð�, OrdTime, OrdTime, char, 9;
		�ֹ������ڵ�, OrdMktCode, OrdMktCode, char, 2;
		�ֹ������ڵ�, OrdPtnCode, OrdPtnCode, char, 2;
		���������ȣ, ShtnIsuNo, ShtnIsuNo, char, 9;
		���������ȣ, MgempNo, MgempNo, char, 9;
		�ֹ��ݾ�, OrdAmt, OrdAmt, long, 16;
		�����ֹ���ȣ, SpareOrdNo, SpareOrdNo, long, 10;
		�ݴ�Ÿ��Ϸù�ȣ, CvrgSeqno, CvrgSeqno, long, 10;
		�����ֹ���ȣ, RsvOrdNo, RsvOrdNo, long, 10;
		�ǹ��ֹ�����, SpotOrdQty, SpotOrdQty, long, 16;
		�����ֹ�����, RuseOrdQty, RuseOrdQty, long, 16;
		�����ֹ��ݾ�, MnyOrdAmt, MnyOrdAmt, long, 16;
		����ֹ��ݾ�, SubstOrdAmt, SubstOrdAmt, long, 16;
		�����ֹ��ݾ�, RuseOrdAmt, RuseOrdAmt, long, 16;
		���¸�, AcntNm, AcntNm, char, 40;
		�����, IsuNm, IsuNm, char, 40;
	end
	END_DATA_MAP
END_FUNCTION_MAP
CSPAT00600