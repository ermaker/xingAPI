require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/windows'

win = XingAPI::Windows.new do |hwnd, msgid, wparam, lparam|
  puts "WM: #{hwnd}, #{msgid}, #{wparam}, #{lparam}"
  if msgid == 1029
    puts "wparam: #{FFI::Pointer.new(:string, wparam).read_string.force_encoding('cp949')}"
    puts "lparam: #{FFI::Pointer.new(:string, lparam).read_string.force_encoding('cp949')}"
  end
end
hwnd = win.window

result = XingAPI::XingAPI.ETK_Connect(hwnd, "hts.etrade.co.kr", 20001, 1024, -1, 512)
p ['connect: ', result]

result = XingAPI::XingAPI.ETK_Login(hwnd, ENV['ID'], ENV['PASS'], ENV['PASS2'], 0, false)
p ['try_login', result]

win.pump_up

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
