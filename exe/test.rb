require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/win32'
require 'ffi'

module XingAPI
  extend FFI::Library
  ffi_lib 'xingAPI'
  ffi_convention :stdcall

  attach_function :ETK_Connect, [:ulong, :string, :int, :int, :int, :int ], :bool
  attach_function :ETK_IsConnected, [], :bool
  attach_function :ETK_Disconnect, [], :bool

  attach_function :ETK_Login, [:ulong, :string, :string, :string, :int, :bool], :bool
  attach_function :ETK_Logout, [:ulong], :bool

  attach_function :ETK_GetAccountListCount, [], :int

  attach_function :ETK_GetAccountList, [:int, :pointer, :int], :bool

  attach_function :ETK_GetClientIP, [:pointer], :void
  attach_function :ETK_GetServerName, [:pointer], :void

  attach_function :ETK_GetLastError, [], :int
  attach_function :ETK_GetErrorMessage, [], :int
end

class Skype
  module Communication
    # Utilises the Windows API to send and receive Window Messages to/from
    # Skype.
    #
    # This protocol is only available on Windows and Cygwin.
    class Windows
      attr_accessor :window

      # Sets up access to Skype
      #
      # @see http://msdn.microsoft.com/en-us/library/bb384843.aspx Creating
      #     Win32-Based Applications
      def initialize(&blk)
        instance = Win32::GetModuleHandle(nil)

        @window_class = Win32::WNDCLASSEX.new
        @window_class[:style]         = Win32::CS_HREDRAW | Win32::CS_VREDRAW
        @window_class[:lpfnWndProc]   = blk
        @window_class[:hInstance]     = instance
        @window_class[:hbrBackground] = Win32::COLOR_WINDOW
        @window_class[:lpszClassName] =
            FFI::MemoryPointer.from_string 'ruby-skype'

        @window = Win32::CreateWindowEx(Win32::WS_EX_LEFT,
                                        FFI::Pointer.new(@window_class.handle),
                                        'ruby-skype',
                                        Win32::WS_OVERLAPPEDWINDOW,
                                        0, 0, 0, 0, Win32::NULL, Win32::NULL,
                                        instance, nil)
      end

      # Update processing.
      #
      # This executes a Windows event loop while there are messages still
      # pending, then dumps back out to let other things take over and do their
      # thing.
      #
      # @return [void]
      def tick
        msg = Win32::MSG.new
        while Win32::PeekMessage(msg, Win32::NULL, 0, 0, Win32::PM_REMOVE) > 0
          # puts "WAIT: #{msg[:hwnd]}, #{msg[:message]}, #{msg[:wParam]}, #{msg[:lParam]}"
          Win32::TranslateMessage(msg)
          Win32::DispatchMessage(msg)
        end
      end

      def pump_up(time: 1)
        step = 0.01
        (time / step).to_i.times do
          tick
          sleep step
        end
      end
    end
  end
end

p ['connected: ', XingAPI.ETK_IsConnected]

hwnd = 0
win = Skype::Communication::Windows.new do |hwnd, msgid, wparam, lparam|
  puts "WM: #{hwnd}, #{msgid}, #{wparam}, #{lparam}"
  if msgid == 1029
    puts "wparam: #{FFI::Pointer.new(:string, wparam).read_string.force_encoding('cp949')}"
    puts "lparam: #{FFI::Pointer.new(:string, lparam).read_string.force_encoding('cp949')}"
  end
  Skype::Communication::Windows::Win32::DefWindowProc(hwnd, msgid, wparam, lparam)
end
p ['win', win]
hwnd = win.window

p ['hwnd', hwnd]

result = XingAPI.ETK_Connect(hwnd, "hts.etrade.co.kr", 20001, 1024, -1, 512)
# result = XingAPI.ETK_Connect(hwnd, "demo.etrade.co.kr", 20001, 1024, -1, 512)
p ['connect: ', result]

result = XingAPI.ETK_Login(hwnd, ENV['ID'], ENV['PASS'], ENV['PASS2'], 0, false)
p ['try_login', result]

win.pump_up

count = XingAPI.ETK_GetAccountListCount()
p ['account list count', count]

count.times do |idx|
  out = FFI::MemoryPointer.new(256)
  XingAPI.ETK_GetAccountList(idx, out, out.size)
  p out.read_string
end

out = FFI::MemoryPointer.new(256)
XingAPI.ETK_GetClientIP(out)
p out.read_string

out = FFI::MemoryPointer.new(256)
XingAPI.ETK_GetServerName(out)
p out.read_string

result = XingAPI.ETK_Logout(hwnd)
p ['try_logout', result]

win.pump_up

p ['Disconnect: ', XingAPI.ETK_Disconnect]

win.pump_up
