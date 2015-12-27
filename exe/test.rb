require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/win32'
require 'xingAPI/windows'

p ['connected: ', XingAPI::XingAPI.ETK_IsConnected]

hwnd = 0
win = XingAPI::Windows.new do |hwnd, msgid, wparam, lparam|
  puts "WM: #{hwnd}, #{msgid}, #{wparam}, #{lparam}"
  if msgid == 1029
    puts "wparam: #{FFI::Pointer.new(:string, wparam).read_string.force_encoding('cp949')}"
    puts "lparam: #{FFI::Pointer.new(:string, lparam).read_string.force_encoding('cp949')}"
  end
  XingAPI::Windows::Win32::DefWindowProc(hwnd, msgid, wparam, lparam)
end
p ['win', win]
hwnd = win.window

p ['hwnd', hwnd]

result = XingAPI::XingAPI.ETK_Connect(hwnd, "hts.etrade.co.kr", 20001, 1024, -1, 512)
# result = XingAPI::XingAPI.ETK_Connect(hwnd, "demo.etrade.co.kr", 20001, 1024, -1, 512)
p ['connect: ', result]

result = XingAPI::XingAPI.ETK_Login(hwnd, ENV['ID'], ENV['PASS'], ENV['PASS2'], 0, false)
p ['try_login', result]

win.pump_up

count = XingAPI::XingAPI.ETK_GetAccountListCount()
p ['account list count', count]

count.times do |idx|
  out = FFI::MemoryPointer.new(256)
  XingAPI::XingAPI.ETK_GetAccountList(idx, out, out.size)
  p out.read_string
end

out = FFI::MemoryPointer.new(256)
XingAPI::XingAPI.ETK_GetClientIP(out)
p out.read_string

out = FFI::MemoryPointer.new(256)
XingAPI::XingAPI.ETK_GetServerName(out)
p out.read_string

result = XingAPI::XingAPI.ETK_Logout(hwnd)
p ['try_logout', result]

win.pump_up

p ['Disconnect: ', XingAPI::XingAPI.ETK_Disconnect]

win.pump_up
