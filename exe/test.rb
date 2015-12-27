require 'xingAPI/win32'
require 'ffi'

module User32
extend FFI::Library
ffi_lib 'user32'
ffi_convention :stdcall

attach_function :SendMessageA, [:ulong, :uint, :ulong, :long], :long
attach_function :PostMessageA, [:ulong, :uint, :ulong, :long], :bool
end


module XingAPI
extend FFI::Library
ffi_lib 'xingAPI'
ffi_convention :stdcall

# BOOL IXingAPI::Connect( HWND hWnd, LPCTSTR pszSvrIP, int nPort, int nStartMsgID, int nTimeOut, int nSendMaxPacketSize )
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


p ['connected: ', XingAPI.ETK_IsConnected]


=begin
class Windows
  attr_accessor :window
  def initialize
    hInstance = Win32::GetModuleHandle(nil)

    @window_class = Win32::WNDCLASSEX.new
    @window_class[:style]         = Win32::CS_HREDRAW | Win32::CS_VREDRAW
    @window_class[:lpfnWndProc]   = method(:message_pump)
    @window_class[:hInstance]     = hInstance
    @window_class[:hbrBackground] = Win32::COLOR_WINDOWFRAME
    @window_class[:lpszClassName] = FFI::MemoryPointer.from_string 'ruby-skype'

    @window = Win32::CreateWindowEx(Win32::WS_EX_LEFT, ::FFI::Pointer.new(@window_class.atom), 'ruby-skype', Win32::WS_OVERLAPPEDWINDOW,
                                    0, 0, 0, 0, Win32::NULL, Win32::NULL, hInstance, nil)
  end

  def message_pump(window_handle, message_id, wParam, lParam)
    if message_id == 1029
      puts "WM: #{window_handle}, #{message_id}, #{wParam}, #{lParam}"
      $stdout.flush
    end
    # return

    puts "WM: #{window_handle}, #{message_id}"
    $stdout.flush
    Win32::DefWindowProc(window_handle, message_id, wParam, lParam)
  end

  module Win32
    extend FFI::Library
    ffi_lib('user32', 'kernel32')
    ffi_convention(:stdcall)

    private

    def self._func(*args)
      attach_function *args
      case args.size
        when 3
          module_function args[0]
        when 4
          module_function args[0]
          alias_method(args[1], args[0])
          module_function args[1]
      end
    end

    public

    ULONG_PTR = FFI::TypeDefs[:ulong]
    LONG_PTR = FFI::TypeDefs[:long]

    ULONG = FFI::TypeDefs[:ulong]
    LONG = FFI::TypeDefs[:long]
    LPVOID = FFI::TypeDefs[:pointer]
    INT = FFI::TypeDefs[:int]
    BYTE = FFI::TypeDefs[:uint16]
    DWORD = FFI::TypeDefs[:ulong]
    BOOL = FFI::TypeDefs[:int]
    UINT = FFI::TypeDefs[:uint]
    POINTER = FFI::TypeDefs[:pointer]
    VOID = FFI::TypeDefs[:void]

    HWND = HICON = HCURSOR = HBRUSH = HINSTANCE = HGDIOBJ =
        HMENU = HMODULE = HANDLE = ULONG_PTR
    LPARAM = LONG_PTR
    WPARAM = ULONG_PTR
    LPCTSTR = LPMSG = LPVOID
    LRESULT = LONG_PTR
    ATOM = BYTE
    NULL = 0

    # WNDPROC = callback(:WindowProc, [HWND, UINT, WPARAM, LPARAM], LRESULT)
    WNDPROC = callback(:WindowProc, [HWND, UINT, :string, :string], LRESULT)

    class WNDCLASSEX < FFI::Struct
      layout :cbSize, UINT,
             :style, UINT,
             :lpfnWndProc, WNDPROC,
             :cbClsExtra, INT,
             :cbWndExtra, INT,
             :hInstance, HANDLE,
             :hIcon, HICON,
             :hCursor, HCURSOR,
             :hbrBackground, HBRUSH,
             :lpszMenuName, LPCTSTR,
             :lpszClassName, LPCTSTR,
             :hIconSm, HICON

      def initialize(*args)
        super
        self[:cbSize] = self.size
        @atom = 0
      end

      def register_class_ex
        (@atom = Win32::RegisterClassEx(self)) != 0 ? @atom : raise("RegisterClassEx Error")
      end

      def atom
        @atom != 0 ? @atom : register_class_ex
      end
    end # WNDCLASSEX

    class POINT < FFI::Struct
      layout :x, LONG,
             :y, LONG
    end

    class MSG < FFI::Struct
      layout :hwnd, HWND,
             :message, UINT,
             :wParam, WPARAM,
             :lParam, LPARAM,
             :time, DWORD,
             :pt, POINT
    end

    _func(:RegisterWindowMessage, :RegisterWindowMessageA, [LPCTSTR], UINT)
    _func(:GetModuleHandle, :GetModuleHandleA, [LPCTSTR], HMODULE)
    _func(:RegisterClassEx, :RegisterClassExA, [LPVOID], ATOM)
    _func(:CreateWindowEx, :CreateWindowExA, [DWORD, LPCTSTR, LPCTSTR, DWORD, INT, INT, INT, INT, HWND, HMENU, HINSTANCE, LPVOID], HWND)
    _func(:GetMessage, :GetMessageA, [LPMSG, HWND, UINT, UINT], BOOL)
    _func(:TranslateMessage, [LPVOID], BOOL)
    _func(:DispatchMessage, :DispatchMessageA, [LPVOID], BOOL)
    _func(:DefWindowProc, :DefWindowProcA, [HWND, UINT, WPARAM, LPARAM], LRESULT)

    # @!group Predefined WindowHandle's
    #
    # These are WindowHandle's provided by the Win32 API for special purposes.

    # Target for SendMessage(). Broadcast to all windows.
    HWND_BROADCAST = 0xffff
    # Used as a parent in CreateWindow(). Signifies that this should be a message-only window.
    HWND_MESSAGE = -3

    # @!endgroup

    # CreateWindow Use Default Value
    CW_USEDEFAULT = 0x80000000

    COLOR_WINDOW = 5
    COLOR_WINDOWFRAME = 6

    # @!group Class Style contants.

    CS_VREDRAW = 0x0001
    CS_HREDRAW = 0x0002

    # @!group Window Style constants
    #
    # This is only a subset.
    # @see http://msdn.microsoft.com/en-us/library/windows/desktop/ms632600.aspx

    WS_BORDER =      0x00800000
    WS_CAPTION =     0x00C00000
    WS_DISABLED =    0x08000000
    WS_OVERLAPPED =  0x00000000
    WS_POPUP =       0x80000000
    WS_SIZEBOX =     0x00040000
    WS_SYSMENU =     0x00080000
    WS_THICKFRAME =  0x00040000
    WS_MAXIMIZEBOX = 0x00010000
    WS_MINIMIZEBOX = 0x00020000
    WS_OVERLAPPEDWINDOW = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX
    WS_POPUPWINDOW = WS_POPUP | WS_BORDER | WS_SYSMENU

    # @!group Window Extended Style constants
    #
    # This is only a subset.
    # @see http://msdn.microsoft.com/en-us/library/windows/desktop/ff700543.aspx

    WS_EX_LEFT = 0

    # @!endgroup
  end
end
=end

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

result = XingAPI.ETK_Login(hwnd, 'ermaker', 'test', 'test', 0, false)
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

sleep 1

p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
p ['Disconnect: ', XingAPI.ETK_Disconnect]
