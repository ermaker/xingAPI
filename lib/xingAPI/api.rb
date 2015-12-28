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
  end
end