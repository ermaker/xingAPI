require 'ffi'

# SERVICE=CSPAT00600, ENCRYPT, SIGNATURE, HEADTYPE=B, CREATOR=김기종, CREDATE=2011/12/07 09:23:39
module XingAPI
  class STRUCT_CSPAT00600InBlock1 < Struct
    pack 1
    layout \
      :AcntNo, [:char, 20], # string, 20, 계좌번호
      :InptPwd, [:char, 8], # string, 8, 입력비밀번호
      :IsuNo, [:char, 12], # string, 12, 종목번호
      :OrdQty, [:char, 16], # long, 16, 주문수량
      :OrdPrc, [:char, 13], # double, 13.2, 주문가
      :BnsTpCode, [:char, 1], # string, 1, 매매구분
      :OrdprcPtnCode, [:char, 2], # string, 2, 호가유형코드
      :MgntrnCode, [:char, 3], # string, 3, 신용거래코드
      :LoanDt, [:char, 8], # string, 8, 대출일
      :OrdCndiTpCode, [:char, 1], # string, 1, 주문조건구분
      :eos, [:char, 0]

    def type
      @type ||= {
        AcntNo: {type: :string, size: '20'},
        InptPwd: {type: :string, size: '8'},
        IsuNo: {type: :string, size: '12'},
        OrdQty: {type: :long, size: '16'},
        OrdPrc: {type: :double, size: '13.2'},
        BnsTpCode: {type: :string, size: '1'},
        OrdprcPtnCode: {type: :string, size: '2'},
        MgntrnCode: {type: :string, size: '3'},
        LoanDt: {type: :string, size: '8'},
        OrdCndiTpCode: {type: :string, size: '1'}
      }
    end
  end

  class STRUCT_CSPAT00600OutBlock1 < Struct
    pack 1
    layout \
      :RecCnt, [:char, 5], # long, 5, 레코드갯수
      :AcntNo, [:char, 20], # string, 20, 계좌번호
      :InptPwd, [:char, 8], # string, 8, 입력비밀번호
      :IsuNo, [:char, 12], # string, 12, 종목번호
      :OrdQty, [:char, 16], # long, 16, 주문수량
      :OrdPrc, [:char, 13], # double, 13.2, 주문가
      :BnsTpCode, [:char, 1], # string, 1, 매매구분
      :OrdprcPtnCode, [:char, 2], # string, 2, 호가유형코드
      :PrgmOrdprcPtnCode, [:char, 2], # string, 2, 프로그램호가유형코드
      :StslAbleYn, [:char, 1], # string, 1, 공매도가능여부
      :StslOrdprcTpCode, [:char, 1], # string, 1, 공매도호가구분
      :CommdaCode, [:char, 2], # string, 2, 통신매체코드
      :MgntrnCode, [:char, 3], # string, 3, 신용거래코드
      :LoanDt, [:char, 8], # string, 8, 대출일
      :MbrNo, [:char, 3], # string, 3, 회원번호
      :OrdCndiTpCode, [:char, 1], # string, 1, 주문조건구분
      :StrtgCode, [:char, 6], # string, 6, 전략코드
      :GrpId, [:char, 20], # string, 20, 그룹ID
      :OrdSeqNo, [:char, 10], # long, 10, 주문회차
      :PtflNo, [:char, 10], # long, 10, 포트폴리오번호
      :BskNo, [:char, 10], # long, 10, 바스켓번호
      :TrchNo, [:char, 10], # long, 10, 트렌치번호
      :ItemNo, [:char, 10], # long, 10, 아이템번호
      :OpDrtnNo, [:char, 12], # string, 12, 운용지시번호
      :LpYn, [:char, 1], # string, 1, 유동성공급자여부
      :CvrgTpCode, [:char, 1], # string, 1, 반대매매구분
      :eos, [:char, 0]

    def type
      @type ||= {
        RecCnt: {type: :long, size: '5'},
        AcntNo: {type: :string, size: '20'},
        InptPwd: {type: :string, size: '8'},
        IsuNo: {type: :string, size: '12'},
        OrdQty: {type: :long, size: '16'},
        OrdPrc: {type: :double, size: '13.2'},
        BnsTpCode: {type: :string, size: '1'},
        OrdprcPtnCode: {type: :string, size: '2'},
        PrgmOrdprcPtnCode: {type: :string, size: '2'},
        StslAbleYn: {type: :string, size: '1'},
        StslOrdprcTpCode: {type: :string, size: '1'},
        CommdaCode: {type: :string, size: '2'},
        MgntrnCode: {type: :string, size: '3'},
        LoanDt: {type: :string, size: '8'},
        MbrNo: {type: :string, size: '3'},
        OrdCndiTpCode: {type: :string, size: '1'},
        StrtgCode: {type: :string, size: '6'},
        GrpId: {type: :string, size: '20'},
        OrdSeqNo: {type: :long, size: '10'},
        PtflNo: {type: :long, size: '10'},
        BskNo: {type: :long, size: '10'},
        TrchNo: {type: :long, size: '10'},
        ItemNo: {type: :long, size: '10'},
        OpDrtnNo: {type: :string, size: '12'},
        LpYn: {type: :string, size: '1'},
        CvrgTpCode: {type: :string, size: '1'}
      }
    end
  end

  class STRUCT_CSPAT00600OutBlock2 < Struct
    pack 1
    layout \
      :RecCnt, [:char, 5], # long, 5, 레코드갯수
      :OrdNo, [:char, 10], # long, 10, 주문번호
      :OrdTime, [:char, 9], # string, 9, 주문시각
      :OrdMktCode, [:char, 2], # string, 2, 주문시장코드
      :OrdPtnCode, [:char, 2], # string, 2, 주문유형코드
      :ShtnIsuNo, [:char, 9], # string, 9, 단축종목번호
      :MgempNo, [:char, 9], # string, 9, 관리사원번호
      :OrdAmt, [:char, 16], # long, 16, 주문금액
      :SpareOrdNo, [:char, 10], # long, 10, 예비주문번호
      :CvrgSeqno, [:char, 10], # long, 10, 반대매매일련번호
      :RsvOrdNo, [:char, 10], # long, 10, 예약주문번호
      :SpotOrdQty, [:char, 16], # long, 16, 실물주문수량
      :RuseOrdQty, [:char, 16], # long, 16, 재사용주문수량
      :MnyOrdAmt, [:char, 16], # long, 16, 현금주문금액
      :SubstOrdAmt, [:char, 16], # long, 16, 대용주문금액
      :RuseOrdAmt, [:char, 16], # long, 16, 재사용주문금액
      :AcntNm, [:char, 40], # string, 40, 계좌명
      :IsuNm, [:char, 40], # string, 40, 종목명
      :eos, [:char, 0]

    def type
      @type ||= {
        RecCnt: {type: :long, size: '5'},
        OrdNo: {type: :long, size: '10'},
        OrdTime: {type: :string, size: '9'},
        OrdMktCode: {type: :string, size: '2'},
        OrdPtnCode: {type: :string, size: '2'},
        ShtnIsuNo: {type: :string, size: '9'},
        MgempNo: {type: :string, size: '9'},
        OrdAmt: {type: :long, size: '16'},
        SpareOrdNo: {type: :long, size: '10'},
        CvrgSeqno: {type: :long, size: '10'},
        RsvOrdNo: {type: :long, size: '10'},
        SpotOrdQty: {type: :long, size: '16'},
        RuseOrdQty: {type: :long, size: '16'},
        MnyOrdAmt: {type: :long, size: '16'},
        SubstOrdAmt: {type: :long, size: '16'},
        RuseOrdAmt: {type: :long, size: '16'},
        AcntNm: {type: :string, size: '40'},
        IsuNm: {type: :string, size: '40'}
      }
    end
  end

  class STRUCT_CSPAT00600InBlock < Struct
    pack 1
    layout \
      :STRUCT_CSPAT00600InBlock1, STRUCT_CSPAT00600InBlock1,
      :eos, [:char, 0]

    def type
      @type ||= {
        STRUCT_CSPAT00600InBlock1: {type: :struct}
      }
    end
  end

  class STRUCT_CSPAT00600OutBlock < Struct
    pack 1
    layout \
      :STRUCT_CSPAT00600OutBlock1, STRUCT_CSPAT00600OutBlock1,
      :STRUCT_CSPAT00600OutBlock2, STRUCT_CSPAT00600OutBlock2,
      :eos, [:char, 0]

    def type
      @type ||= {
        STRUCT_CSPAT00600OutBlock1: {type: :struct},
        STRUCT_CSPAT00600OutBlock2: {type: :struct}
      }
    end
  end

end
