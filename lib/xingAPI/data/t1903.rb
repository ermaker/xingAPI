require 'ffi'

# ATTR, BLOCK, HEADTYPE=A
module XingAPI
  class STRUCT_t1903InBlock < Struct
    pack 1
    layout \
      :shcode, [:char, 6], :_shcode, :char, # string, 6, 단축코드
      :date, [:char, 8], :_date, :char, # string, 8, 일자
      :eos, [:char, 0]

    def type
      @type ||= {
        shcode: {type: :string, size: '6'},
        date: {type: :string, size: '8'}
      }
    end
  end

  class STRUCT_t1903OutBlock < Struct
    pack 1
    layout \
      :date, [:char, 8], :_date, :char, # string, 8, 일자
      :hname, [:char, 20], :_hname, :char, # string, 20, 종목명
      :upname, [:char, 20], :_upname, :char, # string, 20, 업종지수명
      :eos, [:char, 0]

    def type
      @type ||= {
        date: {type: :string, size: '8'},
        hname: {type: :string, size: '20'},
        upname: {type: :string, size: '20'}
      }
    end
  end

  class STRUCT_t1903OutBlock1 < Struct
    pack 1
    layout \
      :date, [:char, 8], :_date, :char, # string, 8, 일자
      :price, [:char, 8], :_price, :char, # long, 8, 현재가
      :sign, [:char, 1], :_sign, :char, # string, 1, 전일대비구분
      :change, [:char, 8], :_change, :char, # long, 8, 전일대비
      :volume, [:char, 12], :_volume, :char, # float, 12, 누적거래량
      :navdiff, [:char, 9], :_navdiff, :char, # float, 9.2, NAV대비
      :nav, [:char, 9], :_nav, :char, # float, 9.2, NAV
      :navchange, [:char, 9], :_navchange, :char, # float, 9.2, 전일대비
      :crate, [:char, 9], :_crate, :char, # float, 9.2, 추적오차
      :grate, [:char, 9], :_grate, :char, # float, 9.2, 괴리
      :jisu, [:char, 8], :_jisu, :char, # float, 8.2, 지수
      :jichange, [:char, 8], :_jichange, :char, # float, 8.2, 전일대비
      :jirate, [:char, 8], :_jirate, :char, # float, 8.2, 전일대비율
      :eos, [:char, 0]

    def type
      @type ||= {
        date: {type: :string, size: '8'},
        price: {type: :long, size: '8'},
        sign: {type: :string, size: '1'},
        change: {type: :long, size: '8'},
        volume: {type: :float, size: '12'},
        navdiff: {type: :float, size: '9.2'},
        nav: {type: :float, size: '9.2'},
        navchange: {type: :float, size: '9.2'},
        crate: {type: :float, size: '9.2'},
        grate: {type: :float, size: '9.2'},
        jisu: {type: :float, size: '8.2'},
        jichange: {type: :float, size: '8.2'},
        jirate: {type: :float, size: '8.2'}
      }
    end
  end


end
