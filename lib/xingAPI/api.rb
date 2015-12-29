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
      result = nil
      t1901 = STRUCT_t1901InBlock.new
      t1901[:shcode].to_ptr.write_string(shcode)

      request_id = XingAPI.ETK_Request(hwnd, 't1901', t1901, t1901.size, false, nil, 1)
      ::XingAPI::logger.debug { "request_id: #{request_id}" }

      loop do
        _, _, wparam, lparam = @win.resume { |_, msgid, _, _| msgid == 1024 + 3}
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA:" }
        case wparam
        when 1
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Data" }
          recv = RECV_PACKET.of(lparam)
          ::XingAPI::logger.debug { recv.to_s }
          result = recv.data.to_hash
          ::XingAPI::logger.debug { result.to_s }
        when 2, 3
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Message" }
          msg = MSG_PACKET.of(lparam)
          ::XingAPI::logger.debug { msg.to_s }

          XingAPI.ETK_ReleaseMessageData(lparam)
        when 4
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Release" }
          XingAPI.ETK_ReleaseRequestData(lparam)
          break
        else
          ::XingAPI::logger.error { "Unknown case! wpararm: #{wparam}" }
        end
      end

      return result
    end

    SELL_OR_BUY = {sell: '1', buy: '2'}

    def tr_CSPAT00600(account, account_pass, shcode, qty, sell_or_buy)
      result = nil

      price = 0

      order = STRUCT_CSPAT00600InBlock1.new
      order[:AcntNo].to_ptr.write_string(account.ljust(20))
      order[:InptPwd].to_ptr.write_string(account_pass.ljust(8))
      order[:IsuNo].to_ptr.write_string("A#{shcode}".ljust(12))
      order[:OrdQty].to_ptr.write_string(format('%016d', qty))
      order[:OrdPrc].to_ptr.write_string(format('%013.2f', price))
      order[:BnsTpCode].to_ptr.write_string(SELL_OR_BUY.fetch(sell_or_buy))
      order[:OrdprcPtnCode].to_ptr.write_string('03')
      order[:MgntrnCode].to_ptr.write_string('000')
      order[:LoanDt].to_ptr.write_string('00000000')
      order[:OrdCndiTpCode].to_ptr.write_string('0')

      request_id = XingAPI.ETK_Request(hwnd, 'CSPAT00600', order, order.size, false, nil, 1)
      ::XingAPI::logger.debug { "request_id: #{request_id}" }

      loop do
        _, _, wparam, lparam = @win.resume { |_, msgid, _, _| msgid == 1024 + 3}
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA:" }
        case wparam
        when 1
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Data" }
          recv = RECV_PACKET.of(lparam)
          ::XingAPI::logger.debug { recv.to_s }
          # require 'pry'
          # binding.pry
          ::XingAPI::logger.debug { "recv.szTrCode: #{recv.szTrCode}" }
          ::XingAPI::logger.debug { "recv.nDataMode: #{recv.nDataMode}" }
          ::XingAPI::logger.debug { "recv.nDataLength: #{recv.nDataLength}" }

          unless recv.nDataLength == 0
            result1 = recv.data(block_name: 'CSPAT00600OutBlock1').to_hash
            ::XingAPI::logger.debug { result1.to_s }
            # result = recv.data(block_name: 'CSPAT00600OutBlock2').to_hash
            # ::XingAPI::logger.debug { result.to_s }
            result2 = STRUCT_CSPAT00600OutBlock2.of(recv.lpData + STRUCT_CSPAT00600OutBlock1.size).to_hash
            ::XingAPI::logger.debug { result2.to_s }
            result = [result1, result2]
          end
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
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Release" }
          ::XingAPI::logger.debug { "request_id : #{lparam}" }
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