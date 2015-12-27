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
      p ['connect: ', result]
      yield
    ensure
      XingAPI.ETK_Disconnect
    end

    def login
      result = XingAPI.ETK_Login(hwnd, ENV['ID'], ENV['PASS'], ENV['PASS2'], 0, false)
      p ['try_login', result]

      @win.resume_login.tap do |_, _, wparam, lparam|
        puts 'WM_LOGIN'
        message = [wparam, lparam].map do |param|
          FFI::Pointer.new(:string, param).read_string.force_encoding('cp949')
        end.join(': ')
        puts message
      end

      yield
    ensure
      XingAPI.ETK_Logout(hwnd)
    end
  end
end