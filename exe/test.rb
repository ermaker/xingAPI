require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/windows'

win = XingAPI::Windows.new do |hwnd, msgid, wparam, lparam|
  puts "WM: #{hwnd}, #{msgid}, #{wparam}, #{lparam}"
  if msgid == 1024 + 5
    puts 'WM_LOGIN'
    message = [wparam, lparam].map do |param|
      FFI::Pointer.new(:string, param).read_string.force_encoding('cp949')
    end.join(': ')
    puts message
  end

  if msgid == 1024 + 3
    puts 'WM_RECEIVE_DATA'
    puts "wparam: #{wparam}"
    puts "lparam: #{lparam}"
    case wparam
    when 1 # Data
      # lparam is the RECV_PACKET
      class RECV_PACKET < FFI::Struct
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
      end
      recv = RECV_PACKET.new(FFI::Pointer.new(lparam))
      puts "recv: #{recv}"
      puts "nRqID: #{recv[:nRqID]}"
      puts "nDataLength: #{recv[:nDataLength]}"
      puts "nTotalDataBufferSize: #{recv[:nTotalDataBufferSize]}"
      puts "nElapsedTime: #{recv[:nElapsedTime]}"
      puts "nDataMode: #{recv[:nDataMode]}"
      puts "szTrCode: #{recv[:szTrCode].to_ptr.read_string}"
      puts "cCont: #{recv[:cCont].to_ptr.read_string}"
      puts "szContKey: #{recv[:szContKey].to_ptr.read_string}"
      puts "szUserData: #{recv[:szUserData].to_ptr.read_string}"
      puts "szBlockName: #{recv[:szBlockName].to_ptr.read_string}"
      puts "lpData: #{recv[:lpData]}"

      if recv[:szBlockName].to_ptr.read_string == 't1901OutBlock'
        class T1901OutBlock < FFI::Struct
          pack 1
          layout \
            :hname, [:char, 20], :hname_, :char,
            :price, [:char, 8], :price_, :char,
            :sign, [:char, 1], :sign_, :char,
            :change, [:char, 8], :change_, :char,
            :diff, [:char, 6], :diff_, :char,
            :volume, [:char, 12], :volume_, :char,
            :recprice, [:char, 8], :recprice_, :char,
            :avg, [:char, 8], :avg_, :char,
            :uplmtprice, [:char, 8], :uplmtprice_, :char,
            :dnlmtprice, [:char, 8], :dnlmtprice_, :char,
            :jnilvolume, [:char, 12], :jnilvolume_, :char,
            :volumediff, [:char, 12], :volumediff_, :char,
            :open, [:char, 8], :open_, :char,
            :opentime, [:char, 6], :opentime_, :char,
            :high, [:char, 8], :high_, :char,
            :hightime, [:char, 6], :hightime_, :char,
            :low, [:char, 8], :low_, :char,
            :lowtime, [:char, 6], :lowtime_, :char,
            :high52w, [:char, 8], :high52w_, :char,
            :high52wdate, [:char, 8], :high52wdate_, :char,
            :low52w, [:char, 8], :low52w_, :char,
            :low52wdate, [:char, 8], :low52wdate_, :char,
            :exhratio, [:char, 6], :exhratio_, :char,
            :flmtvol, [:char, 12], :flmtvol_, :char,
            :per, [:char, 6], :per_, :char,
            :listing, [:char, 12], :listing_, :char,
            :jkrate, [:char, 8], :jkrate_, :char,
            :vol, [:char, 6], :vol_, :char,
            :shcode, [:char, 6], :shcode_, :char,
            :value, [:char, 12], :value_, :char,
            :highyear, [:char, 8], :highyear_, :char,
            :highyeardate, [:char, 8], :highyeardate_, :char,
            :lowyear, [:char, 8], :lowyear_, :char,
            :lowyeardate, [:char, 8], :lowyeardate_, :char,
            :upname, [:char, 20], :upname_, :char,
            :upcode, [:char, 3], :upcode_, :char,
            :upprice, [:char, 7], :upprice_, :char,
            :upsign, [:char, 1], :upsign_, :char,
            :upchange, [:char, 6], :upchange_, :char,
            :updiff, [:char, 6], :updiff_, :char,
            :futname, [:char, 20], :futname_, :char,
            :futcode, [:char, 8], :futcode_, :char,
            :futprice, [:char, 6], :futprice_, :char,
            :futsign, [:char, 1], :futsign_, :char,
            :futchange, [:char, 6], :futchange_, :char,
            :futdiff, [:char, 6], :futdiff_, :char,
            :nav, [:char, 8], :nav_, :char,
            :navsign, [:char, 1], :navsign_, :char,
            :navchange, [:char, 8], :navchange_, :char,
            :navdiff, [:char, 6], :navdiff_, :char,
            :cocrate, [:char, 6], :cocrate_, :char,
            :kasis, [:char, 6], :kasis_, :char,
            :subprice, [:char, 10], :subprice_, :char,
            :offerno1, [:char, 6], :offerno1_, :char,
            :bidno1, [:char, 6], :bidno1_, :char,
            :dvol1, [:char, 8], :dvol1_, :char,
            :svol1, [:char, 8], :svol1_, :char,
            :dcha1, [:char, 8], :dcha1_, :char,
            :scha1, [:char, 8], :scha1_, :char,
            :ddiff1, [:char, 6], :ddiff1_, :char,
            :sdiff1, [:char, 6], :sdiff1_, :char,
            :offerno2, [:char, 6], :offerno2_, :char,
            :bidno2, [:char, 6], :bidno2_, :char,
            :dvol2, [:char, 8], :dvol2_, :char,
            :svol2, [:char, 8], :svol2_, :char,
            :dcha2, [:char, 8], :dcha2_, :char,
            :scha2, [:char, 8], :scha2_, :char,
            :ddiff2, [:char, 6], :ddiff2_, :char,
            :sdiff2, [:char, 6], :sdiff2_, :char,
            :offerno3, [:char, 6], :offerno3_, :char,
            :bidno3, [:char, 6], :bidno3_, :char,
            :dvol3, [:char, 8], :dvol3_, :char,
            :svol3, [:char, 8], :svol3_, :char,
            :dcha3, [:char, 8], :dcha3_, :char,
            :scha3, [:char, 8], :scha3_, :char,
            :ddiff3, [:char, 6], :ddiff3_, :char,
            :sdiff3, [:char, 6], :sdiff3_, :char,
            :offerno4, [:char, 6], :offerno4_, :char,
            :bidno4, [:char, 6], :bidno4_, :char,
            :dvol4, [:char, 8], :dvol4_, :char,
            :svol4, [:char, 8], :svol4_, :char,
            :dcha4, [:char, 8], :dcha4_, :char,
            :scha4, [:char, 8], :scha4_, :char,
            :ddiff4, [:char, 6], :ddiff4_, :char,
            :sdiff4, [:char, 6], :sdiff4_, :char,
            :offerno5, [:char, 6], :offerno5_, :char,
            :bidno5, [:char, 6], :bidno5_, :char,
            :dvol5, [:char, 8], :dvol5_, :char,
            :svol5, [:char, 8], :svol5_, :char,
            :dcha5, [:char, 8], :dcha5_, :char,
            :scha5, [:char, 8], :scha5_, :char,
            :ddiff5, [:char, 6], :ddiff5_, :char,
            :sdiff5, [:char, 6], :sdiff5_, :char,
            :fwdvl, [:char, 12], :fwdvl_, :char,
            :ftradmdcha, [:char, 12], :ftradmdcha_, :char,
            :ftradmddiff, [:char, 6], :ftradmddiff_, :char,
            :fwsvl, [:char, 12], :fwsvl_, :char,
            :ftradmscha, [:char, 12], :ftradmscha_, :char,
            :ftradmsdiff, [:char, 6], :ftradmsdiff_, :char,
            :upname2, [:char, 20], :upname2_, :char,
            :upcode2, [:char, 3], :upcode2_, :char,
            :upprice2, [:char, 7], :upprice2_, :char,
            :jnilnav, [:char, 8], :jnilnav_, :char,
            :jnilnavsign, [:char, 1], :jnilnavsign_, :char,
            :jnilnavchange, [:char, 8], :jnilnavchange_, :char,
            :jnilnavdiff, [:char, 6], :jnilnavdiff_, :char,
            :etftotcap, [:char, 12], :etftotcap_, :char,
            :spread, [:char, 6], :spread_, :char,
            :leverage, [:char, 2], :leverage_, :char,
            :taxgubun, [:char, 1], :taxgubun_, :char,
            :opcom_nmk, [:char, 20], :opcom_nmk_, :char,
            :lp_nm1, [:char, 20], :lp_nm1_, :char,
            :lp_nm2, [:char, 20], :lp_nm2_, :char,
            :lp_nm3, [:char, 20], :lp_nm3_, :char,
            :lp_nm4, [:char, 20], :lp_nm4_, :char,
            :lp_nm5, [:char, 20], :lp_nm5_, :char,
            :etf_cp, [:char, 10], :etf_cp_, :char,
            :etf_kind, [:char, 10], :etf_kind_, :char,
            :vi_gubun, [:char, 10], :vi_gubun_, :char,
            :etn_kind_cd, [:char, 20], :etn_kind_cd_, :char,
            :lastymd, [:char, 8], :lastymd_, :char,
            :payday, [:char, 8], :payday_, :char,
            :lastdate, [:char, 8], :lastdate_, :char,
            :issuernmk, [:char, 20], :issuernmk_, :char,
            :last_sdate, [:char, 8], :last_sdate_, :char,
            :last_edate, [:char, 8], :last_edate_, :char,
            :lp_holdvol, [:char, 12], :lp_holdvol_, :char
        end
        t1901 = T1901OutBlock.new(FFI::Pointer.new(recv[:lpData]))
        puts "hname: #{t1901[:hname].to_ptr.read_string.force_encoding('cp949')}"
        puts "price: #{t1901[:price].to_ptr.read_string}"
        puts "sign: #{t1901[:sign].to_ptr.read_string}"
        puts "change: #{t1901[:change].to_ptr.read_string}"
        puts "diff: #{t1901[:diff].to_ptr.read_string}"
        puts "volume: #{t1901[:volume].to_ptr.read_string}"
        puts "recprice: #{t1901[:recprice].to_ptr.read_string}"
        puts "avg: #{t1901[:avg].to_ptr.read_string}"
      end
    when 2, 3 # 2: Message, 3: System Error
      class MSG_PACKET < FFI::Struct
        pack 1
        layout \
          :nRqID, :int,
          :nIsSystemError, :int,
          :szMsgCode, [:char, 6],
          :nMsgLength, :int,
          :lpszMessageData, :string
      end
      msg = MSG_PACKET.new(FFI::Pointer.new(lparam))
      puts "msg: #{msg}"
      puts "nRqID: #{msg[:nRqID]}"
      puts "nIsSystemError: #{msg[:nIsSystemError]}"
      puts "szMsgCode: #{msg[:szMsgCode].to_ptr.read_string}"
      puts "nMsgLength: #{msg[:nMsgLength]}"
      puts "lpszMessageData: #{msg[:lpszMessageData].force_encoding('cp949')}"
      XingAPI::XingAPI.ETK_ReleaseMessageData(lparam)
    when 4 # Release
      # lparam is the request id
      XingAPI::XingAPI.ETK_ReleaseRequestData(lparam)
    else
      puts "XXXX"
    end
  end
  ::XingAPI::Windows::Win32::DefWindowProc(hwnd, msgid, wparam, lparam)
