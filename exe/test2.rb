require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/api'

=begin
XingAPI::API.new do
  count = XingAPI::XingAPI.ETK_GetAccountListCount()
  ::XingAPI::logger.info { "AccountListCount: #{count}" }
  p ['account list count', count]

  count.times do |idx|
    out = FFI::MemoryPointer.new(256)
    XingAPI::XingAPI.ETK_GetAccountList(idx, out, out.size)
    ::XingAPI::logger.info { "AccountList: #{out.read_string}" }
  end
end
=end

require 'xingAPI/fibered_windows'

module XingAPI
  @win = FiberedWindows.new
  hwnd = @win.hwnd


  result = XingAPI.ETK_Connect(hwnd, "hts.etrade.co.kr", 20001, 1024, -1, 512)
  ::XingAPI::logger.debug { "connect: #{result}" }

  def pointer_to_string(pointer)
    FFI::Pointer.new(pointer).read_string.force_encoding('cp949')
  end
  module_function :pointer_to_string

  result = XingAPI.ETK_Login(hwnd, ENV['ID'], ENV['PASS'], ENV['PASS2'], 0, false)
  ::XingAPI::logger.debug { "login: #{result}" }

  _, _, wparam, lparam = @win.resume_login
  message = [wparam, lparam].map { |param| pointer_to_string(param) }.join(': ')
  ::XingAPI::logger.info { "login: #{message}" }

  unless pointer_to_string(wparam) == '0000'
    ::XingAPI::logger.error { "login: #{message}" }
    return
  end

  XingAPI.ETK_Logout(hwnd)
  ::XingAPI::logger.debug { "logout: #{hwnd}" }

  XingAPI.ETK_Disconnect
  ::XingAPI::logger.debug { 'disconnect' }

  @win.win.pump_up
end