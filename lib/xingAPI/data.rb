require 'ffi'

module XingAPI
  class Struct < FFI::Struct
    def self.of(pointer)
      new(FFI::Pointer.new(pointer))
    end

    def members
      super.reject do |member|
        member.to_s.start_with?('_') || member == :eos
      end
    end

    def try_convert(value)
      case value
      when FFI::StructLayout::CharArray
        value.to_ptr.read_string.force_encoding('cp949')
      when Struct
        value.to_hash
      else
        value
      end
    end

    def to_hash
      Hash[members.map { |m| [m, try_convert(self[m])] }]
    end
  end
end

data_dir = File.expand_path('../data', __FILE__)
Dir["#{data_dir}/*.rb"].each do |filename|
  require filename
end

module XingAPI
  class RECV_PACKET < Struct
    pack 1
    layout \
      :nRqID, :int,
      :nDataLength, :int,
      :nTotalDataBufferSize, :int,
      :nElapsedTime, :int,
      :nDataMode, :int,
      :szTrCode, [:char, 11],
      :cCont, [:char, 1],
      :szContKey, [:char, 19],
      :szUserData, [:char, 31],
      :szBlockName, [:char, 17],
      :lpData, :pointer

    def nRqID; self[:nRqID]; end
    def nDataLength; self[:nDataLength]; end
    def nTotalDataBufferSize; self[:nTotalDataBufferSize]; end
    def nElapsedTime; self[:nElapsedTime]; end
    def nDataMode; self[:nDataMode]; end
    def szTrCode; self[:szTrCode].to_ptr.read_string; end
    def cCont; self[:cCont].to_ptr.read_string; end
    def szContKey; self[:szContKey].to_ptr.read_string; end
    def szUserData; self[:szUserData].to_ptr.read_string; end
    def szBlockName; self[:szBlockName].to_ptr.read_string; end
    def lpData; self[:lpData]; end

    class NilData
      def to_hash
        nil
      end
    end

    def data
      klass = ::XingAPI.const_get("STRUCT_#{szTrCode}OutBlock")
      if nDataLength != klass.size
        ::XingAPI::logger.warn do
          'Size is different:' \
          "nDataLength(#{nDataLength}) != klass.size(#{klass.size})"
        end
      end
      if nDataLength == 0
        ::XingAPI::logger.warn { 'Size is 0'}
        NilData.new
      else
        klass.of(lpData)
      end
    end

    def to_s
      %{[#{szTrCode}] "#{szBlockName}" (#{nDataLength})}
    end
  end

  class MSG_PACKET < Struct
    pack 1
    layout \
      :nRqID, :int,
      :nIsSystemError, :int,
      :szMsgCode, [:char, 6],
      :nMsgLength, :int,
      :lpszMessageData, :string

    def nRqID; self[:nRqID]; end
    def nIsSystemError; self[:nIsSystemError]; end
    def szMsgCode; self[:szMsgCode].to_ptr.read_string; end
    def nMsgLength; self[:nMsgLength]; end
    def lpszMessageData; self[:lpszMessageData].force_encoding('cp949'); end

    def to_s
      "[#{szMsgCode}] #{lpszMessageData}"
    end
  end
end