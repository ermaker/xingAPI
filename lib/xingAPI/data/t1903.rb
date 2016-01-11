require 'ffi'

module XingAPI
  class STRUCT_t1903InBlock < Struct
    pack 1
    layout \
      :shcode, [:char, 6],
      :_shcode, [:char, 1],
      :date, [:char, 8],
      :_date, [:char, 1],
      :eos, [:char, 0]
  end
  class STRUCT_t1903OutBlock < Struct
    pack 1
    layout \
      :date, [:char, 8],
      :_date, [:char, 1],
      :hname, [:char, 20],
      :_hname, [:char, 1],
      :upname, [:char, 20],
      :_upname, [:char, 1],
      :eos, [:char, 0]
  end
  class STRUCT_t1903OutBlock1 < Struct
    pack 1
    layout \
      :date, [:char, 8],
      :_date, [:char, 1],
      :price, [:char, 8],
      :_price, [:char, 1],
      :sign, [:char, 1],
      :_sign, [:char, 1],
      :change, [:char, 8],
      :_change, [:char, 1],
      :volume, [:char, 12],
      :_volume, [:char, 1],
      :navdiff, [:char, 9],
      :_navdiff, [:char, 1],
      :nav, [:char, 9],
      :_nav, [:char, 1],
      :navchange, [:char, 9],
      :_navchange, [:char, 1],
      :crate, [:char, 9],
      :_crate, [:char, 1],
      :grate, [:char, 9],
      :_grate, [:char, 1],
      :jisu, [:char, 8],
      :_jisu, [:char, 1],
      :jichange, [:char, 8],
      :_jichange, [:char, 1],
      :jirate, [:char, 8],
      :_jirate, [:char, 1],
      :eos, [:char, 0]
  end

=begin
  class STRUCT_t1903OutBlock < Struct
    pack 1
    layout \
      :STRUCT_t1903OutBlock1, STRUCT_t1903OutBlock1,
      :eos, [:char, 0]
  end
=end
end
