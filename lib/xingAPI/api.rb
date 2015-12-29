require 'xingAPI/xingAPI'
require 'xingAPI/fibered_windows'
require 'ffi'

module XingAPI
  class API
    extend Forwardable
    attr_reader :win
    def_delegators :@win, :hwnd

    def initialize(ip, port, id, pass, pass2)
      @win = FiberedWindows.new
      connect(ip, port) { login(id, pass, pass2) { yield self } }
    end

    def connect(ip, port)
      ::XingAPI::logger.info { "ip: #{ip}" }
      result = XingAPI.ETK_Connect(hwnd, ip, port.to_i, 1024, -1, 512)
      ::XingAPI::logger.debug { "connect: #{result}" }

      unless result
        ::XingAPI::logger.error { "connect: #{result}" }
        return
      end

      yield
    ensure
      XingAPI.ETK_Disconnect
      ::XingAPI::logger.debug { 'disconnect' }
    end

    def pointer_to_string(pointer)
      FFI::Pointer.new(pointer).read_string.force_encoding('cp949')
    end

    def login(id, pass, pass2)
      result = XingAPI.ETK_Login(hwnd, id, pass, pass2, 0, false)
      ::XingAPI::logger.debug { "login: #{result}" }
      unless result
        ::XingAPI::logger.error { "login: #{result}" }
        return
      end

      _, _, wparam, lparam = @win.resume_login
      result = [wparam, lparam].map { |param| pointer_to_string(param) }
      message = "[#{result[0]}] #{result[1]}"
      ::XingAPI::logger.debug { "login: #{message}" }

      unless pointer_to_string(wparam) == '0000'
        ::XingAPI::logger.error { "login: #{message}" }
        return
      end

      yield
    ensure
      XingAPI.ETK_Logout(hwnd)
      ::XingAPI::logger.debug { "logout: #{hwnd}" }
    end

    def tr_t1901(shcode)
      tr('t1901') do |in_block|
        in_block[:shcode].to_ptr.write_string(shcode)
      end
    end

    SELL_OR_BUY = {sell: '1', buy: '2'}

    def tr_CSPAT00600(account, account_pass, shcode, qty, sell_or_buy)
      tr('CSPAT00600') do |in_block|
        tr_name = 'CSPAT00600'
        price = 0
        in_block[:"STRUCT_#{tr_name}InBlock1"][:AcntNo].to_ptr.write_string(account.ljust(20))
        in_block[:"STRUCT_#{tr_name}InBlock1"][:InptPwd].to_ptr.write_string(account_pass.ljust(8))
        in_block[:"STRUCT_#{tr_name}InBlock1"][:IsuNo].to_ptr.write_string("A#{shcode}".ljust(12))
        in_block[:"STRUCT_#{tr_name}InBlock1"][:OrdQty].to_ptr.write_string(format('%016d', qty))
        in_block[:"STRUCT_#{tr_name}InBlock1"][:OrdPrc].to_ptr.write_string(format('%013.2f', price))
        in_block[:"STRUCT_#{tr_name}InBlock1"][:BnsTpCode].to_ptr.write_string(SELL_OR_BUY.fetch(sell_or_buy))
        in_block[:"STRUCT_#{tr_name}InBlock1"][:OrdprcPtnCode].to_ptr.write_string('03')
        in_block[:"STRUCT_#{tr_name}InBlock1"][:MgntrnCode].to_ptr.write_string('000')
        in_block[:"STRUCT_#{tr_name}InBlock1"][:LoanDt].to_ptr.write_string('00000000')
        in_block[:"STRUCT_#{tr_name}InBlock1"][:OrdCndiTpCode].to_ptr.write_string('0')
      end
    end

    def tr(tr_name)
      result = nil

      in_block = ::XingAPI.const_get(:"STRUCT_#{tr_name}InBlock").new
      yield in_block

      request_id = XingAPI.ETK_Request(hwnd, tr_name, in_block, in_block.size, false, nil, 1)
      ::XingAPI::logger.debug { "request_id: #{request_id}" }

      loop do
        _, _, wparam, lparam = @win.resume { |_, msgid, _, _| msgid == 1024 + 3}
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA:" }
        case wparam
        when 1
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Data" }
          recv = RECV_PACKET.of(lparam)
          ::XingAPI::logger.debug { "recv: #{recv}" }
          result = recv.data.to_hash
          ::XingAPI::logger.debug { "result: #{result}" }
        when 2
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Message" }
          msg = MSG_PACKET.of(lparam)
          ::XingAPI::logger.info { msg.to_s }
          XingAPI.ETK_ReleaseMessageData(lparam)
        when 3
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Error" }
          msg = MSG_PACKET.of(lparam)
          ::XingAPI::logger.info { msg.to_s }
          XingAPI.ETK_ReleaseMessageData(lparam)
          break
        when 4
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Release (#{lparam})" }
          XingAPI.ETK_ReleaseRequestData(lparam)
          break
        else
          ::XingAPI::logger.error { "Unknown case! wpararm: #{wparam}" }
        end
      end

      return result
    end
  end
end