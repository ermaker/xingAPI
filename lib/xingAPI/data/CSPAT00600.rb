require 'ffi'

module XingAPI
  class STRUCT_CSPAT00600InBlock1 < FFI::Struct
    pack 1
    layout \
          :AcntNo, [:char, 20],
          :InptPwd, [:char, 8],
          :IsuNo, [:char, 12],
          :OrdQty, [:char, 16],
          :OrdPrc, [:char, 13],
          :BnsTpCode, [:char, 1],
          :OrdprcPtnCode, [:char, 2],
          :MgntrnCode, [:char, 3],
          :LoanDt, [:char, 8],
          :OrdCndiTpCode, [:char, 1],
          :eos, [:char, 0]

    def self.of(pointer)
      new(FFI::Pointer.new(pointer))
    end

    def members
      super.reject do |member|
        member.to_s.start_with?('_') || member == :eos
      end
    end

    def try_string(value)
      case value
      when FFI::StructLayout::CharArray
        value.to_ptr.read_string.force_encoding('cp949')
      else
        value
      end
    end

    def to_hash
      Hash[
        members.map do |m|
          v = self[m]
          v = try_string(v)
          [m, v]
        end
      ]
    end
  end
  class STRUCT_CSPAT00600OutBlock1 < FFI::Struct
    pack 1
    layout \
          :RecCnt, [:char, 5],
          :AcntNo, [:char, 20],
          :InptPwd, [:char, 8],
          :IsuNo, [:char, 12],
          :OrdQty, [:char, 16],
          :OrdPrc, [:char, 13],
          :BnsTpCode, [:char, 1],
          :OrdprcPtnCode, [:char, 2],
          :PrgmOrdprcPtnCode, [:char, 2],
          :StslAbleYn, [:char, 1],
          :StslOrdprcTpCode, [:char, 1],
          :CommdaCode, [:char, 2],
          :MgntrnCode, [:char, 3],
          :LoanDt, [:char, 8],
          :MbrNo, [:char, 3],
          :OrdCndiTpCode, [:char, 1],
          :StrtgCode, [:char, 6],
          :GrpId, [:char, 20],
          :OrdSeqNo, [:char, 10],
          :PtflNo, [:char, 10],
          :BskNo, [:char, 10],
          :TrchNo, [:char, 10],
          :ItemNo, [:char, 10],
          :OpDrtnNo, [:char, 12],
          :LpYn, [:char, 1],
          :CvrgTpCode, [:char, 1],
          :eos, [:char, 0]

    def self.of(pointer)
      new(FFI::Pointer.new(pointer))
    end

    def members
      super.reject do |member|
        member.to_s.start_with?('_') || member == :eos
      end
    end

    def try_string(value)
      case value
      when FFI::StructLayout::CharArray
        value.to_ptr.read_string.force_encoding('cp949')
      else
        value
      end
    end

    def to_hash
      Hash[
        members.map do |m|
          v = self[m]
          v = try_string(v)
          [m, v]
        end
      ]
    end
  end
  class STRUCT_CSPAT00600OutBlock2 < FFI::Struct
    pack 1
    layout \
          :RecCnt, [:char, 5],
          :OrdNo, [:char, 10],
          :OrdTime, [:char, 9],
          :OrdMktCode, [:char, 2],
          :OrdPtnCode, [:char, 2],
          :ShtnIsuNo, [:char, 9],
          :MgempNo, [:char, 9],
          :OrdAmt, [:char, 16],
          :SpareOrdNo, [:char, 10],
          :CvrgSeqno, [:char, 10],
          :RsvOrdNo, [:char, 10],
          :SpotOrdQty, [:char, 16],
          :RuseOrdQty, [:char, 16],
          :MnyOrdAmt, [:char, 16],
          :SubstOrdAmt, [:char, 16],
          :RuseOrdAmt, [:char, 16],
          :AcntNm, [:char, 40],
          :IsuNm, [:char, 40],
          :eos, [:char, 0]

    def self.of(pointer)
      new(FFI::Pointer.new(pointer))
    end

    def members
      super.reject do |member|
        member.to_s.start_with?('_') || member == :eos
      end
    end

    def try_string(value)
      case value
      when FFI::StructLayout::CharArray
        value.to_ptr.read_string.force_encoding('cp949')
      else
        value
      end
    end

    def to_hash
      Hash[
        members.map do |m|
          v = self[m]
          v = try_string(v)
          [m, v]
        end
      ]
    end
  end
end