end
hwnd = win.window

result = XingAPI::XingAPI.ETK_Connect(hwnd, "hts.etrade.co.kr", 20001, 1024, -1, 512)
p ['connect: ', result]

result = XingAPI::XingAPI.ETK_Login(hwnd, ENV['ID'], ENV['PASS'], ENV['PASS2'], 0, false)
p ['try_login', result]

win.pump_up

if false
  require 'ffi'

  class T1901 < FFI::Struct
    pack 1
    layout :shcode, [:char, 6]
  end

  t1901 = T1901.new
  t1901[:shcode].to_ptr.write_string('122630')

  request_id = XingAPI::XingAPI.ETK_Request(hwnd, 't1901', t1901, t1901.size, false, nil, 1)
  puts "request_id: #{request_id}"

  win.pump_up
end

if false
  count = XingAPI::XingAPI.ETK_GetAccountListCount()
  p ['account list count', count]

  count.times do |idx|
    out = FFI::MemoryPointer.new(256)
    XingAPI::XingAPI.ETK_GetAccountList(idx, out, out.size)
    p out.read_string
  end
end

if false
  out = FFI::MemoryPointer.new(256)
  XingAPI::XingAPI.ETK_GetClientIP(out)
  p out.read_string
end

if false
  out = FFI::MemoryPointer.new(256)
  XingAPI::XingAPI.ETK_GetServerName(out)
  p out.read_string
end

XingAPI::XingAPI.ETK_Logout(hwnd)
XingAPI::XingAPI.ETK_Disconnect
