require 'ffi'

# ATTR, BLOCK, HEADTYPE=A
module XingAPI
  class STRUCT_t1901InBlock < Struct
    pack 1
    layout \
      :shcode, [:char, 6], :_shcode, :char, # string, 6, 단축코드
      :eos, [:char, 0]

    def type
      @type ||= {
        shcode: {type: :string, size: '6'}
      }
    end
  end

  class STRUCT_t1901OutBlock < Struct
    pack 1
    layout \
      :hname, [:char, 20], :_hname, :char, # string, 20, 한글명
      :price, [:char, 8], :_price, :char, # long, 8, 현재가
      :sign, [:char, 1], :_sign, :char, # string, 1, 전일대비구분
      :change, [:char, 8], :_change, :char, # long, 8, 전일대비
      :diff, [:char, 6], :_diff, :char, # float, 6.2, 등락율
      :volume, [:char, 12], :_volume, :char, # float, 12, 누적거래량
      :recprice, [:char, 8], :_recprice, :char, # long, 8, 기준가
      :avg, [:char, 8], :_avg, :char, # long, 8, 가중평균
      :uplmtprice, [:char, 8], :_uplmtprice, :char, # long, 8, 상한가
      :dnlmtprice, [:char, 8], :_dnlmtprice, :char, # long, 8, 하한가
      :jnilvolume, [:char, 12], :_jnilvolume, :char, # float, 12, 전일거래량
      :volumediff, [:char, 12], :_volumediff, :char, # long, 12, 거래량차
      :open, [:char, 8], :_open, :char, # long, 8, 시가
      :opentime, [:char, 6], :_opentime, :char, # string, 6, 시가시간
      :high, [:char, 8], :_high, :char, # long, 8, 고가
      :hightime, [:char, 6], :_hightime, :char, # string, 6, 고가시간
      :low, [:char, 8], :_low, :char, # long, 8, 저가
      :lowtime, [:char, 6], :_lowtime, :char, # string, 6, 저가시간
      :high52w, [:char, 8], :_high52w, :char, # long, 8, 52최고가
      :high52wdate, [:char, 8], :_high52wdate, :char, # string, 8, 52최고가일
      :low52w, [:char, 8], :_low52w, :char, # long, 8, 52최저가
      :low52wdate, [:char, 8], :_low52wdate, :char, # string, 8, 52최저가일
      :exhratio, [:char, 6], :_exhratio, :char, # float, 6.2, 소진율
      :flmtvol, [:char, 12], :_flmtvol, :char, # float, 12, 외국인보유수량
      :per, [:char, 6], :_per, :char, # float, 6.2, PER
      :listing, [:char, 12], :_listing, :char, # long, 12, 상장주식수(천)
      :jkrate, [:char, 8], :_jkrate, :char, # long, 8, 증거금율
      :vol, [:char, 6], :_vol, :char, # float, 6.2, 회전율
      :shcode, [:char, 6], :_shcode, :char, # string, 6, 단축코드
      :value, [:char, 12], :_value, :char, # long, 12, 누적거래대금
      :highyear, [:char, 8], :_highyear, :char, # long, 8, 연중최고가
      :highyeardate, [:char, 8], :_highyeardate, :char, # string, 8, 연중최고일자
      :lowyear, [:char, 8], :_lowyear, :char, # long, 8, 연중최저가
      :lowyeardate, [:char, 8], :_lowyeardate, :char, # string, 8, 연중최저일자
      :upname, [:char, 20], :_upname, :char, # string, 20, 업종명
      :upcode, [:char, 3], :_upcode, :char, # string, 3, 업종코드
      :upprice, [:char, 7], :_upprice, :char, # float, 7.2, 업종현재가
      :upsign, [:char, 1], :_upsign, :char, # string, 1, 업종전일비구분
      :upchange, [:char, 6], :_upchange, :char, # float, 6.2, 업종전일대비
      :updiff, [:char, 6], :_updiff, :char, # float, 6.2, 업종등락율
      :futname, [:char, 20], :_futname, :char, # string, 20, 선물최근월물명
      :futcode, [:char, 8], :_futcode, :char, # string, 8, 선물최근월물코드
      :futprice, [:char, 6], :_futprice, :char, # float, 6.2, 선물현재가
      :futsign, [:char, 1], :_futsign, :char, # string, 1, 선물전일비구분
      :futchange, [:char, 6], :_futchange, :char, # float, 6.2, 선물전일대비
      :futdiff, [:char, 6], :_futdiff, :char, # float, 6.2, 선물등락율
      :nav, [:char, 8], :_nav, :char, # float, 8.2, NAV
      :navsign, [:char, 1], :_navsign, :char, # string, 1, NAV전일대비구분
      :navchange, [:char, 8], :_navchange, :char, # float, 8.2, NAV전일대비
      :navdiff, [:char, 6], :_navdiff, :char, # float, 6.2, NAV등락율
      :cocrate, [:char, 6], :_cocrate, :char, # float, 6.2, 추적오차율
      :kasis, [:char, 6], :_kasis, :char, # float, 6.2, 괴리율
      :subprice, [:char, 10], :_subprice, :char, # long, 10, 대용가
      :offerno1, [:char, 6], :_offerno1, :char, # string, 6, 매도증권사코드1
      :bidno1, [:char, 6], :_bidno1, :char, # string, 6, 매수증권사코드1
      :dvol1, [:char, 8], :_dvol1, :char, # long, 8, 총매도수량1
      :svol1, [:char, 8], :_svol1, :char, # long, 8, 총매수수량1
      :dcha1, [:char, 8], :_dcha1, :char, # long, 8, 매도증감1
      :scha1, [:char, 8], :_scha1, :char, # long, 8, 매수증감1
      :ddiff1, [:char, 6], :_ddiff1, :char, # float, 6.2, 매도비율1
      :sdiff1, [:char, 6], :_sdiff1, :char, # float, 6.2, 매수비율1
      :offerno2, [:char, 6], :_offerno2, :char, # string, 6, 매도증권사코드2
      :bidno2, [:char, 6], :_bidno2, :char, # string, 6, 매수증권사코드2
      :dvol2, [:char, 8], :_dvol2, :char, # long, 8, 총매도수량2
      :svol2, [:char, 8], :_svol2, :char, # long, 8, 총매수수량2
      :dcha2, [:char, 8], :_dcha2, :char, # long, 8, 매도증감2
      :scha2, [:char, 8], :_scha2, :char, # long, 8, 매수증감2
      :ddiff2, [:char, 6], :_ddiff2, :char, # float, 6.2, 매도비율2
      :sdiff2, [:char, 6], :_sdiff2, :char, # float, 6.2, 매수비율2
      :offerno3, [:char, 6], :_offerno3, :char, # string, 6, 매도증권사코드3
      :bidno3, [:char, 6], :_bidno3, :char, # string, 6, 매수증권사코드3
      :dvol3, [:char, 8], :_dvol3, :char, # long, 8, 총매도수량3
      :svol3, [:char, 8], :_svol3, :char, # long, 8, 총매수수량3
      :dcha3, [:char, 8], :_dcha3, :char, # long, 8, 매도증감3
      :scha3, [:char, 8], :_scha3, :char, # long, 8, 매수증감3
      :ddiff3, [:char, 6], :_ddiff3, :char, # float, 6.2, 매도비율3
      :sdiff3, [:char, 6], :_sdiff3, :char, # float, 6.2, 매수비율3
      :offerno4, [:char, 6], :_offerno4, :char, # string, 6, 매도증권사코드4
      :bidno4, [:char, 6], :_bidno4, :char, # string, 6, 매수증권사코드4
      :dvol4, [:char, 8], :_dvol4, :char, # long, 8, 총매도수량4
      :svol4, [:char, 8], :_svol4, :char, # long, 8, 총매수수량4
      :dcha4, [:char, 8], :_dcha4, :char, # long, 8, 매도증감4
      :scha4, [:char, 8], :_scha4, :char, # long, 8, 매수증감4
      :ddiff4, [:char, 6], :_ddiff4, :char, # float, 6.2, 매도비율4
      :sdiff4, [:char, 6], :_sdiff4, :char, # float, 6.2, 매수비율4
      :offerno5, [:char, 6], :_offerno5, :char, # string, 6, 매도증권사코드5
      :bidno5, [:char, 6], :_bidno5, :char, # string, 6, 매수증권사코드5
      :dvol5, [:char, 8], :_dvol5, :char, # long, 8, 총매도수량5
      :svol5, [:char, 8], :_svol5, :char, # long, 8, 총매수수량5
      :dcha5, [:char, 8], :_dcha5, :char, # long, 8, 매도증감5
      :scha5, [:char, 8], :_scha5, :char, # long, 8, 매수증감5
      :ddiff5, [:char, 6], :_ddiff5, :char, # float, 6.2, 매도비율5
      :sdiff5, [:char, 6], :_sdiff5, :char, # float, 6.2, 매수비율5
      :fwdvl, [:char, 12], :_fwdvl, :char, # long, 12, 외국계매도합계수량
      :ftradmdcha, [:char, 12], :_ftradmdcha, :char, # long, 12, 외국계매도직전대비
      :ftradmddiff, [:char, 6], :_ftradmddiff, :char, # float, 6.2, 외국계매도비율
      :fwsvl, [:char, 12], :_fwsvl, :char, # long, 12, 외국계매수합계수량
      :ftradmscha, [:char, 12], :_ftradmscha, :char, # long, 12, 외국계매수직전대비
      :ftradmsdiff, [:char, 6], :_ftradmsdiff, :char, # float, 6.2, 외국계매수비율
      :upname2, [:char, 20], :_upname2, :char, # string, 20, 참고지수명
      :upcode2, [:char, 3], :_upcode2, :char, # string, 3, 참고지수코드
      :upprice2, [:char, 7], :_upprice2, :char, # float, 7.2, 참고지수현재가
      :jnilnav, [:char, 8], :_jnilnav, :char, # float, 8.2, 전일NAV
      :jnilnavsign, [:char, 1], :_jnilnavsign, :char, # string, 1, 전일NAV전일대비구분
      :jnilnavchange, [:char, 8], :_jnilnavchange, :char, # float, 8.2, 전일NAV전일대비
      :jnilnavdiff, [:char, 6], :_jnilnavdiff, :char, # float, 6.2, 전일NAV등락율
      :etftotcap, [:char, 12], :_etftotcap, :char, # long, 12, 순자산총액(억원)
      :spread, [:char, 6], :_spread, :char, # float, 6.2, 스프레드
      :leverage, [:char, 2], :_leverage, :char, # long, 2, 레버리지
      :taxgubun, [:char, 1], :_taxgubun, :char, # string, 1, 과세구분
      :opcom_nmk, [:char, 20], :_opcom_nmk, :char, # string, 20, 운용사
      :lp_nm1, [:char, 20], :_lp_nm1, :char, # string, 20, LP1
      :lp_nm2, [:char, 20], :_lp_nm2, :char, # string, 20, LP2
      :lp_nm3, [:char, 20], :_lp_nm3, :char, # string, 20, LP3
      :lp_nm4, [:char, 20], :_lp_nm4, :char, # string, 20, LP4
      :lp_nm5, [:char, 20], :_lp_nm5, :char, # string, 20, LP5
      :etf_cp, [:char, 10], :_etf_cp, :char, # string, 10, 복제방법
      :etf_kind, [:char, 10], :_etf_kind, :char, # string, 10, 상품유형
      :vi_gubun, [:char, 10], :_vi_gubun, :char, # string, 10, VI발동해제
      :etn_kind_cd, [:char, 20], :_etn_kind_cd, :char, # string, 20, ETN상품분류
      :lastymd, [:char, 8], :_lastymd, :char, # string, 8, ETN만기일
      :payday, [:char, 8], :_payday, :char, # string, 8, ETN지급일
      :lastdate, [:char, 8], :_lastdate, :char, # string, 8, ETN최종거래일
      :issuernmk, [:char, 20], :_issuernmk, :char, # string, 20, ETN발행시장참가자
      :last_sdate, [:char, 8], :_last_sdate, :char, # string, 8, ETN만기상환가격결정시작일
      :last_edate, [:char, 8], :_last_edate, :char, # string, 8, ETN만기상환가격결정종료일
      :lp_holdvol, [:char, 12], :_lp_holdvol, :char, # string, 12, ETNLP보유수량
      :eos, [:char, 0]

    def type
      @type ||= {
        hname: {type: :string, size: '20'},
        price: {type: :long, size: '8'},
        sign: {type: :string, size: '1'},
        change: {type: :long, size: '8'},
        diff: {type: :float, size: '6.2'},
        volume: {type: :float, size: '12'},
        recprice: {type: :long, size: '8'},
        avg: {type: :long, size: '8'},
        uplmtprice: {type: :long, size: '8'},
        dnlmtprice: {type: :long, size: '8'},
        jnilvolume: {type: :float, size: '12'},
        volumediff: {type: :long, size: '12'},
        open: {type: :long, size: '8'},
        opentime: {type: :string, size: '6'},
        high: {type: :long, size: '8'},
        hightime: {type: :string, size: '6'},
        low: {type: :long, size: '8'},
        lowtime: {type: :string, size: '6'},
        high52w: {type: :long, size: '8'},
        high52wdate: {type: :string, size: '8'},
        low52w: {type: :long, size: '8'},
        low52wdate: {type: :string, size: '8'},
        exhratio: {type: :float, size: '6.2'},
        flmtvol: {type: :float, size: '12'},
        per: {type: :float, size: '6.2'},
        listing: {type: :long, size: '12'},
        jkrate: {type: :long, size: '8'},
        vol: {type: :float, size: '6.2'},
        shcode: {type: :string, size: '6'},
        value: {type: :long, size: '12'},
        highyear: {type: :long, size: '8'},
        highyeardate: {type: :string, size: '8'},
        lowyear: {type: :long, size: '8'},
        lowyeardate: {type: :string, size: '8'},
        upname: {type: :string, size: '20'},
        upcode: {type: :string, size: '3'},
        upprice: {type: :float, size: '7.2'},
        upsign: {type: :string, size: '1'},
        upchange: {type: :float, size: '6.2'},
        updiff: {type: :float, size: '6.2'},
        futname: {type: :string, size: '20'},
        futcode: {type: :string, size: '8'},
        futprice: {type: :float, size: '6.2'},
        futsign: {type: :string, size: '1'},
        futchange: {type: :float, size: '6.2'},
        futdiff: {type: :float, size: '6.2'},
        nav: {type: :float, size: '8.2'},
        navsign: {type: :string, size: '1'},
        navchange: {type: :float, size: '8.2'},
        navdiff: {type: :float, size: '6.2'},
        cocrate: {type: :float, size: '6.2'},
        kasis: {type: :float, size: '6.2'},
        subprice: {type: :long, size: '10'},
        offerno1: {type: :string, size: '6'},
        bidno1: {type: :string, size: '6'},
        dvol1: {type: :long, size: '8'},
        svol1: {type: :long, size: '8'},
        dcha1: {type: :long, size: '8'},
        scha1: {type: :long, size: '8'},
        ddiff1: {type: :float, size: '6.2'},
        sdiff1: {type: :float, size: '6.2'},
        offerno2: {type: :string, size: '6'},
        bidno2: {type: :string, size: '6'},
        dvol2: {type: :long, size: '8'},
        svol2: {type: :long, size: '8'},
        dcha2: {type: :long, size: '8'},
        scha2: {type: :long, size: '8'},
        ddiff2: {type: :float, size: '6.2'},
        sdiff2: {type: :float, size: '6.2'},
        offerno3: {type: :string, size: '6'},
        bidno3: {type: :string, size: '6'},
        dvol3: {type: :long, size: '8'},
        svol3: {type: :long, size: '8'},
        dcha3: {type: :long, size: '8'},
        scha3: {type: :long, size: '8'},
        ddiff3: {type: :float, size: '6.2'},
        sdiff3: {type: :float, size: '6.2'},
        offerno4: {type: :string, size: '6'},
        bidno4: {type: :string, size: '6'},
        dvol4: {type: :long, size: '8'},
        svol4: {type: :long, size: '8'},
        dcha4: {type: :long, size: '8'},
        scha4: {type: :long, size: '8'},
        ddiff4: {type: :float, size: '6.2'},
        sdiff4: {type: :float, size: '6.2'},
        offerno5: {type: :string, size: '6'},
        bidno5: {type: :string, size: '6'},
        dvol5: {type: :long, size: '8'},
        svol5: {type: :long, size: '8'},
        dcha5: {type: :long, size: '8'},
        scha5: {type: :long, size: '8'},
        ddiff5: {type: :float, size: '6.2'},
        sdiff5: {type: :float, size: '6.2'},
        fwdvl: {type: :long, size: '12'},
        ftradmdcha: {type: :long, size: '12'},
        ftradmddiff: {type: :float, size: '6.2'},
        fwsvl: {type: :long, size: '12'},
        ftradmscha: {type: :long, size: '12'},
        ftradmsdiff: {type: :float, size: '6.2'},
        upname2: {type: :string, size: '20'},
        upcode2: {type: :string, size: '3'},
        upprice2: {type: :float, size: '7.2'},
        jnilnav: {type: :float, size: '8.2'},
        jnilnavsign: {type: :string, size: '1'},
        jnilnavchange: {type: :float, size: '8.2'},
        jnilnavdiff: {type: :float, size: '6.2'},
        etftotcap: {type: :long, size: '12'},
        spread: {type: :float, size: '6.2'},
        leverage: {type: :long, size: '2'},
        taxgubun: {type: :string, size: '1'},
        opcom_nmk: {type: :string, size: '20'},
        lp_nm1: {type: :string, size: '20'},
        lp_nm2: {type: :string, size: '20'},
        lp_nm3: {type: :string, size: '20'},
        lp_nm4: {type: :string, size: '20'},
        lp_nm5: {type: :string, size: '20'},
        etf_cp: {type: :string, size: '10'},
        etf_kind: {type: :string, size: '10'},
        vi_gubun: {type: :string, size: '10'},
        etn_kind_cd: {type: :string, size: '20'},
        lastymd: {type: :string, size: '8'},
        payday: {type: :string, size: '8'},
        lastdate: {type: :string, size: '8'},
        issuernmk: {type: :string, size: '20'},
        last_sdate: {type: :string, size: '8'},
        last_edate: {type: :string, size: '8'},
        lp_holdvol: {type: :string, size: '12'}
      }
    end
  end


end
