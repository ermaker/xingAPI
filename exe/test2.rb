require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/fibered_windows'

win = XingAPI::FiberedWindows.new
hwnd = win.hwnd

result = XingAPI::XingAPI.ETK_Connect(hwnd, "hts.etrade.co.kr", 20001, 1024, -1, 512)
p ['connect: ', result]

result = XingAPI::XingAPI.ETK_Login(hwnd, ENV['ID'], ENV['PASS'], ENV['PASS2'], 0, false)
p ['try_login', result]

_, _, wparam, lparam = win.resume_login
puts 'WM_LOGIN'
message = [wparam, lparam].map do |param|
  FFI::Pointer.new(:string, param).read_string.force_encoding('cp949')
end.join(': ')
puts message

XingAPI::XingAPI.ETK_Logout(hwnd)
XingAPI::XingAPI.ETK_Disconnect
