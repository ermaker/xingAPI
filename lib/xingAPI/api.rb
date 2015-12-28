require 'xingAPI/xingAPI'
require 'xingAPI/fibered_windows'
require 'ffi'

module XingAPI
  class API
    def hwnd
      @win.hwnd
    end

    def initialize
      @win = FiberedWindows.new
      connect { login { yield } }
    end

    def connect
      result = XingAPI.ETK_Connect(hwnd, "hts.etrade.co.kr", 20001, 1024, -1, 512)
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

    def login
      result = XingAPI.ETK_Login(hwnd, ENV['ID'], ENV['PASS'], ENV['PASS2'], 0, false)
      ::XingAPI::logger.debug { "login: #{result}" }
      unless result
        ::XingAPI::logger.error { "login: #{result}" }
        return
      end

      _, _, wparam, lparam = @win.resume_login
      message = [wparam, lparam].map { |param| pointer_to_string(param) }.join(': ')
      ::XingAPI::logger.info { "login: #{message}" }

      unless pointer_to_string(wparam) == '0000'
        ::XingAPI::logger.error { "login: #{message}" }
        return
      end

      yield
    ensure
      XingAPI.ETK_Logout(hwnd)
      ::XingAPI::logger.debug { "logout: #{hwnd}" }
    end
  end
end